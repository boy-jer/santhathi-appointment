function display_category_in_voucher(obj, input_id, category) {
  if (obj.value != '') {
    $('#tr_category_'+input_id).html(category);
  }
}

$(function($){//on document ready
  $(".inventory_auto_complete_field").each(function (i) {
    $(this).add_inventory_auto_complete_events();
  });
});

jQuery.fn.add_inventory_auto_complete_events = function() {
  this.blur(function() {
    set_inventory_amount(this);
  })
  return this;
};

jQuery.fn.add_inventory_quantity_events = function() {
  this.keydown(function() {
    set_total_amount(this);
  })
  return this;
};

function set_inventory_amount(obj) {
  var inv_name_text_field_id = $(obj).attr('id');
  var inv_price_text_field_id = inv_name_text_field_id.substring(0, (inv_name_text_field_id.length - 20)) + "_price";
  $('#'+inv_price_text_field_id).attr('value', get_inventory_price($(obj).attr('value'), inventory_items_arr));
}

function get_inventory_price(inv_name, inv_arr) {
  var price;
  for(var i=0;i<inv_arr.length; i++) 
      if (inv_name == inv_arr[i][0]) 
          return inv_arr[i][1];
}

/*
$(function($){//on document ready
  $(".inventory_pop_up").each(function (i) {
    $(this).while_clicked();
  });
});

jQuery.fn.while_clicked = function() {
  this.blur(function() {
    open_inventory_pop_up(this);
  })
  return this;
};

function open_inventory_pop_up(obj) {
  if ($(obj).attr('value') == '') {
    return;
  }
  var div_str = "<div id='inventory_pop_up' style='position:absolute;background:#F1EEEC;width:450px;height:300px;padding:5px;border:1px solid #DEDAD8;'>";
  div_str += '<table>';
  for(var i=0;i<10;i++) {
    div_str += '<tr><td><input class="inventory_auto_complete_field" id="purchase_voucher_entry_account_transaction_items_attributes_2_inventory_name" name="purchase_voucher_entry[account_transaction_items_attributes][2][account_name]" onblur="display_category_in_voucher(this, 2, \'Credit\')" size="30" style="border:0px;" type="text" /></td></tr>';    
  }
  div_str += '/<table>';
  div_str += "</div>";
  $('#inventory_pop_up_container').html(div_str);
  $('#inventory_pop_up').css('top', $(obj).position().top + 27);
  $('#inventory_pop_up').css('left', $(obj).position().left + 50);
  set_inventory_auto_complete_fields();
  $('#inventory_pop_up_container').show();
}

function set_inventory_auto_complete_fields() {
  $(".inventory_auto_complete_field").autocomplete(inventory_items_arr, {
		minChars: 0,
		width: 310,
		matchContains: true,
		highlightItem: false,		
		formatResult: function(row) {
			return row.to;
		}
  });
}
*/
