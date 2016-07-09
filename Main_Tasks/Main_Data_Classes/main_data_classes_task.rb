require_relative "helper_methods"

#method takes natural number and returns sum of its digits
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


def max_num_of_digits_in_a_row(some_string)
  a = 0
  array = Array.new
  some_string.each_char do |char|
    if is_digit(char)
      a += 1
    else
      a = 0
    end
    array.push a
  end
  array.max
end

puts max_num_of_digits_in_a_row('sdsssdfs5656ssd')