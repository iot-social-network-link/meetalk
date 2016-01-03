Rails.application.routes.draw do
  root 'rooms#index'

  get 'room', to: 'rooms#room', as: 'room'
  get 'vote', to: 'rooms#vote', as: 'vote'
  get 'message/:id', to: 'rooms#message', as: 'message'
  get 'matching', to: 'rooms#matching'

  post 'casting', to: 'rooms#casting'
  post 'wait', to: 'rooms#wait', as: 'wait'

  mount API => '/'
end
