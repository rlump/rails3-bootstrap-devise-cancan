// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

$(document).ready(function(){
  $("img").click(function(){
    var src = $(this).attr("src")
    $("#layoutPhotoTarget").html('<img src = "' + src + '">');
    $("#inputPhotoTarget").val(src);
    $("#pagenav").html('<div class="span9">\
      <button id="cancel_photo" class="btn btn-danger right pad_bottom" type="button">Cancel</button>\
      <button id="save_photo" class="btn btn-primary right pad_bottom" type="button" >Save Changes</button>\
      <\div>');
    $("#save_photo").click(function(){
      $('#photo_submit').submit();
    });
    $("#cancel_photo").click(function(){
      $("#inputPhotoTarget").val("");
      $('#photo_submit').submit();
    });
  });
});
