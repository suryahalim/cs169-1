$(window).load(function() {
	$('.loading-page').fadeOut(3000);
})

// Youtube API

var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var player;
function onYouTubeIframeAPIReady() {
	player = new YT.Player('yt-player', {
	    height: '500px',
	    width: '100%',
	    videoId: 'frubRK86fb4',
	    playerVars: {
	      'controls': 0,
	      'rel': 0,
	      'showinfo': 0,
	      'modestbranding': 1,
	    },
	});
}