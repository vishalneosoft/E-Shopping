/*price range*/

	var RGBChange = function() {
	  $('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
	};	

// function myFunction(cartId,product_id,min,max) {
//     var value = document.getElementById("quantity-update-"+cartId).value;
//     if( value == '' || value > max || value <= 0 )
//     {
//       alert("Quantity should be between "+min+" and "+max);
//     }
//     else
//     {
//       $.ajax({
//       url: "/cart_items/"+cartId,
//       type: "PUT",
//       data: {"product_id" : product_id,"quantity" :value},
//       dataType: "script"
//       });
//     }
// }

$(document).ready(function(){ 
  $(document).on("click","#form-close",function() {
    $("new_address").slideUp();
  });
});

$(document).ready(function(){ 
  $(document).on("click","#check-address",function() {
    if($('#check-address').is(':checked'))
    {
      $('#name1').val($('#name').val());
      $('#address-field1').val($('#address-field').val());
      $('#address-field3').val($('#address-field2').val());
      $('#pincode1').val($('#pincode').val());
      $('#phone1').val($('#phone').val());
      $('#city1').val($('#city').val());
      $('#country1').val($('#country').val());
      $('#state1').val($('#state').val());
    } 
    else 
    { 
      $('#name1').val("");
      $('#address-field1').val("");
      $('#address-field3').val("");
      $('#pincode1').val("");
      $('#phone1').val("");
      $('#city1').val("");
      $('#country1').val("");
      $('#state1').val("");
    };

  });
});

$(document).ready(function(){
  $(document).on("change",".cart_quantity_input",function() {
    var value = parseInt($(this).val());
    var min = $(this).attr('min');
    var max = $(this).attr('max');
    var productId = $(this).attr('product_id');
    var id = $(this).attr('id');
    var originalval = $(this).attr('value');
    var cartId = id.replace('quantity-update-','');
    if( value == '' || value > max || value <= 0 )
    { 
      $("#"+id).val(originalval);
      alert("Quantity should be between "+min+" and "+max);
    }
    else
    {
      $.ajax({
      url: "/cart_items/"+cartId,
      type: "PUT",
      data: {"product_id" :productId,"quantity" :value},
      dataType: "script"
      });
    }
  });
   
	$(function () {
		$.scrollUp({
	        scrollName: 'scrollUp', // Element ID
	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
	        scrollFrom: 'top', // 'top' or 'bottom'
	        scrollSpeed: 300, // Speed back to top (ms)
	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
	        animation: 'fade', // Fade, slide, none
	        animationSpeed: 200, // Animation in speed (ms)
	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
					//scrollTarget: false, // Set a custom target element for scrolling to the top
	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
	        scrollTitle: false, // Set a custom <a> title if required.
	        scrollImg: false, // Set true to use image
	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
	        zIndex: 2147483647 // Z-Index for the overlay
		});
	});
});
