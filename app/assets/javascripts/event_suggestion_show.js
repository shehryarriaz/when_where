$(function(){

  $('#add_venue').on('click', function(){
    $('form#new_event_venue').slideToggle(200, function(){});
  });

  $('#invited_heading').on('click', function(){
    $('#invitee_list').slideToggle(200, function(){});
  });

  
  $("form").keypress(function(e) {
    //Enter key
    if (e.which == 13) {
      return false;
    }
  });
  

});