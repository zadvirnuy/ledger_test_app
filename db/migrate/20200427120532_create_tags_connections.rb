class CreateTagsConnections < ActiveRecord::Migration[6.0]
  def up
    create_table :tag_connections do |t|
      t.references :tag, index: true
      t.references :subject, polymorphic: true
    end
  end

  def down
    drop_table :tag_connections
  end
end
