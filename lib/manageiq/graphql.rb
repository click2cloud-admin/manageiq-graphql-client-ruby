require "manageiq/graphql/version"
require "graphql/client"
require "graphql/client/http"
require "net/http"
require "json"

module Manageiq
  module Graphql
    HTTP = GraphQL::Client::HTTP.new("http://localhost:3001/graphql")
    Schema = GraphQL::Client.load_schema(File.expand_path(File.join("..", "..", "config", "schema.json"), __dir__))
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

    class QueryAdapter
      URL = "http://localhost:3001/graphql/queries".freeze

      def self.all
        @all ||= JSON.parse(Net::HTTP.get(URI(URL)))["data"].each_with_object({}) do |query, result|
          # The graphql-client implementation requires that this is
          # assigned to a constant
          const_set(query["operationName"], Client.parse(query["query"]))

          # We are only interested in the operation definition portion
          # of the document (this is the thing we have to send to
          # `.query`), hence the somewhat awkward constant lookup
          # here.
          result[query["operationName"]] = const_get(query["operationName"]).const_get(query["operationName"])
        end
      end
    end

    class QueryRepository
      def self.all
        QueryAdapter.all.values
      end

      def self.find(name)
        QueryAdapter.all.fetch(name)
      end
    end
  end
end
