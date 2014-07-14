class Book
  
  LITTLE_WORDS = %w(the and over of in a an)

  def title
  	@title
  end

  def title=(s)
  	@title = s.split.each do |word| 
  		word.capitalize! unless LITTLE_WORDS.include?(word)
  	end

  	@title[0].capitalize!
    @title = @title.join(' ')
  end

end