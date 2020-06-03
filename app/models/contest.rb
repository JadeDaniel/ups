class Contest < ApplicationRecord
   has_many :contests, :foreign_key => 'parent_id'
   has_many :votes, dependent: :delete_all

   has_many :items
   has_many :taggings
   has_many :tags, through: :taggings

   def tag_list
      tags.join(", ")
    end

    def get_parent
      if self.parent_id
        Contest.find self.parent_id
      end
    end
  
    def self.bread_crumb_length
      3
    end
  
    def tag_list=(tags_string)
      tag_names = tags_string.split(",").collect{|s| s.strip.downcase }.uniq
      new_or_found_tags = tag_names.collect { |tag_name| Tag.find_or_initialize_by(name: tag_name) }
      self.tags = new_or_found_tags
    end

    def get_bread_crumbs
      depth = Contest.bread_crumb_length + 1
      bread_crumbs = []
      c = self
      while depth > 0 
        if c.get_parent
          c = c.get_parent
        else 
          bread_crumbs.push 'root'
          break
        end
        bread_crumbs.push c
        depth = depth - 1
      end
      bread_crumbs
    end
end
