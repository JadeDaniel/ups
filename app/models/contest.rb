class Contest < ApplicationRecord
   has_many :contests, :foreign_key => 'parent_id'
   has_many :votes, dependent: :delete_all

   has_many :items
   has_many :taggings
   has_many :tags, through: :taggings

   def tag_list
      tags.join(", ")
    end
  
    def tag_list=(tags_string)
      tag_names = tags_string.split(",").collect{|s| s.strip.downcase }.uniq
      new_or_found_tags = tag_names.collect { |tag_name| Tag.find_or_initialize_by(name: tag_name) }
      self.tags = new_or_found_tags
    end
end
