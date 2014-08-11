module Intermediary
  module Emitter
    class Base
      class << self
        attr_accessor :routing_key
      end

      attr_reader :object, :href

      def initialize(object)
        @object = object
      end

      def routing_key
        href.gsub(%r(^http://), '').gsub('.', '_').gsub('/', '.')
      end

      def emit(event)
        Intermediary::Connection.exchange.publish(
          payload.merge(event: event).to_json,
          routing_key: routing_key,
          content_type: 'application/json'
        )
      end

      def payload
        object.attributes
      end
    end
  end
end

