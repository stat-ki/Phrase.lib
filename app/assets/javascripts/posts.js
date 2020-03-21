$(document).ready(function () {
    $('#is_original_true').on("click", function(){
        $(".source_field").fadeOut();
    });
    $('#is_original_false').on("click", function(){
        $(".source_field").fadeIn();
    });
});