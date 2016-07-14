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

def number_of_first_matching_chars(string)
  matching_array = Array.new
  string.each_char do |char|
    until matching_array.include?(char)
      matching_array.push char
    end
  end
  matching_array.length
end

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

def print_elements_in_range(array)
  range = (array.first..array.last)
  array.each do |elem|
    print elem if range.include?(elem)
  end
end

def add_first_elem_to_each_even(array)
  range = (1...array.length-1)
  array.each_with_index do |elem, index|
    if range.include?(index) && elem.even?
      array[index] += array[0]
    end
  end
  array
end