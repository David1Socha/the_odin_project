def find_substrings(str, dictionary)
  substrings = Hash.new
  words = str.downcase.split(' ')
  dictionary.each do |dict_word|
    occurrences = words.select { |word| word.include? dict_word }.length
    substrings[dict_word] = occurrences if occurrences > 0
  end
  return substrings
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

msg = "Howdy partner, sit down! How's it going?"
substrings = find_substrings(msg, dictionary)
puts "\"#{msg}\" contains the following substrings: #{substrings.to_s}"