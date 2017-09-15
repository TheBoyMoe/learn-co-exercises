## Using Multiple Controllers

Implementing an app with two models, e.g. products and orders, with all the CRUD actions (index, new, create, etc) would result in an ApplicationController that was large and rather complex. Following the Single Responsibility Principle, we want to encapsulate only logic pertaining to a single entity within a class. In this example we would have a separate controller for both products and orders, each inheriting from ApplicationController, e.g.

```ruby
  # defined in 'app/controllers/application_controller.rb'
  class ApplicationController < Sinatra::Base
    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
    end

    get '/' do
      erb :index
    end

    # helper methods available to all 'child' controllers
    helpers do

      def logged_in?
        # ......
      end

    end

  end

  # defined in 'app/controllers/products_controller.rb'
  class ProductsController < ApplicationController
    get '/products' do
      "Product Index"
    end

    get '/products/:id' do
      "Product #{params[:id]} Show"
    end
  end

  # defined in 'app/controllers/orders_controller.rb'
  class OrdersController < ApplicationController
    get '/orders' do
      "Order Index"
    end

    get '/orders/:id' do
      "Order #{params[:id]} Show"
    end
  end
```

Just as the ApplicationController is mounted in the `config.ru` file, we also need to mount any other controller, e.g.

```ruby
  # example config.ru
  require 'sinatra'

  require_relative 'app/controllers/products_controller'
  require_relative 'app/controllers/orders_controller'
  require_relative 'app/controllers/application_controller'

  # mount the controllers
  use ProductsController
  use OrdersController
  run ApplicationController
```

We need to load the controller files using `require_relative` statements, before mounting them. Only one class can be specified with `run` - the 'ApplicationController', the others are mounted as 'middleware' with `use`.
