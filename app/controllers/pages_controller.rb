class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def feed
    @name = "#{current_user.first_name} #{current_user.last_name}"
  end
end
