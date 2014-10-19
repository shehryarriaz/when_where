var myMap = myMap || {};

myMap.initialize = function() {
  var mapCanvas = $('#map-canvas')[0];
  var eventVenuePath = $(location).attr('pathname');

  if (mapCanvas){
    // AJAX FOR COORDINATES

    successCallback();

    function successCallback() {
      $.ajax({
        url: eventVenuePath,
        type: 'GET',
        dataType: 'JSON',
        success: function(data) {
          var venueId = data.venue_id;
          $.ajax({
            url: '/venues/' + venueId,
            type: 'GET',
            dataType: 'JSON',
            success: function(data) {
              var venueId = data.venue_id
              console.log(venueId)
            }
          });
        }
      });
    }

    // MAP
    var mapOptions = {
      center: { lat:  51.52, lng: -0.115},     
      zoom: 14,
      mapTypeId:google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    // MARKER
    var markerOptions = {
      position: new google.maps.LatLng(51.53, -0.109446)
    }
    var marker = new google.maps.Marker(markerOptions);
    marker.setMap(map);

    // INFO WINDOW
    var infoWindowOptions = {
      content: 'We Are Here!',
      position: new google.maps.LatLng(51.535, -0.10945)
    }
    var popup = new google.maps.InfoWindow(infoWindowOptions);
  }
}

google.maps.event.addDomListener(window, 'load', myMap.initialize);