def is_natural_number(number)
  if (number.class == Fixnum || number.class == Bignum) && number > 0
    true
  end
end

def is_digit(object)
  if object =~ /[0-9]/
    true
  end
end