class ProductsController < ApplicationController
	layout 'alternate'
	def index

	end

	def about
		render layout: 'alt'
	end
end