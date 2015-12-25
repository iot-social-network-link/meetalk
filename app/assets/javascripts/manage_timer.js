/* -----------------------------------------------------------------
 * GoCon room タイマー管理用のライブラリ
 *
 * ----------------------------------------------------------------- */

var start_time;

function repeat_timer(){
  var endDateTime = new Date();
  var a_day = 24 * 60 * 60 * 1000;

  // 終了時間の10分までの時間を計算
  var left = (10 * 60 * 1000) - (endDateTime　- start_time);

  if(left < 0){
    return;
  }

  // 残時間を秒で割って残分数を出す。
  // 残分数を60で割ることで、残時間の「時」の余りとして、『残時間の分の部分』を出す
  var m = Math.floor((left % a_day) / (60 * 1000)) % 60

  // 残時間をミリ秒で割って、残秒数を出す。
  // 残秒数を60で割った余りとして、「秒」の余りとしての残「ミリ秒」を出す。
  // 更にそれを60で割った余りとして、「分」で割った余りとしての『残時間の秒の部分』を出す
  var s = Math.floor((left % a_day) / 1000) % 60 % 60

  var s_timer = m + '分' + s + '秒';

  $("#room_timer").html("終了まで" + s_timer);
  setTimeout('repeat_timer()',1000);
}

function display_timer(){
  start_time　= new Date();
  repeat_timer();
    // console.log("change!");
}
