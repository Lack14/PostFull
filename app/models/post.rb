class Post < ActiveRecord::Base
	acts_as_votable
  belongs_to :user
  has_many :comments
  has_many :bookmarks
  mount_uploader :image,ImageUploader
  validates :titl, presence: true
  validates :body, presence: true
end
