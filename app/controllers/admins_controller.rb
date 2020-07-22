class AdminsController < ApplicationController

  def is_owner?
    @admin.is_owner = true
  end
end
