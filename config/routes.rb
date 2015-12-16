Rails.application.routes.draw do
  root 'rooms#index'
  get 'room/:id' => 'rooms#room'
end
