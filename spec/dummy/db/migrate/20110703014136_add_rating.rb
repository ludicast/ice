class AddRating < ActiveRecord::Migration
  def self.up
    change_table :notes do |t|
      t.string :secret_data, :default => "Secret Data"
    end
  end

  def self.down
    remove_column :notes, :secret_data
  end
end
