class Time
  def self.christmas_year
    if Time.now.month < 6
      return Time.now.year - 1
    else
      return Time.now.year
    end
  end
end
