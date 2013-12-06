# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# window.myNamespace.myName = -> "Bob"


get_pay_and_change = (price, step) ->
    pay = 0    
    return [0, 0] if price == 0
    loop
        pay = pay + step
        break if pay >= price
    change = pay - price
    return [pay, change]

sum_book_price = () ->
    # alert "poc456"
    # iterate through each td based on class and add the values
    total_discounted_price = 0
    total_original_price = 0
    $(".discounted_price").each ->
      value = $(this).text()
      
      # add only if the value is number
      total_discounted_price += parseFloat(value)  if not isNaN(value) and value.length isnt 0      

    $(".original_price").each ->
      value = $(this).text()
      
      # add only if the value is number
      total_original_price += parseFloat(value)  if not isNaN(value) and value.length isnt 0

    total_original_price = Math.ceil(total_original_price)
    total_discounted_price = Math.ceil(total_discounted_price)

    $("#total_original").html total_original_price
    $("#total_discounted").html total_discounted_price   
    [pay, change] = get_pay_and_change(total_discounted_price, 1000)
    $("#if_user_pay_in_thounsand").html pay
    $("#change_in_thounsand").html change    

    [pay, change] = get_pay_and_change(total_discounted_price, 100)
    $("#if_user_pay_in_hundred").html pay
    $("#change_in_hundred").html change           

window.sum_book_price = sum_book_price

$(document).ready ->

    hide_error_msg = -> 
        $('#form_error').hide()

Book =
    add: () ->
        alert "vvn~"


jQuery ->
    $("#checkout_table").on "click", "button[type=\"submit\"]", (e) ->
        $(this).closest("tr").remove()
        sum_book_price()



###
    $(book_price).keyup (e) ->
        if (e.which == 13) 
        # if user click enter           
            e1 = $(this);   
            alert(e1.val().length)
            e1.val('') #clear value

            Book.add()

    $('#add_book_btn').click ->
        alert 'yo'
        $(@).find('input').each -> @reset() # afterwards clear the form
###