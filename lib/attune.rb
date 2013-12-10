require 'faraday'

require "attune/version"
require "attune/configurable"
require "attune/default"
require "attune/client"

module Attune
  def self.client
    Client.new
  end
end
