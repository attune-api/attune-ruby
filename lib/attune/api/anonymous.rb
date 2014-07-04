require "json"
require "uri"

module Attune
  module Api
    class Anonymous
      basePath = "/"

      def initialize(client)
        @client = client
      end

      # Create anonymous visitor
      #
      # @return [Attune::Model::AnonymousResult]
      # @raise [ArgumentError] if user_agent is not provided
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def create ()
        query_param_keys = []

        # set default values and merge with input
        options = {
        }

        #resource path
        path = "/anonymous".sub('{format}','json')

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:POST, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::AnonymousResult.new(JSON.parse(response.body))else
          mockProc = MOCKS['Anonymous.create']
          if mockProc
            mockResponse = mockProc.call()
            Attune::Model::AnonymousResult.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Returns an anonymous visitor, containing any assigned customer ID.
      #
      # @param [string] anonymous
      # @return [Attune::Model::Customer]
      # @raise [ArgumentError] if user_agent is not provided
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def get (anonymous)
        query_param_keys = []

        # verify existence of params
        raise "anonymous is required" if anonymous.nil?
        # set default values and merge with input
        options = {
        :anonymous => anonymous}

        #resource path
        path = "/anonymous/{anonymous}".sub('{format}','json').sub('{' + 'anonymous' + '}', escapeString(anonymous))
        

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:GET, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::Customer.new(JSON.parse(response.body))else
          mockProc = MOCKS['Anonymous.get']
          if mockProc
            mockResponse = mockProc.call(anonymous)
            Attune::Model::Customer.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Binds one actor to another, allowing activities of those actors to be shared between the two.
      #
      # @param [string] anonymous
      # @param [Customer] body
      # @raise [ArgumentError] if user_agent is not provided
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def update (anonymous,body)
        query_param_keys = []

        # verify existence of params
        raise "anonymous is required" if anonymous.nil?
        raise "body is required" if body.nil?
        # set default values and merge with input
        options = {
        :anonymous => anonymous,
          :body => body}

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
      
      private
      def escapeString(string)
        URI.encode(string.to_s)
      end
    end
  end
end

