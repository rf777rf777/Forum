class Group < ActiveRecord::Base
	#限制 title 不能為空
	validates :title,presence: true

	has_many :posts

	belongs_to :owner,class_name: "User",foreign_key: :user_id

	def editable_by?(user)
		user && user == owner
	end
end
