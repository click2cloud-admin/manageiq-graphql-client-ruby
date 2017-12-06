require "manageiq/graphql/version"
require "graphql/client"
require "graphql/client/http"

module Manageiq
  module Graphql
    HTTP = GraphQL::Client::HTTP.new("http://localhost:3001/graphql")
    Schema = GraphQL::Client.load_schema(File.expand_path(File.join("..", "..", "config", "schema.json"), __dir__))
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

  end
end
