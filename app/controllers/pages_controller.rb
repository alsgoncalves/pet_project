require 'will_paginate/array'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    # User Box
    @user_name = "#{current_user.first_name} #{current_user.last_name}"

    org_followed = current_user.favourites.map(&:organization)
    @num_org_followed = org_followed.size

    @top_categories = top_categories(orgs: org_followed, top_num: 3)

    @events_part = current_user.participations.map(&:event)
    @num_events_part = @events_part.size
    @num_future_events_part = @events_part.select { |event| event.date >= DateTime.tomorrow.beginning_of_day }
                                           .size


    # User Feed
    posts_followed = org_followed.map(&:posts).flatten
    events_followed = org_followed.map(&:events).flatten

    @feed_items = (posts_followed + events_followed).sort_by(&:created_at)
                                                    .paginate(page: params[:page], per_page: 10)


    # Calendar pop-up box
    gon.calendar_events = calendar_top_events(events_followed: events_followed,
                                              events_part: @events_part,
                                              top_num: 3)


    # Sugestions Box
    # Still not implemented: missing the locations being quantified with coordinates
    @org_recommended = (Organization.all - org_followed).first(3)
    @events_near = events_followed.first(3)


    # In order for the AJAX requests to work
    respond_to do |format|
      format.html
      format.js
    end
  end

  # Get the top x categories in terms of num of orgs it contains; the result is an array with x arrays
  # where the first element is the name of the category and the second is the num of orgs it contains
  def top_categories(orgs:, top_num:)
    return orgs.group_by(&:category)
               .map { |k, v| [k.name, v.size] }
               .sort_by { |arr| - arr.last }
               .first(top_num)
  end

  # For each day, in the period of one month back and one month fowards in time, get the top x events;
  # first get the events where the user will be participating and fill the rest with events of orgs
  # the user follows
  def calendar_top_events(events_followed:, events_part:, top_num:)
    other_events = events_followed - events_part
    result = {}

    if params[:start_date].present?
      start_date = Date.parse params[:start_date]
    else
      start_date = Date.today
    end

    date_counter = start_date.prev_month

    while date_counter <= start_date.next_month
      helper_arr = events_part.select { |event| event.date.beginning_of_day == date_counter }
                              .first(top_num)
                              .map { |event| transform_event_format(event: event, participating: true) }

      helper_arr << other_events.select { |event| event.date.beginning_of_day == date_counter }
                                .first(top_num - helper_arr.size)
                                .map { |event| transform_event_format(event: event, participating: false) }

      result[date_counter.strftime('%Y-%m-%d')] = helper_arr.flatten
      date_counter += 1
    end

    return result
  end

  # Transform each event, in the array of events given, into an hash with the relevant key/value
  # properties to be transmited to the view
  def transform_event_format(event:, participating:)
    return {
      title: event.title,
      org_name: event.organization.name,
      org_cat_icon: event.organization.category.icon,
      location: event.location,
      time: event.date,
      part_count: event.part_count,
      participating: participating
    }
  end
end
