class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    # If the user searches for something: it will display the organizations in a 30km radius;
    # else: all organizations will be displayed
    @organizations = policy_scope(Organization)
    if params[:query].present?
      @organizations = Organization.near(params[:query], 30)
      @organizations = policy_scope(Organization)
    else
      @organizations = Organization.all
    end
    @selected_organizations = @organizations.order('created_at ASC').first(9)
  end

  def show
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def new
    @organization = Organization.new
    authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    authorize @organization

    @organization.save!
    @admin = Admin.new
    @admin.user_id = current_user.id
    @admin.organization_id = @organization.id
    @admin.can_edit = true
    @admin.can_add_events = true
    @admin.can_add_posts = true
    @admin.can_add_admin = true
    @admin.is_owner = true

    @admin.save!
    redirect_to organization_path(@organization)
  end

  def edit
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def update
    @organization = Organization.find(params[:id])
    authorize @organization
    @organization.update(organization_params)
    redirect_to organization_path(@organization)
  end

  def destroy
    authorize @organization
    @organization.destroy
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :address, :phone_number, :email, :category, :description, :city, :zip_code, :country, :avatar, photos: [])
  end
end
