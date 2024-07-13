class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.date :start_at
      t.date :end_at
      t.integer :status
      t.text :notes

      t.timestamps
    end
  end
end
