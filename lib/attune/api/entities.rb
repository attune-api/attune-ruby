require "json"
require "uri"

module Attune
  module Api
    class Entities
      basePath = "/"

      def initialize(client)
        @client = client
      end

      # Save a new blacklist entry.
      #
      # @param [Attune::Model::BlacklistParams] body
      # @return [Attune::Model::BlacklistSaveResponse]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def blacklist_save (body)
        query_param_keys = []

        # set default values and merge with input
        options = {
        :body => body}

        #resource path
        path = "/entities/rankings/blacklists".sub('{format}','json')

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
        response = @client.request(:POST, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::BlacklistSaveResponse.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.blacklist_save']
          if mockProc
            mockResponse = mockProc.call(body)
            Attune::Model::BlacklistSaveResponse.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # List all blacklist entries for your account.
      #
      # @return [Attune::Model::BlacklistGetResponse]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def blacklist_get_all ()
        query_param_keys = []

        # set default values and merge with input
        options = {
        }

        #resource path
        path = "/entities/rankings/blacklists".sub('{format}','json')

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:GET, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::BlacklistGetResponse.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.blacklist_get_all']
          if mockProc
            mockResponse = mockProc.call()
            Attune::Model::BlacklistGetResponse.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Updates a blacklist with the specified ID.
      #
      # @param [String] id
      # @param [Attune::Model::BlacklistParams] body
      # @return [Attune::Model::BlacklistUpdateResponse]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def blacklist_update (id,body)
        query_param_keys = []

        # verify existence of params
        raise ArgumentError, "id is required" if id.nil?
        # set default values and merge with input
        options = {
        :id => id,
          :body => body}

        #resource path
        path = "/entities/rankings/blacklists/{id}".sub('{format}','json').sub('{' + 'id' + '}', escapeString(id))
        

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
        response = @client.request(:PUT, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::BlacklistUpdateResponse.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.blacklist_update']
          if mockProc
            mockResponse = mockProc.call(id,body)
            Attune::Model::BlacklistUpdateResponse.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Delete blacklist by id.
      #
      # @param [String] id
      # @return [Attune::Model::BlacklistDeleteResponse]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def blacklist_delete (id)
        query_param_keys = []

        # verify existence of params
        raise ArgumentError, "id is required" if id.nil?
        # set default values and merge with input
        options = {
        :id => id}

        #resource path
        path = "/entities/rankings/blacklists/{id}".sub('{format}','json').sub('{' + 'id' + '}', escapeString(id))
        

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:DELETE, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::BlacklistDeleteResponse.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.blacklist_delete']
          if mockProc
            mockResponse = mockProc.call(id)
            Attune::Model::BlacklistDeleteResponse.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Returns the blacklist with the specified ID.
      #
      # @param [String] id
      # @return [Attune::Model::Blacklist]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def blacklist_get (id)
        query_param_keys = []

        # verify existence of params
        raise ArgumentError, "id is required" if id.nil?
        # set default values and merge with input
        options = {
        :id => id}

        #resource path
        path = "/entities/rankings/blacklists/{id}".sub('{format}','json').sub('{' + 'id' + '}', escapeString(id))
        

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:GET, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::Blacklist.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.blacklist_get']
          if mockProc
            mockResponse = mockProc.call(id)
            Attune::Model::Blacklist.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Returns a ranking of the specified entities for the current user.
      #
      # @param [Attune::Model::RankingParams] body
      # @return [Attune::Model::RankedEntities]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def get_rankings (body)
        query_param_keys = []

        # verify existence of params
        raise ArgumentError, "body is required" if body.nil?
        # set default values and merge with input
        options = {
        :body => body}

        #resource path
        path = "/entities/ranking".sub('{format}','json')

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
        response = @client.request(:POST, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::RankedEntities.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.get_rankings']
          if mockProc
            mockResponse = mockProc.call(body)
            Attune::Model::RankedEntities.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      # Returns multiple rankings of the specified entities for the current user.
      #
      # @param [Attune::Model::BatchRankingRequest] body
      # @return [Attune::Model::BatchRankingResult]
      # @raise [ArgumentError] for invalid inputs
      # @raise [Faraday::Error::ClientError] if the request fails or exceeds the timeout
      # @raise [AuthenticationException] if authorization header not accepted
      def batch_get_rankings (body)
        query_param_keys = []

        # verify existence of params
        raise ArgumentError, "body is required" if body.nil?
        # set default values and merge with input
        options = {
        :body => body}

        #resource path
        path = "/entities/ranking/many".sub('{format}','json')

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
        response = @client.request(:POST, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        if response
          Attune::Model::BatchRankingResult.new(JSON.parse(response.body))
        else
          mockProc = MOCKS['Entities.batch_get_rankings']
          if mockProc
            mockResponse = mockProc.call(body)
            Attune::Model::BatchRankingResult.new(mockResponse)
          else
            nil
          end
        end
        
      end
      
      private
      def escapeString(string)
        URI.encode(string.to_s)
      end
    end
  end
end

