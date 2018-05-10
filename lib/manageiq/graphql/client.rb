require "manageiq/graphql/client/version"
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
  end
end
