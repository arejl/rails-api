class AddPrivateToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :private_article, :boolean
  end
end
