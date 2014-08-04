module Intermediary
  module Emitter
    class Base
      class << self
        attr_accessor :routing_key
      end

      attr_reader :object, :href, :id

      def initialize(object)
        @object = object
        @href   = generate_href
      end

      def routing_key
        [self.class.routing_key, id].join(".")
      end

      def emit(event)
        Intermediary::Connection.exchange.publish(
          payload.merge(event: event).to_json,
          routing_key: routing_key,
          content_type: 'application/json'
        )
      end

      def payload
        object.attributes.merge(
          href: href
        )
      end
    end
  end
end

