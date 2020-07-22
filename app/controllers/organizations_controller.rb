class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index   #to be implemented when add map
    #if params[:search].nil? || params[:search] == ""
     # @organizations = Organization.geocoded
    #else
      #@organizations = Organization.search_by_full_name(params[:search])
   # end
   # @markers = @organizations.map do |organization|
     # {
     #   lat: organization.latitude,
     #   lng: organization.longitude
     # }
    #end
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def new
    @organization = Organization.new
    # authorize @organization
  end

  def create
    @organization = Organization.new(organization_params)
    # authorize @organization

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
    # authorize @organization
  end

  def update
    @organization = Organization.find(params[:id])
    # authorize @organization
    @organization.update(organization_params)
    redirect_to organization_path(@organization)
  end

  def destroy
    # authorize @organization
    @organization.destroy
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :address, :phone_number, :email, :category, :description, :city, :zip_code, :country, photos: [])
  end
end
