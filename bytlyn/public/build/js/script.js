$(document).ready(function() {

	$('.loading-page').hide();

	// parallax effect 
	$('.parallax').parallax();
	$('.carousel').slick({
		dots: true,
		infinite: true,
		slidesToShow: 3,
  		slidesToScroll: 1,
  		lazyLoad: 'ondemand',
  		responsive: [
	    {
	      breakpoint: 550,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1,
	      }
	    }]
	});

	// Add New Card Form
	$('#card-add-new').hide();
	$('#card-add-button').click(function() {
		$('#card-add-new').show();
		$('#card-add-new').addClass("animated slideInUp");
	});

	// change profile-photo 
	$('.change-photo-button').click(function() {
		$('input[id="user_avatar"]').click();
	});

	// click to restaurant
	// bug: when waitlist is clicked it also goes to the restaurant page
	$('.card-view').click(function() {
		// var ln = $('.card-header').attr("href")
		// window.location.href = ln;
	});

	// shopping cart
	$('.shopping-cart-title').click(function() {
		$('.shopping-cart-wrapper').toggle();
		$('.shopping-cart svg').toggle();
	});

	// payment detail toggle
	$('.payment-summary').click(function() {
		console.log($(this).parent().parent().find('payment-detail'));
		$(this).parent().parent().find('.payment-detail').toggle();
		// $(this).parent().children('.payment-detail').toggle();
	});

	// typed.js for landing page
	$('#typed').typed({
        strings: ["Fettuccine", "Lasagna", "Pad Thai", "Fried Rice"],
        typeSpeed: 0,
        backDelay: 1000,
        loop: true
    });

    $('div[toggle="advanced-search"]').click(function(){
    	$('.advanced-search-wrapper').show();
    	$('.advanced-search-wrapper').addClass("animated slideInUp");
    });

    $('.alert-success').delay(2000).fadeOut(1000);

    // highcharts
    var waitlist_curr = $('.waitlist_curr').html();
    var waitlist_hist = $('.waitlist_hist').html();
    var delivery_curr = $('.delivery_curr').html();
    var delivery_hist = $('.delivery_hist').html();
    var del_hist_list = gon.delivery_hist_list;
    for (var i = 0; i < del_hist_list.length; i++) {
       var ol = del_hist_list[i][0];
       del_hist_list[i][0] =  Date.parse(ol);
   }
    // $('.display_data').innerHTML(del_hist_list);

     $('.highcharts-delivery-history').highcharts({
        chart: {
            zoomType: 'x'
        },
        title: {
            text: 'Delivery History'
        },
        subtitle: {
            text: document.ontouchstart === undefined ?
                    'Click and drag in the plot area to zoom in' : 'Pinch the chart to zoom in'
        },
        xAxis: {
            type: 'datetime'
        },
        yAxis: {
            title: {
                text: '# Deliveries'
            }
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            area: {
                fillColor: {
                    linearGradient: {
                        x1: 0,
                        y1: 0,
                        x2: 0,
                        y2: 1
                    },
                    stops: [
                        [0, Highcharts.getOptions().colors[0]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                marker: {
                    radius: 2
                },
                lineWidth: 1,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                threshold: null
            }
        },

        series: [{
            type: 'area',
            name: '# Deliveries',
            data: del_hist_list
        }]
    });

    $('.highcharts-waitlist').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: 'Waitlist'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Current Waitlist', parseInt(waitlist_curr)],
                {
                    name: 'History Waitlist',
                    y: parseInt(waitlist_hist),
                    sliced: true,
                    selected: true
                },
            ]
        }]
    });

	$('.highcharts-delivery').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: 'Delivery'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Current Delivery', parseInt(delivery_curr)],
                {
                    name: 'History Delivery',
                    y: parseInt(delivery_hist),
                    sliced: true,
                    selected: true
                },
            ]
        }]
    });
});


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