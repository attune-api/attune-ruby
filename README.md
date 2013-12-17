# Attune

A client for the [Attune ranking API](http://attune.co/). Build using the excellent [faraday](https://github.com/lostisland/faraday) library.

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
    session[:attune_id] ||= attune_client.create_anonymous(user_agent: request.env["HTTP_USER_AGENT"])
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
    attune_client.bind(session[:attune_id], current_user.id)
  end
end
```

The client can then perform rankings

``` ruby
class ProductsController
  def index
    @products = Product.all

    ranking = attune_client.get_ranking(
      id: session[:attune_id],
      view: request.fullpath,
      collection: 'products',
      entities: @products.map(&:id)
    )
    @products.sort_by do |product|
      ranking.index(product.id.to_s)
    end
  end
end
```


### Configuration

Attune can be configured globally

``` ruby
Attune.configure do |c|
  c.endpoint = "http://example.com/"
  c.timeout  = 5
end
```

Settings can also be overridden on a client object

``` ruby
client = Attune::Client.new(timeout: 2)
```

## Contributing

1. Fork it ( http://github.com/freerunningtech/attune/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
