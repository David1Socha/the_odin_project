def caesar_cipher(message, shift)
  lowercase_letters = ('a'..'z').to_a.join
  uppercase_letters = ('A'..'Z').to_a.join
  letters = lowercase_letters +  uppercase_letters;

  shift %= letters.size

  shifted_lowercase = lowercase_letters[shift..-1] + lowercase_letters[0...shift]
  shifted_uppercase = uppercase_letters[shift..-1] + uppercase_letters[0...shift]
  shifted_letters = shifted_lowercase + shifted_uppercase

  message.tr(letters, shifted_letters)
end

puts "Enter your message:"
original_message = gets.chomp

puts "Enter shift factor:"
shift = gets.chomp.to_i

translated_message = caesar_cipher(original_message, shift)
puts "Translated message: #{translated_message}"