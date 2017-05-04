class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :chosen_level

  def highscore
    # Just didn't have anywhere else to put this at the moment
    @users = User.all.sort {|u1, u2| u1.co2_result <=> u2.co2_result }
    render 'users/index'
  end

  def chosen_level
    params[:level] && Level.find(params[:level]) || current_user && current_user.level || Level.first
  end
end
