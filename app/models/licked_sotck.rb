class LickedSotck < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :user
  has_many :articles
end
