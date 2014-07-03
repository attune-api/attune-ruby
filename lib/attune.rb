require 'faraday'

require "attune/version"
require "attune/configurable"
require "attune/default"
require "attune/client"
require "attune/api/entities"
require "attune/api/anonymous"
require "attune/models/blacklistgetresponse"
require "attune/models/anonymousresult"
require "attune/models/blacklistparams"
require "attune/models/rankedentities"
require "attune/models/rankingparams"
require "attune/models/customer"
require "attune/models/blacklist"
require "attune/models/batchrankingrequest"
require "attune/models/scopeentry"
require "attune/models/blacklistsaveresponse"
require "attune/models/batchrankingresult"

module Attune
  def self.client
    Client.new
  end

  # Simulate all API calls
  # This is equivalent to setting disabled to true and exception_handler to
  # :mock
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

