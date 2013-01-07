require 'open3'
require 'rbconfig'

class Pingly
  VERSION = '0.6.1'

  attr_accessor :host, :timeout

  def self.ping_loop(host, timeout = 5)
    while true do
      p = new(host)
      p.ping!

      yield if block_given? && !p.successful?

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
    perform_ping
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
    response_regex(/, (\d+)(?: packets)? received/).to_i
  end

  def response
    "#{Time.now.strftime('%Y-%m-%d %H:%M:%S')} - " + (successful? ? successful_response : failed_response)
  end

  def successful?
    ping! unless ping_performed

    response_status.success? && packet_loss < 25
  end

  private

  attr_accessor :ping_performed, :response_stdout, :response_stderr, :response_status

  def successful_response
    "#{host}(#{ip_address}) - Sent: #{packets_sent} Received: #{packets_received} Loss: #{packet_loss}%"
  end

  def failed_response
    if response_stderr.to_s.strip.empty?
      successful_response
    else
      response_stderr.to_s
    end
  end

  def perform_ping
    self.response_stdout, self.response_stderr, self.response_status = Open3.capture3(build_ping_string)
    self.ping_performed = true
  end

  def response_regex(regex)
    ping! unless ping_performed
    response_stdout =~ regex
    $1
  end

  def build_ping_string
    command =  ["ping"]
    command += case RbConfig::CONFIG['host_os']
               when /bsd|osx|darwin/i
                 %W[-t #{timeout}]
               when /linux/i
                 %W[-w #{timeout}]
               end
    command << host

    command.join(' ')
  end
end

if __FILE__ == $0
  Pingly.ping_loop('google.com') do
    `say 'link down'`
  end
end
