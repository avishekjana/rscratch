$(document).ready(function() {
  var get_exception_data, load_log_summary_bar_chart, logCountBarChart;
  $(".exception-info").hide();
  logCountBarChart = void 0;

  // Getting exception details
  $(document).on("click", ".exception-item", function() {
    var e_action, e_controller, e_date, e_id, e_message, e_new_count, e_raw, e_total_count, loader;
    $(".exception-info").show();
    $(".no-exception").hide();
    $("#mark-resolve-btn").hide();
    $("#resolved-btn").hide();    
    // Getting data attributes
    e_id = $(this).data("exception-id");
    e_message = $(this).data("exception-message");
    e_raw = $(this).data("exception-raw");
    e_date = $(this).data("exception-date");
    e_total_count = $(this).data("exception-total-count");
    e_new_count = $(this).data("exception-new-count");
    e_controller = $(this).data("exception-controller");
    e_action = $(this).data("exception-action");
    e_status = $(this).data("exception-status");
    e_ignore = $(this).data("exception-ignore");
    // Setting data
    $('.exception-message').html(e_message);
    $('.exception-raw').html(e_raw);
    $('.exception-total-count').html(e_total_count);
    $('.exception-new-count').html(e_new_count);
    $('.exception-date').html("Last occured on: " + e_date);
    $(".exception-item").removeClass("selected");
    $(".excp-item-" + e_id).addClass("selected");

    loader = JST['rscratch/templates/loader'];
    $('.progress-loader').html(loader);
    get_exception_data(e_id, 1);
  });

  // Log pagination
  $(document).on("click", ".log-navigator", function() {
    current_page = parseFloat($("#current_page_num").val());
    total_page = parseFloat($("#total_page_count").val());
    e_id = parseFloat($("#exception_entry_id").val());
    nav = $(this).data("navigate");
    page = get_page_number(nav,current_page,total_page)
    get_exception_data(e_id, page);
  });

  // Resolve issue
  $(document).on("click", "#mark-resolve-btn", function() {
    exception_id = $("#exception_entry_id").val();
    var request;
    request = $.ajax({
      type: 'POST',
      url: "/rscratch/exceptions/" + exception_id + "/resolve.json",
      dataType: "json"
    });    
    request.done(function(rData, textStatus, jqXHR) {
      $("#mark-resolve-btn").hide();
      $("#resolved-btn").show();  
    });
    request.error(function(jqXHR, textStatus, errorThrown) {
      alert("AJAX Error:" + textStatus);
    });    
  });

  // ignore toggle issue
  $(document).on("click", "#ignore-issue-box", function() {
    exception_id = $("#exception_entry_id").val();
    var request;
    request = $.ajax({
      type: 'POST',
      url: "/rscratch/exceptions/" + exception_id + "/toggle_ignore.json",
      dataType: "json"
    });    
    request.done(function(rData, textStatus, jqXHR) {
      if(rData.status == "ok"){
        Materialize.toast("Issue successfully updated", 5000)
      }
    });
    request.error(function(jqXHR, textStatus, errorThrown) {
      alert("AJAX Error:" + textStatus);
    });    
  });  


  // Getting page number
  get_page_number = function(nav,current_page,total_page){
    var page = 0;
    if(nav == "first"){ page = 1; }
    else if(nav == "last"){ page = total_page; }
    else if(nav == "next"){
      if(current_page == total_page){ page = total_page; }
      else{ page = current_page + 1; }
    } else if(nav == "previous"){
      if(current_page == 1){ page = 1; }
      else{ page = current_page - 1; }
    }
    return page
  }

  // Getting exception details
  get_exception_data = function(exception_id, page) {
    var request;
    request = $.ajax({
      type: 'GET',
      url: "/rscratch/exceptions/" + exception_id + ".json?page=" + page,
      dataType: "json"
    });
    request.done(function(rData, textStatus, jqXHR) {
      var over_data;
      if (page === 1) {
        load_log_summary_bar_chart(rData.data.log_summary);
      }
      // Checking resolve status
      if(rData.data.status == "new") { 
        $("#mark-resolve-btn").show(); 
        $("#resolved-btn").hide(); 
      }else { 
        $("#mark-resolve-btn").hide(); 
        $("#resolved-btn").show(); 
      }

      // Checking toggle status
      if(rData.data.is_ignored == false) { 
        $("#ignore-issue-box").prop('checked', false); 
      }else { 
        $("#ignore-issue-box").prop('checked', true); 
      }      
      // Setting pagination values
      $("#current_page_num").val(page);
      $("#total_page_count").val(rData.data.total_occurance_count);
      $("#exception_entry_id").val(exception_id);  
      $(".current-log").html(page);

      // Setting log data
      $(".ex-backtrace").html(rData.data.log.backtrace);
      $(".ex-params").html(rData.data.log.parameters);
      rData.response = rData.data;
      over_data = JST['rscratch/templates/exception_overview'](rData);
      $('#overview').html(over_data);
    });
    request.error(function(jqXHR, textStatus, errorThrown) {
      alert("AJAX Error:" + textStatus);
    });
  };

  // Load bar chart
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
        count_array.unshift('');
        label_array.unshift('-');
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
          fillColor: 'rgba(158, 158, 158, 0.8)',
          strokeColor: 'rgba(158, 158, 158, 1)',
          highlightFill: 'rgba(158, 158, 158, 0.3)',
          highlightStroke: 'rgba(158, 158, 158, 0.7)',
          data: count_array
        }
      ]
    };
    countBarChart = $('#log-count-canvas').get(0).getContext('2d');
    logCountBarChart = new Chart(countBarChart).Bar(dataBarChart, {
      scaleShowGridLines: false,
      showScale: false,
      animationSteps: 15,
      barValueSpacing: 1,
      responsive: false
    });
  };
});
