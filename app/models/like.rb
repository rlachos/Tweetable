class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, counter_cache: :likes_count
  validates :user_id, uniqueness: { scope: :tweet,
                                    message: "Oops, you already said that!" }
end
