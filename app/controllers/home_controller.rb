class HomeController < ApplicationController
  def index
    @profile = current_user.profile.present? ? current_user.profile : nil
    @current_step = @profile&.next_step || :general
  end
end