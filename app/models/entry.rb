class Entry < ActiveRecord::Base
  belongs_to :title
  
    default_scope { order('entry_date DESC', 'created_at DESC') } 
  
end	