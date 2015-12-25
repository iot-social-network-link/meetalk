/* -----------------------------------------------------------------
 * APIリクエストなど、通信関連のライブラリ
 *  
 * ----------------------------------------------------------------- */

function selectElm_wGender(s_gender){
    if (s_gender == 'male'){
	return "#streams-male"
    }else{
	return "#streams-female"
    }
}
function select_uinfo(windowid, resp){
    for(var i=0; i<resp.length; i++){
	var tmp = resp[i];
	console.log( windowid + ' and ' + tmp.id + ' =? ' + (windowid == tmp.id) );
	if (windowid == tmp.id){ //windowidが一致した場合に、ユーザ情報を返却
	    console.log(tmp.id + ',  ' + tmp.name + ',  ' + tmp.gender);
	    var obj = {'wid': tmp.id, 'name': tmp.name, 'gender': tmp.gender};
	    console.log(obj);
	    return obj;
	}
    }
    //objなければfalse返す
    return false;
}

function addview_uinfo(uinfo){
    /*
    //name
    alert(uinfo['name']);
    var nameElem = document.createElement('div');
    nameElem.setAttribute("class", "peer-name");
    nameElem.innerHTML = "pname: " + uinfo['name'];  
    $(nameElem).appendTo("#my-video-elem"); //★動的に
    //$("#pname-" + 'windowid').appendTo(nameElem); //★動的に
    //gender
    var genElem = document.createElement('div');
    genElem.setAttribute("class", "peer-name");
    genElem.innerHTML = "pgender: " + uinfo['gender'];
    //$("#pname-" + 'windowid').appendTo(genElem); //★動的に
    */
}

function display_uinfo(wid, roomid){
    // APIにアクセス
    //    var api_url = '/api/v1/users/' + room_id + '.json';
    var api_url = '/api/v1/users/1.json'; //暫定的に
    console.log('ajax start: wid=' + wid + ',   roomid=' + roomid );
    $.ajax({
	    type: "GET",
	    url: api_url, //data: [param],
            dataType: "json",
	    //通信成功時
	    success: function(resp){
		console.log('ajax json output');
		var obj = select_uinfo(wid, resp);
		console.log(obj['name']);
		//addview_uinfo(obj);
	    }
	});
}
