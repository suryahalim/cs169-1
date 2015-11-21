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

	def self.get_customer_delivery(user_id)
		return Delivery.where(user_id: user_id)

	end

	def self.get_restaurant_delivery(user_id)
		delivery_list = Delivery.where(rest_id: user_id)
		list_and_cart = []
		delivery_list.each do |delivery|
			this_cart = Cart.find_cart(delivery.user_id, delivery.rest_id, delivery.version)
			this_menu = []
			this_cart.each do |cart|
				this_menu << {name: Menu.find(cart.menu_id).name, qty: cart.qty}
			end

			list_and_cart << {:delivery => delivery, :cart => this_menu}
		end
		return list_and_cart
	end

end
