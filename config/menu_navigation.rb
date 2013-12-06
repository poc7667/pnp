# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|


  navigation.items do |primary|

    # primary.item :urltests, 'Check-In', root_path
    primary.item :urltests, '結帳', carts_path
    primary.item :urltests, '查書/入庫', root_path
    primary.item :urltests, 'History', carts_path
    primary.item :urltests, '帳單明細', orders_path
    primary.item :urltests, '新增會員', customers_path
    # primary.item :urltests, 'Users', customers_path
    # primary.item :urltests, 'Search bk', book_search_view_path
    # primary.item :urltests, 'Bar Code', book_print_barcode_path


    primary.dom_class='nav'
  end

end