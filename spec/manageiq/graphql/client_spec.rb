require "spec_helper"

RSpec.describe Manageiq::Graphql::Client do
  it "has a version number" do
    expect(Manageiq::Graphql::Client::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
