# CnpjTools

This is a gem with tools to work with the Brazilian Business Tax ID, known as CNPJ.

This gem will validate the number itself, and not if CNPJ is valid at govern department of Receita Federal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cnpj_tools'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cnpj_tools

## Usage

### CnpjTools.valid? (boolean)
Any non-digit character will be ignored and only numbers will be tested.

Tax ID number will be validate for length, invalid number repetitions, first and second verification digits.

    CnpjTools.valid?('16.533.758/0001-25') => true
    CnpjTools.valid?('16533758000125') => true
    CnpjTools.valid?('16.533.758-0001-25') => true
    CnpjTools.valid?(16533758000125) => true

    CnpjTools.valid?('12.333.758/0001-25') => false


### CnpjTools.format (string)
Format the CNPJ accordingly with the parameters, no validation will be done.

If the string length is different from 14 (CNPJ standard length) an empty string will be returned.

### with_mask
A string with default mask applied will be returned -> '##.###.###/####-##'

    CnpjTools.format('16533758000126') => '16.533.758/0001-26'

### digits_only
A string with digits only will be returned.

    CnpjTools.format('16.533.758/0001-25', format: :digits_only) => '16533758000125'


### CnpjTools.return_valid (string)
This method combines valid? and format and will return a formatted string if CNPJ is valid.

If the string length is different from 11 (CNPJ standard length) or CNPJ isn't valid an empty string will be returned.

### with_mask
A string with default mask applied will be returned -> '##.###.###/####-##'

    CnpjTools.return_valid('16533758000125') => '16.533.758/0001-25'

### digits_only
A string with digits only will be returned.

    CnpjTools.return_valid('16.533.758/0001-25', format: :digits_only) => '16533758000125'


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/m-escobar/cnpj_tools. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/m-escobar/cnpj_tools/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CnpjTools project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/m-escobar/cnpj_tools/blob/master/CODE_OF_CONDUCT.md).
