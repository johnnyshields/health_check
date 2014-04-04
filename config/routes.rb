HealthCheck::Engine.routes.draw do

  root :to => 'health_check#index'

  get '(/:checks)(.:format)',
      :to => 'health_check/health_check#index',
      :as => 'health_check'

end
