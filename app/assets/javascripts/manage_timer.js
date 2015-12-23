/* -----------------------------------------------------------------
 * GoCon room タイマー管理用のライブラリ
 *  
 * ----------------------------------------------------------------- */

function change_timer(){
    //カウントダウンさせる。date型つかう？要調査
    var s_timer = 'mm分ss秒';
    return s_timer;
}

function display_timer(){
    var timerElem = document.createElement('div');
    timerElem.setAttribute("class", "room_timer");
    timerElem.innerHTML = "終了まで: " + change_timer();
    $(timerElem).appendTo("#room_timer");
}

