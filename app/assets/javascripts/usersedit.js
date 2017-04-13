$(document).on('turbolinks:load',function() {
  $('select').material_select();
  $('.cancel').hide();
  $('#cancelaccount').on('click', function(){
    $('.cancel').toggle();
  })
});
