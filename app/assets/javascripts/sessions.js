$(document).on('ready page:load', function () {
  $('textarea').focus(function() {
    $(this).css("background-color","#e6ffff");
  }).blur(function() {
    $(this).css("background-color","white");
    $(this).height("39px");
      var content = $(this).val();
      var str = $(this).attr('name');
      var itemEdited = str.split("[")[0] + "s"
      var itemId = $(this).parents("li").attr("id")
      var sessionId = $('.session_tag').attr('id')
      // alert(content + itemEdited + itemId)
    $.ajax({
      url: sessionId + '/' + itemEdited +'/' + itemId + '/update',
      type: 'POST',
      dataType: 'json',
      data: {'itemId': itemId, 'sessionId': sessionId, 'content': content},
      success: function(){
        alert (itemEdited + ' was updated');
      }
    });
  });
});
