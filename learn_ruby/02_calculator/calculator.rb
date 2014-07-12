def add(x,y)
  x + y
end

def subtract(x,y)
  x-y
end

def sum(x)
  x.inject(0) { |sum,element| sum + element}
end

def multiply(x)
  x.inject(1) { |product,element| product * element}
end

def power(x,y)
  pow = 1
  y.times do
    pow = pow * x
  end
  pow
end

def factorial(x)
  fact = 1
  x.times do |i|
    fact = fact * (i + 1)
  end
  x==0 ? 1 : fact
end

puts factorial(1)