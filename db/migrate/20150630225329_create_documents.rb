class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.jsonb :body

      t.timestamps null: false
    end
  end
end
