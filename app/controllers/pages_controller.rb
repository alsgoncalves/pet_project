require 'will_paginate/array'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    @name = "#{current_user.first_name} #{current_user.last_name}"

    organizations_followed = current_user.favourites.map { |fav| fav.organization }

    posts = organizations_followed.map { |org| org.posts }.flatten
    events = organizations_followed.map { |org| org.events }.flatten

    @items = (posts + events).sort_by { |x| x.created_at }.paginate(page: params[:page], per_page: 10)

    @organizations_recommended = (Organization.all - organizations_followed).first(3)

    @near_events = events.first(3)
  end
end
