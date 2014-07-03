require "json"
require "uri"

module Attune
  module Api
    class Entities
      basePath = "/"

      def initialize(client)
        @client = client
      end

      def escapeString(string)
        URI.encode(string.to_s)
      end

      def blacklist_get (opts={})
        query_param_keys = []

        # set default values and merge with input
        options = {
        }.merge(opts)

        #resource path
        path = "/entities/rankings/blacklists".sub('{format}','json')

        # pull querystring keys from options
        queryopts = options.select do |key,value|
          query_param_keys.include? key
        end

        headers = nil
        post_body = nil
        response = @client.request(:GET, path, {:params=>queryopts,:headers=>headers, :body=>post_body })
        Attune::Model::BlacklistGetResponse.new(JSON.parse(response.body))
      end
      
      def blacklist_save (body,opts={})
        query_param_keys = []

        # set default values and merge with input
        options = {
        :body => body}.merge(opts)

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
        Attune::Model::BlacklistSaveResponse.new(JSON.parse(response.body))
      end
      
      def get_rankings (body,opts={})
        query_param_keys = []

        # verify existence of params
        raise "body is required" if body.nil?
        # set default values and merge with input
        options = {
        :body => body}.merge(opts)

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
        Attune::Model::RankedEntities.new(JSON.parse(response.body))
      end
      
      def batch_get_rankings (body,opts={})
        query_param_keys = []

        # verify existence of params
        raise "body is required" if body.nil?
        # set default values and merge with input
        options = {
        :body => body}.merge(opts)

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
        Attune::Model::BatchRankingResult.new(JSON.parse(response.body))
      end
      
      end
  end
end

