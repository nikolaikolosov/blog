class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :body
      t.references :user, index: true

      t.timestamps
    end
    add_index :comments, :post_id
  end
end