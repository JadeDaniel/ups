class Tag < ApplicationRecord
    has_many :taggings
    has_many :items, through: :taggings
    has_many :contests, through: :taggings

    validates_presence_of :name

    def to_s
        name
    end
end
