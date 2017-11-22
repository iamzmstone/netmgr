Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#list_switch'
  get 'vlans' => 'main#vlans'
  get 'list_switch' => 'main#list_switch'
  get 'list_port' => 'main#list_port'
  get 'switch_detail' => 'main#switch_detail'
end
