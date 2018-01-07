require 'aws-sdk'
require 'pry'
require './lib/instance-fetcher.rb'
require './lib/config-writer.rb'


close_instances = InstanceFetcher.fetch_close_instance
ConfigWriter.write_config(close_instances)
