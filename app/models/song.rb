class Song < ActiveRecord::Base
  has_many :adds, dependent: :destroy
  belongs_to :user

  validates :artist, :title, presence: true, length: {in: 2..40}
end
