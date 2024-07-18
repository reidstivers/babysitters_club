class AddPhotosToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :photos, :string
  end
end
