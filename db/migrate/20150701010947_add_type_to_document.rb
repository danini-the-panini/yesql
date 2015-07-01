class AddTypeToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :type, :string
  end
end
