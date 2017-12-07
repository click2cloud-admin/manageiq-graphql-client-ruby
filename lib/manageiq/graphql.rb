require "manageiq/graphql/version"
require "graphql/client"
require "graphql/client/http"
require "net/http"
require "json"

module Manageiq
  module Graphql
    class Client
      def self.endpoint
        @endpoint
      end

      def self.endpoint=(endpoint)
        @endpoint = endpoint
      end

      def self.sync
        @http = nil
        @schema = nil
        @client = nil
        http
        schema
        client
      end

      def self.query(*args)
        client.query(*args)
      end

      def self.parse(*args)
        client.parse(*args)
      end

      def self.http
        @http ||= GraphQL::Client::HTTP.new(endpoint)
      end
      private_class_method :http

      def self.schema
        @schema ||= GraphQL::Client.load_schema(http)
      end
      private_class_method :schema

      def self.client
        @client ||= GraphQL::Client.new(schema: schema, execute: http)
      end
      private_class_method :client
    end

    # class QueryAdapter
    #   URL = "http://localhost:3001/graphql/queries".freeze

    #   def self.all
    #     @all ||= JSON.parse(Net::HTTP.get(URI(URL)))["data"].each_with_object({}) do |query, result|
    #       # The graphql-client implementation requires that this is
    #       # assigned to a constant
    #       const_set(query["operationName"], Client.parse(query["query"]))

    #       # We are only interested in the operation definition portion
    #       # of the document (this is the thing we have to send to
    #       # `.query`), hence the somewhat awkward constant lookup
    #       # here.
    #       result[query["operationName"]] = const_get(query["operationName"]).const_get(query["operationName"])
    #     end
    #   end
    # end

    # class QueryRepository
    #   def self.all
    #     QueryAdapter.all.values
    #   end

    #   def self.find(name)
    #     QueryAdapter.all.fetch(name)
    #   end
    # end
  end
end
