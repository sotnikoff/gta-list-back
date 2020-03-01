Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
             headers: :any,
             expose: %w[Authorization X-Expired-At X-User-Id Content-Type Accept Total Per-Page],
             methods: %i[get post put patch delete options head]
  end
end
