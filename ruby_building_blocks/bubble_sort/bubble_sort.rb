def bubble_sort(array)
  bubble_sort_by(array) { |l, r| r <=> l}
end

def bubble_sort_by(array)
  arr = array.clone
  arr.each_index do |i|
  	(arr.size - 1).downto(i) do |j|
  	  arr[j-1], arr[j] = arr[j], arr[j-1] if yield(arr[j-1],  arr[j]) < 0
  	end
  end
end

sample_array = [4,3,78,2,0,2]
sorted_sample_array = bubble_sort(sample_array)
puts "#{sample_array}, after bubble_sort, becomes #{sorted_sample_array}"

second_sample_array = ["hi","hello","hey"]
sorted_second_array = bubble_sort_by(second_sample_array) { |left, right| right.length - left.length}
puts "#{second_sample_array}, after bubble_sort_by block '{ |left, right| right.length - left.length}', becomes #{sorted_second_array}"
