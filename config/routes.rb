Rails.application.routes.draw do

  root 'home#index'
  
  # Pages
  get 'home/realtime_data'
  get 'home/increment/:id' => 'home#increment'
  get 'day' => 'home#day'
  get 'night' => 'home#night'
  get 'credit' => 'home#credit'
  get 'program' => 'home#program_page'
  get 'day/:id' => 'home#day'
  get 'night/:id' => 'home#night'
  get 'find/:id' => 'home#find'
  

  # 사용자 세션 부분
  get 'likelion' => 'sessions#new'
  post 'likelion' => 'sessions#create'
  
  controller :sessions do
    get 'logout' => :destroy
  end
  
  # 관리자 페이지 부분
  get 'fest_manage' => 'users#show'
  get 'fest_manage/make/realtime' => 'users#make_realtime'
  get 'fest_manage/make/location' => 'users#make_location'
  post 'fest_manage/make/location/save' => 'users#write'
  get 'fest_manage/make/location/list' => 'users#make_location_list'
  post 'fest_manage/make/realtime/save' => 'users#make_realtime_save'
  post 'fest_manage/make/location/update/:id' => 'users#update'
  get 'fest_manage/make/location/rewrite/:id' => 'users#make_location_rewrite'
  get 'fest_manage/make/location/destroy/:id' => 'users#destroy'
  get 'fest_manage/make/location/list/day' => 'users#day'
  get 'fest_manage/make/location/list/night'=> 'users#night'
  get 'fest_manage/make/location/list/db_move'=> 'users#db_move'
  
  resources :users

end
