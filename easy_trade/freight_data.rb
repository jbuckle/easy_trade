module EasyTrade
  class FreightData
    include Utils

    attr_reader :major, :minor, :incidental

    def self.generate(major:, minor:, incidental:)
      data = new(major: major, minor: minor, incidental: incidental)
      data.generate
      return data
    end

    def initialize(major:, minor:, incidental:)
      @major_lots = major
      @minor_lots = minor
      @incidental_lots = incidental
    end

    def generate
      @major = weight_and_price_array(@major_lots, 10)
      @minor = weight_and_price_array(@minor_lots, 5)
      @incidental = weight_and_price_array(@incidental_lots, 1)
      self
    end

    private

    def weight_and_price_array(count, multiplier)
      array = []
      count.times do
        weight = Roll.n_die(1, false) * multiplier
        price = weight * price_per_ton
        array << { weight: weight, revenue: price }
      end

      return array
    end

    def price_per_ton
      @pbod ||= price_table.fetch(config.destination.parsecs_away)
    end

    def price_table
      { 1 => 1000, 2 => 1600, 3 => 3000, 4 => 7000, 5 => 7700, 6 => 86000 }
    end
  end
end
