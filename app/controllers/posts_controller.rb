class PostsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @post = Post.new
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @post
  end

  def create
    # TODO: move this validation later to pundit
    @organization = Organization.find(params[:organization_id])
    authorize @post

    current_user_admin = @organization.find_admin(current_user)

    if current_user_admin != nil && current_user_admin.can_add_posts
      @post = Post.new(post_params)
      @post.organization = @organization 
      @post.save!
      flash[:notice] = 'Upload successful'
      redirect_to organization_path(@organization)
    else
      flash[:alert] = "You are not allowed to perform this action"
    end
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to organization_path(@organization)
    else
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to organization_path(@organization)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :location, :date)
  end
end
