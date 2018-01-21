require 'yaml'
require 'logger'
require './easy_trade/configuration.rb'

# Modifiers
require './easy_trade/modifiers'
require './easy_trade/passenger_modifiers'

# Availability Generation
require './easy_trade/generate_passengers.rb'
require './easy_trade/generate_freight.rb'
require './easy_trade/generate_mail.rb'

EasyTrade::Configuration.init(YAML.load_file('./data.yml'))

module EasyTrade

  def self.generate_outcomes!
    # Determine availabilities of the kinds of freight that the rest of the
    # team is willing to put up with
    passenger_availability = EasyTrade::GeneratePassengers.generate
    # freight_availability = EasyTrade::GenerateFreight.call(config: config)
    # mail_availability = EasyTrade::GenerateMail.call(config: config)
  end
end
