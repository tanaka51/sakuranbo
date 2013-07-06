# Sakuranbo

Sakuranbo provides `lazy_update` to `AR::Base.has_many`.

This solves has_many's update.

## Installation

Add this line to your application's Gemfile:

    gem 'sakuranbo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakuranbo

## Usage

```rb
class User < ActiveRecord::Base
  has_many :comments, lazy_update: true
end

# Adds `attr_accessor :cached_comment_ids`

user = User.create!
user.cached_comment_ids # => nil

# Assigns `cached_comment_ids` to `comment_ids` in before_save

cooment = Comment.create!
user.cached_comment_ids = [comment.id]
user.cached_comment_ids # => [51]
user.comment_ids        # => []
user.save!
user.comment_ids        # => [51]
```

And you can name prefix to specify option except `true`.

```rb
class User < ActiveRecord::Base
  has_many :comments, lazy_update: :my_prefix
end

# Adds `attr_accessor :my_prefix_comment_ids`

user = User.create!
user.my_prefix_comment_ids # => nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
