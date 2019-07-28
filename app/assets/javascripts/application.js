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
//= require_tree .

/*!
 * jQuery UI Touch Punch 0.2.3
 *
 * Copyright 2011–2014, Dave Furfero
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * Depends:
 *  jquery.ui.widget.js
 *  jquery.ui.mouse.js
 */
 
!function(a){function f(a,b){if(!(a.originalEvent.touches.length>1)){a.preventDefault();var c=a.originalEvent.changedTouches[0],d=document.createEvent("MouseEvents");d.initMouseEvent(b,!0,!0,window,1,c.screenX,c.screenY,c.clientX,c.clientY,!1,!1,!1,!1,0,null),a.target.dispatchEvent(d)}}if(a.support.touch="ontouchend"in document,a.support.touch){var e,b=a.ui.mouse.prototype,c=b._mouseInit,d=b._mouseDestroy;b._touchStart=function(a){var b=this;!e&&b._mouseCapture(a.originalEvent.changedTouches[0])&&(e=!0,b._touchMoved=!1,f(a,"mouseover"),f(a,"mousemove"),f(a,"mousedown"))},b._touchMove=function(a){e&&(this._touchMoved=!0,f(a,"mousemove"))},b._touchEnd=function(a){e&&(f(a,"mouseup"),f(a,"mouseout"),this._touchMoved||f(a,"click"),e=!1)},b._mouseInit=function(){var b=this;b.element.bind({touchstart:a.proxy(b,"_touchStart"),touchmove:a.proxy(b,"_touchMove"),touchend:a.proxy(b,"_touchEnd")}),c.call(b)},b._mouseDestroy=function(){var b=this;b.element.unbind({touchstart:a.proxy(b,"_touchStart"),touchmove:a.proxy(b,"_touchMove"),touchend:a.proxy(b,"_touchEnd")}),d.call(b)}}}(jQuery);

function booth_show(element, id){
     var className = '.pin-body_'+id;
    var pinClassName = '.booth'+id+' > a';
    var path = location.pathname.split("/");
    path = path[1];
    $(className).toggleClass("shown");
    if(location.pathname.split("/")[1] == 'day'){
         $(".pin_img").attr("src", "/assets/pins/pin.png");
        if($(className).hasClass("shown") == true){
            $("#pin_off_"+id).attr("src", "/assets/pins/shownpin.png");
        }else{
            $("#pin_off_"+id).attr("src", "/assets/pins/pin.png");
        }
    }else if(location.pathname.split("/")[1] == 'night'){
         $(".pin_img").attr("src", "/assets/pins/beerpin.png");
        if($(className).hasClass("shown") == true){
            $("#pin_on_"+id).attr("src", "/assets/pins/shownpin.png");
        }else{
            $("#pin_on_"+id).attr("src", "/assets/pins/beerpin.png");
        }
    }
    $("div:not("+className+")").removeClass("shown");
}

function booth_close(element, id){
    var className = '.pin-body_'+id;
    var pinClassName = '.booth'+id+' > a';
    var path = location.pathname.split("/");
    path = path[1];
    if(path=='day'){
        $("#pin_off_"+id).attr("src", "/assets/pins/pin.png");
    }else if(path=='night'){
        $("#pin_on_"+id).attr("src", "/assets/pins/beerpin.png");
    }
    $(className).removeClass("shown");
}

$(document).ready(function() {
    /* Materialize Elements will be enabled */
    $('select').material_select();
    $('.parallax').parallax();
    $("select[required]").css({display: "inline", height: 0, padding: 0, width: 0});
     /* Enable Tabs */
    $('ul.tabs').tabs();
         
    
    /* Route Actions */
    var path = location.pathname.split("/");
    path = path[1];
    
    if(path == 'day' || path == 'night'){
        $('body').addClass('no-scroll');
        $('.toast_msg_map').fadeIn(400).delay(3000).fadeOut(400);
        if(getParameter('id')!=null){
            booth_location_show();
        }
        if(path == 'day'){
            $('body').addClass('day');
            $('body').css('background-color','#7ACEBF');
        }else if(path == 'night'){
            $('body').addClass('night');
            $('body').css('background-color','#444');
        }
    }else if(path == 'likelion'){
        $('body').css('background-color','#EEE');
        $('body').addClass('scrollable');
    }else if(path == 'fest_manage' || path == 'realtime' || path == 'location' || path == 'list'){
        $('body').css('background-color','#FFF');
        $('body').addClass('scrollable');
    }else if(path=='credit'){
        $('body').addClass('scrollable');
    }
    else{
        $('body').addClass('scrollable');
        $('.toast_msg').fadeIn(400).delay(5000).fadeOut(400);
    }
    
    setInterval(refreshForLED, 5000);
    
    $("#info_container").draggable();
     $('.carousel').carousel({full_width: true});
    
});


/* 지도 낮/밤 전환*/
function modeReplace(url){
    location.replace(url);
}

/* 실시간 정보 전달*/
function refreshForLED(){
    $.ajax({
        method:"GET",
        dataType: "json",
        url:"/home/realtime_data",
        success:function(data){
            if(data.id > initLEDId){
                $(".toast_msg").html('<i class="material-icons">wifi</i>&nbsp;&nbsp;[실시간 | '+data.Title+']<br>' + data.Content);
                $('.toast_msg').slideDown(400).delay(5000).fadeOut(400); //fade out after 3 seconds
                initLEDId = data.id
            }
        }
    })
}


/* Increment Like Views with AJAX */
function increment(view_id){
    link = "/home/increment/"+view_id;
    $.ajax({
        method:"GET",
        dataType:"json",
        url:link,
        success:function(data){
            var temp = $("#like_num"+view_id).text();
            temp = parseInt(temp);
            temp = temp + 1;
            $("#like_num"+view_id).text(temp);
        }
    })
}    

/* Click Go To Map */
function map_func(select_id){
    increment(select_id);
    window.location.href = '/find/'+select_id;
}    


function booth_location_show(){
    var data = getParameter('id'); //?id=에서 Information ID 추출
    booth_show(null, data);
    
    var booth_id = ".booth" + data;
    var top = $(booth_id).css('top');
    var left = $(booth_id).css('left');
    
    $("#info_container").css('top',-top.split('px')[0]+200);
    $("#info_container").css('left',-left.split('px')[0]+200);
}

var getParameter = function (param) {
    var returnValue;
    var url = location.href;
    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == param.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};

function changeImage(id) {
     /* Route Actions */
        var path = location.pathname.split("/");
        path = path[1];
        
    if ($(".pin-body_"+id).hasClass("shown")==true) {
        //shown이었던 핀의 해제, 원상태 복귀
        if(path == 'day'){
            $("#pin_off_"+id).attr("src", "/assets/pins/pin.png");
        }else if(path == 'night'){
            $("#pin_off_"+id).attr("src", "/assets/pins/beerpin.png");
        }
    } 
    
    else {
        
    }
}