class AddDestinationToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :destination, :string
  end
end
