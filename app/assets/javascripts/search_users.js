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
  $("#search_users").append('<label for="friend_ids_'+object.id+'">' + object.value + '</label>');
  $("#search_users").append('<input id="friend_ids_' + object.id + '" name="friend_ids[]" type="checkbox" value="'+object.id+'" checked="checked"><br>');
}