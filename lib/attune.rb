require 'faraday'

require "attune/version"
require "attune/configurable"
require "attune/default"
require "attune/client"

module Attune
  def self.client
    Client.new
  end
  def self.test_mode!
    configure do |c|
      c.exception_handler = :mock
      c.disabled = true
    end
  end
  def self.configure(&block)
    Default.configure(&block)
  end
end
