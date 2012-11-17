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



