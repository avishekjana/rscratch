$(document).ready(function() {
  var get_exception_data, load_log_summary_bar_chart, logCountBarChart;
  $(".exception-summary").hide();
  logCountBarChart = void 0;
  $(document).on("click", ".exception-item", function() {
    var e_action, e_controller, e_date, e_id, e_message, e_new_count, e_raw, e_total_count, loader;
    $(".exception-summary").show();
    e_id = $(this).data("exception-id");
    e_message = $(this).data("exception-message");
    e_raw = $(this).data("exception-raw");
    e_date = $(this).data("exception-date");
    e_total_count = $(this).data("exception-total-count");
    e_new_count = $(this).data("exception-new-count");
    e_controller = $(this).data("exception-controller");
    e_action = $(this).data("exception-action");
    $('.exception-message').html(e_message);
    $('.exception-raw').html(e_raw);
    $('.exception-total-count').html(e_total_count);
    $('.exception-new-count').html(e_new_count);
    $('.exception-date').html("Last occured on: " + e_date);
    $('.ex-controller').html("Controller & Action: " + e_controller + "#" + e_action);
    $(".exception-item").removeClass("selected");
    $(".excp-item-" + e_id).addClass("selected");
    loader = JST['rscratch/templates/loader'];
    $('.progress-loader').html(loader);
    get_exception_data(e_id, 1);
  });

  get_exception_data = function(exception_id, page) {
    var request;
    request = $.ajax({
      type: 'GET',
      url: "/rscratch/exceptions/" + exception_id + ".json?page=" + page,
      dataType: "json"
    });
    request.done(function(responseData, textStatus, jqXHR) {
      if (page === 1) {
        load_log_summary_bar_chart(responseData.data.log_summary);
      }
    });
    request.error(function(jqXHR, textStatus, errorThrown) {
      alert("AJAX Error:" + textStatus);
    });
  };

  load_log_summary_bar_chart = function(data) {
    var countBarChart, count_array, dataBarChart, empty, i, j, label_array;
    count_array = [];
    label_array = [];
    i = 0;
    while (i < data.length) {
      count_array.push(data[i].exception_count);
      label_array.push(data[i].date);
      i++;
    }
    if (label_array.length < 30) {
      empty = 30 - label_array.length;
      j = 0;
      while (j < empty) {
        label_array.push(' ');
        j++;
      }
    }
    if (logCountBarChart) {
      logCountBarChart.destroy();
    }
    dataBarChart = {
      labels: label_array,
      datasets: [
        {
          label: 'Exception count, group by date',
          fillColor: 'rgba(250, 250, 250, 0.5)',
          strokeColor: 'rgba(255, 255, 255, 0.8)',
          highlightFill: 'rgba(255, 255, 255, 0.7)',
          highlightStroke: 'rgba(255, 255, 255, 0.7)',
          data: count_array
        }
      ]
    };
    countBarChart = $('#log-count-canvas').get(0).getContext('2d');
    logCountBarChart = new Chart(countBarChart).Bar(dataBarChart, {
      scaleShowGridLines: false,
      showScale: false,
      animationSteps: 15,
      barValueSpacing: 5,
      responsive: true
    });
  };
});