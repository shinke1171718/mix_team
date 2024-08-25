class Admins::BaseController < ApplicationController

  layout 'admin'

  before_action :authenticate_admin!
  before_action :set_admin

  private

  def set_admin
    @admin = current_admin
  end
end
