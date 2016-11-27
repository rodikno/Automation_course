=begin
Mechanics are the people who can repair and refuel vehicles.

Also each mechanic knows at least couple of strong swearings
and he can say any of them if you'll kindly ask him.

Also Mechanics drink vodka sometimes.
And they're always drinking together.
Each mechanic is proud of maximum amount of Vodka he could consume and
they're not sharing this information with anybody except _other mechanics_.

So you definitely have to be a mechanic to ask other mechanic about how much bottles of alcohol
he can drink at once.
=end

class Mechanic

  attr_reader :age

  def initialize(age, refuel_skill)
    @age
    @refuel_skill
    @alcohol_max_consumption = 1
  end

  def refuel_transport(transport, quantity, fuel_type)
    if @refuel_skill
      transport.refuel(quantity, fuel_type)
    else
      puts "This mechanic is not trained to refuel vehicles"
    end
  end

  def how_much_drinks(mechanic)
    amount = mechanic.get_alcohol_limit
    puts "As I remember this guy has consumed #{amount} bottle of Vodka once we had a party..."
    amount
  end

  def say_swear
    puts get_random_swear
  end

  private
  def get_random_swear
    swears = ['Fuck this shit!', 'Oooh shit!', 'Damn it!', 'WTF?!']
    swears.sample
  end

  def alcohol_max_consumption
    @alcohol_max_consumption
  end

  protected
  def get_alcohol_limit
    @alcohol_max_consumption
  end
end
