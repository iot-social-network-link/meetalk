/* -----------------------------------------------------------------
 * APIリクエストなど、通信関連のライブラリ
 *  
 * ----------------------------------------------------------------- */
//追加するDOMを、性別によって切り替える
function selectElm_wGender(s_gender){
    if (s_gender == 'male'){
	return "#streams-male"
    }else{
	return "#streams-female"
    }
}
//API取得したuinfoのうち、追加されたpeer(wid)の情報を選択
function select_uinfo(wid, resp){
    for(var i=0; i<resp.length; i++){
	var tmp = resp[i];
	//console.log( wid + ' and ' + tmp.id + ' =? ' + (wid == tmp.id) );
	if (wid == tmp.id){ //windowidが一致した場合に、ユーザ情報を返却
	    var obj = {'wid': tmp.id, 'name': tmp.name, 'gender': tmp.gender};
	    console.log('get obj from 1. Get userinfo API');
	    console.log(obj);
	    return obj;
	}
    }
    //objなければfalse返す
    return false;
}

function addview_uinfo(video, uinfo, wid){

    // ユーザ枠を追加: <div id = "peer-video-uinfo-[windowid]">
    var pVideoElem = document.createElement('div');
    pVideoElem.setAttribute("id", 'peer-video-uinfo-'+ video['id']);
    console.log('peer video obj:');
    console.log(video);
    ( $('#peer-video-uinfo-'+ video['id'])[0] )? console.log('exist_peer') : $(pVideoElem).appendTo(selectElm_wGender(uinfo['gender']));

    // peerのvideoを表示
    var vNode = MultiParty.util.createVideoNode(video);
    vNode.setAttribute("class", "video peer-video");
    $(vNode).appendTo(pVideoElem); 

    //ユーザ情報の表示
    var nameElem = document.createElement('div');
    nameElem.setAttribute("class", "peer-name");
    nameElem.setAttribute("id", "peer-name-" + wid);
    nameElem.innerHTML = ('pname: ' + uinfo['name'] + '<br> pgender: ' + uinfo['gender']);
    ( $("#peer-name-" + wid)[0] )? console.log('exist_peer') : $(nameElem).appendTo("#peer-video-uinfo-" + wid);
   
   //    $("#peer-name-" + wid).html("pname: " + uinfo['name'] + '<br>' + "pgender: " + uinfo['gender']);
}

// ------------------------------------
// 1. Get userinfo API
// ------------------------------------
function display_uinfo(video, roomid){
    var api_url = '/api/v1/window_id/' + video['id'] + '.json?room_id=' + roomid;
    //'/api/v1/users/' + roomid + '.json';
    console.log('api connect: url=' + api_url);
    $.ajax({
	    type: "GET",
	    url: api_url,
            dataType: "json",
	    //通信成功時
	    success: function(resp){
		//var obj = select_uinfo(wid, resp);
		//console.log(obj['name']);
		//addview_uinfo(obj, wid);
		console.log('api response: url=' + api_url);
		console.log(resp);
		addview_uinfo(video, resp, video['id']);
	    }
	});
}


// ------------------------------------
// 2. Fullroom API
// ------------------------------------
function check_fullroom(roomid){
    // APIにアクセス
    var api_url = '/api/v1/room_full/' + roomid + '.json';
    //var api_url = '/api/v1/room_full/1.json'; //暫定的に
    console.log('api connect: url=' + api_url);
    $.ajax({
	    type: "GET",
	    url: api_url, //data: [param],
            dataType: "json",
	    //通信成功時
	    success: function(resp){
		console.log('result: ' + resp.result + '  from:' + api_url);
		if (resp.result) { display_timer(); }
		//var obj = ;
	    }
	});
}

// ------------------------------------
// 3. resist windowid for userDB
// ------------------------------------
function regist_windowid(userid, wid){
    // APIにアクセス
    var api_url = '/api/v1/user/' + userid + '.json';
    console.log('api connect: url=' + api_url + 'with wid: ' + wid);
    $.ajax({
	    type: "PUT",
	    url: api_url, 
	    data: "window_id=" + wid,
            dataType: "json",
	    //通信成功時
	    success: function(resp){
		console.log('result: ' + resp.result + '  from:' + api_url);
	    }
	});
}