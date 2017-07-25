class UserPrefsController < ApplicationController
  def interests
    @tags = Tag.all
    @user = current_user.email
  end

  def update_interest
  	tag  = params[:user][:tag]
  	user = params[:user][:user]
  	btn  = params[:button]
  	respond_to do |format|
      format.html { redirect_to env["HTTP_REFERER"], notice: 'Interest was successfully updated.' }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  private
    def user_prefs_params
      params.require(:user).permit(:tag)
    end
end
