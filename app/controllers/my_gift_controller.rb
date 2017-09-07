class MyGiftController < ApplicationController
  before_action :current_user

  def index
    @gifts = Gift.where(giver: current_user)
  end
end
