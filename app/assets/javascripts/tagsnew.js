$(document).on('turbolinks:load',function() {
  getTagForm();
});

var getTagForm = function(){
  $('.addTag').on('click', function(e){
    e.preventDefault();
    var $link = $(this)
    var route = $link.attr('href')
    console.log(route)

    $.ajax({
      url: route,
      method: "get"
    })
    .done(function(tagForm){
      $('#tag-form').show();
      $('#tag-form').empty();
      $link.hide();
      $('#tag-form').prepend(tagForm)
    })
    .fail(function(){
      console.log("tag form load fail")
    })
  })
}

var addTagHandler = function(){
  $('new-tag-form').on('submit', function(e){
    e.preventDefault();
    var $form = $(this)
    var route = $form.attr('action')
    var methodType = $form.attr('method')
    var data = $form.serialize();
  })
}

