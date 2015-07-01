YeSQL
=====

This is a quick example app I threw together to demonstrate the use of Postgres JSONB with Ruby on Rails.

Originally for a [talk](http://www.meetup.com/joziruby/events/222957475/) I did at [Jozi.rb](http://www.meetup.com/joziruby/).

Requires Rails 4.2 and Postgres 9.4

```
$ bundle install
$ rake db:setup
$ rails server
```

The repo has branches strategically placed throughout the lifecycle of the app. You can go through it step by step:

1-document
----------

In this branch, the model `Document` has been set up with a string title and JSONB body. ActiveRecord supports JSONB natively so the migration is as simple as `t.jsonb :body`

```ruby
create_table :documents do |t|
  t.string :title
  t.jsonb :body

  t.timestamps null: false
end
```

ActiveRecord allows you to store Ruby hashes and arrays in JSONB columns as-is, so setting up a simple form that saves to the database is as easy as:

```ruby
# view
= text_field_tag('body[foo]', @document.body['foo'])
# ...
= text_field_tag('body[bar]', @document.body['bar'])

# controller
@document = Document.new(title: params[:title], body: params[:body])
```

Which will save a JSON object to the db that will look something like `{"foo": "lorem", "bar": "ipsum"}`

Postgres allows JSONB data to contain any valid JSON, and will validate any inserted JSON for you.

2-search
--------

In this branch a search feature is added, which allows for searching for text at specific keys in the JSON structure.

Here's a query on `body.foo` in `documents#index`:

```ruby
@documents.where("body ->> 'foo' ILIKE ?", "%#{params[:body][:foo]}%")
```

The `->>` operator selects the `foo` property from the `body` JSON and coerces it into the equivalent Postgres type, so you can then continue to operate on the value as you would any normal column. In this example, `ILIKE` is used to do case-insensitive string matching.

3-validation
------------

This just shows how a simple ActiveRecord Validator can be used to validate the contents of a JSONB column. Since ActiveRecord parses JSONB as a Ruby hash, it is straightforward to retrieve and validate data from it:

```ruby
if record.body['foo'].blank?
  record.errors['foo'] << 'is required'
else
  record.errors['foo'] << 'must be at least 5 characters long' if record.body['foo'].size < 5
end
```

4-types
-------

Rails makes single-table inheritance a breeze. A single table with a JSONB column and a type column can be used to make dozens of models without the need for dozens of tables, which usually requires a lot of schema design and migrations after migrations.

The two types in this example are `FooBarDocument` and `LoremIpsumDocument`, and the only difference between the two are the validation, but naturally anything can happen from this point on:

```ruby
class FooBarDocument < Document
  validates_with FooBarDocumentValidator
end

class LoremIpsumDocument < Document
  validates_with LoremIpsumDocumentValidator
end
```
