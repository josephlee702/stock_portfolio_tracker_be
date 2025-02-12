Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'  # this allows the backend to communicate with the front end, bypassing default CORS setting
    resource '*',
      headers: :any,
      expose: ['Authorization'],  # Allow headers like Authorization for JWT
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
