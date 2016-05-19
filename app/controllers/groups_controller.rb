class GroupsController < ApplicationController
	before_action :authenticate_user! , except: [:index,:show]

	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end

	def show
		@group = Group.find(params[:id])

		#在 groups 下的 show action 撈出 @group 所有的 posts
		@posts = @group.posts
	end

	def edit
		@group = Group.find(params[:id])
	end

	def create
		@group = Group.new(group_params)

		if @group.save
			redirect_to groups_path
		else
			render :new
		end
	end

	def update
		@group = Group.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, notice: "UpdateSuccess!"
		else
			render :edit
		end
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to groups_path, alert: "GroupDelete"
	end


	private

	def group_params
		params.require(:group).permit(:title, :description)
	end
end
