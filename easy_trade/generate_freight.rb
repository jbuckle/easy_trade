module EasyTrade
  class GenerateFreight
    include Utils

    def self.generate
      new.generate
    end

    def generate
      @situational_modifiers = FreightModifiers.generate
      @discretionary_modifiers = config.discretionary_freight_modifier

      binding.pry
    end

  end
end
