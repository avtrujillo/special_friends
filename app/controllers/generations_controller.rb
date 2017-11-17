class GenerationsController < ApplicationController

  def index
    @generations = Generation.all
  end

  def show
  end

  def my_gen
    @generation = Generation.find_by(id: current_user.id)
    if @generation
      redirect_to @generation
    else
      redirect_to @generation : render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

end
