class AdminsController < ApplicationController

  
  def new
    @organization = Organization.find(params[:organization_id])
    @users = User.all
    @admin  = Admin.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @user_email = User.search(params[:email])
    if @user_email.valid?
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
