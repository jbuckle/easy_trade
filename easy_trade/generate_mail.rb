module EasyTrade
  class GenerateMail
    include Interactor

    def self.generate
      new.generate
    end

    def generate
      @situational_modifiers = FreightModifiers.generate
      @discretionary_modifier = config.discretionary_mail_modifier
    end
  end
end
