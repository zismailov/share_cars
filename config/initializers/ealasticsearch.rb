config = {
  host: "http://localhost:9200/",
  transport_options: {
    request: { timeout: 5 }
  }
}

config.merge!(YAML.load_file("config/elasticsearch.yml").symbolize_keys) if File.exist?("config/elasticsearch.yml")

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
