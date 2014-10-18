var myMap = myMap || {};

myMap.initialize = function() {
  console.log('Map working')
  
  var mapOptions = {
      center: { lat:  51.52, lng: -0.115},     
      zoom: 14,
      mapTypeId:google.maps.MapTypeId.ROADMAP
  };

    var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
}

google.maps.event.addDomListener(window, 'load', myMap.initialize);