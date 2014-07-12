def echo(x)
  x
end

def shout(x)
  x.upcase
end

def repeat(x, n=2)
  ("#{x} " * n).strip
end

def start_of_word(x, chars)
  x[0,chars]
end

def first_word(x)
  index_of_space = x.index(" ")
  index_of_space.nil? ? x : x[0, index_of_space]
end

def titleize(x)
  x.capitalize!
  words = x.split
  little_words = %w(the and over of)
  
  words.each do |word|
    word.capitalize! unless little_words.include?(word)
  end
  words.join(' ')
end