require 'will_paginate/array'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    # User Info Box
    @name = "#{current_user.first_name} #{current_user.last_name}"

    @my_participations = current_user.participations.map(&:event)

    # User Feed
    org_followed = current_user.favourites.map { |fav| fav.organization }

    posts_followed = org_followed.map { |org| org.posts }.flatten
    events_followed = org_followed.map { |org| org.events }.flatten

    @feed_items = (posts_followed + events_followed).sort_by { |x| x.created_at }.paginate(page: params[:page], per_page: 10)

    # Sugestions Box
    @org_recommended = (Organization.all - org_followed).first(3)

    @events_near = events_followed.first(3)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
