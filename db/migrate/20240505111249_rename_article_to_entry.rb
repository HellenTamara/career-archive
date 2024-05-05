class RenameEntryToEntry < ActiveRecord::Migration[7.1]
  def self.up
    rename_table :articles, :entries
  end

  def self.down
    rename_table :entries, :articles
  end
end
