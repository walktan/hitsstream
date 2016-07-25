// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree ../../../vendor/assets/javascripts/.
//= require_tree ../../../vendor/assets/stylesheets/.
//= require_tree .


$(function(){
	var tag = document.createElement('script');
	tag.src = 'https://www.youtube.com/iframe_api';
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var ytplayer;
	var position = 0;
	switch ($('#player1').data("now-ranking")) {
		case 1:
			position = 0;
			break;
		case 2:
			position = 100;
			break;
		case 3:
			position = 300;
			break;
		case 4:
			position = 495;
			break;
		case 5:
			position = 695;
			break;
		case 6:
			position = 890;
			break;
		case 7:
			position = 1090;
			break;
		case 8:
			position = 1285;
			break;
		case 9:
			position = 1485;
			break;
		case 10:
			position = 1700;
			break;
	}
	window.scrollTo( 0, position );
});

function onYouTubeIframeAPIReady() {
	var video_id = $('#player1').data("video-id");
	ytplayer = new YT.Player('player1', {
		height: '324',
		width: '576',
		videoId: video_id,
		playerVars: {
                rel: 0, // 再生終了後に関連動画を表示するかどうか設定
                autoplay: 1 // 自動再生するかどうか設定
            },
		events: {
			'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
};

function onPlayerReady(event) {
	$('#play_button, #play_button_list').click(function(){
		var state = ytplayer.getPlayerState();
		if(state == YT.PlayerState.PLAYING) {
			ytplayer.pauseVideo();
		}else{
			ytplayer.playVideo();
		};
	});
	$('#next_button, #next_button_list').click(function(){
		$.ajax({
			url: '/ranks/next',
			type: 'POST',
			data: {this_date: $('#target_date').data("target-date"),
		           name: $('#genre_name').data("genre-name"),
		           now_ranking: $('#player1').data("now-ranking")}
		});
	});
	$('#prev_button, #prev_button_list').click(function(){
		$.ajax({
			url: '/ranks/prev',
			type: 'POST',
			data: {this_date: $('#target_date').data("target-date"),
		           name: $('#genre_name').data("genre-name"),
		           now_ranking: $('#player1').data("now-ranking")}
		});
	});
};

function onPlayerStateChange(event) {
	var state = ytplayer.getPlayerState();
	if(state == YT.PlayerState.ENDED) {
		$.ajax({
			url: '/ranks/next',
			type: 'POST',
			data: {this_date: $('#target_date').data("target-date"),
		           name: $('#genre_name').data("genre-name"),
		           now_ranking: $('#player1').data("now-ranking")}
		});
	};
	if(state == YT.PlayerState.PLAYING) {
	document.getElementById("play_button").innerHTML="［ PAUSE ■ ］";
	document.getElementById("play_button_list").innerHTML="■";
	document.getElementById("play_button_list").className="play";

	};
	if(state == YT.PlayerState.PAUSED) {
	document.getElementById("play_button").innerHTML="［ PLAY ▶ ］";
	document.getElementById("play_button_list").innerHTML="▶";
	document.getElementById("play_button_list").className="pause";
	};
};

