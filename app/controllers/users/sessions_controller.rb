class Users::SessionsController < Devise::SessionsController
    # Desativar verificação de CSRF para API login
    skip_before_action :verify_authenticity_token, only: [:create]
  
    def after_sign_in_path_for(resource)
      admin_dashboard_path # ou qualquer outra página que deseja redirecionar
    end
  end
  