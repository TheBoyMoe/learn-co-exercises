require "seatgeek_cli/version"

class SeatgeekCli::CLI
  attr_reader :external_ip

  def initialize(ip = nil)
    @external_ip = ip || self.class.get_external_ip
  end

  def call
    puts 'Welcome to seatgeek, the fan site where you can select from millions of tickets for purchase'
  end

  def self.get_external_ip
    `curl https://api.ipify.org`
  end

end
