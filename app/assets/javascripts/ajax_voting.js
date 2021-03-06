$(function(){

  $('div[id^=vote_link_event_venue_]').on('click', 'a.like_venue_link', function(event){
    event.preventDefault();
    event.stopPropagation();
    var link = event.currentTarget;
    var linkURL = link.href;
    var eventVenueId = linkURL.split('/')[4];
    var likesContainerId = "likes_event_venue_" + eventVenueId
    var likesContainer = $("#" + likesContainerId);
    var likesNumber = parseInt(likesContainer.text());
    var $this = $(this);
    var linkParent = $this.parent();
    console.log(linkParent.html())
    
    $.ajax({
      url: linkURL + '.json',
      type: "PUT",
      success: function(data){
        console.log('success like')
        console.log(data)
        likesContainer.text(likesNumber+1);
        linkParent.html('<a href="/event_venues/' + eventVenueId + '/vote/unlike" class="unlike_venue_link" data-method="put" rel="nofollow">Unlike</a>');
      },
      error: function(data){
        console.log('Sorry there was an error with the ajax PUT request')
      }
    });
    
    
  });

  $('div[id^=vote_link_event_venue_]').on('click', 'a.unlike_venue_link',function(event){
    event.preventDefault();
    event.stopPropagation();
    console.log('clicked unlike')
    var link = event.currentTarget;
    var linkURL = link.href;
    var eventVenueId = linkURL.split('/')[4];
    var likesContainerId = "likes_event_venue_" + eventVenueId
    var likesContainer = $("#" + likesContainerId);
    var likesNumber = parseInt(likesContainer.text());
    var $this = $(this);
    var linkParent = $this.parent();
    console.log(linkParent.html())

    $.ajax({
      url: linkURL + '.json',
      type: "PUT",
      success: function(data){
        console.log('success unlike')
        console.log(data)
        likesContainer.text(likesNumber-1);
        linkParent.html('<a href="/event_venues/' + eventVenueId + '/vote/like" class="like_venue_link" data-method="put" rel="nofollow">Like</a>');
      },
      error: function(data){
        console.log('Sorry there was an error with the ajax PUT request')
      }
    });
  });


});