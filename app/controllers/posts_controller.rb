class PostsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @post = Post.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    if @organization.admin?
      Post.new(post_params)
    else
      flash[:alert] = "You are not allowed to perform this action"
    end
    if @post.save
      redirect_to organization_path(@organization)
      flash[:notice] = 'Upload successful.'
    else
      render :new
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :location, :date)
  end
end
