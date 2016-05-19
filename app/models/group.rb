class Group < ActiveRecord::Base
	#限制 title 不能為空
	validates :title,presence: true
end
