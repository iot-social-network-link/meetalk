/* -----------------------------------------------------------------
 * 共通関数を定義
 *
 * ----------------------------------------------------------------- */

//jsで利用する定数
const VIDEO_TIME = 60 * 10; //10m (60 * 10
const TOP_URL = 'http://' + location.host + '/';
const VOTE_URL = TOP_URL + 'vote/';


//htmlエンコード
function escapeHtml(content) {
    var TABLE_FOR_ESCAPE_HTML = {
	"&": "&amp;",
	"\"": "&quot;",
	"<": "&lt;",
	">": "&gt;"
    };
    return content.replace(/[&"<>]/g, function(match) {
    return TABLE_FOR_ESCAPE_HTML[match];
  });
}


//RFC3986 に従ったURLエンコード処理 
//ref)https://code4sec.com/yukisov/item/2ITFUFjeaGNb4aUGloMk#h2-4
function encodeURI(str) {
    return encodeURIComponent(str).replace(/[!'()*]/g, function(c) {
    return '%' + c.charCodeAt(0).toString(16);
  });
}

