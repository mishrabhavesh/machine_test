class AddCurrentArticleToUsers < ActiveRecord::Migration[6.0]
  def change

    add_column :users, :current_article, :integer 
  end
end
