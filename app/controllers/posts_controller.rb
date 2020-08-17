class PostsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    authorize @organization, :new_post?

    @post = Post.new
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @post
  end

  def create
    # TODO: move this validation later to pundit
    @organization = Organization.find(params[:organization_id])
    authorize @organization, :new_post?

    @post = Post.new(post_params)
    @post.organization = @organization 
    @post.save!
    
    flash[:notice] = 'Upload successful'
    redirect_to organization_path(@organization)
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
    params.require(:post).permit(:title, :description, :location, :date, images: [])
  end
end
