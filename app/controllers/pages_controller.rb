require 'will_paginate/array'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    # User Info Box
    @user_name = "#{current_user.first_name} #{current_user.last_name}"

    org_followed = current_user.favourites.map { |fav| fav.organization }
    @num_org_followed = org_followed.size

    # Create an array of arrays where the first element is the name of the category and the second
    # is the number of organizations followed in that category; sorted by the second argument (DESC)
    org_followed_by_category = org_followed.group_by(&:category)
                                            .map { |key, value| [key.name, value.size] }
                                            .sort_by { |arr| - arr.last }
    num_top_categories = 3
    @top_categories = org_followed_by_category.first(num_top_categories)

    @my_participations = current_user.participations.map(&:event)
    @num_my_participations = @my_participations.size
    @num_my_future_participations = @my_participations.reject { |event| event.date < DateTime.tomorrow.beginning_of_day }.size


    # User Feed
    posts_followed = org_followed.map { |org| org.posts }.flatten
    events_followed = org_followed.map { |org| org.events }.flatten

    @feed_items = (posts_followed + events_followed).sort_by { |x| x.created_at }.paginate(page: params[:page], per_page: 10)


    # Sugestions Box
    @org_recommended = (Organization.all - org_followed).first(3)

    @events_near = events_followed.first(3)


    # Calendar side box
    @calendar_events = calendar_top_events(events_followed, @my_participations)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def calendar_top_events(events_followed, my_events)
    result = {}
    date_counter = Date.today.prev_month
    other_events = events_followed - my_events

    while date_counter <= Date.today.next_month
      arr = my_events.select {|x| x.date.beginning_of_day == date_counter }.first(3).map { |event| transform_event(event, true)}
      arr << other_events.select {|x| x.date.beginning_of_day == date_counter }.first(3 - arr.size).map { |event| transform_event(event, false)}

      result[date_counter.strftime('%Y-%m-%d')] = arr.flatten
      date_counter += 1
    end

    return result
  end

  def transform_event(event, participation)
    return {
      title: event.title,
      org_name: event.organization.name,
      location: event.location,
      time: event.date,
      part_count: event.part_count,
      participating: participation
    }
  end
end
