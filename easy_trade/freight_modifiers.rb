module EasyTrade
  class FreightModifiers < Modifiers
    attr_reader :major, :minor, :incidental
    base_modifiers :pop_modifier, :starport_modifier, :tech_level_modifier, :zone_modifier

    def self.generate
      modifiers = new
      modifiers.generate
      return modifiers
    end

    def generate
      @major = base_modifier - 4
      @minor = base_modifier
      @incidental = base_modifier + 2
    end

    private

      def pop_modifier
        @pop_modifier ||=
          case config.origin.population_level
          when 0..1
            -4
          when 6..7
            2
          else
            4
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
          end
      end

      def tech_level_modifier
        @tech_level_modifier ||=
          case config.origin.tech_level
          when 0..6
            -1
          when 7..8
            0
          else
            2
          end
      end

      def zone_modifier
        @zone_modifier ||=
          case config.origin.zone_type.to_s.downcase
          when 'amber'
            -2
          when 'red'
            -6
          else
            0
          end
      end
  end
end
