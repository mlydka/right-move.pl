ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

	  #offers
    map.offer ':url', :controller => 'offers', :action => 'show', :requirements => { :url => /(sprzedaz|wynajem)(-[a-z]+){2,}-[\d]{4}/ }
		map.search 'wyszukiwarka', :controller => 'offers', :action => 'search'

    # categories
    map.with_options :controller => 'categories', :action => 'show' do |categories|
      categories.sell_apartments  'sprzedaz-mieszkania',         :type => 'sprzedaż', :name => 'mieszkania'
      categories.rent_apartments  'wynajem-mieszkania',          :type => 'wynajem',  :name => 'mieszkania'
      categories.sell_houses      'sprzedaz-domy',               :type => 'sprzedaż', :name => 'domy'
      categories.rent_houses      'wynajem-domy',                :type => 'wynajem',  :name => 'domy'
      categories.sell_allotments  'sprzedaz-dzialki',            :type => 'sprzedaż', :name => 'działki'
      categories.sell_offices     'sprzedaz-lokale-uzytkowe',    :type => 'sprzedaż', :name => 'lokale użytkowe'
      categories.rent_offices     'wynajem-lokale-uzytkowe',     :type => 'wynajem',  :name => 'lokale użytkowe'
      categories.sell_commercials 'sprzedaz-obiekty-komercyjne', :type => 'sprzedaż', :name => 'obiekty komercyjne'
      categories.rent_commercials 'wynajem-obiekty-komercyjne',  :type => 'wynajem',  :name => 'obiekty komercyjne'
    end

    # subcategories
    map.with_options :controller => 'categories', :action => 'show', :type => 'sprzedaż' do |categories|
      categories.connect 'sprzedaz-mieszkania-garsoniery-i-jednopokojowe',   :name => 'garsoniery i jednopokojowe'
      categories.connect 'sprzedaz-mieszkania-dwupokojowe',                  :name => 'dwupokojowe'
      categories.connect 'sprzedaz-mieszkania-trzypokojowe',                 :name => 'trzypokojowe'
      categories.connect 'sprzedaz-mieszkania-cztery-pokoje-i-wiecej',       :name => 'cztery pokoje i więcej'
    end

    map.with_options :controller => 'categories', :action => 'show', :type => 'wynajem' do |categories|
      categories.connect 'wynajem-mieszkania-garsoniery-i-jednopokojowe',   :name => 'garsoniery i jednopokojowe'
      categories.connect 'wynajem-mieszkania-dwupokojowe',                  :name => 'dwupokojowe'
      categories.connect 'wynajem-mieszkania-trzypokojowe',                 :name => 'trzypokojowe'
      categories.connect 'wynajem-mieszkania-cztery-pokoje-i-wiecej',       :name => 'cztery pokoje i wiecej'
    end

    map.login 'login', :controller => 'sessions', :action => 'new'
    map.logout 'logout', :controller => 'sessions', :action => 'destroy'

    # home
    map.with_options :controller => 'home' do |home|
      home.about   'o_nas',                :action => 'about'
      home.policy  'polityka_prywatnosci', :action => 'policy'
      home.career  'kariera',              :action => 'career'
      home.contact 'kontakt',              :action => 'contact'

      home.user_offer   'zglos_oferte',  :action => 'user_offer'
      home.user_request 'czego_szukasz', :action => 'user_request'
    end

    #articles
    map.with_options :controller => 'articles' do |articles|
      articles.articles 'artykuly',     :action => 'index'
      articles.article  'artykuly/:id', :action => 'show', :requirements => { :id => /\d+/ }
    end

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

    map.resources :sessions
    map.resources :articles

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

    map.namespace :admin do |admin|
			admin.resources :contents
      admin.resources :offers, :collection => { :toggle_variables_form => :post, :upload_image => :post, :destroy_image => :delete }
      admin.resources :categories, :collection => { :toggle_variables_form => :post }, :member => { :reorder => :put }
      admin.resources :variables
      admin.resources :categories_variables, :collection => { :reorder => :put }, :member => { :change_status => :put }
      admin.resources :articles
    end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
    map.root :controller => 'home'
    map.admin 'admin', :controller => 'admin/main'

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect '*path', :controller => 'home'
end
