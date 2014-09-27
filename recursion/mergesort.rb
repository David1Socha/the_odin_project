def merge_sort(arr)
  return arr if arr.size == 1
  mid_index = arr.size / 2
  front =  merge_sort(arr[0...mid_index])
  back = merge_sort(arr[mid_index..-1])
  merged, i, j = [], 0, 0
  curr_front, curr_back = front[i], back[j]
  until curr_front.nil? && curr_back.nil? do
    if !curr_back.nil? && (curr_front.nil? || curr_front > curr_back)
      merged << curr_back
      j += 1
      curr_back = back[j]
    else
      merged << curr_front
      i += 1
      curr_front = front[i]
    end
  end
  return merged
end

#sample run for testing
TEST_ARR = [3,56,311,0,38,-44,2]
sorted_arr = merge_sort(TEST_ARR)
puts "#{TEST_ARR} sorts to #{sorted_arr}"