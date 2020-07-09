class Article < ApplicationRecord

    belongs_to :category
    belongs_to :user
    has_many :comments
    validates :title, presence: true
    validates :description, presence: true
    validates :category_id, presence: true
    belongs_to  :licked_sotck
    scope :search, -> category_id { where(category_id: category_id)}

    def self.like_inc(article)
        Article.find(article_id)
        
    end

    def self.comment(comment,article_id,current_user)
        Comment.create(comment: comment, article_id: article_id, user_id: current_user)
    end
end
