class PostsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @post = Post.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @post = Post.new(post_params)
    @post.organization = @organization
    if @post.save
      redirect_to organization_path(@organization)
      flash[:notice] = 'Upload successful.'
    else
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to organization_path(@organization)
    else
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to organization_path(@organization)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :location, :date)
  end
end
