Rails.application.routes.draw do
  # Rota para o dashboard do administrador
  get "admin/dashboard", to: "admin#dashboard", as: :dashboard

  # Configuração do Devise para autenticação de usuários, com sessão personalizada
  devise_for :users, controllers: { sessions: 'users/sessions' }
  
  # Rotas para usuários, restritas apenas para ações de index e show
  resources :users, only: [:index, :show]

  # Rota principal para usuários autenticados, direcionando para o dashboard do administrador
  authenticated :user do
    root 'admin#dashboard', as: :authenticated_root
    get 'settings', to: 'admin#settings', as: :settings
  end

  # Rota principal para usuários não autenticados, direcionando para a página de login do Devise
  devise_scope :user do
    root to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  # Rotas para produtos, incluindo busca personalizada
  resources :produtos, except: [:new, :edit] do
    collection do
      get 'busca', to: 'produtos#search', as: :search
    end
  end

  # Rotas para encomendas (pedidos)
  resources :encomendas, except: [:new, :edit]

  # Namespace para relatórios, com rotas específicas para cada relatório
  namespace :relatorios do
    get 'produtos_vendidos', to: 'relatorios#produtos_vendidos'
    get 'paes_vendidos', to: 'relatorios#paes_vendidos'
  end
end
