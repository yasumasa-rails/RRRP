class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, 
         ##:omniauthable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
         ###, omniauth_providers: [:twitter]

    
    def display_name
        [first_name, last_name].compact.join(' ')
    end
    
    def jwt_payload
        {
          user_id: id,
          email: email,
          firstName: first_name,
          lastName: last_name,
          displayName: display_name
        }
    end
    
end