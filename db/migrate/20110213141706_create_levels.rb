class CreateLevels < ActiveRecord::Migration
  def self.up
    create_table :levels do |t|
      t.integer :word_id
      t.integer :exercise_id
      t.integer :level
      t.datetime :next_visit
      t.timestamps
    end
    add_index :levels, :word_id
    add_index :levels, :exercise_id
    add_index :levels, :next_visit
    add_index :levels, :level


  end

  def self.down
    drop_table :levels
  end
end
