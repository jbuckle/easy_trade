module EasyTrade
  class Roll
    include Utils

    def self.for_effect(dm, roll_message = '')
      self.new.for_effect(dm, roll_message)
    end

    def self.n_die(number_of_die, roll_message = '')
      self.new.n_die(number_of_die, roll_message)
    end

    def self.skill_check(dm, roll_message = '')
      self.new.skill_check(dm, roll_message)
    end

    def for_effect(dm, roll_message = '')
      calculate_effect(skill_check(dm, roll_message))
    end

    def n_die(number_of_die, roll_message)
      total = 0

      number_of_die.times { total += Random.rand(1..6) }
      logger.debug("Rolled #{number_of_die} dice and got #{total} - #{roll_message}") if roll_message

      total
    end

    def skill_check(dm, roll_message = '')
      value = Random.rand(1..6) + Random.rand(1..6) + dm
      logger.debug("Rolled a #{value} - #{roll_message}") if roll_message
      value
    end

    private

      def calculate_effect(roll_value)
        roll_value - 8
      end

  end
end
