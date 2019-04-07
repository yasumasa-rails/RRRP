##https://github.com/lynndylanhurley/devise_token_auth
##http://sainu.hatenablog.jp/entry/2018/08/11/194319
module Api
  module Auth
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      before_action :authenticate_api_user!, except: [:create]
      private
      def sign_up_params
        params.permit( :email,  :password, :password_confirmation)
      end
    end  
  end
end
