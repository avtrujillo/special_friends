class HTMLErrorsController < ApplicationController

  def error_status_page
    render status: params[:error_id],
      file: "#{Rails.root}/public/#{params[:error_id]}.html" and return
  end

end
