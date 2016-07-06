// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui/datepicker
//= require_tree .
//= javascript_include_tag :application
$(document).on("page:change", function() {
  $("#stand-up nav .menu a").hover(function(){
    var img = jQuery(this).find("img#icon-change"),
        img_path;

    if (img.length){
      img_path = img.attr('src');
      img_path = img_path.substr(0,img_path.lastIndexOf("."))+'-lightblue.png';
      img.attr('src',img_path);
      }
    }, function(){
      var img = jQuery(this).find("img#icon-change"),
          img_path;
      if (img.length){
        img_path = img.attr('src');

        img_path = img_path.substr(0,img_path.lastIndexOf("-"))+'.png';
        img.attr('src',img_path);
      }
   });

});
