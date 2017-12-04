# Manageiq::Graphql::Client::Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'manageiq-graphql-client-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install manageiq-graphql-client-ruby

## Usage

To play around with this, open up a console:

```sh
bin/console
```

And execute a sample query:

```ruby
VmsQuery = Manageiq::Graphql::Client.parse <<-'GRAPHQL'
query {
  vms {
    name
  }
}
GRAPHQL

Manageiq::Graphql::Client.query(VmsQuery) # => #<GraphQL::Client::Response:0x0000556d881473f0 @original_hash={"data"=>{"vms"=>[{"name"=>"vmdemods10"}, etc, etc...
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Manageiq::Graphql::Client::Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/imtayadeway/manageiq-graphql-client-ruby/blob/master/CODE_OF_CONDUCT.md).
