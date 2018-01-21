module EasyTrade
  class Configuration
    class << self
      def init(hash)
        @config ||= RecursiveOpenStruct.new(hash)
      end

      def config
        @config
      end
    end
  end
end
