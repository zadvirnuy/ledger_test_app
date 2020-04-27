Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    resources :ledgers, except: :destroy do
      scope module: :ledgers do
        resources :transactions, except: %i[destroy show] do
          scope module: :transactions do
            resources :tags, only: %i[create]
          end
        end
      end
    end
    resource :stats, only: [] do
      collection do
        get :ledger_totals
        get :ledger_balance
      end
    end
  end
end
