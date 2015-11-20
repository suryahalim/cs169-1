class Delivery < ActiveRecord::Base

	def self.get_delivery_cust(params)
		return Delivery.where(user_id: params[0])
	end

	def self.get_delivery_rest(params)
		# render text: params
		# return params
		return Delivery.where(rest_id: params)
	end

	def self.get_order(params)
		@cart = Cart.where(cust_id: params[:user_id], rest_id: params[:rest_id], version: params[:version])
		menuArray = []
		@cart.each do |c|
			menu = Menu.find(c.menu_id)
			menuArray.push(menu.name)
		end
		return menuArray
	end

end
