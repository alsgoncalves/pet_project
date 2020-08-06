class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :warning
  before_action :authenticate_user!
end
