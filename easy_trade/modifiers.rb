module EasyTrade
  class Modifiers
    include Utils

    def self.base_modifiers(*methods)
      @base_modifiers ||= (methods || [])
    end

    def base_modifier
      @base_modifier ||=
        begin
          total = 0
          self.class.base_modifiers.each do |method|
            total += calculate_with_logging(method)
          end

          logger.debug("#{self.class.to_s} total_base_modifier: #{total}")
          total
        end
    end

    private
      def calculate_with_logging(method)
        value = send(method)
        raise ArgumentError if !value.is_a?(Integer)
        logger.debug("#{self.class.to_s} #{method}: #{value}")
        value
      end
  end
end
