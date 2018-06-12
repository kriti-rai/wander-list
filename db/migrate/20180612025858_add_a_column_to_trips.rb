class AddAColumnToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :url, :string
  end
end
