Rails.application.routes.draw do
  root 'rooms#index'
  get 'room/:id' => 'rooms#room'
  get 'matching/:id' => 'rooms#matching'
  post 'casting' => 'rooms#casting'
  post 'waiting' => 'rooms#waiting'
  post 'message' => 'rooms#message'

  mount API => '/'
end
