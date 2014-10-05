def caesar_cipher(message, shift)
  lowercase_letters = ('a'..'z').to_a.join
  uppercase_letters = ('A'..'Z').to_a.join
  letters = lowercase_letters +  uppercase_letters;

  shift %= lowercase_letters.size

  shifted_lowercase = lowercase_letters[shift..-1] + lowercase_letters[0...shift]
  shifted_uppercase = uppercase_letters[shift..-1] + uppercase_letters[0...shift]
  shifted_letters = shifted_lowercase + shifted_uppercase

  message.tr(letters, shifted_letters)
end