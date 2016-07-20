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
//= require_tree .


$(function(){
	var tag = document.createElement('script');
	tag.src = 'https://www.youtube.com/iframe_api';
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	var ytplayer;
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

