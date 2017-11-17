class GenerationsController < ApplicationController

  def index
    @generations = Generation.all
  end

  def show
    @generation = Generation.find(params[:id])
  end

  def my_gen
    @generation = Generation.find_by(id: current_user.id)
    if @generation
      redirect_to @generation
    else
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

end
