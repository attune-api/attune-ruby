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
params.active_from = DateTime.now
params.active_to = DateTime.now + 7
response = client.entities.blacklist_save(params)
blacklist_id = response.id
```

## Retrieve a blacklist entry

``` ruby
blacklist = client.entities.blacklist_get(blacklist_id)
```

## Update a blacklist entry

``` ruby
params = Attune::Model::BlacklistParams.new
params.disabled = true
client.entities.blacklist_update(blacklist_id, params)
```

## Delete a blacklist entry

``` ruby
client.entities.blacklist_delete(blacklist_id)
```

## Get all blacklists for your account

``` ruby
response = client.entities.blacklist_get_all()
all_blacklists  = response.blacklists
```
