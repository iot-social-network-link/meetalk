var view = function (){};

//-----------------------------------
// パネルデフォルト表示
//-----------------------------------
view.animatePanel = function(){
  $('.panel-animate').animate({
    'opacity' : '1.0', 'padding-top' : '100px'
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
  $(".radio-group").click(function(){
    if(this.id=="male"){
      $("#male").attr("src", "assets/male_selected.png");
      $("#female").attr("src", "assets/female.png");
      $("input[name='user[gender]']").attr({
        value: "male",
        id: "user_gender_male"
      });
    } else if(this.id=="female"){
      $("#male").attr("src", "assets/male.png");
      $("#female").attr("src", "assets/female_selected.png");
      $("input[name='user[gender]']").attr({
        value: "female",
        id: "user_gender_female"
      });
    }

  });
}

//-----------------------------------
// 動画オプション
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
