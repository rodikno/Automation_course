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


def max_num_of_digits_in_a_row(string)
  a = 0
  array = Array.new
  string.each_char do |char|
    if is_digit(char)
      a.next
    else
      a = 0
    end
    array.push a
  end
  array.max
end

def max_number_from_string(string)
  array = string.scan(/[0-9]*/)
  array.delete('')
  new = array.map { |elem| elem.to_i}
  new.max
end

print max_number_from_string('5545sd6455600s44d454sd45s')