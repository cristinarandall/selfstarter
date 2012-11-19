
function get_users() {

var company_id = $("#company_id").attr("value");
$.ajax({
  url: "admins/get_orders?company_id=" + company_id,
  type: 'POST',
  data: "company_id=" + company_id,
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;
                for (var i = 0; i < json_object.length; i++) {


}

}

});
}



$(function(){



$(".item-row input.quantity").change(function() {



var total = 0;
$(".item-row input.quantity").bind("keyup", function(e){

var quantity_value = $(this).attr("value");

total = total + parseInt(quantity_value) * parseFloat($(this).next(".price").html());

});

$("#order-total").html(total)


});


});



