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
  array = string.scan(/[0-9]*/)
  array.max_by(&:length)
end

def max_number_from_string(string)
  array = string.scan(/[0-9]*/)
  array.delete('')
  new = array.map { |elem| elem.to_i}
  new.max
end
