class ParticipationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    authorize @event, :new_participation?
  end

  def create
    @event = Event.find(params[:event_id])
    authorize @event

    @participation = Participation.new
    @participation.user = current_user
    @participation.event = @event
    @participation.save!
  end

  def destroy
    participation = Participation.find_by(event_id: params[:event_id], user_id: current_user.id).first
    authorize participation

    participation.destroy

    redirect_to :organizations_path, alert: 'Your participation has been deleted'
  end

end
