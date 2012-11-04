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

CrisisHelper.App.buildHome = function(json) {
  $('#overlay').remove();
  $('.container').empty();
  console.log(json);
};

CrisisHelper.App.fillCountyList = function(countyList) {
  var $countyListElem = $('<div/>', {
    id: 'countyList',
    'class': 'btn-group btn-group-vertical'
  });

  $.each(countyList, function(index, county) {
    console.log(index);
    console.log(county);
    var $countyElem = $('<button/>', {
      data: {
        'county-id': county.id
      },
      onclick: 'javascript: CrisisHelper.Location.getByCounty($(this).data("county-id"))',
      text: county.name,
      appendTo: $countyListElem
    });
  });

  $('form').replaceWith($countyListElem);
};

CrisisHelper.Location.getGeoLocation = function() {
  var pos = localStorage.getItem('CrisisHelperPosition');
  if (pos) {
    CrisisHelper.Location.position = JSON.parse(pos);
    if (window.location.pathname === '/') {
      // TODO build home with ajax
      window.location = '/home';
    }
    return false;
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

CrisisHelper.Location.getByZip = function(zip) {
  $.ajax({
    url: '/locations',
    dataType: 'json',
    data: {zip: zip},
    success: CrisisHelper.App.buildLocation
  });
};

CrisisHelper.Location.getByCityState = function(city, state) {
  $.ajax({
    url: '/locations',
    dataType: 'json',
    data: {city: city, state: state},
    success: CrisisHelper.App.fillCountyList
  });
};

$(function() {
  CrisisHelper.Location.getGeoLocation();
});
