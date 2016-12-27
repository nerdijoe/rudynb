class Listing < ActiveRecord::Base
  belongs_to :user

  attr_accessor :tag_list

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  # acts_as_taggable_on :skills, :interests


  def tag_list
    self.tags.map { |t| t.name }.join(", ")
  end

  def tag_list=(new_value)
    tag_names = new_value.split(/,\s+/)
    self.tags = tag_names.map { |name| ActsAsTaggableOn::Tag.where('name = ?', name).first or ActsAsTaggableOn::Tag.create(:name => name) }
  end

end
