class UserPrefsController < ApplicationController
  def interests
    @tags = Tag.all
    @user = current_user.email
  end

  def update_interest
  	tag  = params[:user][:tag].to_i
  	user = params[:user][:user].to_i
  	btn  = params[:button]
  	id = user*1000 + tag ## TODO: Better handling of composite key needed. This "works" for up to 1000 tags and 2M users
	interest = UserInterest.find_or_initialize_by(tag_id: tag, id: id)
	if interest.weight == nil then interest.weight = 0 end
	if btn == '+' then interest.weight += 1 end
	if btn == '-' then interest.weight -= 1 end
	interest.save!
  	respond_to do |format|
      format.html { redirect_to env["HTTP_REFERER"] }
      format.json { render :show, status: :ok, location: @user }
    end
  end

  private
    def user_prefs_params
      params.require(:user).permit(:tag)
    end
end
