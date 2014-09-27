def fibs(n)
  curr = 1
  last = 0
  fibos = [last]
  fibos << curr unless n == 1
  (n-2).times do 
    temp = last + curr
    last = curr
    curr = temp
    fibos << temp
  end
  return fibos
end

def fibs_rec(n)
  return [0] if n == 1
  return [0,1] if n == 2
  prev_fibs = fibs_rec(n-1)
  return prev_fibs << (prev_fibs.last + prev_fibs[n-3])
end

def demonstrate_fibos
  puts "fibs(3):"
  puts fibs(3)
  puts
  
  puts "fibs(10):"
  puts fibs(10)
  puts
  
  puts "fibs_rec(3):"
  puts fibs_rec(3)
  puts
  
  puts "fibs_rec(10):"
  puts fibs_rec(10)
  puts
end

demonstrate_fibos