/* -----------------------------------------------------------------
 * GoCon room タイマー管理用のライブラリ
 *  --> connect_apiにて、満室判定ならcallされる
 * ----------------------------------------------------------------- */

var left_time = gon.const.video_time; //再帰呼び出しで利用するため、グローバル変数にする

function display_timer(){
  left_time = left_time - 1;

  if(left_time < 0){ // 終了判定・処理
    console.log('ridirect to: ' + VOTE_URL);
    multiparty.close(); // multipartyインスタンスclose
    $(window).off('beforeunload');
    location.href=VOTE_URL; //redirect to vote
  } else {
    // m:残時間を60でわった値  s:残時間を60で割った余り
    var m = Math.floor(left_time / 60);
    var s = left_time % 60;
    s = (s < 0) ? 0 : s; //マイナスならないよう修正
    var s_timer = ( (m > 0) ? (m + '分' + s + '秒') : (s + '秒') );
    $("#room_timer").html('<p id="timer_counter" > 終了まで' + s_timer + '</p>');
  }
}

function count_timer(){
  setInterval("display_timer()",1000);
}
