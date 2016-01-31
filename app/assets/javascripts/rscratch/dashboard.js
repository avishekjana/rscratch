// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var exceptionLineChart;

function load_dashboard_UI_components() {
  // $(document).ready(function() {
  // Initializing dashboard components

  // AJAX Request
  var request = $.ajax({
    url: "/rscratch/dashboard/index.json",
    method: "GET",
    dataType: "json",
  });
  request.done(function( data, textStatus, jqXHR ) {
    load_exception_line_chart(data);
  });
  request.fail(function( jqXHR, textStatus ) {
    alert("Sorry Something Went Wrong");
    // Materialize.toast('Sorry somethnig went wrong while crunching data, please try after sometime!', 5000);
  });
}


function load_exception_line_chart(data){
  if(exceptionLineChart) {
    exceptionLineChart.destroy();
  }  
  var date_array = [];
  var count_array = [];

  for(i=0; i<data.length; i++){
    count_array.push(data[i].exception_count);
    date_array.push(data[i].date);
  }
  var lineChartData = {
    labels : date_array,
    datasets : [
      {
        label: "Exception summary dataset",
        fillColor : "rgba(255,255,255,0)",
        strokeColor : "#ffffff",
        pointColor : "#009688",
        pointStrokeColor : "#ffffff",
        pointHighlightFill : "#ffffff",
        pointHighlightStroke : "#ffffff",
        data: count_array
      }
    ]
  }
  var newExcpLineChart = $("#exception-line-canvas").get(0).getContext("2d");
  exceptionLineChart = new Chart(newExcpLineChart).Line(lineChartData, {
        scaleShowGridLines : true,///Boolean - Whether grid lines are shown across the chart    
        scaleGridLineColor : "rgba(178, 223, 219, 0.1)",//String - Colour of the grid lines    
        scaleGridLineWidth : 1,//Number - Width of the grid lines   
        scaleShowHorizontalLines: true,//Boolean - Whether to show horizontal lines (except X axis)   
        scaleShowVerticalLines: false,//Boolean - Whether to show vertical lines (except Y axis)    
        bezierCurve : true,//Boolean - Whether the line is curved between points    
        bezierCurveTension : 0.4,//Number - Tension of the bezier curve between points    
        pointDot : true,//Boolean - Whether to show a dot for each point    
        pointDotRadius : 5,//Number - Radius of each point dot in pixels    
        pointDotStrokeWidth : 2,//Number - Pixel width of point dot stroke    
        pointHitDetectionRadius : 20,//Number - amount extra to add to the radius to cater for hit detection outside the drawn point    
        datasetStroke : true,//Boolean - Whether to show a stroke for datasets    
        datasetStrokeWidth : 3,//Number - Pixel width of dataset stroke   
        datasetFill : true,//Boolean - Whether to fill the dataset with a colour        
        animationSteps: 15,// Number - Number of animation steps    
        animationEasing: "easeOutQuart",// String - Animation easing effect     
        tooltipTitleFontFamily: "'Roboto','Helvetica Neue', 'Helvetica', 'Arial', sans-serif",// String - Tooltip title font declaration for the scale label    
        scaleFontSize: 12,// Number - Scale label font size in pixels   
        scaleFontStyle: "normal",// String - Scale label font weight style    
        scaleFontColor: "#ffffff",// String - Scale label font colour
        tooltipEvents: ["mousemove", "touchstart", "touchmove"],// Array - Array of string names to attach tooltip events   
        tooltipFillColor: "rgba(255,255,255,0.8)",// String - Tooltip background colour   
        tooltipTitleFontFamily: "'Roboto','Helvetica Neue', 'Helvetica', 'Arial', sans-serif",// String - Tooltip title font declaration for the scale label    
        tooltipFontSize: 12,// Number - Tooltip label font size in pixels
        tooltipFontColor: "#000",// String - Tooltip label font colour    
        tooltipTitleFontFamily: "'Roboto','Helvetica Neue', 'Helvetica', 'Arial', sans-serif",// String - Tooltip title font declaration for the scale label    
        tooltipTitleFontSize: 14,// Number - Tooltip title font size in pixels    
        tooltipTitleFontStyle: "bold",// String - Tooltip title font weight style   
        tooltipTitleFontColor: "#000000",// String - Tooltip title font colour   
        tooltipYPadding: 8,// Number - pixel width of padding around tooltip text   
        tooltipXPadding: 16,// Number - pixel width of padding around tooltip text    
        tooltipCaretSize: 10,// Number - Size of the caret on the tooltip   
        tooltipCornerRadius: 6,// Number - Pixel radius of the tooltip border   
        tooltipXOffset: 10,// Number - Pixel offset from point x to tooltip edge
        responsive: true    
  }); 
}

