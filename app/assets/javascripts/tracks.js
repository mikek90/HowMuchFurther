// changed format from coffee to js
// ------------------------------------------------------------------------------
// Place all the behaviors and hooks related to the matching controller here.
//All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
// ------------------------------------------------------------------------------

app = (typeof app === 'undefined') ? function () { } : app;

app.parseurl = function() {
    var tmp = $("#urlInput").val().match(/a=[^&]+/g)[0];
    var urlCoordinates = tmp.substring(2, tmp.length).split(",");
    
    if (urlCoordinates.length = 4) {
        $("#track_latitude_from").val(urlCoordinates[0]);
        $("#track_longtitude_from").val(urlCoordinates[1]);
        $("#track_latitude_to").val(urlCoordinates[2]);
        $("#track_longtitude_to").val(urlCoordinates[3]);
    }
}

app.generateChart = function (data) {
    app.data = data;

    app.xAxis = [];
    app.yAxis = [];
    
    app.xy = [];

    $.each(data, function(i, val) {

        var yVal = val[2];
        var xVal = 0;

        if (i != 0) {
            xVal = app.xAxis[i - 1] + getDistanceFromLatLonInKm(data[i - 1][1], data[i - 1][0], val[1], val[0]);
        }

        app.xAxis.push(xVal)
        app.yAxis.push(yVal)

        app.xy.push({x: xVal, y: yVal});
    });

    var ctx = document.getElementById("line-chart").getContext('2d');

    var scatterChart = new Chart(ctx, {
        type: 'scatter',
        data: {
            datasets: [{
                label: 'Height',
                data: app.xy
            }]
        },
        options: {
            showLines: true
        }
    });
}

function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    var R = 6371 * 1000; // Radius of the earth in m
    var dLat = deg2rad(lat2-lat1);  // deg2rad below
    var dLon = deg2rad(lon2-lon1); 
    var a = 
      Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
      Math.sin(dLon/2) * Math.sin(dLon/2)
      ; 
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    var d = R * c; // Distance in m
    return d;
  }
  
  function deg2rad(deg) {
    return deg * (Math.PI/180)
  }