class Account::PostsController < ApplicationController
	before_action :authenticate_user!

	def index
		@posts = current_user.posts.recent #.order("updated_at DESC")
	end
end
