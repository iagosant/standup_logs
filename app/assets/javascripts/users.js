$(document).on('ready page:load', function () {

  $('select').material_select();
  $('select').on('change', function(){
    var newSelect = $('select').val();
    console.log(newSelect);
    var userId = $(this).parents('.selected_role').attr('id');
    $.ajax({
      url: 'users/roleUpdate',
      type: 'POST',
      dataType: 'json',
      data: {'user_id': userId, 'new_role': newSelect},
      success: function(){
        alert ('user role was changed to' + newSelect);
      }
    });
  });
});
