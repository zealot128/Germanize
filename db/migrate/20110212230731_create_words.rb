class CreateWords < ActiveRecord::Migration
  def self.up
    create_table :words do |t|
      t.integer :user_id
      t.string :name
      t.text :translation
      t.text :examples
      t.string :wordform
      t.text :grammar
      t.integer :level
      t.datetime :next_visit
      t.text :stats

      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end
end
