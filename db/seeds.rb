# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Idea.destroy_all
User.destroy_all
Review.destroy_all
Like.destroy_all

PASSWORD = "123"
super_user = User.create(
    first_name: "Admin",
    last_name: "User",
    email: "admin@user.com",
    password: PASSWORD,
    is_admin: true
)

5.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}@#{last_name}.com",
        password: PASSWORD
    )
end

users = User.all

50.times do
    created_at = Faker::Date.backward(days: 635 * 5)

    i = Idea.create(
        title: Faker::Quotes::Shakespeare.hamlet_quote,
        description: Faker::TvShows::BrooklynNineNine.quote,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
    )
    if i.valid?
        rand(1..5).times do
            Review.create(body: Faker::Hacker.say_something_smart, idea: i,user: users.sample)
        end
        i.likers = users.shuffle.slice(0, rand(users.count))
    end

end

ideas = Idea.all
reviews = Review.all
likes = Like.all

p "gerenrated #{ideas.count} ideas"
p "generated #{users.count} users"
p "generated #{reviews.count} reviews"
p "generated #{likes.count} likes"

