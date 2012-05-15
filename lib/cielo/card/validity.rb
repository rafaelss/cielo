module Cielo
  class Card
    class Validity
      class InvalidDate < StandardError; end

      def initialize(year, month)
        @year = year.to_i
        @month = month.to_i

        now = Time.now
        if @year < now.year || (@year == now.year && @month < now.month)
          raise InvalidDate, "#{@month}/#{@year} is not valid"
        end
      end

      def to_s
        [@year, "%02d" % @month].join
      end
    end
  end
end
