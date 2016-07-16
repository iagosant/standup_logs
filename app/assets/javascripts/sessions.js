$(document).on('turbolinks:load',function(){
  // $('#datepicker2').on('change',function(){
    // alert('datepicker2');

  $('#narrowSearch').on('click', function(){
    var selectedUsers = $('select#searchByUser').val();
    // alert(selectedUsers);

    var dateTypeVar = $('input#datepicker').datepicker('getDate');
    var dateTypeVarTwo = $('#datepicker2').datepicker('getDate');
    $.ajax({
      url: 'sessions/' + 'cleanDate',
      type: 'POST',
      dataType: 'json',
      data: {'dateTypeVar': dateTypeVar, 'dateTypeVarTwo': dateTypeVarTwo, 'selectedUsers': selectedUsers},
      success: function(data, textStatus) {
        // alert(data);
        if (data != ""){
          $('tbody').html("");
          for (i=0;i<data.length;i++){
            var id = data[i].id;
            var date = data[i].created_at;
            var weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            var clean_date = new Date(date);
            var n = new Date(clean_date).getDay();
            var dayOfWeek = weekday[n];
            var m = new Date(clean_date).getMonth();
            var monthIs = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
            var month = monthIs[m];
            var dayOfMonth = new Date(clean_date).getDate();
            var html = '<tr>';
            html += '<td>';
            html += '<img height="15" src="/assets/wip-5b4657932e2940c3bed7f403256b308a9b8a2034765b544e0b64ca428b7f3845.png" alt="Wip">';
            html += '</td>';
            html += '<td>';
            html += '<a href="/sessions/' + id + '">' + dayOfWeek + ' STAND-UP' + '</a>';
            html += '</td>';
            html += '<td>';
            html += '<a href="/sessions/' + id + '">' + month + ' ' + dayOfMonth + '</a>';
            html += '</td>';
            html += '<td>';
            html += '<a data-confirm="Delete this session?" rel="nofollow" data-method="delete" href="/sessions/' + id + '">';
            html += '<i class="small material-icons">delete</i>';
            html += '</a>';
            html += '</td>';
            html += '</tr>';
            $('tbody').append(html);
          }
        }
      }
    });
  });

  $('textarea').focus(function() {
    $(this).css("background-color","#e6ffff");
  }).blur(function() {
    $(this).css("background-color","white");
    $(this).height("39px");
    var content = $(this).val();
    var str = $(this).attr('name');
    var itemEdited = str.split("[")[0] + "s";
    var itemId = $(this).parents("li").attr("id");
    var sessionId = $('.session_tag').attr('id');
    // alert(content + itemEdited + itemId)
    $.ajax({
      url: sessionId + '/' + itemEdited +'/' + itemId + '/update',
      type: 'POST',
      dataType: 'json',
      data: {'itemId': itemId, 'sessionId': sessionId, 'content': content}
      // success: function(){
      //   alert (itemEdited + ' was updated');
      // }
    });
  });

  $('td.delete').click(function(){
    var sessionId = $('tr').attr('data');
    alert('clicked on delete');
    $.ajax({
      url: 'sessions' + '/' + 'deleteSession' + '/' + sessionId,
      type: 'POST',
      dataType: 'json',
      data: {'sessionId': sessionId},
      success: function(data, textStatus){
        if ( data != ""){
          // alert('data');
          $('tbody').html("");
          for (i=0;i<data.length;i++){
            var id = data[i].id;
            var date = data[i].created_at;
            // alert(date);
            var weekday = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            var clean_date = new Date(date);
            var n = new Date(clean_date).getDay();
            var dayOfWeek = weekday[n];
            var m = new Date(clean_date).getMonth();
            var monthIs = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
            var month = monthIs[m];
            var dayOfMonth = new Date(clean_date).getDate();
            var html = '<tr>';
            html += '<td>';
            html += '<img height="15" src="/assets/wip-5b4657932e2940c3bed7f403256b308a9b8a2034765b544e0b64ca428b7f3845.png" alt="Wip">';
            html += '</td>';
            html += '<td>';
            html += '<a href="/sessions/' + id + '">' + dayOfWeek + ' STAND-UP' + '</a>';
            html += '</td>';
            html += '<td>';
            html += '<a href="/sessions/' + id + '">' + month + ' ' + dayOfMonth + '</a>';
            html += '</td>';
            html += '<td>';
            html += '<a data-confirm="Delete this session?" rel="nofollow" data-method="delete" href="/sessions/' + id + '">';
            html += '<i class="small material-icons">delete</i>';
            html += '</a>';
            html += '</td>';
            html += '</tr>';
            $('tbody').append(html);
          }
        }
      }
    });
  });

  $('#removeUser').on('click', function(){
    var selectedUser = $(this).closest('div');
    var sessionUser = $(this).closest('div').attr('data');
    var splitSessionUser = sessionUser.split(" ");
    alert(splitSessionUser)
    var sessionId = splitSessionUser[0];
    var userId = splitSessionUser[1];
    alert(sessionId + " " + userId);
    $(selectedUser).fadeOut();
    $.ajax({
      url: '/' + 'sessions' + '/' + sessionId + '/' + 'removeUser',
      type: 'POST',
      dataType: 'json',
      data: {'sessionId': sessionId, 'userId':userId}
    });
  });

  $('#addUser').on('click', function(){
    var userIds = $('select#addUserToSession').val();
    alert(userIds);
  });

});
