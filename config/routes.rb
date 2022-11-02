Rails.application.routes.draw do
  root to: 'homes#top'
  get 'books/new'
  post 'books'=> 'books#create'
  get 'books/:id' => 'books#show',as: 'book'
  get 'books/:id/edit' => 'books#edit', as: 'edit_book'
  get 'books' => 'books#index'
  patch 'books/:id' => 'books#update', as: 'update_book'
end
