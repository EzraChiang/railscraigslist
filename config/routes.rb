Rails.application.routes.draw do
  get '/' => redirect("/categories")

  resources :categories do
    resources :articles, except: [:edit]
  end

  get '/categories/:category_id/articles/:id/secret' => 'articles#secret'
  get '/categories/:category_id/articles/:id/:secret' => 'articles#edit'
end
