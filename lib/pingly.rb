class Pingly
  VERSION = '0.3.0'

  attr_accessor :host, :timeout, :raw_response

  def self.ping_loop(host, timeout = 5)
    while true do
      p = new(host)
      p.ping!

      if p.packet_loss > 25
        yield if block_given?
      end

      puts p.response
    end
  end

  def self.ping!(host, timeout = 5)
    new(host,timeout).ping!
  end

  def initialize(host, timeout = 5)
    self.host, self.timeout = host, timeout
  end

  def ping!
    self.raw_response = `#{build_ping_string}`
  end

  def packet_loss
    response_regex(/(\d+\.\d+)\% packet loss$/).to_f
  end

  def ip_address
    response_regex(/^PING #{Regexp.escape(host)} \((\d+\.\d+\.\d+\.\d+)\)/)
  end

  def packets_sent
    response_regex(/^(\d+) packets transmitted/).to_i
  end

  def packets_received
    response_regex(/, (\d+) packets received/).to_i
  end

  def response
    "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} - #{host}(#{ip_address}) - Sent: #{packets_sent} Received: #{packets_received} Loss: #{packet_loss}%"
  end

  private

  def response_regex(regex)
    ping! unless raw_response
    raw_response =~ regex
    $1
  end

  def build_ping_string
    "ping -t #{timeout} -q #{host}"
  end
end

if __FILE__ == $0
  Pingly.ping_loop('google.com') do
    `say 'link down'`
  end
end
