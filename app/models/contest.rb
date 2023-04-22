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
  
    def self.total_bread_crumb_length
      3
    end
  
    def tag_list=(tags_string)
      tag_names = tags_string.downcase.split(",").map(&:strip).uniq.reject(&:empty?)
      self.tags = tag_names.map { |tag_name| Tag.find_or_initialize_by(name: tag_name) { |tag| } }
    end

    def get_bread_crumbs
      depth = Contest.total_bread_crumb_length + 1
      bread_crumbs = []
      c = self
      bread_crumbs.push c # add self
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
