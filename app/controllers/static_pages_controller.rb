class StaticPagesController < ApplicationController

  skip_before_action :require_login

  def home
  end

  def help
  end

  def privacy_policy

  end
end
