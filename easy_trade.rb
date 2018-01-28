require 'yaml'
require 'logger'

require './easy_trade/configuration.rb'
require './easy_trade/utils.rb'
require './easy_trade/roll.rb'

# Modifiers
require './easy_trade/modifiers'
require './easy_trade/passenger_modifiers'
require './easy_trade/freight_modifiers'
require './easy_trade/mail_modifiers'

# Availability Generation
require './easy_trade/generate_passengers.rb'
require './easy_trade/generate_freight.rb'
require './easy_trade/generate_mail.rb'

# Data Objects
require './easy_trade/passenger_data.rb'
require './easy_trade/freight_data.rb'

EasyTrade::Configuration.init(YAML.load_file('./data.yml'))

module EasyTrade

  def self.generate_outcomes!
    # Determine availabilities of the kinds of freight that the rest of the
    # team is willing to put up with
    passenger_availability = EasyTrade::GeneratePassengers.generate
    freight_availability = EasyTrade::GenerateFreight.generate
    binding.pry
    # mail_availability = EasyTrade::GenerateMail.call(config: config)
  end
end
