# Dummy date vars
module DateContext
  def today
    Date.today.strftime('%Y-%m-%d')
  end

  def yesterday
    (Date.today - 1).strftime('%Y-%m-%d')
  end
end
