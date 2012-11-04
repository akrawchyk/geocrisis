var CrisisHelper = CrisisHelper || {};

CrisisHelper.Location = CrisisHelper.Location || {};
CrisisHelper.App = CrisisHelper.App || {};

CrisisHelper.Location.TIMEOUT = 1000 * 60;  // 1 minute
CrisisHelper.Location.MAXIMUM_AGE = 0;      // always request new location
CrisisHelper.Location.OPTIONS = {
  enableHighAccuracy: true,
  timeout: CrisisHelper.Location.TIMEOUT,
  maximumAge: CrisisHelper.Location.MAXIMUM_AGE
};

CrisisHelper.Location.position = null;

CrisisHelper.Location.getGeoLocation = function(callback) {
  var pos = localStorage.getItem('CrisisHelperPosition');
  if (pos) {
    CrisisHelper.Location.position = JSON.parse(pos);
    callback();
  } else if (navigator.geolocation) {
    // append overlay
    var $overlay = $('<div/>', {
      id: 'overlay',
      text: 'Aquiring location...',
      appendTo: 'body'
    });

    // request location
    navigator.geolocation.getCurrentPosition(
      CrisisHelper.Location.success,
      CrisisHelper.Location.error,
      CrisisHelper.Location.OPTIONS
    );
  } else {
    alert('Geolocation API not supported');
  }
};

CrisisHelper.Location.success = function(pos) {
  console.log(pos);
  localStorage.setItem('CrisisHelperPosition', JSON.stringify(pos));
  CrisisHelper.Location.position = pos;
  CrisisHelper.Location.getByGeoLocation(pos.coords.latitude, pos.coords.longitude);
};

CrisisHelper.Location.error = function(error) {
  var $alertError = $('<div/>', {
    'class': 'alert alert-error',
    text: error.message,
    prependTo: '#landing-page'
  });

  $('#overlay').remove();
};

CrisisHelper.Location.getByGeoLocation = function(lat, lng) {
  $('#overlay').html('Location acquired!');

  $.ajax({
    url: '/locations',
    dataType: 'json',
    data: {latlng: lat + ',' + lng},
    success: CrisisHelper.App.buildLocation
  });
};

// CrisisHelper.Location.getByZip = function(zip) {
//   $.ajax({
//     url: '/locations',
//     dataType: 'json',
//     data: {zipcode: zip},
//     success: CrisisHelper.App.buildLocation
//   });
// };

// CrisisHelper.Location.getByCityState = function(city, state) {
//   $.ajax({
//     url: '/locations',
//     dataType: 'json',
//     data: {city: city, state: state},
//     success: CrisisHelper.App.fillCountyList
//   });
// };

CrisisHelper.App.addAlerts = function(alerts) {
  localStorage.setItem('CrisisHelperAlerts', JSON.stringify(alerts));

  var $alertsElem = $('<div/>', {
    'class': 'alert alert-error',
    text: 'Natioal Weather Service Alert',
    prependTo: '#home'
  });

  var $alertsIcon = $('<i/>', {
    'class': 'icon-warning-sign',
    prependTo: $alertsElem
  });

  $.each(alerts, function(index, alert) {
    var $alertElem = $('<p/>', {
      text: alert.title,
      appendTo: $alertsElem
    });
  });
};

CrisisHelper.App.buildLocation = function() {
  var alerts = localStorage.getItem('CrisisHelperAlerts');
  if (alerts) {
    CrisisHelper.Location.alerts = JSON.parse(alerts);
    CrisisHelper.App.addAlerts(CrisisHelper.Location.alerts);
  } else {
    $.ajax({
      url: '/noaa',
      dataType: 'json',
      data: {cc: 'NJC001'}, // TODO
      success: CrisisHelper.App.addAlerts
    });
  }

};

$(function() {
  CrisisHelper.Location.getGeoLocation(function() {
    if (window.location.href === '/') {
      window.location = '/home';
    }

    CrisisHelper.App.buildLocation();
  });
});
