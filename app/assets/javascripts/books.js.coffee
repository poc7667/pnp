# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

#通常比較好的Practice 應該是, 把function 寫在外面, 當document ready之後再給於載入。

$(document).ready ->
	no_op: () ->
		alert "no op"
	
# Order =
# 	count: () ->
# 		exrate = parseInt($('#order_ex_rate').val(), 10)
# 		a = parseInt($('#order_product_rmb').val(), 10)
# 		b = parseInt($('#order_delivery_rmb').val(), 10)

# 		alert (a+b)*exrate
jQuery ->
	# $('#get_order_price').click ->
		# alert 'yo'
		# Order.count()
		# $(@).find('input').each -> @reset() # afterwards clear the form
