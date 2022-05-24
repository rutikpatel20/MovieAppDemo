class Movie < ApplicationRecord
  has_one_attached :poster do |attachable|
    attachable.variant :thumb, resize_to_limit: [350, 350]
  end
  has_many_attached :images
end
