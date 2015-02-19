class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.boolean :is_pom, default: false, null: false
      t.integer :tryst_id
      t.integer :length_s
      t.timestamp :start_time
      t.timestamp :finished_at

      t.timestamps null: false
    end
  end
end
