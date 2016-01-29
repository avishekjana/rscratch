// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
  $(".exception-summary").hide();
  $(document).on("click", ".exception-item", function() {
    var e_date, e_id, e_message, e_new_count, e_total_count, loader;
    $(".exception-summary").show();
    e_id = $(this).data("exception-id");
    e_message = $(this).data("exception-message");
    e_date = $(this).data("exception-date");
    e_total_count = $(this).data("exception-total-count");
    e_new_count = $(this).data("exception-new-count");
    $(".exception-item").removeClass("selected");
    $(".excp-item-" + e_id).addClass("selected");
    loader = JST['rscratch/templates/loader'];
    $('.progress-loader').html(loader);
    $('.exception-message').html(e_message);
    $('.exception-total-count').html(e_total_count);
    $('.exception-new-count').html(e_new_count);
    $('.exception-date').html("Last occured on " + e_date);
  });
});