class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :category_id
      t.string :secret

      t.timestamps
    end
  end
end
