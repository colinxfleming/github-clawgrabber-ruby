# Dummy date vars
class DateContext
  def initialize
    @today = Date.today.strftime('%Y-%m-%d')
    @yesterday = (Date.today - 1).strftime('%Y-%m-%d')
  end
end
