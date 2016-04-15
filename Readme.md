# Hurray
ActiveRecord extension for working with database arrays fields.

ordered_with
--
Get records ordered according to the ids order.<br />

``` ruby
User.where(id: [4, 2, 6])
#=> [#<User id: 2 ...>, #<User id: 4 ...>, #<User id: 6 ...>]
```

If you want to get User::ActiveRecord_Relation with specified order use ordered_with(ids):

``` ruby
User.ordered_with([4, 2, 6])
#=> [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>]
```
