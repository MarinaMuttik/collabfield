# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_users
  user_id = 1
  10.times do
    User.create(
      name: "test#{user_id}",
      email: "test#{user_id}@test.com",
      password: '123456',
      password_confirmation: '123456'
    )
    user_id += 1
  end
end

Categories = {
  'hobby' => ['Arts', 'Sports', 'Sciences', 'Collecting', 'Reading', 'Other'],
  'study' => ['Arts and Humanities', 'Physical Science and Engineering',
           'Math and Logic', 'Computer Science', 'Data Science',
           'Economics and Finance', 'Business', 'Social Sciences',
           'Language', 'Law', 'Other'],
  'team' => ['Study', 'Development', 'Arts and Hobby', 'Other']
}

def seed_categories
  Categories.each do |branch, names|
    names.each do |name|
      Category.create(branch: branch, name: name)
    end
  end
end


def seed_posts
  categories = Category.all

  categories.each do |category|
    5.times do
      Post.create(
        title: Faker::Lorem.sentences[0],
        content: Faker::Lorem.sentences[0],
        user_id: rand(1..10),
        category_id: category.id
      )
    end
  end
end

if Rails.env.development?
  seed_users
  seed_categories
  seed_posts
end

if Rails.env.production?
  seed_categories
end
