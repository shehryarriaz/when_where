var myMap = myMap || {};

myMap.initialize = function() {

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
}

google.maps.event.addDomListener(window, 'load', myMap.initialize);