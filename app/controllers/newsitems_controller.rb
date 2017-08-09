class NewsitemsController < ApplicationController
  before_action :set_newsitem, only: [:show, :edit, :update, :destroy]

  SCORE_NEW_POST = 5
  SCORE_FIRST_POST = 25

  # GET /newsitems
  # GET /newsitems.json
  def index
    logger.debug "::: Newsitem index running"
    @newsitems = Newsitem.all.where(level: chosen_level).sort_by{ |obj| obj.created_at }.reverse
  end

  # GET /newsitems/1
  # GET /newsitems/1.json
  def show
    puts "=== SHOWING NEWSITEM #{@newsitem.id} - #{@newsitem.name}"
    @newsitem.read_by_user!(current_user.id)
  end

  # GET /newsitems/new
  def new
    @newsitem = Newsitem.new
  end

  # GET /newsitems/1/edit
  def edit
  end

  # POST /newsitems
  # POST /newsitems.json
  def create
    @newsitem = Newsitem.new(newsitem_params)
    puts "Created by user #{current_user.id}"
    @newsitem.created_by = current_user.id
    @newsitem.liked_by @user

    # New post, update streak counters
    last_newsitem = Newsitem.find_by_sql [
        "select created_at from newsitems where created_by=? order by created_at desc limit 1", current_user.id]
    if last_newsitem.count >= 1 then 
      last_post_date = Time.at(last_newsitem.first.created_at).to_date
      today = Date.today

      # Day streak
      if last_post_date == today then
        # Day streak preserved, already posted today
      elsif last_post_date == today - 1 then
        # Day streak preserved, this is the first post today
        current_user.streak_d = current_user.streak_d ? current_user.streak_d + 1 : 1
      else
        # Day streak lost
        current_user.streak_d = 0
      end

      # Week streak
      if last_post_date.cweek == today.cweek and last_post_date.year == today.year then
        # Week streak preserved, already posted this week
      elsif last_post_date.cweek == today.cweek - 1 or (last_post_date.cweek >= 52 and today.cweek == 1) then
        # FIXME: Check years also
        # Week streak preserved, this is the first post this week
        current_user.streak_w = current_user.streak_w ? current_user.streak_w + 1 : 1
      else
        # Week streak lost
        current_user.streak_w = 0
      end

      # Month streak
      if last_post_date.mon == today.mon and last_post_date.year == today.year then
        # Month streak preserved, already posted this month
      elsif last_post_date.mon == today.mon - 1 or (last_post_date.mon == 12 and today.mon == 1) then
        # FIXME: Check years also
        # Month streak preserved, this is the first post this month
        current_user.streak_m = current_user.streak_m ? current_user.streak_m + 1 : 1
      else
        # Week streak lost
        current_user.streak_m = 0
      end

    end
    current_user.post_score = current_user.post_score ? current_user.post_score + SCORE_NEW_POST : SCORE_FIRST_POST
    current_user.save

    respond_to do |format|
      if @newsitem.save
        format.html { redirect_to @newsitem, notice: 'Newsitem was successfully created.' }
        format.json { render :show, status: :created, location: @newsitem }
      else
        format.html { render :new }
        format.json { render json: @newsitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /newsitems/1
  # PATCH/PUT /newsitems/1.json
  def update
    respond_to do |format|
      if @newsitem.update(newsitem_params)
        format.html { redirect_to @newsitem, notice: 'Newsitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @newsitem }
      else
        format.html { render :edit }
        format.json { render json: @newsitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsitems/1
  # DELETE /newsitems/1.json
  def destroy
    @newsitem.destroy
    respond_to do |format|
      format.html { redirect_to newsitem_url, notice: 'Newsitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote 
    logger.debug "::: Upvote running"
    @newsitem = Newsitem.find(params[:id])
    @newsitem.upvote_by current_user
    logger.debug "Upvote: #{@newsitem} user=#{current_user}"
    redirect_to :back
  end  

  def downvote
    logger.debug "::: Downvote running"
    @newsitem = Newsitem.find(params[:id])
    @newsitem.downvote_by current_user
    logger.debug "Downvote: #{@newsitem} user=#{current_user}"
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsitem
      @newsitem = Newsitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def newsitem_params
      params.require(:newsitem).permit(:icon, :name, :text, :level_id, :tags, :bestbefore, :relevancedays, :links)
    end
end
