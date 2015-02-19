class CreatePauses < ActiveRecord::Migration
  def change
    create_table :pauses do |t|
      t.integer :time_block_id
      t.datetime :start_time
      t.integer :length_s

      t.timestamps null: false
    end
  end
end
