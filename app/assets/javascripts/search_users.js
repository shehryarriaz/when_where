$( document ).ready(function(ev) {
  $.ajax({
    url: '/users',
    type: 'GET',
    dataType: 'JSON',
    data: { q: $('#user_search').val() },
    success: function(data) {
      var users = [];
      for (var i = 0; i < data.length; i++) {
        users.push({value: data[i].name, id: data[i].id});
      }
      $( "#user_search" ).autocomplete({
        source: users, 
        select: function(a,b) {
          a.preventDefault();
        displayEmails(b.item);
        }
      });
    }
  });
});

function displayEmails(object) {
  $("#search_users").append('<input id="invitation_ids_' + object.id + '" name="event_suggestion[invitee_ids][]" style="display:none" type="checkbox" value="' + object.id + '" checked="checked">');
  $("#search_users").append('<label class="btn btn-default btn-lg" for="invitation_ids_' + object.id +'"><span class="glyphicon glyphicon-user"></span> ' + object.value + '</label>');
}