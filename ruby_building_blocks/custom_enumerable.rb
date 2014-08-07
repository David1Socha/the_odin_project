module Enumerable

  def my_each
    return self unless block_given?
    for element in self
      yield element
    end
  end

  def my_each_with_index
    return self unless block_given?
    i = 0
    for e in self
      yield(e, i)
      i += 1
    end
  end

  def my_select
  	return self unless block_given?
    arr = Array.new
    my_each do |e|
      arr << e if yield e
    end
    return arr
  end

  def my_all?
    if block_given?
      my_each do |e|
        return false unless yield e
      end
    else
      my_each do |e|
        return false unless e
      end
    end
    true
  end

  def my_any?
    if block_given?
      my_each do |e|
        return true if yield e
      end
    else
      my_each do |e|
        return true if e
      end
    end
    false
  end  

  def my_none?
    if block_given?
      my_each do |e|
        return false if yield e
      end
    else
      my_each do |e|
        return false if e
      end
    end
    true
  end  

  def my_count(item = nil)
    count = 0

    if block_given?
      my_each do |e|
      	count += 1 if yield e
      end
    else
      my_each do |e|
      	count += 1 if e == item || item.nil?
      end
    end
    
    count
  end

#  def my_map
#  	arr = Array.new
#  	if block_given?
#  	  my_each do |e|
#  	    arr << yield e
#  	  end
#  	  return arr
#  	else
#  	  return self
#    end
#  end

  def my_map(proc)
  	arr = Array.new
  	my_each do |e|
  	  new_element = proc.call(e)
  	  new_element = yield new_element
  	  arr << new_element
  	end
  	return arr
  end

  def my_inject(initial = nil)
  	if initial.nil?
  	  accum = self.first
  	  my_each_with_index do |e, i|
  	  	accum = yield(accum, e) unless i == 0
  	  end
  	else
  	  accum = initial
  	  my_each do |e|
  	  	accum = yield(accum, e)
  	  end
  	end
  	return accum
  end
  
end

def multiply_els(arr)
  arr.my_inject { |prod, n| prod * n}
end