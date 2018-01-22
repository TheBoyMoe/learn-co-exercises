class CouponsController < ApplicationController

	def show
		@coupon = Coupon.find(params[:id])
	end

	def index
		@coupons = Coupon.all
	end

	def create
		# first verdion is required to make controller specs pass with a valid record with data
		# post passes a coupon hash, {coupon: {coupon_code: '', store: ''}}
		# @coupon = Coupon.create(coupon_code: params[:coupon][:coupon_code], store: params[:coupon][:store])
		@coupon = Coupon.create(coupon_code: params[:coupon_code], store: params[:store])
		redirect_to coupon_path(@coupon)
	end

	def new
	end

end