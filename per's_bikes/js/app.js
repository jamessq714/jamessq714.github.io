

$(document).ready(function(){
	if($("#my-als-list").size()){
		$("#my-als-list").als({
			visible_items: 3,
			scrolling_items: 1,
			circular: "yes",
			autoscroll: "yes",
			interval: 3000,
		});
	}

	doLocalization()

  	$('.flag').click(function(){
	   	setCurrentLanguage($(this).data('lang'))
    	doLocalization()
 	 })
});	
