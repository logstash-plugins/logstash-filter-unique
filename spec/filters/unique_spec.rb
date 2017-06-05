# encoding: utf-8

require "logstash/devutils/rspec/spec_helper"
require "logstash/filters/unique"

describe LogStash::Filters::Unique do

  describe "unique on non array should return origin value" do
    # The logstash config goes here.
    # At this time, only filters are supported.
    config <<-CONFIG
      filter {
        unique {
          fields => ["field1"]
        }
      }
    CONFIG

    sample("field1" => "asdf") do
      insist { subject.get("field1") } == "asdf"
    end
  end

  describe "unique on array of integers" do
    # The logstash config goes here.
    # At this time, only filters are supported.
    config <<-CONFIG
      filter {
        unique {
          fields => ["field2"]
        }
      }
    CONFIG

    sample("field2" => [1,2,1,2,1,2,1,2]) do
      insist { subject.get("field2") } == [1,2]
    end
  end


  describe "unique on array of strings" do
    # The logstash config goes here.
    # At this time, only filters are supported.
    config <<-CONFIG
      filter {
        unique {
          fields => ["field3"]
        }
      }
    CONFIG

    sample("field3" => ["a", "b", "c", "c", "d"]) do
      insist { subject.get("field3") } == ["a", "b", "c", "d"]
    end
  end
end
