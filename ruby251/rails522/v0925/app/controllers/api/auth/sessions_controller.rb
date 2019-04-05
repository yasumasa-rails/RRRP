##https://github.com/lynndylanhurley/devise_token_auth
module Api
  module Auth
    class SessionsController < DeviseTokenAuth::SessionsController
        # Prevent session parameter from being passed
        # Unpermitted parameter: session
        wrap_parameters format: []
    end    
  end
end
