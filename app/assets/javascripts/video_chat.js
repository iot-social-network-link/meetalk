/* -----------------------------------------------------------------
 * Skyway multyparty 利用したライブラリ
 *
 * ----------------------------------------------------------------- */

//自分が入室したときの処理
function proc_myms(video, s_roomid, s_name, s_gender, uid){
  console.log('myvideo obj:');
  console.log(video);

  // 3. resist wid
  regist_windowid(uid, video['id']);

  // 自分のvideoを表示
  var vNode = MultiParty.util.createVideoNode(video);
  vNode.setAttribute("class", "video my-video");
  vNode.volume = 0;
  $(vNode).appendTo(selectElm_wGender(s_gender)); //"#streams"

  // 名前枠を追加
  var myVideoElem = document.createElement('div');
  myVideoElem.setAttribute("id", 'my-video-uinfo');
  myVideoElem.innerHTML = 'myname:  ' + s_name + '<br>mygen: ' + s_gender;
  $(myVideoElem).appendTo(selectElm_wGender(s_gender)); //"#streams"
}

//他人が入室したときの処理
function peer_myms(roomid, video){

  // 1. get peer uinfo
  display_uinfo(video, roomid); // wid, roomid

  // 2. check fullroom API
  check_fullroom(roomid); // roomid ■動的に //call display_timer();
}


function manage_mediasteam(s_roomid, s_name, s_gender, uid) {
  multiparty.on('my_ms', function(video) {
	  proc_myms(video, s_roomid, s_name, s_gender, uid); //自分入室時の処理

	}).on('peer_ms', function(video) {
    peer_myms(s_roomid, video); //他人入室時の処理
	}).on('ms_close', function(peer_id) {
	  // TODO
	  // 対象のユーザ情報を削除 wid
	  // 4. delete_user(); //ブラウザを閉じた場合はexit関数で処理されないため必要

	  // peerが切れたら、対象のvideoノードを削除する
	  $("#"+peer_id).remove();
	})

  // Error handling:★ユーザに何を表示すべきか要検討
  multiparty.on('error', function(err) {
	  alert(err);
	});
}

function manage_message(name){
  multiparty.on('message', function(mesg) {
	  // peerからテキストメッセージを受信
	  $("p.receive").append(mesg.data + "<br>");
	});

  $("#message form").on("submit", function(ev) {
	  ev.preventDefault();  // onsubmitのデフォルト動作（reload）を抑制
	  // テキストデータ取得
	  var $text = $(this).find("input[type=text]");
	  var data = escapeHtml(($text.val()));
	  data = name + ': ' + data;
	  if(data.length > 0) {
      data = data.replace(/</g, "<").replace(/>/g, ">");
		　$("p.receive").append(data + "<br>");
		　// メッセージを接続中のpeerに送信する
		　multiparty.send(data);
		　//		$text.val("");
	  }
	});
}

//先に、manage_***()の定義が必要
function video_chat_start(s_roomid, s_name, s_gender, uid) {

  var room_name = 'room' + (s_roomid).toString();

  //sessionStorageクリア
  clearSessionStorage();

  mlt_debug = (DEBUG_FLG) ? 2 : 0;
  multiparty = new MultiParty( {
    //"key": "44ed614d-25eb-4a1f-b7a8-a47acd9f7595",
    // "key": "50ceb8ca-2920-42a1-a3ae-edfa39d3ab3d",
    "key": gon.const.multi_party_key,
	  "reliable": true,
	  "room": room_name,
    "id": 'meetalkid_' + uid, //skywayでユーザを一位に特定するid?
	  "debug": mlt_debug
	});
  //manage_message(s_name); //チャットしない
  // サーバとpeerに接続
  multiparty.start();
  manage_mediasteam(s_roomid, s_name, s_gender, uid);
}

function message_start(s_name, s_roomid) {
  multiparty = new MultiParty( {
    "key": gon.const.multi_party_key,
	  // "key": "44ed614d-25eb-4a1f-b7a8-a47acd9f7595",
	  "reliable": true,
	  "room_id": s_roomid,
	  "debug": 2
	});
  manage_message(s_name);
  // サーバとpeerに接続
  multiparty.start();
}

// Exit機能(skyway)
function exit_video_chat(){
  logging_debug("Exit!!");
  multiparty.close();
  // 4. delete_user();
  location.href=TOP_URL; //redirect to top.
}

// ブラウザのsessionStorageを削除する関数
function clearSessionStorage(){
  //sessionStorage
  var storage = sessionStorage;
  logging_debug('sessionStorage:');
  logging_debug(storage);
  storage.clear();
  logging_debug(storage);
}

// Exit機能
function exit(){
  logging_debug("Exit!!");
  clearSessionStorage();
  location.href=TOP_URL; //redirect to top.
}

// 映像ON／OFF機能
function onVideoChange(){
  video_check_on = document.video_change_form.video_on.checked;

  if (video_check_on == true){
    logging_debug("映像ON");
    multiparty.unmute({"video": true});
  } else {
    logging_debug("映像OFF");
    multiparty.mute({"video": true});
  }
}

// 音声ON／OFF機能
function onAudioChange(){
  audio_check_on = document.audio_change_form.audio_on.checked;

  if (audio_check_on == true){
    logging_debug("音声ON");
    multiparty.unmute({"audio": true});
  } else {
    logging_debug("音声OFF");
    multiparty.mute({"audio": true});
  }
}
