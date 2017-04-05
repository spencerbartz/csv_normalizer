Rails.application.routes.draw do
  root 'uploads#index'
  post 'upload'           => 'uploads#upload'
  get  'overview'         => 'uploads#overview'
  get  'purge_and_reset'  => 'uploads#purge_and_reset'
end
