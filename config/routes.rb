Rails.application.routes.draw do
  root 'rooms#index'
  post 'casting' => 'rooms#casting'
  get 'room/:id' => 'rooms#room'

  mount API => '/'
end
