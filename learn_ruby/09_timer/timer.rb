class Timer
  
  def initialize
    @seconds = 0
  end

  def seconds
    @seconds
  end

  def seconds=(s)
    @seconds = s
  end

  def time_string
    h = pad @seconds / 3600 
    m = pad @seconds / 60 % 60
    s = pad @seconds % 60
    time_string = "#{h}:#{m}:#{s}"
  end

  def pad(val)
    val = val < 10 ? "0#{val}" : "#{val}"
  end

end