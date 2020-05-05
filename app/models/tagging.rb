class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :contest, optional: true
  belongs_to :item, optional: true

  validate :one_and_no_more_objects_tagged

  def self.get_taggable
    [:contest, :item]
  end

  def tagged
    contest if contest
    item if item
  end

  def one_and_no_more_objects_tagged
    object_references = {
      :contest => contest, 
      :item => item
    }.compact
    if object_references.size == 0
      errors[:base] << "one existing object must be tagged"
    elsif object_references.size > 1
      object_references.each do |sym, obj|
        errors.add(sym, "only one object may be tagged") if obj.present?
      end
    end
  end
end
