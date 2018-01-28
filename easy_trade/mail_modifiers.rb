module EasyTrade
  class MailModifiers < Modifiers
    attr_reader :mail
    base_modifiers :freight_modifier, :armed_ship_modifier, :military_rank_modifier,
      :social_modifier, :tech_level_modifier

    def self.generate
      modifiers = new
      modifiers.generate
      return modifiers
    end

    def generate
      @mail = base_modifier
    end

    private

      def freight_modifier
        @freight_modifier ||=
          begin
            fm = FreightModifiers.generate.minor
            case fm
            when -100..-10
              -2
            when -9..-5
              -1
            when -4..4
              0
            when 5..9
              1
            else
              2
            end
          end
      end

      def armed_ship_modifier
        @armed_ship_modifier ||= (config.ship.is_armed ? 2 : 0 )
      end

      def military_rank_modifier
        @military_rank_modifier ||= [config.ship.highest_naval, config.ship.highest_scout].max
      end

      def social_modifier
        @social_modifier ||= config.ship.highest_social
      end

      def tech_level_modifier
        @tech_level_modifier ||= config.origin.tech_level <= 5 ? -4 : 0
      end
  end
end
