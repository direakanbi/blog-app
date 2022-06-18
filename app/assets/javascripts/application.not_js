//= require jquery
// = require jquery_ujs 

$(document).on('ajax:success', function (data, status) {
  console.log(data)
  var $el = $('h2');
  // var r = $.parseJSON(data.data);
  // console.log(r)
  // $el.append('<div>' + data.currentTarget + '</div>')
  $.each(data, function (p) {
    $el.append(
      // '<div class="name">' + p + '</div>'
    );
  });
});