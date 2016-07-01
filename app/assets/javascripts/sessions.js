$(document).on('ready page:load', function () {
  // alert('works');
  $('input#datepicker').on('change',function(){
    var dateTypeVar = $(this).datepicker('getDate');
    $.ajax({
      url: 'sessions/' + 'search',
      type: 'POST',
      dataType: 'json',
      data: {'dateTypeVar': dateTypeVar},
      success: function(data, textStatus) {
        if (data != ""){
          $('tbody').html("")
          for (i=0;i<data.length;i++){
            var id = data[i][0];
            var date = data[i][1];
            var weekday = new Array(7);
            weekday[0] = "Sunday";
            weekday[1] = "Monday";
            weekday[2] = "Tuesday";
            weekday[3] = "Wednesday";
            weekday[4] = "Thursday";
            weekday[5] = "Friday";
            weekday[6] = "Saturday";
            var clean_date = new Date(date);
            var n = new Date(clean_date).getDay();
            var dayOfWeek = weekday[n];
            var m = new Date(clean_date).getMonth();
            var monthIs = new Array(12);
            monthIs[0] = 'January';
            monthIs[1] = 'February';
            monthIs[2] = 'March';
            monthIs[3] = 'April';
            monthIs[4] = 'May';
            monthIs[5] = 'June';
            monthIs[6] = 'July';
            monthIs[7] = 'August';
            monthIs[8] = 'September';
            monthIs[9] = 'October';
            monthIs[10] = 'November';
            monthIs[11] = 'December';
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
    var itemEdited = str.split("[")[0] + "s"
    var itemId = $(this).parents("li").attr("id")
    var sessionId = $('.session_tag').attr('id')
    // alert(content + itemEdited + itemId)
    $.ajax({
      url: sessionId + '/' + itemEdited +'/' + itemId + '/update',
      type: 'POST',
      dataType: 'json',
      data: {'itemId': itemId, 'sessionId': sessionId, 'content': content},
      // success: function(){
      //   alert (itemEdited + ' was updated');
      // }
    });
  });
});
