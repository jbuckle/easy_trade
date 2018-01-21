require 'yaml'
require './easy_trade/generate_passengers.rb'
require './easy_trade/generate_freight.rb'
require './easy_trade/generate_mail.rb'

class EasyTrade

  def generate_outcomes
    config = YAML.load_file('./data.yml')

    # Determine availabilities of the kinds of freight that the rest of the
    # team is willing to put up with
    passenger_availability = EasyTrade::GeneratePassengers.call(config: config)
    freight_availability = EasyTrade::GenerateFreight.call(config: config)
    mail_availability = EasyTrade::GenerateMail.call(config: config)

  end
end
