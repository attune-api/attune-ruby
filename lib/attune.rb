require 'faraday'

require "attune/version"
require "attune/configurable"
require "attune/default"
require "attune/client"
require "attune/mocks"
require "attune/api/entities"
require "attune/api/anonymous"
require "attune/models/blacklist_get_response"
require "attune/models/anonymous_result"
require "attune/models/blacklist_params"
require "attune/models/ranked_entities"
require "attune/models/ranking_params"
require "attune/models/customer"
require "attune/models/blacklist"
require "attune/models/batch_ranking_request"
require "attune/models/scope_entry"
require "attune/models/blacklist_save_response"
require "attune/models/batch_ranking_result"

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

