Rails.application.routes.draw do
  root 'rooms#index'
  get 'room/:id' => 'rooms#room'
  get 'vote/:id' => 'rooms#vote'
  get 'message/:id' => 'rooms#message'
  post 'casting' => 'rooms#casting'
  post 'matching' => 'rooms#matching'

  mount API => '/'
end
