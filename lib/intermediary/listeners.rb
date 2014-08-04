module Intermediary
  class Listeners
    @@listeners = []

    def self.register(listener)
      @@listeners << listener
    end

    def self.activate_all
      @@listeners.each { |listener| self.activate(listener) }
    end

    def self.activate(listener)
      queue_name  = listener.instance_variable_get(:@queue_name)
      routing_key = listener.instance_variable_get(:@routing_key)

      raise "#{listener.name} must define @queue_name" if queue_name.nil?
      raise "#{listener.name} must define @routing_key" if routing_key.nil?

      channel = Connection.channel.create_channel
      channel.prefetch(3)

      channel.
        queue(queue_name, auto_delete: true).
        bind(Connection.exchange, routing_key: routing_key).
        subscribe(consumer_tag: self.consumer_tag,
                  ack: true) do |delivery_info, properties, payload|
          payload = JSON.parse payload
          begin
            listener.act(payload, delivery_info, properties)
          rescue StandardError => e
            listener.on_error(e) if listener.respond_to?(:on_error)
          end
          channel.acknowledge(delivery_info.delivery_tag, false)
        end
    end

    def self.consumer_tag
      [`hostname`.strip, Process.pid, SecureRandom.uuid].map(&:to_s).join("/")
    end
  end
end
