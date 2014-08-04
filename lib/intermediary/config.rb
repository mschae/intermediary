module Intermediary
  class Config
    ATTRIBUTES = [:host, :port, :username, :password, :vhost, :domain]
    attr_accessor *ATTRIBUTES

    def to_hash
      Hash[
        ATTRIBUTES.map do |a|
          [a, send(a)] unless send(a).nil?
        end.compact
      ]
    end
  end
end
