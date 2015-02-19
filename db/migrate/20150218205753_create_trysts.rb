class CreateTrysts < ActiveRecord::Migration
  def change
    create_table :trysts do |t|
      t.integer :user_id
      t.integer :target_total_poms
      t.integer :pom_length_s
      t.integer :break_length_s
      t.integer :long_break_length_s
      t.integer :long_break_modulus
      t.integer :endtime

      t.timestamps null: false
    end
  end
end
