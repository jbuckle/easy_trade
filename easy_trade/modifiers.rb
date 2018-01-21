module EasyTrade
  class Modifiers

    def self.base_modifiers(*methods)
      @base_modifiers ||= (methods || [])
    end

    def base_modifier
      @base_modifier ||= self.class.base_modifiers.each_with_object(0).each do |method, total|
        total + calculate_with_logging(method)
      end
    end

    private

      def calculate_with_logging(method)
        value = send(method)
        raise ArgumentError if !value.is_a?(Integer)
        logger.debug("#{self.class.to_s} #{method}: #{value}")
        value
      end

      def config
        @config = Configuration.config
      end

      def logger
        @logger = Logger.new(STDOUT)
        @logger.level = config.log_level
        @logger
      end
  end
end
