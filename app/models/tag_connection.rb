class TagConnection < ActiveRecord::Base
  belongs_to :tag
  belongs_to :subject, polymorphic: true
end
