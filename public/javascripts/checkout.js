

var hideMessage = function() {
    
$("#exceed-error").fadeOut();
}


function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}


function orderinfo(order_id){

//$(".order-profile").modal("show");

}

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function calculate_volume_discount() {

var total = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseFloat($(this).next(".price").html());
total = input_val + total;
});

if (total > 24000){
return .23;
} else if (total < 199){
return 0;
} else {

var top = (.23 - .05) * (total - 199);
var result = (top / (24000 - 199)) + .05;
return result;

}




}


function shipping_cost(total) {

total = parseFloat(total);
if (total < 500){
$(".total-shipping").html("30");
$("#total-shipping-cost").attr("value",amount);


return 30;

} else if (total > 500){
var amount = (total / 500) * 30;

$(".total-shipping").html(amount);
$("#total-shipping-cost").attr("value",amount);


return amount;
}

}

function calculate_discount() {

var total = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseFloat($(this).next(".price").html());

total = input_val + total;
});

$(".subtotal").html(addCommas(total));


var base_discount = total * .15;
var base_discount=Math.round(base_discount*100)/100;
$(".base-discount").html(addCommas(base_discount.toFixed(2)))

var volume_discount = calculate_volume_discount();
var volume_discount = volume_discount * total;
$(".volume-discount").html(addCommas(volume_discount.toFixed(2)));
var total_discount = volume_discount + base_discount;

var percentage_tot_discount = (total_discount / total);

var percentage_tot_discount=Math.round(percentage_tot_discount*100*100)/100;
$(".total-discount").html(addCommas(percentage_tot_discount.toFixed(2)));
if (jQuery("#outside-us").is(':checked')) {
var total_final = total - parseFloat(total_discount) + shipping_cost(total);
} else {
var total_final = total - parseFloat(total_discount);
}
$("#order-total").html(addCommas(total_final.toFixed(2)));


var deposit = Math.round(total_final*.30*1000)/1000;
var balance = Math.round(total_final*.70*1000)/1000;

deposit = deposit.toFixed(2);
balance = balance.toFixed(2);

$("#order-total-deposit").html(addCommas(deposit));

$("#order-total-deposit-input").attr("value",deposit);

$("#order-total-balance").html(addCommas(balance));
$("#order-total-balance-input").attr("value", balance);

var total_rebate = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseFloat($(this).next(".price").html());
//total = input_val + total;
var selector_string = "#rebate_" + $(this).attr("id");
var input_val = Math.round(input_val*.1*100)/100;

$(selector_string).html(input_val.toFixed(2));
total_rebate = input_val + total_rebate;
});

$("#total-rebate").html(total_rebate.toFixed(2));



}


function products_in_order(id) {
$.ajax({
  url: "/products_in_order",
  type: 'POST',
  data: "id=" + id,
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;


//$("#products-table").html("");


var html_string = "<thead><tr><th>Product Name</th><th> Quantity</th></tr></thead>";

                for (var i = 0; i < json_object.length; i++) {

var html_string = html_string + "<tr><td> " + json_object[i].name + " </td><td>" + json_object[i].quantity  + " </td></tr>";
$("#products-table").append(html_string);
}


$("#products-table").html(html_string);


}
});
}


function single_order(id) {
$.ajax({
  url: "/single_order",
  type: 'POST',
  data: "id=" + id,
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;



                for (var i = 0; i < json_object.length; i++) {



if ( (json_object[i].paid_deposit) && (json_object[i].paid_balance))  {
var html_string = "<tr><td> Order # </td><td>" + json_object[i].gritworks  + " </td></tr> <tr><td> Name </td><td>" + json_object[i].name  + " </td></tr><tr><td> Email </td><td>" + json_object[i].email  + " </td></tr> <tr><td> Address </td><td>" + json_object[i].address  + " </td></tr><tr><td> Order Total </td><td>" + json_object[i].total  + " </td></tr> <tr><td> Deposit </td><td>$" + json_object[i].deposit  + " </td></tr><tr><td> Balance </td><td>$" + json_object[i].balance  + " <span style='color:green;'> (Successfully Paid Deposit and Balance)</span> </td></tr><tr><td> Status </td><td>" + json_object[i].status  + " </td></tr>";
} else if (json_object[i].paid_deposit) {
var html_string = "<tr><td> Order # </td><td>" + json_object[i].gritworks  + " </td></tr> <tr><td> Name </td><td>" + json_object[i].name  + " </td></tr><tr><td> Email </td><td>" + json_object[i].email  + " </td></tr> <tr><td> Address </td><td>" + json_object[i].address  + " </td></tr><tr><td> Order Total </td><td>" + json_object[i].total  + " </td></tr> <tr><td> Deposit </td><td>$" + json_object[i].deposit  + " <span style='color:green;'> (Successfully Paid Deposit)</span> </td></tr><tr><td> Balance </td><td>$" + json_object[i].balance  + " <button class='charge-balance' data-id='"+ json_object[i].order_id+ "'> Charge Balance</button> </td></tr><tr><td> Status </td><td>" + json_object[i].status  + " </td></tr>";

} else {
var html_string = "<tr><td> Order # </td><td>" + json_object[i].gritworks  + " </td></tr> <tr><td> Name </td><td>" + json_object[i].name  + " </td></tr><tr><td> Email </td><td>" + json_object[i].email  + " </td></tr> <tr><td> Address </td><td>" + json_object[i].address  + " </td></tr><tr><td> Order Total </td><td>" + json_object[i].total  + " </td></tr> <tr><td> Deposit </td><td>$" + json_object[i].deposit  + " <button class='charge-deposit blue' data-id='"+ json_object[i].order_id+ "'> Charge Deposit</button></td></tr><tr><td> Balance </td><td>$" + json_object[i].balance  + " <button class='charge-balance' data-id='"+ json_object[i].order_id+ "'> Charge Balance</button> </td></tr><tr><td> Status </td><td>" + json_object[i].status  + " </td></tr>";
}



$("#profile-table").html(html_string);

}



//$('.datatable').dataTable({ 'sPaginationType':'full_numbers' });
}
});
}

function summary_stats() {
$.ajax({
  url: "performance/get_summary",
  type: 'POST',
  data: "nada",
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;
                
for (var i = 0; i < json_object.length; i++) {
$(".stats-summary.bottom-right").append("<li><strong class='stats-count'>" + json_object[i].count + "</strong><p>" + json_object[i].name + "</p></li>");
}
}

});
}




function populate_order_stats() {

$.ajax({
  url: "/get_orders",
  type: 'POST',
  data: "data",
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;
                for (var i = 0; i < json_object.length; i++) {
var order_id = json_object[i].id.toString();


$(".order-data").append("<tr><td> " + json_object[i].gritworks + "</td><td><a class='trigger-modal-profile' id='"+ json_object[i].id  + "'>" + json_object[i].name +"</a></td><td >" + json_object[i].products + "</td><td >" + json_object[i].num_items + "</td><td> " + json_object[i].total +" </td> <td>"+ json_object[i].created_at + "</td> <td>"+ json_object[i].email + "</td><td>" + json_object[i].address + "</td> <td>" + json_object[i].status + "</td> </tr>");

}



$('.datatable').dataTable({ 'sPaginationType':'full_numbers' });

$(".trigger-modal-profile").click(function() {


var order_id = $(this).attr("id");


single_order(order_id);
products_in_order(order_id);

$(".order-profile").modal("show");
});


}

});
}




$(document).ready(function(){




$(".checkout-amazon").click(function() {
$("#order-form").submit();
});



    $('#outside-us').change(function() {       

calculate_discount();

    });


$(".item-row input.quantity").bind("keyup", function(e){



var actual_value = $(this).attr("value");

var actual_value_int = parseInt(actual_value)
if (actual_value_int > 50)
{
$(this).attr("value", 50);
$("#exceed-error").fadeIn();

setTimeout(hideMessage, 4000);
}

//$(this).attr("value", actual_value.substring(0, 3));

calculate_discount();

});


$(".charge-balance").live("click", function(e){


var id = $(this).attr("data-id");
//$(this).removeClass("red").addClass("green");
//$(this).html("Successfully charged balance");
$.ajax({
  url: "/pay_balance",
  type: 'POST',
  data: "order_id=" + id,
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;
$(".charge-balance").removeClass("red").addClass("green");
$(".charge-balance").html("Successfully charged balance");
alert("Successfully charged balance");
}
});

});


$(".charge-deposit").live("click", function(e){


var id = $(this).attr("data-id");

//$(this).removeClass("blue").addClass("green");
//$(this).html("Successfully charged deposit");

$.ajax({
  url: "/pay_deposit",
  type: 'POST',
  data: "order_id=" + id,
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;

$(".charge-deposit").removeClass("blue").addClass("green");
$(".charge-deposit").html("Successfully charged deposit");
alert("Successfully charged deposit");
}
});

});


$('.item-row input.quantity').change(function() {


calculate_discount();

});


$(".ordertype-item").hover(function(){

var image_url = $(this).attr("data-url");
$("img.preview-image").attr("src", image_url);

});








});



