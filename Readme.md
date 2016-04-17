# Hurray
ActiveRecord extension for working with database arrays fields.

Installation
--
Add following line to Gemfile

``` ruby
gem 'hurray'
```

ordered_with
--
Get records ordered according to the specified with array column order.<br />

``` ruby
User.where(id: [4, 2, 6])
#=> [#<User id: 2 ...>, #<User id: 4 ...>, #<User id: 6 ...>]
```

If you want to get User::ActiveRecord_Relation with specified order use

```ordered_with(column, array, options = { provided: false, direction: :asc })```

``` ruby
User.ordered_with(:id, [4,2,6])
#=> User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>, #<User id: 1 ...>, ...]

User.ordered_with(:id, [4,2,6], provided: true)
#=> User::ActiveRecord_Relation [#<User id: 4 ...>, #<User id: 2 ...>, #<User id: 6 ...>]

User.ordered_with(:name, %w(Nick Malvin John), provided: true)
#=> User::ActiveRecord_Relation [#<User name: Nick ...>, #<User name: Malvin ...>, #<User name: John ...>]
```
