class RenameBoardTripsTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :boards_trips, :board_trips
  end
end
