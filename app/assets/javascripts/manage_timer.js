/* -----------------------------------------------------------------
 * GoCon room タイマー管理用のライブラリ
 *
 * ----------------------------------------------------------------- */

var left_time;

function repeat_timer(){

  // カウントダウンを実行
  left_time = left_time - 1;

  if(left_time < 0){
    return;
  }

  // 残時間を60でわった値が残分数
  var m = Math.floor(left_time / 60);

  // 残時間を60で割ったあまりが残秒数
  var s = left_time % 60;

  if(m > 0){
    var s_timer = m + '分' + s + '秒';
  }　else {
    var s_timer = s + '秒';
  }

  $("#room_timer").html("　終了まで" + s_timer);
  setTimeout('repeat_timer()',1000);
}

function display_timer(){
  left_time　= 60 * 10;
  repeat_timer();
}
