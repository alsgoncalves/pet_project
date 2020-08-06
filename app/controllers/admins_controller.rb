class AdminsController < ApplicationController

  def new
    @organization = Organization.find(params[:organization_id])
    @admin = Admin.new
  end

  def create
    # Load data from the database.
    @organization = Organization.find(params[:organization_id])
    @candidate_user = User.find_by_email(params[:email])

    # Check is candidate user is valid.
    if @candidate_user.nil?
      return redirect_to :new_organization_admin, alert: "User not found."
    end

    # Check if the candidate user is already linked to the organization.
    if @candidate_user.admin_for?(@organization.id)
      return redirect_to :new_organization_admin, alert: 'User is already an admin to this organization!'
    end

    # Create an admin entry between the user and the organization.
    @admin = Admin.new
    @admin.user_id = @candidate_user.id
    @admin.organization_id = @organization.id

    @admin.can_edit = params[:can_edit] == '1'
    @admin.can_add_events = params[:can_add_events] == '1'
    @admin.can_add_posts = params[:can_add_posts] == '1'
    @admin.can_add_admin = params[:can_add_admin] == '1'
    @admin.is_owner = false

    @admin.save!
    redirect_to organization_admin_path(organization_id)
  end

  def show
    organization = Organization.find(params[:organization_id])
    @admins = organization.admins
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
