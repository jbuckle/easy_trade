module EasyTrade
  module Utils

    private

      def self.config
        @config ||= Configuration.config
      end

      def self.logger
        @logger ||= Logger.new(STDOUT)
        @logger.level = config.log_level
        @logger
      end

      def config
        @config ||= Configuration.config
      end

      def logger
        @logger ||= Logger.new(STDOUT)
        @logger.level = config.log_level
        @logger
      end

  end
end
