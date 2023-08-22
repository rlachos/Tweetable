# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

puts "Creating previous data..."

Like.delete_all
Tweet.delete_all
User.delete_all

puts "Database cleared."

ActiveRecord::Base.connection.reset_pk_sequence!('likes')
ActiveRecord::Base.connection.reset_pk_sequence!('tweets')
ActiveRecord::Base.connection.reset_pk_sequence!('users')

puts "Reseted ids"

puts "Seeding users and tweets..."

5.times do |index|

    user = User.new(email: "user#{index}@gmail.com",
                  username: Faker::Internet.unique.username(specifier: (1..16)),
                  name: Faker::Name.name,
                  password: "#{Faker::Internet.password(min_length: 6)}#{rand(1..9)}",
                  role: 0)

  user.avatar.attach(io: URI.open(Faker::Avatar.unique.image(size: "100x100", format: "jpg")), filename: "#{index}.jpg")
  p user.errors.full_messages unless user.save

  tweet = Tweet.create(body: Faker::Quote.unique.famous_last_words, user_id: user.id)

end

puts "Seeding of #{User.all.size} users and #{Tweet.all.size} tweets completed."

puts "Seeding replies..."

Tweet.all.each do |tweet|
  users = User.all.to_a
  #users.delete(tweet.user)

  users.each do |user|
    reply = Tweet.create(body: Faker::Quote.unique.famous_last_words, user_id: user.id)
    tweet.replies.push(reply)
  end
end

puts "Seeding of replies completed."

puts "Seeding likes..."

User.all.each do |user|
  liked_tweets = Tweet.all.sample(rand(3..8))

  liked_tweets.each do |tweet|
    Like.create(user_id: user.id, tweet_id: tweet.id)
  end
end