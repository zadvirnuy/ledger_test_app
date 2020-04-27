class CreateTags < ActiveRecord::Migration[6.0]
  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :tags
  end
end
