function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

function calculate_volume_discount() {

var total = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseInt($(this).next(".price").html());
total = input_val + total;
});

if (total > 24000){
return .23;
} else if (total < 199){
return 0;
} else {

var top = (.23 - .05) / (total - 199);
var result = (top / (24000 - 199)) + .05;
return result;

}




}


function shipping_cost(total) {


if (total < 500){
return 30;
} else if (total < 500){
var amount = total / (30*500);
return amount;
}

}

function calculate_discount() {

var total = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseInt($(this).next(".price").html());
total = input_val + total;
});

var base_discount = total * .15;
var base_discount=Math.round(base_discount*100)/100;
$(".base-discount").html(base_discount)

var volume_discount = calculate_volume_discount();
var volume_discount = volume_discount * total;
var volume_discount=Math.round(volume_discount*100)/100;
$(".volume-discount").html(volume_discount);

var total_discount = volume_discount + base_discount;

var percentage_tot_discount = (total_discount / total);

var percentage_tot_discount=Math.round(percentage_tot_discount*100*100)/100;
$(".total-discount").html(percentage_tot_discount);

if (jQuery("#outside-us").is(':checked')) {
var total_final = total - parseInt(total_discount) + shipping_cost(total);
} else {
var total_final = total - parseInt(total_discount);
}
$("#order-total").html(total_final);


var deposit = Math.round(total_final*.30*1000)/1000;
var balance = Math.round(total_final*.70*1000)/1000;

deposit = deposit.toFixed(2);
balance = balance.toFixed(2);

$("#order-total-deposit").html(deposit);
$("#order-total-deposit-input").html(deposit);

$("#order-total-balance").html(balance);
$("#order-total-balance-input").html(balance);

var total_rebate = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value") * parseInt($(this).next(".price").html());
//total = input_val + total;
var selector_string = "#rebate_" + $(this).attr("id");
var input_val = Math.round(input_val*.1*100)/100;
$(selector_string).html(input_val);
total_rebate = input_val + total_rebate;
});

$("#total-rebate").html(total_rebate);


}

function populate_order_stats() {
$.ajax({
  url: "performance/get_stats",
  type: 'POST',
  data: "nada",
  success: function(selectValues){
var json_object = JSON.parse(selectValues);
var count = 0;
                for (var i = 0; i < json_object.length; i++) {

$(".order-data").append("<tr><td>"+ json_object[i].name +"</td><td >" + json_object[i].products + "</td><td >" + json_object[i].num_items + "</td><td> " + json_object[i].revenue +" </td> <td>"+ json_object[i].created_at + "</td> <td>"+ json_object[i].email + "</td> <td>"+ json_object[i].phone_number + "</tr>");

}

$('.datatable').dataTable({ 'sPaginationType':'full_numbers' });
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




$(document).ready(function(){




$(".checkout-amazon").click(function() {
$("#order-form").submit();
});



    $('#outside-us').change(function() {       

calculate_discount();

    });


$(".item-row input.quantity").bind("keyup", function(e){

calculate_discount();

});


$('.item-row input.quantity').change(function() {


calculate_discount();

});


$(".ordertype-item").hover(function(){

var image_url = $(this).attr("data-url");
$("img.preview-image").attr("src", image_url);

});








});



