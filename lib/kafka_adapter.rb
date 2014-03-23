# encoding: utf-8

require 'poseidon'
require 'kafka_adapter/producer_factory'

module KafkaAdapter

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.publish(messages, topic = nil)
    ProducerFactory.producer(topic).publish(messages)
  rescue => e
    logger.warn("Problem sending events to Kafka: #{e.message} #{e.backtrace.join("\n")}") if logger
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.test_mode!
    @test_mode = true
  end

  def self.test_mode?
    @test_mode
  end

  def self.logger
    configuration.logger
  end

  class Configuration
    attr_accessor :brokers, :topic, :compression_codec, :test_mode, :logger

    def initialize
      @topic              = "test"
      @brokers            = ['localhost:9092']
      @compression_codec  = nil
      @test_mode          = false
      @logger             = nil
    end

  end
end