module FriendsHelper
  def christmas_year
    if Date.new.month < 6
      return Date.year - 1
    else
      return Date.year
    end
  end
end
