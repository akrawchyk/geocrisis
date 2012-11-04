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
CrisisHelper.App.STORAGE_KEYS = [
  'CrisisHelperAlerts',
  'CrisisHelperPosition'
];

CrisisHelper.Location.position = null;
CrisisHelper.Location.watchProcess = null;

CrisisHelper.Location.getGeoLocation = function(callback) {
  var pos = localStorage.getItem('CrisisHelperPosition');
  if (pos) {
    CrisisHelper.Location.position = JSON.parse(pos);
    CrisisHelper.Location.watch();
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
      CrisisHelper.Location.setLocation,
      CrisisHelper.Location.error,
      CrisisHelper.Location.OPTIONS
    );
  } else {
    var $alertError = $('<div/>', {
      'class': 'alert alert-error',
      text: 'Geolocation API not supported',
      prependTo: '#landing-page'
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
  CrisisHelper.App.clearStorage();
  localStorage.setItem('CrisisHelperPosition', JSON.stringify(pos));
  CrisisHelper.Location.position = pos;
  CrisisHelper.Location.getByGeoLocation(pos.coords.latitude, pos.coords.longitude);
};

CrisisHelper.Location.watchSuccess = function(pos) {
  console.log('Started watch');
  if (pos.coords.latitude > CrisisHelper.Location.position.coords.latitude + 0.5 ||
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
  if (!CrisisHelper.Location.position) {
    var $alertError = $('<div/>', {
      'class': 'alert alert-error',
      text: error.message,
      prependTo: '#landing-page'
    });
  }

  $('#overlay').remove();
};

CrisisHelper.Location.getByGeoLocation = function(lat, lng) {
  $('#overlay').html('Location acquired!');
  window.location = '/home';

  $.ajax({
    url: '/locations',
    dataType: 'json',
    data: {latlng: lat + ',' + lng},
    success: CrisisHelper.App.buildLocation
  });
};

CrisisHelper.App.clearStorage = function() {
  $.each(CrisisHelper.App.STORAGE_KEYS, function(index, key) {
    localStorage.removeItem(key);
  });
};

// CrisisHelper.App.addAlerts = function(alerts) {
//   if (alerts[0].summary) {
//     localStorage.setItem('CrisisHelperAlerts', JSON.stringify(alerts));
//     CrisisHelper.Location.alerts = JSON.parse(alerts);
//     var $alertsElem = $('<div/>', {
//       'class': 'alert alert-error',
//       text: 'Natioal Weather Service Alert',
//       prependTo: '#home'
//     });
//
//     var $alertsIcon = $('<i/>', {
//       'class': 'icon-warning-sign',
//       prependTo: $alertsElem
//     });
//
//     $.each(alerts, function(index, alert) {
//       var $alertElem = $('<p/>', {
//         text: alert.title,
//         appendTo: $alertsElem
//       });
//     });
//   }
// };

// CrisisHelper.App.buildLocation = function() {
//   var alerts = localStorage.getItem('CrisisHelperAlerts');
//   if (alerts) {
//     CrisisHelper.Location.alerts = JSON.parse(alerts);
//     CrisisHelper.App.addAlerts(CrisisHelper.Location.alerts);
//   } else {
//     $.ajax({
//       url: '/noaa',
//       dataType: 'json',
//       data: {cc: 'ARC043'}, // TODO
//       success: CrisisHelper.App.addAlerts
//     });
//   }
// };

$(function() {
  CrisisHelper.Location.getGeoLocation(function() {
    // if (window.location.href === '/') {
    //   window.location = '/home';
    // }

    // CrisisHelper.App.buildLocation();
  });
});
