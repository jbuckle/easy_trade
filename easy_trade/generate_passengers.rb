module EasyTrade
  class GeneratePassengers
    attr_reader :config

    def self.generate
      GeneratePassengers.new.generate
    end

    def initialization
      @config = Configuration.config
    end

    def generate
      difficulty_modifiers = PassengerModifiers.generate
    end
  end
end
