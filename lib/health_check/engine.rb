module HealthCheck
  class Engine < ::Rails::Engine

    isolate_namespace HealthCheck

    config.after_initialize do |app|
      HealthCheck::Engine.prepend_routes(app) # prepend routes so a catchall doesn't get in the way
    end

    private

    def self.prepend_routes(app)
      return if HealthCheck::Engine.routes.recognize_path('/') rescue nil
      require HealthCheck::Engine.root.join("app/controllers/health_check/health_check_controller")

      app.routes.prepend do
        mount HealthCheck::Engine => HealthCheck.mount_at, as: "health_check"
      end
    end
  end
end
