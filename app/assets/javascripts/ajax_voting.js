$(function(){

  $('.like_venue_link').on('click', function(event){
    event.preventDefault();
    event.stopPropagation();
    var link = event.currentTarget;
    var linkURL = link.href;
    var eventVenueId = linkURL.split('/')[4];
    var likesContainerId = "likes_event_venue_" + eventVenueId
    var likesContainer = $("#" + likesContainerId);
    var likesNumber = parseInt(likesContainer.text());
    
    $.ajax({
      url: linkURL + '.json',
      type: "PUT",
      success: function(data){
        console.log('success')
        console.log(data)
        likesContainer.text(likesNumber+1);
      },
      error: function(data){
        console.log('Sorry there was an error with the ajax PUT request')
      }
    })
    
    
  });

  $('.unlike_venue_link').on('click', function(event){
    event.preventDefault();
    // event.stopPropagation();
    console.log('clicked unlike')
  });


});