var eventVenueMap = eventVenueMap || {};

eventVenueMap.initialize = function() {
  var mapCanvas = $('#map-canvas')[0];
  var eventVenuePath = $(location).attr('pathname');

  if (!!mapCanvas){

    drawMap();

    // AJAX FOR COORDINATES

    function drawMap() {
      $.ajax({
        url: eventVenuePath,
        type: 'GET',
        dataType: 'JSON',
        success: function(data) {
          var venueId = parseInt(data.venue_id);
          $.ajax({
            url: '/venues/' + venueId,
            type: 'GET',
            dataType: 'JSON',
            success: function(data) {
              setupMap(data);
            }
          });
        }
      });
    }

    function setupMap(data) {
      var latitude = data.latitude
      var longitude = data.longitude
      var name = data.name;
      var address = data.address;

      // USER LOCATION AND DISTANCE
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
      } else {
        alert('Your browser does not support geolocation.');
      }

      function successCallback(position) {
        var origin = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        var destination = new google.maps.LatLng(latitude, longitude);

        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix(
        {
          origins: [origin],
          destinations: [destination],
          travelMode: google.maps.TravelMode.DRIVING,
          avoidHighways: false,
          avoidTolls: false
        }, callback);

        function callback(response, status) {
          if (status != google.maps.DistanceMatrixStatus.OK) {
            alert('Error was: ' + status);
          } else {
            $('.distance').append(" | " + response.rows[0].elements[0].distance.text + " from your current location");
          }
        }
      }

      function errorCallback(error) {
        console.log(error);
      }

      // MAP
      var mapOptions = {
        center: { lat: latitude, lng: longitude},
        zoom: 15,
        mapTypeId:google.maps.MapTypeId.ROADMAP
      };
      var map = new google.maps.Map(mapCanvas, mapOptions);

      // MARKER
      var markerOptions = {
        position: new google.maps.LatLng(latitude, longitude),
        map: map,
        name: name,
        address: address
      }
      var marker = new google.maps.Marker(markerOptions);
      marker.setMap(map);

      // INFO WINDOW
      var infoWindowOptions = {
        content: '<strong>' + name + '</strong><br><medium>' + address + '</medium>',
        position: new google.maps.LatLng(latitude, longitude)
      }
      var popup = new google.maps.InfoWindow(infoWindowOptions);

      google.maps.event.addListener(marker, 'click', function() {
        popup.open(map, marker);
      });
    }
  }
  if ($('#autocomplete').length) { 
  var autocomplete = new google.maps.places.Autocomplete($('#autocomplete')[0]);
  }
}

google.maps.event.addDomListener(window, 'load', eventVenueMap.initialize);