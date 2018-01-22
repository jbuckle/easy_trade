module EasyTrade
  class GeneratePassengers
    include Utils

    def self.generate
      GeneratePassengers.new.generate
    end

    def generate
      @situational_modifiers = PassengerModifiers.generate
      @discretionary_modifier = config.discretionary_passenger_modifier

      high_passage_count = passenger_count(:high)
      middle_passage_count = passenger_count(:middle)
      basic_passage_count = passenger_count(:basic)
      low_passage_count = passenger_count(:low)

      binding.pry
    end

    private
      def passenger_count(level)
        lev = level.to_s

        logger.debug("Generating final count of #{lev} passengers")

        effect = Roll.for_effect(best_skill_to_use, "Skill modifier for #{lev} passage")
        dm = effect + @situational_modifiers.send(level) + @discretionary_modifier

        logger.debug("DM for #{lev} roll - #{dm}")

        # Roll 2D to generate lookup number for traffic table
        lookup = Roll.skill_check(dm, "Generating lookup value for #{lev} passage")

        return Roll.n_die(passenger_traffic_table(lookup), "Count for #{lev} passage FINAL")
      end

      # Returns the number of dice to roll to get a final count
      def passenger_traffic_table(result_of_passenger_roll)
        case result_of_passenger_roll
        when (-100..1)
          0
        when 2..3
          1
        when 4..6
          2
        when 7..10
          3
        when 11..13
          4
        when 14..15
          5
        when 16
          6
        when 17
          7
        when 18
          8
        when 19
          9
        else
          10
        end
      end

      def best_skill_to_use
        @best_skill_to_use ||=
          [ config.seeker_statistics.broker,
          config.seeker_statistics.carouse,
          config.seeker_statistics.streetwise ].max
      end
  end
end
