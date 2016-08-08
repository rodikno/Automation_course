require_relative "helper_methods"

#takes natural number and returns sum of its digits
def sum_of_digits(number)
  sum = 0
  if is_a_natural_number?(number)
    string_number = number.to_s
    string_number.each_char { |digit| sum += digit.to_i }
  else
    raise "Argument is not a natural number"
  end
  print sum
end

#takes a string and returns value of max number of digits placed in a row
def max_num_of_digits_in_a_row(string)
  array = string.scan(/[0-9]*/)
  array.max_by(&:length)
end

#takes a string and returns maximum number which could be found there
def max_number_from_string(string)
  array = string.scan(/[0-9]*/)
  array.delete('')
  new = array.map { |elem| elem.to_i}
  new.max
end

#counts chars matching in two strings starting from the left, stops on the first not matching char
def number_of_first_matching_chars(base_string, compare_string)
  base_array, compare_array = base_string.scan(/./), compare_string.scan(/./)
  counter = 0
  base_array.each_with_index do |elem, i|
    if base_array[i] == compare_array[i]
      counter += 1
    else break
    end
  end
  counter
end

#puts elements with even indexes, then with odd indexes
def even_odd_by_index(array)
  even, odd = [], []
  i = 0
  array.length.times do
    if i.even?
      even.push array[i]
    else
      odd.push array[i]
    end
    i += 1
  end
  print "Even: #{even}\nOdd: #{odd}"
end

#returns index of last elem of a given array which follows the condition a[0] < elem < a[-1]
def last_element_conditional_index(array)
  indexes_of__fitting_elements = Array.new

  array.each_with_index do |elem, i|
    indexes_of__fitting_elements.push(i) if (elem > array.first) && (elem < array.last)
  end
  indexes_of__fitting_elements.last
end

#modifies given array by adding first element to each even number
def add_first_elem_to_each_even(array)
  range = (1...array.length-1)
  array.each_with_index do |elem, index|
    if range.include?(index) && elem.even?
      array[index] += array[0]
    end
  end
  array
end

#replaces a keys of a given hash with symbols and values with integers,
#otherwise puts nil as a value
def hash_to_sym_and_int(hash)
  hash.each_pair do |key, value|
    key = key.to_sym
    is_an_integer?(value) ? hash[key] = value.to_i : hash[key] = nil
  end
  hash
end

#removes all pairs from hash where first char of a key in string representation is "s"
def hash_remove_when_starts_with_s(hash)
  hash.delete_if { |key, value| key.to_s[0] == 's' }
end

#keeps in a given hash only pairs where value is a natural number and value > 0
def hash_keep_natural_only(hash)
  hash.keep_if { |key, value| is_a_natural_number?(value) }
end