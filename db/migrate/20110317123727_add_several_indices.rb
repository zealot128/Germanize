class AddSeveralIndices < ActiveRecord::Migration
  def self.up
    add_index :exercises, :user_id
    add_index :words, :user_id
    add_index :words, :created_at
  end

  def self.down
  end
end
