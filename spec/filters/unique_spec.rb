require_relative '../spec_helper'
require 'logstash/filters/unique'

describe LogStash::Filters::Unique do

  it "should register" do
    plugin = LogStash::Plugin.lookup("filter", "unique").new("fields" => [])
    expect {plugin.register}.to_not raise_error
  end

  context "when having an array of elements" do

    let(:plugin) { LogStash::Filters::Unique.new("fields" => "array") }
    let(:data)   { { "array" => [1,2,1,2,1,2,1,2], "other_field" => "dummy string" }}
    let(:event)  { LogStash::Event.new(data) }

    before(:each) do
      plugin.filter(event)
    end

    it "filter all events in the array property" do
      expect(event["array"]).to eq([1,2])
    end

    it "does not touch non filtered properties" do
      expect(event["other_field"]).to eq("dummy string")
    end

  end
end
