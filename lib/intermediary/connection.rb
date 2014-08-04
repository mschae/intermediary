module Intermediary
  class Connection
    class << self
      def channel
        @connection ||=
          begin
            bunny = Bunny.new(Intermediary.config.to_hash)
            bunny.start
          end
      end

      def exchange
        channel.topic "intermediary.topicexchange"
      end
    end
  end
end
