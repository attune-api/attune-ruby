require "uri"

class Anonymous_api
  basePath = "/"

  def initialize(client) {
    @client
  }

  def self.escapeString(string)
    URI.encode(string.to_s)
  end

  def self.create (opts={})
    query_param_keys = []

    # set default values and merge with input
    options = {
    }.merge(opts)

    #resource path
    path = "/anonymous".sub('{format}','json')

    # pull querystring keys from options
    queryopts = options.select do |key,value|
      query_param_keys.include? key
    end

    headers = nil
    post_body = nil
    response = @client.request(:POST, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
    AnonymousResult.new(response)
  end

def self.update (anonymous,body,opts={})
    query_param_keys = []

    # verify existence of params
    raise "anonymous is required" if anonymous.nil?
    raise "body is required" if body.nil?
    # set default values and merge with input
    options = {
    :anonymous => anonymous,
      :body => body}.merge(opts)

    #resource path
    path = "/anonymous/{anonymous}".sub('{format}','json').sub('{' + 'anonymous' + '}', escapeString(anonymous))
    

    # pull querystring keys from options
    queryopts = options.select do |key,value|
      query_param_keys.include? key
    end

    headers = nil
    post_body = nil
    if body != nil
      if body.is_a?(Array)
        array = Array.new
        body.each do |item|
          if item.respond_to?("to_body".to_sym)
            array.push item.to_body
          else
            array.push item
          end
        end
        post_body = array

      else
        if body.respond_to?("to_body".to_sym)
	        post_body = body.to_body
	      else
	        post_body = body
	      end
      end
    end
    @client.request(:PUT, path, {:params=>queryopts,:headers=>headers, :body=>post_body})
    
  end

def self.get (anonymous,opts={})
    query_param_keys = []

    # verify existence of params
    raise "anonymous is required" if anonymous.nil?
    # set default values and merge with input
    options = {
    :anonymous => anonymous}.merge(opts)

    #resource path
    path = "/anonymous/{anonymous}".sub('{format}','json').sub('{' + 'anonymous' + '}', escapeString(anonymous))
    

    # pull querystring keys from options
    queryopts = options.select do |key,value|
      query_param_keys.include? key
    end

    headers = nil
    post_body = nil
    response = @client.request(:GET, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
    Customer.new(response)
  end

end

