class HomeController < ApplicationController
  def index
  end

  def admin
    render layout: 'admin'
  end
end
