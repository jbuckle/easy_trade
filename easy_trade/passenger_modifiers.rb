module EasyTrade
  class PassengerModifiers < Modifiers
    attr_reader :high, :middle, :basic, :low
    base_modifiers :zone_modifier, :starport_modifier, :pop_modifier, :steward_modifier

    def self.generate
      modifiers = self.new
      modifiers.generate
      return modifiers
    end

    def generate
      @high = base_modifier - 4
      @middle = base_modifier
      @basic = base_modifier
      @low = base_modifier + 1
    end

    private

      def steward_modifier
        config.ship.highest_steward
      end

      def zone_modifier
        @zm ||=
          case config.origin.zone_type.to_s.downcase
          when 'amber'
            1
          when 'red'
            -4
          else
            0
          end
      end

      def starport_modifier
        @starport_modifier ||=
          case config.origin.starport_level.downcase
          when 'a'
            2
          when 'b'
            1
          when 'e'
            -1
          when 'x'
            -3
          else
            0
          end
      end

      def pop_modifier
        @pop_modifier ||=
          case config.origin.population_level
          when 0..1
            -4
          when 2..5
            0
          when 6..7
            1
          else
            3
          end
      end
  end
end
