class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :url, null: false

      t.timestamps
    end
    add_index :entries, :url, unique: true
  end
end
