# Intermediary

This gems aims to unify asynchronous communication between different apps in a
SOA.

It is built on top of the awesome bunny gem, which provides an interface to
RabbitMQ.

The emitter (the app that publishes updates) in this gem does not know who
consumes those updates. To this end a topic exchange is being used. To make
subscribing to updates as straightforward as possible the exchange key mimics
restful routes. Updates to resources are published in an exchange key that
reflects the resource's href (down to the host).

## Installation

Add this line to your application's Gemfile:

    gem 'intermediary'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install intermediary

## Usage

As explained above, gem provides two elements to exchange updates between apps:
- The emitter
- The listener

To use the emitter one simply inherits from `Intermediary::Emitters::Base` as
follows:

```ruby
class MyEmitter < Intermediary::Emitters::Base
  def href

  end
end
```

Per default the initializer takes one argument (the object). As everything else
it can be customized by overwriting it.

The href method always has to be supplied to indicate how to construct the
routing key.

Per default the payload emitted is the the object's `.to_attributes` and the
event.

### The Listener

The receiver is merely a user-defined class that implements the following
method: `self.act`. Which takes three arguments: `payload`, `routing_key` and
`properties`. The `payload` will be a hash.

Furthermore the class has to define `@queue_name` and `@routing_key`.

Example:
```ruby
class MyListener
  @queue_name  = "my-awesome-queue"
  @routing_key = "app_example_com.model.#"

  def self.act(payload, routing_key, properties)
    puts payload.inspect
  end
end
```

**Please note that multiple receivers with the same queue name will share
items!**

To register a listener, please call the following (e.g. in an initializer):

```ruby
Intermediary::Listeners.register MyListener
```

Alternatively one can define a `self.on_error` method with takes one argument:
The error itself. It will get called when processing a job failed.

### Emitter



## Contributing

1. Fork it ( http://github.com/<my-github-username>/intermediary/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
