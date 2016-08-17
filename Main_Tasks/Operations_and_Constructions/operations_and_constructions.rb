def random_integers
  arry = Array.new
  i = 0
  until i == 10 do
    puts "=========\n"
    arry[i] = rand(10)
      case
        when arry[i] == 0
          puts "We've got 0\n"
        when arry[i].even?
          puts "The number is even\n"
          puts "The number is less than 5\n" if arry[i] < 5
          puts "The number is more than 5\n" if arry[i] > 5
        when arry[i].odd?
          puts "The number is odd\n"
          puts "The number is less than 5\n" if arry[i] < 5
          puts "The number is more than 5\n" if arry[i] > 5
          puts "We've got 5" if arry[i] == 5
        else
          puts "Unexpected value #{arry[i]}\n"
      end
    i += 1
  end
  print arry
end

random_integers