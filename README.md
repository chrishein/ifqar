# Ifqar

Investment Funds Quoter Argentina is a ruby client that retrieves funds stats
from [cafci.org.ar](http://www.cafci.org.ar/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ifqar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ifqar

## Usage

```ruby
require 'ifqar'

date = Date.parse('14-03-2017')
type = :EQUITY

quoter = Ifqar::FundQuoter.new
stats = quoter.stats(date, type)

stats.funds_quotes.each do |fund_quote|
  puts [fund_quote.fund.name, fund_quote.share_value].join(': ')
end
```



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chrishein/ifqar.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
