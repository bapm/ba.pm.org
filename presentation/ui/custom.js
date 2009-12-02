$(document).ready(function(){
	// if the slide contains just <h1> put it's text in single cell table
	$(".slide").each(function () {
		if (($(this).children().size() == 1) && ($(this).children().filter('h1').size() == 1)) {
			var h1 = $(this).children().filter('h1');
			$(this).html('<h1 class="hidden">'+$(h1).text()+'</h1><table class="singleCellTable"><tr><td>'+$(h1).html()+'</td></tr></table>');
		}
	});
	// replace div class sigleThink with single cell table
	$(".singleThink").each(function () {
		$(this).html('<table class="singleCellTable"><tr><td>'+$(this).html()+'</td></tr></table>');
	});
});


// Counter
var minutes = null;
var counter = null;

function initCounter() {
	counter = document.getElementById('counter');

	if (counter) {
		minutes = counter.innerHTML;
		displayCounter();
	}
}

function displayCounter() {
	if (minutes>0) {
		minutes-=1;
		counter.innerHTML=minutes; 
		setTimeout("displayCounter()",1000*60);
	}
}
