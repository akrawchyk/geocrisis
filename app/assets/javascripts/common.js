var CommonJS = CommonJS || {};

CommonJS.Navigation = CommonJS.Navigation || {};
CommonJS.Navigation.shown = false;

CommonJS.Navigation.showNavigation = function() {
  console.log(CommonJS.Navigation.shown);
  if (CommonJS.Navigation.shown == false) {
	  $.get("/render_navigation",
	  		{},
	  		function(data) {
	  			data.html += "<button type='button' class='back_button'><i class='icon-home'></i>Back</button>"

				// append overlay
			    var $overlay = $('<div/>', {
			      id: 'overlay',
			      html: data.html,
			      appendTo: 'body'
			    });

			    $("#overlay .back_button").click(function() {
			    	$("#overlay").hide();
			    });
			    $("#overlay").css({"opacity": ".95", "position": "fixed"});

	  			CommonJS.Navigation.shown = true;
	  		}
	  	)
  } else {
  	$("#overlay").show();
  }
};

CommonJS.Navigation.hideNavigation = function() {
	$("#navigation").hide();
}

// this is where it begins
$(function() {
	$("#nav_menu_button").click(function() { 
		CommonJS.Navigation.showNavigation();
	});
});