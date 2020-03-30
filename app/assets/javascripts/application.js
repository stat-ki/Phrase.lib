// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require bootstrap-sprockets
//= require_tree .

$(function () {
    $("#search_model").on("change", function(){
        $.when(
            $("#search-introduction").fadeOut(),
            $("#search_model").fadeOut()
        ).done(function(){
            $("#search-description").fadeIn();
            $("#search_word").fadeIn();
            $("#search-submit").fadeIn();
        });
    });
    $('#image-preview').change(function(e){
        var file = e.target.files[0];
        var reader = new FileReader();
        // when the file is't image
        if(file.type.indexOf("image") < 0){
          alert("画像ファイルを指定してください。");
          return false;
        }
        // set preview to image tag
        reader.onload = (function(file){
          return function(e){
            $("#image-preview-field").attr("src", e.target.result);
          };
        })(file);
        reader.readAsDataURL(file);
    });
});