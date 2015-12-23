/* -----------------------------------------------------------------
 * Skyway multyparty 利用したライブラリ
 *  
 * ----------------------------------------------------------------- */

function manage_mediasteam(s_roomid, s_nickname) {
    multiparty.on('my_ms', function(video) {
	    // 自分のvideoを表示
	    var vNode = MultiParty.util.createVideoNode(video);
	    vNode.setAttribute("class", "video my-video");
	    vNode.volume = 0;
	    $(vNode).appendTo("#streams");
	    display_timer(); // 暫定的にここで呼ぶ。本来は■でcall
	}).on('peer_ms', function(video) {
	    console.log("video received!!")
	    //ユーザ情報取得APIをリクエスト
	    //４人に見たしているか判定
	    //display_timer(); // ■本来はここでcall

	    // peerのvideoを表示
	    var vNode = MultiParty.util.createVideoNode(video);
	    vNode.setAttribute("class", "video peer-video");
	    $(vNode).appendTo("#streams");
	    console.log($("#streams"))
	}).on('ms_close', function(peer_id) {
	    // peerが切れたら、対象のvideoノードを削除する
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
function video_chat_start(s_roomid, s_nickname) {
    multiparty = new MultiParty( {
	    "key": "44ed614d-25eb-4a1f-b7a8-a47acd9f7595",
	    "reliable": true,
	    "room_id": s_roomid,
	    "debug": 3
	});
    manage_message();
    // サーバとpeerに接続
    multiparty.start();
    manage_mediasteam(s_roomid, s_nickname);
}
function exit_video_chat(){
    console.log("Exit!!");
    multiparty.close();
    var top_url = "http://" + location.host;
    console.log(top_url);
    location.href=top_url; //redirect to top.
}

