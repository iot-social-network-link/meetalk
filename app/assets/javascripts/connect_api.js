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
    var wid = '1' // ★暫定的
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

function addview_uinfo(uinfo, wid){
    //alert(uinfo['name']);
    var nameElem = document.createElement('div');
    nameElem.setAttribute("class", "peer-name");
    nameElem.innerHTML = "pname: " + uinfo['name'] + '<br>' + "pgender: " + uinfo['gender'];
    $(nameElem).appendTo("#peer-video-uinfo-" + wid); //★動的に
}

// ------------------------------------
// 1. Get userinfo API
// ------------------------------------
function display_uinfo(wid, roomid){
    //    var wid = '1'; //暫定★
    // APIにアクセス
    var api_url = '/api/v1/users/' + roomid + '.json';
    //var api_url = '/api/v1/users/1.json'; //暫定的に
    console.log('api connect: url=' + api_url + ',   param=' + wid );
    $.ajax({
	    type: "GET",  //★ API修正後、postにして、widパラメータにいれる
	    url: api_url, //data: [param],
            dataType: "json",
	    //通信成功時
	    success: function(resp){
		console.log('ajax json output');
		var obj = select_uinfo(wid, resp);
		console.log(obj['name']);
		addview_uinfo(obj, wid);
	    }
	});
}


// ------------------------------------
// 2. use Fullroom API
// ------------------------------------
function check_fullroom(roomid){
    // APIにアクセス
    //    var api_url = '/api/v1/room_full/' + roomid + '.json';
    var api_url = '/api/v1/room_full/1.json'; //暫定的に
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