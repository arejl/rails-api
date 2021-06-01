class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  scope :public_articles, -> { where(private_article: false) }
end