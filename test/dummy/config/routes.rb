Dummy::Application.routes.draw do
  mount HealthCheck::Engine => '/'
end
