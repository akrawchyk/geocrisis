var CrisisHelper = CrisisHelper || {};

CrisisHelper.Location = CrisisHelper.Location || {};

CrisisHelper.Location.TIMEOUT = 1000 * 60;  // 1 minute
CrisisHelper.Location.MAXIMUM_AGE = 0;      // always request new location
CrisisHelper.Location.OPTIONS = {
  enableHighAccuracy:true,
  timeout:CrisisHelper.Location.TIMEOUT,
  maximumAge:CrisisHelper.Location.MAXIMUM_AGE
};

CrisisHelper.Location.position = null;
CrisisHelper.Location.watchProcess = null;

CrisisHelper.Location.getGeoLocation = function(callback) {
  if(!session_data && navigator.geolocation) {
    console.log('line 18');
    // append overlay
    var $overlay = $('<div/>', {
      id:'overlay',
      text:'Aquiring location...',
      appendTo:'body'
    });

    // request location
    navigator.geolocation.getCurrentPosition(
      CrisisHelper.Location.setLocation,
      CrisisHelper.Location.error,
      CrisisHelper.Location.OPTIONS
    );
  } else if(session_data) {
    console.log('line 33');
    window.location = '/home';
  } else {
    console.log('line 36');
    var $alertError = $('<div/>', {
      'class':'alert alert-error',
      text:'Geolocation API not supported',
      prependTo:'#landing-page'
    });
  }
};

CrisisHelper.Location.watch = function() {
  CrisisHelper.Location.watchProcess = navigator.geolocation.getCurrentPosition(
    CrisisHelper.Location.watchSuccess,
    CrisisHelper.Location.error,
    CrisisHelper.Location.OPTIONS
  );
};

CrisisHelper.Location.setLocation = function(pos) {
  CrisisHelper.Location.position = pos;
  CrisisHelper.Location.locationRedirect(pos.coords.latitude, pos.coords.longitude);
};

CrisisHelper.Location.watchSuccess = function(pos) {
  console.log('Started watch');
  if(pos.coords.latitude > CrisisHelper.Location.position.coords.latitude + 0.5 ||
    pos.coords.latitude < CrisisHelper.Location.position.coords.latitude - 0.5 ||
    pos.coords.longitude > CrisisHelper.Location.position.coords.longitude + 0.5 ||
    pos.coords.longitude < CrisisHelper.Location.position.coords.longitude - 0.5) {
    console.log('new position');
    console.log(pos);
    CrisisHelper.Location.setLocation(pos);
  }
};

CrisisHelper.Location.error = function(error) {
  console.log(error);
  if(!CrisisHelper.Location.position) {
    var $alertError = $('<div/>', {
      'class':'alert alert-error',
      text:error.message,
      prependTo:'#landing-page'
    });
  }

  $('#overlay').remove();
};

CrisisHelper.Location.locationRedirect = function(lat, lng) {
  $('#overlay').html('Location acquired!');
  window.location = '/locations?latlng=' + lat + ',' + lng;
};

$(function() {
  CrisisHelper.Location.getGeoLocation(function(pos) {
  });
});