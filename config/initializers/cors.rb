Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins /\Ahttp:\/\/192\.168\.137\.\d+(:\d+)?\z/ # any device in hotspot

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
