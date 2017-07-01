class UserPrefsController < ApplicationController
  # GET /levels
  # GET /levels.json
  def index
    @tags = Tag.all
  end

  def show
  end

  def interests
    @tags = Tag.all
  end
end
