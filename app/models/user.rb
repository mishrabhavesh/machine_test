class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 105},
              format: { with: VALID_EMAIL_REGEX }
    validates_uniqueness_of :email
    has_secure_password
    belongs_to :role
    has_many :articles
    has_many :comments
    has_many :licked_sotcks
end
