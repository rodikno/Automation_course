require_relative "helper_methods"


#takes natural number and returns sum of its digits
def sum_of_digits(number)
  a, b = [], []
  sum = 0
  if is_natural_number(number)
    0.upto(number.size) {
      a = number.divmod(10)
      sum += a[1]
      number = a[0]
    }
    sum
  end
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

#returns index of last elem which follows the condition a[0] < elem < a[-1]
def last_element_in_range_index(array)
  range = (array.first+1...array.last)
  indexes_of_elements_in_range = []

  array.each_with_index do |elem, i|
    indexes_of_elements_in_range.push(i) if range.include?(elem)
  end
  indexes_of_elements_in_range.last
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