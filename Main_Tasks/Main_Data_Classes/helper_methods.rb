def is_a_natural_number?(number)
  if (number.class == Fixnum || number.class == Bignum) && number > 0
    true
  end
end

def is_a_digit?(object)
  if object =~ /[0-9]/
    true
  end
end

def is_an_integer?(string)
  true if string.to_i.to_s == string
end