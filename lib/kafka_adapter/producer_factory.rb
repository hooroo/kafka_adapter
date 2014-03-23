# encoding: utf-8

module KafkaAdapter
  class ProducerFactory

    def self.producer(topic)
      producers[subtopic(topic)]
    end

    private

    def self.producer_for(topic)
      Producer.new(producer_class, topic, KafkaAdapter.configuration.brokers, compression_codec: KafkaAdapter.configuration.compression_codec)
    end

    def self.producer_class
      if KafkaAdapter.test_mode?
        TestProducer
      else
        Poseidon::Producer
      end
    end

    def self.kafka_message(message, topic)
      Poseidon::MessageToSend.new(topic, message)
    end

    def self.producers
      @@producers ||= Hash.new {|prodz, topic| prodz[topic] = producer_for(topic)}
    end

    def self.subtopic(topic)
      if topic
        "#{KafkaAdapter.configuration.topic}-#{topic}"
      else
        KafkaAdapter.configuration.topic
      end
    end
  end

  class Producer
    attr_reader :topic
    def initialize(clazz, topic, brokers, opts)
      @publisher = clazz.new(brokers, topic, opts)
      @topic = topic
    end
    def publish(messages)
      @publisher.send_messages(messages.map {|msg| ProducerFactory.kafka_message(msg, topic)})
    end
  end

  class TestProducer
    attr_reader :messages, :brokers, :client_id, :opts

    def initialize(brokers, client_id, opts)
      @messages = []
      @brokers = brokers
      @client_id = client_id
      @opts = opts
    end

    def send_messages(messages)
      @messages << messages
    end
  end
end