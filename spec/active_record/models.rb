# models
class User < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :user
end

# migration
class CreateAllTables < ActiveRecord::Migration
  create_table(:users)    { |t| t.string :name }
  create_table(:comments) { |t| t.string :body; t.integer :user_id }
end
ActiveRecord::Migration.verbose = false
CreateAllTables.up
