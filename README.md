# Outbanker

Outbanker reads a CSV file exported from Outbanker/MAC and converts the types to Ruby, as well as doing some cleanups.

## Installation

Add this line to your application's Gemfile:

    gem 'outbanker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install outbanker

## Usage

    lines = Outbanker::StatementLines.read('outbank.csv')
    lines.each do |line|
      puts line.amount
    end

See the class +StatementLine+ for all available fields.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
