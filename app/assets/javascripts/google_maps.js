var myMap = myMap || {};

myMap.initialize = function() {
  var mapCanvas = $('#map-canvas')[0];
  var eventVenuePath = $(location).attr('pathname');
  console.log(eventVenuePath);

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
          console.log(venueId);
          $.ajax({
            url: '/venues/' + venueId,
            type: 'GET',
            dataType: 'JSON',
            success: function(data) {
              console.log(data);
              setupMap(data);
            }
          });
        }
      });
    }

    function setupMap(data) {
      var latitude = data.latitude
      var longitude = data.longitude

      console.log(latitude, longitude);

      // MAP
      var mapOptions = {
        center: { lat: latitude, lng: longitude},
        zoom: 14,
        mapTypeId:google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map( mapCanvas, mapOptions);

      // MARKER
      var markerOptions = {
        position: new google.maps.LatLng( latitude, longitude)
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
}

google.maps.event.addDomListener(window, 'load', myMap.initialize);