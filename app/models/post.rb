class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :title, presence: true,
                    length: { minimum: 3, maximum: 200 }
  validates :content, presence: true,
                      length: { minimum: 20 }
  validates :category_id, presence: true

  default_scope { includes(:user).order(created_at: :desc) }

  scope :by_branch, -> (branch) do
    joins(:category).where(categories: { branch: branch })
  end

  scope :by_category, -> (branch, category_name) do
    joins(:category).where(categories: { name: category_name, branch: branch })
  end

  scope :search, -> (search) do
    where("title ILIKE ? OR content ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
