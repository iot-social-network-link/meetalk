var view = function (){};

//-----------------------------------
// パネルデフォルト表示
//-----------------------------------
view.animatePanel = function(){
  $('.panel-animate').animate({
    'opacity' : '1.0', 'padding-top' : '60px'
  },1000);
}

//-----------------------------------
// name入力後にボタンをenable化
//-----------------------------------
view.checkForm = function() {
  var test = $('#submit').prop('disabled', true);

  $('#user_name').on('keydown keyup keypress change', function(e){
    if ($(this).val().length >= 2 && $("input[name='user[gender]']").val()){
      $('#submit').prop('disabled', false);
    }else{
      $('#submit').prop('disabled', true);
    }
  });
  $(".radio-group").on('click', function(e){
    if ($('#user_name').val().length >= 2){
      $('#submit').prop('disabled', false);
    }else{
      $('#submit').prop('disabled', true);
    }
  });
}

//-----------------------------------
// 性別選択ボタンへの属性付与
//-----------------------------------
view.makeRadioBtn = function() {
  var _initOp = 0.5;
  var _clickOp = 1.0;
  var _diffOp = 0.1;
  var _currentOp = 0.0;
  var _enterOp = 0.0;
  var _clickFlag = "";

  $("#male").fadeTo(0, _initOp);
  $("#female").fadeTo(0, _initOp);

  $(".radio-group").on({
    'mouseenter':function(e){
      if(_clickFlag==this.id){
        _currentOp = _clickOp;
        _enterOp = _currentOp-_diffOp;
        $(this).stop().fadeTo("fast", _enterOp);
      }else{
        _currentOp = _initOp;
        _enterOp = _currentOp-_diffOp;
        $(this).stop().fadeTo("fast", _enterOp);
      }
    },
    'mouseleave':function(e){
      $(this).stop().fadeTo("fast", _enterOp+_diffOp);
    },
    'click':function(e){
      _enterOp = _clickOp;
      _clickFlag = this.id;
      if(this.id=="male"){
        $("#male").stop().fadeTo("fast", _clickOp);
        $("#female").stop().fadeTo("fast", _initOp);
        $("input[name='user[gender]']").attr({
          value: "male",
          id: "user_gender_male"
        });
      } else if(this.id=="female"){
        $("#female").stop().fadeTo("fast", _clickOp);
        $("#male").stop().fadeTo("fast", _initOp);
        $("input[name='user[gender]']").attr({
          value: "female",
          id: "user_gender_female"
        });
      }
    }
  });
}

//-----------------------------------
// 動画オプション - オーディオON/OFF
//-----------------------------------
view.onChangeAudio = function(){
  document.audio_change_form.audio_on.checked = 1;
  $("#voice-icon").on('click', function(e){
    if($("input[name='audio_change']").attr("id")=="audio_on"){
      console.log("ミュート");
      $("input[name='audio_change']").attr({id: 'audio_off'});
      document.audio_change_form.audio_on.checked = 0;
      $(this).attr("src", "assets/mute.png");
    }else if($("input[name='audio_change']").attr("id")=="audio_off"){
      console.log("録音中…");
      $("input[name='audio_change']").attr({id: 'audio_on'});
      document.audio_change_form.audio_on.checked = 1;
      $(this).attr("src", "assets/voice.png");
    }
  onAudioChange();
  });
}

//-----------------------------------
// 動画オプション - ビデオON/OFF
//-----------------------------------
view.onChangeVideo = function(){
  document.video_change_form.video_on.checked = 1;
  $("#camera-icon").on('click', function(e){
    if($("input[name='video_change']").attr("id")=="video_on"){
      console.log("カメラoff");
      $("input[name='video_change']").attr({id:'video_off'});
      document.video_change_form.video_on.checked = 0;
      $(this).attr("src", "assets/cam_off.png");
    }else if($("input[name='video_change']").attr("id")=="video_off"){
      console.log("カメラon");
      $("input[name='video_change']").attr({id:'video_on'});
      document.video_change_form.video_on.checked = 1;
      $(this).attr("src", "assets/cam.png");
    }
  onVideoChange();
  });
}
