module EasyTrade
  class GenerateFreight
    include Utils

    def self.generate
      new.generate
    end

    def generate
      @situational_modifiers = FreightModifiers.generate
      @discretionary_modifier = config.discretionary_freight_modifier

      major_lots = freight_count(:major)
      minor_lots = freight_count(:minor)
      incidental_lots = freight_count(:incidental)

      return FreightData.generate(
        major: major_lots,
        minor: minor_lots,
        incidental: incidental_lots
      )

      binding.pry
    end

    private

      def freight_count(level)
        lev = level.to_s

        logger.debug("Generating number of available #{lev} freight lots")

        effect = Roll.for_effect(best_skill_to_use, "Applying effect of skill check")
        dm = effect + @situational_modifiers.send(level) + @discretionary_modifier

        logger.debug("Total DM for #{lev} freight lots roll: #{dm}")

        # Roll 2D to generate lookup number for freight data
        lookup = Roll.skill_check(dm, "Seeing how many dice to roll for #{lev} freight lot count")
        return Roll.n_die(freight_traffic_table(lookup), "Count for #{lev} freight lots FINAL")
      end

      def freight_traffic_table(result_of_freight_roll)
        case result_of_freight_roll
        when (-1000..1)
          0
        when 2..3
          1
        when 4..5
          2
        when 6..8
          3
        when 9..11
          4
        when 12..14
          5
        when 15..16
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
        @best_skill_to_use ||= [config.seeker_statistics.broker, config.seeker_statistics.streetwise].max
      end

  end
end
