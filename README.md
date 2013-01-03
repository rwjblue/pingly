# Pingly

We built this to allow us to quickly know if our Internet connection had failed, but
we quickly realized it had many more possibilities. Uses your systems 'ping' command
to attempt a ping on the host specified and lets you access the results.

## Installation

Add this line to your application's Gemfile:

    gem 'pingly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pingly

## Usage

Use the Pingly binary (optionally specifying a host to ping) to ping every 5 seconds and log the output forever.

You can also use this in your code to test if a service is up:

    require 'pingly'

    # standard initialization
    p = Pingly.new('google.com')
    p.ping!

    # quick/shortcut initialization (same as above)
    p = Pingly.ping!('google.com')

    puts p.response #=> "2013-01-03 15:48:29 - google.com(74.125.139.102) - Sent: 5 Received: 5 Loss: 0.0%"

One can call any of the following methods on an instance of Pingly to get various details of the ping attempt:

* packet\_loss - Returns a float representing the packet loss.
* ip\_address - Returns a string representing the IP Address that the system resolved the passed in host to.
* packets\_sent - Returns the number of packets sent as an integer.
* packets\_received - Returns the number of packets received as an integer.
* response - Returns a formatted string containing the results if the previous methods.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
