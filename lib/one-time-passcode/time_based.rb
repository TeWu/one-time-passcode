require 'base32'
require 'openssl'


module OneTimePasscode

  class TimeBased
    DIGEST = OpenSSL::Digest.new("sha1")
    CODE_LENGTH = 6
    SECONDS_VALID = 30
    
    def initialize(key)
      @hmac = OpenSSL::HMAC.new(preprocess_key(key), DIGEST)
    end
    
    def generate_code_number
      time_bytes = [Time.now.to_i / SECONDS_VALID].pack('N').rjust(8,"\x00")
      digest_bytes = generate_digest_bytes(time_bytes)
      digest_to_code_number(digest_bytes)
    end
    
    def generate_code_string
      generate_code_number.to_s.rjust(CODE_LENGTH,"0")
    end
    
    def seconds_remaining
      SECONDS_VALID - (Time.now.to_i % SECONDS_VALID)
    end
    
    
    private
    
    def generate_digest_bytes(time_bytes)
      @hmac.reset
      @hmac << time_bytes
      @hmac.digest.bytes
    end

    def digest_to_code_number(digest_bytes)
      digest_parts = extract_digest_parts(digest_bytes)
      big_integer = digest_parts.map(&:chr).join.unpack('N').first
      big_integer % 10**CODE_LENGTH
    end
    
    def extract_digest_parts(digest_bytes)
      offset = digest_bytes.last & 0x0F
      digest_parts = digest_bytes[offset, 4]
	    [digest_parts[0] & 0b0111_1111] + digest_parts[1..-1]  # Ignore the most significant bit as per RFC 4226
    end

    def preprocess_key(key)
      Base32.decode(key.upcase.gsub(/\s+/, ""))
    end

  end
  
end

