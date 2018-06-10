class CreateBoardsTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :boards_trips do |t|
      t.integer :board_id
      t.integer :trip_id
      t.timestamps null: false
    end
  end
end
