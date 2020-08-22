require 'will_paginate/array'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    # User Info Box
    @name = "#{current_user.first_name} #{current_user.last_name}"

    org_followed = current_user.favourites.map { |fav| fav.organization }
    @org_followed_num = org_followed.size

    # Create an array of arrays where the first element is the name of the category and the second
    # is the number of organizations followed in that category; sorted by the second argument (DESC)
    org_followed_by_category = org_followed.group_by(&:category)
                                            .map { |key, value| [key.name, value.size] }
                                            .sort_by { |arr| - arr.last }
    num_top_categories = 3
    @top_categories = org_followed_by_category.first(num_top_categories)

    @my_participations = current_user.participations.map(&:event)
    @my_participations_num = @my_participations.size
    @my_future_participations_num = @my_participations.reject { |event| event.date < DateTime.tomorrow.beginning_of_day }.size


    # User Feed
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
