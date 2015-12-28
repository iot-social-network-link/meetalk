Rails.application.routes.draw do
  root 'rooms#index'

  get 'room/:id', to: 'rooms#room', as: 'room'
  get 'vote/:id', to: 'rooms#vote', as: 'vote'
  get 'message/:id', to: 'rooms#message', as: 'message'

  post 'casting', to: 'rooms#casting'
  post 'matching', to: 'rooms#matching'

  mount API => '/'
end
