class StaticPagesController < ApplicationController

  skip_before_action :require_login

  def home
  end

  def db_backup
    send_file("#{Rails.root}/db/production.sqlite3", {
      filename: 'production.sqlite3',
      disposition: 'attachment'
    })
  end

  def help
  end

  def privacy_policy

  end
end
