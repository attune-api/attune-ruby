# Attune

A client for the [Attune ranking API](http://attune.co/). Built using the excellent [faraday](https://github.com/lostisland/faraday) library.

* [Github](https://github.com/attune-api/attune-ruby)
* [RubyGems](https://rubygems.org/gems/attune)
* [Documentation](http://rdoc.info/github/attune-api/attune-ruby)

## Installation

Add this line to your application's Gemfile:

    gem 'attune'

And then execute:

    $ bundle

## Usage

### Example rails usage

Requests are performed through a client object

``` ruby
client = Attune::Client.new
```

Visitors to the application should be tagged with an anonymous user id

``` ruby
class ApplicationController
  before_filter do
    session[:attune_id] ||= attune_client.anonymous.create.id
  end

  private
  def attune_client
    @attune_client ||= Attune.client
  end
end
```

The user id can be bound to a customer id at login

``` ruby
class SessionsController
  # ...

  def create
    # ...
    attune_customer = Attune::Model::Customer.new(customer: current_user.id)
    attune_client.anonymous.update(session[:attune_id], attune_customer)
  end
end
```

The client can then perform rankings

``` ruby
class ProductsController
  def index
    @products = sorted(Product.all)
  end

  private
  def sorted products
    ranking_params = Attune::Model::RankingParams.new
    ranking_params.anonymous = session[:attune_id]
    ranking_params.view = request.fullpath
    ranking_params.entity_type = 'products'
    ranking_params.user_agent = request.env["HTTP_USER_AGENT"]
    ranking_params.ids = products.map(&:id)
    scope = Attune::Model::ScopeEntry.new
    scope.name = 'category'
    scope.value = 'pants'
    ranking_params.scope = [scope]
    ranking = attune_client.entities.get_rankings(ranking_params)
    products.sort_by do |product|
      ranking.ranking.index(product.id.to_s)
    end
  end
end
```

The client provides a way to request a new auth_token through the API

``` ruby
client = Attune::Client.new
auth_token = client.get_auth_token('my-client-id', 'my-client-secret')
```

Also see [Blacklist examples](blacklist.md) for examples of our blacklist API.

### Configuration

Attune can be configured globally

``` ruby
Attune.configure do |c|
  c.auth_token = "my-secure-auth-token"
  c.endpoint = "http://example.com/"
  c.timeout  = 5
end
```

Settings can also be overridden on a client object

``` ruby
client = Attune::Client.new(auth_token: "my-secure-auth-token", timeout: 2)
```

See the documentation for
[Attune::Configurable](http://rdoc.info/github/attune-api/attune-ruby/master/Attune/Configurable)
and the
[default configuration](http://rdoc.info/github/attune-api/attune-ruby/master/Attune/Default)
for more details.

### Debugging 
 How to identify attune vs control in the browser?
 You can identify the cell assignment by fetching the data in the below variable
 # @attr [String] cell Cell assignment
 https://github.com/attune-api/attune-ruby/blob/master/lib/attune/models/ranked_entities.rb

### Testing

For testing and development, the ranking API can be simulated using.

``` ruby
Attune.test_mode!
```

In this mode no API calls will be made, and rankings will be returned in their original order.
Calling `.test_mode!` is equivalent to setting `disabled` to true and `exception_handler` to `:mock`.

## Contributing

1. Fork it ( http://github.com/attune-api/attune-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
