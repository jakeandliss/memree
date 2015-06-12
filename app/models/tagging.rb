class Tagging < ActiveRecord::Base
  
  belongs_to :tag
  belongs_to :entry
  belongs_to :user

  after_save do
    update_column(:user_id, tag.user_id)
  end

end
