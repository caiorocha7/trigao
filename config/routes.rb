Rails.application.routes.draw do
  get "admin/dashboard"
  # Devise authentication with custom sessions controller
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  # Root for authenticated users
  authenticated :user do
    root 'admin_dashboard#index', as: :authenticated_root
  end

  # Root for unauthenticated users (login page)
  devise_scope :user do
    root to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy', as: :logout  # Logout route
  end

  # Products with search
  resources :produtos do
    collection do
      get 'busca', to: 'produtos#search'
    end
  end

  # Orders
  resources :encomendas

  # Reports
  namespace :relatorios do
    get 'produtos_vendidos', to: 'relatorios#produtos_vendidos'
    get 'paes_vendidos', to: 'relatorios#paes_vendidos'
  end
end
