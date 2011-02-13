class DropSomeCols < ActiveRecord::Migration
  def self.up
    remove_column :words, :next_visit
    remove_column :words, :stats
    remove_column :words, :level
    add_column :levels, :stats, :text
  end

  def self.down
  end
end
