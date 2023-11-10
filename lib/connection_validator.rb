# frozen_string_literal: true

require 'resolv'

class ConnectionValidator
  def self.call
    dns_resolver = Resolv::DNS.new

    begin
      dns_resolver.getaddress('google.com')
      warn 'Connection valid:'
    rescue Resolv::ResolvError
      warn 'No Internet connection'
      exit
    end
  end
end
