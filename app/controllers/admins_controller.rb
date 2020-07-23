class AdminsController < ApplicationController

  
  def new
    @organization = Organization.find(params[:organization_id])
    @admin  = Admin.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
