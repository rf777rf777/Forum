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
		#@group = Group.find(params[:id])
		@group = current_user.groups.find(params[:id])
	end

	def create
		#@group = Group.new(group_params)
		
		@group = current_user.groups.new(group_params)

		if @group.save
			current_user.join!(@group)
			redirect_to groups_path ,notice: "CreateSuccess!"
		else
			render :new
		end
	end

	def update
		#@group = Group.find(params[:id])
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, notice: "UpdateSuccess!"
		else
			render :edit
		end
	end

	def destroy
		#@group = Group.find(params[:id])
		@group = current_user.groups.find(params[:id])

		@group.destroy
		redirect_to groups_path, alert: "GroupDelete"
	end

	def join
		@group = Group.find(params[:id])

		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "JoinSuccess!"
		else
			flash[:warning] = "You're already a member!"
		end

		redirect_to group_path(@group)
	end

	def quit
		@group = Group.find(params[:id])

		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:alert] = "QuitSuccess!"
		else
			flash[:warning] = "You're not the member yet!"
		end	

		redirect_to group_path(@group)
	end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end
end
