Rails.application.routes.draw do
  get 'schedule_activity' => "activities#schedule_activity", as: :schedule_activity
  get 'check_conflicts' => "activities#check_conflicts", as: :check_conflicts
  get 'update_schedule' => "activities#update_schedule", as: :update_schedule
  resources :activities
  resources :locations
  resources :time_slots
  resources :participants
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
