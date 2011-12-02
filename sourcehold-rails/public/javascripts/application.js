// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.validator.setDefaults({
  submitHandler: function() {  }
});

$(document).ready(function() {
  $('.del_email').bind('ajax:success', function(){
    $(this).closest('<li>').css('background-color', 'red');
  });

  $("#user_username").blur(function() {
    if($("#user_username").val != ''){
      $.ajax({
        type: 'POST',
        url: '/ajax/username',
        data: {'name':$("#user_username").val()},
        success: function (data) { 
          if(data == true){
            $("#user_username").addClass("ajax-does-exist");
          }
          else if( data == false){
            $("#user_username").addClass("ajax-does-not-exist");
          }
        },
        error: function (data) {  },
        dataType: 'json'
      });
    }
  });

  $("#user_email").blur(function() {
    if($("#user_email").val != ''){
      $.ajax({
        type: 'POST',
        url: '/ajax/emailaddress',
        data: {'email':$("#user_email").val()},
        success: function (data) { 
          if(data == true){
            $("#user_email").addClass("ajax-does-exist");
          }
          else if( data == false){
            $("#user_email").addClass("ajax-does-not-exist");
          }
        },
        error: function (data) {  },
        dataType: 'json'
      });
    }
  });

  $("#add_new_email").blur(function() {
    if($("#add_new_email").val != ''){
      $.ajax({
        type: 'POST',
        url: '/ajax/emailaddress',
        data: {'email':$("#add_new_email").val()},
        success: function (data) { 
          if(data == true){
            $("#add_new_email").addClass("ajax-does-exist");
          }
          else if( data == false){
            $("#add_new_email").addClass("ajax-does-not-exist");
          }
        },
        error: function (data) {  },
        dataType: 'json'
      });
    }

  });

  $("#repo_name").blur(function() {
    if($("#repo_name").val != ''){
      $.ajax({
        type: 'POST',
        url: '/ajax/repoexist',
        data: {'repo':$("#repo_name").val()},
        success: function (data) { 
          if(data == true){
            $("#repo_name").addClass("ajax-does-exist");
          }
          else if( data == false){
            $("#repo_name").addClass("ajax-does-not-exist");
          }
        },
        error: function (data) {  },
        dataType: 'json'
      });
    }
  });

  $('.add-key-button').click(function(){
    $('.add-ssh-key-form').slideToggle('fast', function(){
    }); 
  });
  
  $('.close-information-div').click(function(){
    $('.information').hide('slow');
  });
  
  positionFooter();

  $(window)
    .scroll(positionFooter)
    .resize(positionFooter);

  function positionFooter() {
    var docHeight = $(document.body).height() - $("#sticky-footer-push").height();
    if(docHeight < $(window).height()){
      var diff = $(window).height() - docHeight;
      if (!$("#sticky-footer-push").length > 0) {
        $("#footer").before('<div id="sticky-footer-push"></div>');
      }
      $("#sticky-footer-push").height(diff);
    }
  }

  $('#branch-list').hover(function(){
    $('.inactive-branch').toggle();
  },
  function(){
    $('.inactive-branch').toggle();
  });

});

function show_key(name){
  $('.'+name).slideToggle('fast');
}
