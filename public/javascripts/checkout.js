

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
function calculate_discount() {

var total = 0;
$(".item-row .quantity").each(function() {
var input_val = $(this).attr("value");
total = input_val + total;
});

var base_discount = total * .15;
$(".base-discount").html(base_discount)

var volume_discount = calculate_volume_discount();
var volume_discount = volume_discount * total;
var volume_discount=Math.round(volume_discount*100)/100;
$(".volume-discount").html(volume_discount);

var total_discount = volume_discount + base_discount;

var percentage_tot_discount = (total_discount / total);

var percentage_tot_discount=Math.round(percentage_tot_discount*100)/100;
$(".total-discount").html(percentage_tot_discount);

if (jQuery("#outside-us").is(':checked')) {
var total_final = total - parseInt(total_discount) + 30;
} else {
var total_final = total - parseInt(total_discount);
}
$("#order-total").html(total_final);


var deposit = Math.round(total_final*.3*100)/100;
var balance = Math.round(total_final*.7*100)/100;


$("#order-total-deposit").html(deposit);
$("#order-total-deposit-input").html(deposit);

$("#order-total-balance").html(balance);
$("#order-total-balance-input").html(balance);
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


$(".item-row input.quantity").bind("keyup", function(e){

calculate_discount();

});





});



