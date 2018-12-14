class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # destroy deletes all posts user made if the user is destroyed
  has_many :posts, dependent: :destroy

  validates :name, presence: true,
                   uniqueness: { case_sensitive: true }
end
