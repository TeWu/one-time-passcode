Simple one-time passcode generator compatible with Google Authenticator
===


Example usage
---
```ruby
  totp = OneTimePasscode::TimeBased.new("example key")
  totp.generate_code_string  # => "039883"
  totp.generate_code_number  # => 39883
  totp.seconds_remaining     # => 5
  
  ... wait 5 seconds ...
  
  totp.generate_code_string  # => "752931"
  totp.seconds_remaining     # => 30
```


More one-time passcode related content
---

* [How Google Authenticator Works](https://garbagecollected.org/2014/09/14/how-google-authenticator-works/)
* [Full-featured ruby one-time passcode library](https://github.com/mdp/rotp)
