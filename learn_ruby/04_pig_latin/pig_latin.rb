def translate(str)
  words = str.split
  words.map! {|word| latinize word}
  words.join(' ')
end

#Note: a word with no vowels will 'break' the program, since I'm not sure how Pig Latin rules would handle that
def latinize(word) 
  vowel_index = -1
  begin
  	previous_index = vowel_index
    vowel_index = word.index(/[aeiou]/, previous_index + 1)
  end while word[(vowel_index - 1) .. vowel_index] == "qu" && vowel_index != 0 
  latinized_word = "#{word[vowel_index..-1]}#{word[0,vowel_index]}ay"
end
