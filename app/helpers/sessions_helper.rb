module SessionsHelper

  def log_in(user)
    session[:id] = user.id
  end

  def current_user
    @current_user ||= Friend.find_by(id: session[:id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:id)
    @current_user = nil
  end

  def omniauth_strategies
    OmniAuth.strategies - [OmniAuth::Strategies::OAuth2]
  end

  def strategy_basename(strat)
    strat.to_s[22..-1]
  end

end
