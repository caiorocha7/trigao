class UsersController < ApplicationController
    before_action :authenticate_user!  # Garante que apenas usuários autenticados acessem
  
    def index
      @users = User.all  # Recupera todos os usuários
    end
end
  