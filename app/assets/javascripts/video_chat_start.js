function video_chat_start(s_room_id, a_nickname) {
    var multiparty;

    //debug
    alert('roomid:  '+ s_room_id);
    alert('nickname1:  '+ a_nickname[1] );

    // MultiParty インスタンスを生成
    multiparty = new MultiParty( {
	    "key": "44ed614d-25eb-4a1f-b7a8-a47acd9f7595",
	    "reliable": true,
	    "debug": 3
	    //"room_id": room_id
	});
    /////////////////////////////////
    // for MediaStream
    multiparty.on('my_ms', function(video) {
	    // 自分のvideoを表示
	    var vNode = MultiParty.util.createVideoNode(video);
	    vNode.setAttribute("class", "video my-video");
	    vNode.volume = 0;
	    $(vNode).appendTo("#streams");
	}).on('peer_ms', function(video) {
		console.log("video received!!")
		    // peerのvideoを表示
		    console.log(video);
		var vNode = MultiParty.util.createVideoNode(video);
		vNode.setAttribute("class", "video peer-video");
		$(vNode).appendTo("#streams");
		console.log($("#streams"))
		    }).on('ms_close', function(peer_id) {
			    // peerが切れたら、対象のvideoノードを削除する
			    $("#"+peer_id).remove();
			})
	////////////////////////////////
	// for DataChannel
	multiparty.on('message', function(mesg) {
		// peerからテキストメッセージを受信
		$("p.receive").append(mesg.data + "<br>");
	    });
    ////////////////////////////////
    // Error handling
    multiparty.on('error', function(err) {
	    alert(err);
	});
    multiparty.start();
    //////////////////////////////////////////////////////////
    // テキストフォームに入力されたテキストをpeerに送信
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
