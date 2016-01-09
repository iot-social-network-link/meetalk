/* -----------------------------------------------------------------
 * 共通関数を定義
 *
 * ----------------------------------------------------------------- */

//jsで利用する定数
const TOP_URL   = 'https://' + location.host + '/';
const VOTE_URL  = TOP_URL + 'vote/';
const DEBUG_FLG = true; // true で、ログ表示

//debug flgに応じてlogging
function logging_debug(obj){
  if (DEBUG_FLG) { //debug=ONなら、ログ表示
    console.log(obj);
  }
}

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
