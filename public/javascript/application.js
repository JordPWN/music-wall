$(document).ready(function () {

	// $('.fa.fa-thumbs-up').each({
		$.get("/vote_track", function(response){
			$.each(response["voted_on"], function(index, value){
				$(index).toggleClass('voted');
			});
		});
	// });

	$('.dropdown-toggle').dropdown();


	$('.fa.fa-thumbs-up').click(function(){
		var track_id = $(this).attr('id');
		var element = $(this);
		$.get("/vote_track", {track_id: track_id}, function(response){
			$("#count-"+track_id).html(response["number_upvotes"]);
			$(element).toggleClass('voted');
		});
	});
});