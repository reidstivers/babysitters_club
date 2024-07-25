class AddQualificationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :qualification, :string
  end
end
