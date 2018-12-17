# AltCharacters

alt_characters alternate base32 without numeric characters and padding

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'alt_characters'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alt_characters

## Usage

### Quick start

```ruby
require 'alt_characters'

encoded_text = AltCharacters.alt32_encode('foo')
# => "Nmhgw"

AltCharacters.alt32_decode(encoded_text)
# => "foo"
```

or

```ruby
require 'alt_characters'

encoded_text = Alt32.new.encode('foo')
# => "Nmhgw"

Alt32.new.decode(encoded_text)
# => "foo"
```


### Modifying encodable characters

```ruby
require 'alt_characters'

encodable_characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'

encoded_text = Alt32.new(characters: encodable_characters).encode('foo')
# => "MZXW6"

Alt32.new(characters: encodable_characters).decode(encoded_text)
# => "foo"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/booink/alt_characters. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AltCharacters project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/alt_characters/blob/master/CODE_OF_CONDUCT.md).
