# Blacklist API

## Add a blacklist entry

``` ruby
params = Attune::Model::BlacklistParams.new
params.ids = [1,2,3]
params.entity_type = 'products'
scope = Attune::Model::ScopeEntry.new
scope.name = 'page'
scope.value = 'sale'
params.scope = [scope]
params.active_from = '2012-06-04 19:00:00'
params.active_to = '2012-06-06 19:00:00'
client.entities.blacklist_save(params)
```

## Retrieve a blacklist entry

``` ruby
blacklist = client.entities.blacklist_get(blacklist_id)
```

## Update a blacklist entry

``` ruby
params = Attune::Model::BlacklistParams.new
params.disabled = true
client.entities.blacklist_update(params)
```

## Delete a blacklist entry

``` ruby
client.entities.blacklist_delete(blacklist_id)
```

## Get all blacklists for your account
``` ruby
all_blacklists = client.entities.blacklist_get_all(blacklist_id)
```
