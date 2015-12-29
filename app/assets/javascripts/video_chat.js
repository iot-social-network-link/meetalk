/* -----------------------------------------------------------------
 * Skyway multyparty 利用したライブラリ
 *
 * ----------------------------------------------------------------- */

//自分が入室したときの処理
function proc_myms(video, s_name, s_gender){
    console.log('myvideo obj:');
    console.log(video);
    // 3. resist wid
    //resist_wid();

    // 自分のvideoを表示
    var vNode = MultiParty.util.createVideoNode(video);
    vNode.setAttribute("class", "video my-video");
    vNode.volume = 0;
    $(vNode).appendTo(selectElm_wGender(s_gender)); //"#streams"
    // 名前枠を追加
    var myVideoElem = document.createElement('div');
    myVideoElem.setAttribute("id", 'my-video-uinfo'); //★ 動的にwid入れる
    myVideoElem.innerHTML = 'name:  ' + s_name + '<br>gen: ' + s_gender;
    $(myVideoElem).appendTo(selectElm_wGender(s_gender)); //"#streams"
    
}
//他人が入室したときの処理
function peer_myms(roomid, video){
    // ユーザ枠を追加: <div id = "peer-video-uinfo-[windowid]">
    var pVideoElem = document.createElement('div');
    pVideoElem.setAttribute("id", 'peer-video-uinfo-'+ video['id']);
    console.log('peer video obj:');
    console.log(video);
    $(pVideoElem).appendTo(selectElm_wGender(s_gender)); //"#streams"

    // peerのvideoを表示
    var vNode = MultiParty.util.createVideoNode(video);
    vNode.setAttribute("class", "video peer-video");
    $(vNode).appendTo(pVideoElem); 

    // 1. get peer uinfo
    display_uinfo(video['id'], roomid); // wid, roomid
    // 2. check fullroom API
    check_fullroom(roomid); // roomid ■動的に //call display_timer();
}


function manage_mediasteam(s_roomid, s_name, s_gender) {
    multiparty.on('my_ms', function(video) {
	    proc_myms(video, s_name, s_gender); //自分入室時の処理

	}).on('peer_ms', function(video) {
	    peer_myms(s_roomid, video); //自分入室時の処理

	}).on('ms_close', function(peer_id) {
	    // peerが切れたら、対象のvideoノードを削除する
	    // 4. delete_user(); //ブラウザを閉じた場合はexit関数で処理されない
	    $("#"+peer_id).remove();
	})

    // Error handling:★ユーザに何を表示すべきか要検討
    multiparty.on('error', function(err) {
	    alert(err);
	});
}

function manage_message(){
    multiparty.on('message', function(mesg) {
	    // peerからテキストメッセージを受信
	    $("p.receive").append(mesg.data + "<br>");
	});

    $("#message form").on("submit", function(ev) {
	    ev.preventDefault();  // onsubmitのデフォルト動作（reload）を抑制
	    // テキストデータ取得
	    var $text = $(this).find("input[type=text]");
	    var data = $text.val();
	    if(data.length > 0) {
		data = data.replace(/</g, "<").replace(/>/g, ">");
		$("p.receive").append(data + "<br>");
		// メッセージを接続中のpeerに送信する
		multiparty.send(data);
		$text.val("");
	    }
	});
}

//先に、manage_***()の定義が必要
function video_chat_start(s_roomid, s_name, s_gender) {
    multiparty = new MultiParty( {
	    "key": "44ed614d-25eb-4a1f-b7a8-a47acd9f7595",
	    "reliable": true,
	    "room_id": s_roomid,
	    "debug": 3
	});
    manage_message();
    // サーバとpeerに接続
    multiparty.start();
    manage_mediasteam(s_roomid, s_name, s_gender);
}

// Exit確認
function exit_confirm(){
    if (confirm("会話が終了します。本当に終了してもよいですか？")) {
        exit_video_chat();
    }
}

// Exit機能
function exit_video_chat(){
    console.log("Exit!!");
    multiparty.close();
    // 4. delete_user();
    var top_url = "http://" + location.host;
    console.log(top_url);
    location.href=top_url; //redirect to top.
}

// 映像ON／OFF機能
function onVideoChange(){
  video_check_on = document.video_change_form.video_on.checked;

  if (video_check_on == true){
    console.log("映像ON");
    multiparty.unmute({"video": true});
  } else {
    console.log("映像OFF");
    multiparty.mute({"video": true});
  }
}

// 音声ON／OFF機能
function onAudioChange(){
  audio_check_on = document.audio_change_form.audio_on.checked;

  if (audio_check_on == true){
    console.log("音声ON");
    multiparty.unmute({"audio": true});
  } else {
    console.log("音声OFF");
    multiparty.mute({"audio": true});
  }
}
