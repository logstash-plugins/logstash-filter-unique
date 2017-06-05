# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::Unique < LogStash::Filters::Base
  config_name "unique"

  # The fields on which to run the unique filter.
  config :fields, :validate => :array, :required => true

  public
  def register
    # Nothing to do
  end # def register

  public
  def filter(event)
    @fields.each do |field|
      next unless event.include?(field)
      next unless event.get(field).is_a?(Array)
      event.set(field, event.get(field).uniq)
    end
  end # def filter

end # class LogStash::Filters::Unique
