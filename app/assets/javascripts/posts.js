$(document).ready(function () {
    $('#is_original_false').on("click", function(){
        $("#source-modal").modal();
    });
    $('#is_sharing_false').on("click", function(){
        $("#detail-field").fadeIn();
    });
    $('#is_sharing_true').on("click", function(){
        $("#detail-field").fadeOut();
    });
    $('[data-toggle="tooltip"]').tooltip();


    //Initialize tooltips
    $('.nav-tabs > li a[title]').tooltip();

    //Wizard
    $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {

        var $target = $(e.target);
        if ($target.parent().hasClass('disabled')) {
            return false;
        }
    });

    $(".next-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        $active.next().removeClass('disabled');
        nextTab($active);

    });
    $(".prev-step").click(function (e) {

        var $active = $('.wizard .nav-tabs li.active');
        prevTab($active);

    });
});

function nextTab(elem) {
    $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
    $(elem).prev().find('a[data-toggle="tab"]').click();
}