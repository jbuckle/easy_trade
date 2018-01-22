module EasyTrade
  class PassengerData
    include Utils

    attr_reader :high, :middle, :basic, :low

    def self.generate(high:, middle:, basic:, low:)
      self.new(high: high, middle: middle, basic: basic, low: low).generate
    end

    def initialize(high:, middle:, basic:, low:)
      @high_count = high
      @middle_count = middle
      @basic_count = basic
      @low_count = low
    end

    def generate
      @high = { available: @high_count,
                ticket_cost: ticket_price(:high),
                tonnage_per: 1,
                stateroom_per: 1,
                steward_per: 0.10,
                low_berth_per: 0,
                monthly_cost_per: 1500 }
      @middle = { available: @middle_count,
                  ticket_cost: ticket_price(:middle),
                  tonnage_per: 0.10,
                  stateroom_per: 1,
                  steward_per: 0.01,
                  low_berth_per: 0,
                  monthly_cost_per: 1000 }
      @basic = { available: @basic_count,
                 ticket_cost: ticket_price(:basic),
                 tonnage_per: 0.01,
                 stateroom_per: 0.25,
                 steward_per: 0,
                 low_berth_per: 0,
                 monthly_cost_per: 1000 }
      @low = { available: @low_count,
               ticket_cost: ticket_price(:low),
               tonnage_per: 0.01,
               stateroom_per: 0,
               steward_per: 0,
               low_berth_per: 1,
               monthly_cost_per: 100 }
      self
    end

    private

      def ticket_price(level)
        ticket_price_table.fetch(config.destination.parsecs_away).fetch(level)
      end

      def ticket_price_table
        @price_table ||= {
          1 => { high: 8500, middle: 6200, basic: 2200, low: 700 },
          2 => { high: 12000, middle: 9000, basic: 2900, low: 1300 },
          3 => { high: 20000, middle: 15000, basic: 4400, low: 2200 },
          4 => { high: 41000, middle: 31000, basic: 8600, low: 4300 },
          5 => { high: 45000, middle: 34000, basic: 9400, low: 13000 },
          6 => { high: 470000, middle: 350000, basic: 93000, low: 96000 }
        }
      end
  end
end
