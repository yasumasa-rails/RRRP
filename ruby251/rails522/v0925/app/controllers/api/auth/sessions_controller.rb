##https://github.com/lynndylanhurley/devise_token_auth
module Api
  module Auth
    class SessionsController < DeviseTokenAuth::SessionsController
      before_action :authenticate_api_user!, except: [:create]
        # Prevent session parameter from being passed
        # Unpermitted parameter: session
        wrap_parameters format: []
    end    
  end
end
