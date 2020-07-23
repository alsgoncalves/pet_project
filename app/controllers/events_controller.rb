class EventsController < ApplicationController
  def new
    @organization = Organization.find(params[:organization_id])
    @event = Event.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @event = Event.new(event_params)
    @event.organization = @organization
    if @event.save
      redirect_to organization_path(@organization)
      flash[:notice] = 'Upload successful.'
    else
      render :new
    end
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to organization_path(@organization)
    else
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:organization_id])
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to organization_path(@organization)
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :date, :part_count)
  end
end
