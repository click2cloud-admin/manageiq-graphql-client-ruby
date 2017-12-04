require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :schema do
  task :reload do
    require "manageiq/graphql"
    GraphQL::Client.dump_schema(
      Manageiq::Graphql::HTTP,
      File.expand_path(File.join("config", "schema.json"), __dir__)
    )
  end
end
