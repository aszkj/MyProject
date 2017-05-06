$(document).ready(function(){
    $("#regTab").click(function(){
        $(".up1").hide();
        $(".signForm").hide();
        $(".registerForm").show();
        $(".up2").show();
        $(this).css("color","#fff");
        $("#signTab").css("color","#e5e5e5");
    });
    $("#signTab").click(function(){
        $(".up2").hide();
        $(".registerForm").hide();
        $(".signForm").show();
        $(".up1").show();
        $(this).css("color","#fff");
        $("#regTab").css("color","#e5e5e5");
    });
   $("#invite_input").click(function(){
       if($('#invite_input').is(':checked')){
           $(".invite-code").show();
           $(".invite-p").css("color","#ff5555");
       }else {
           $(".invite-code").hide();
           $(".invite-p").css("color","#ddd");
       }
       });

    $(".eye-close").click(function () {
        $(".eye-close").hide();
        $(".eye-open").show();
        $(".password").attr("type","text");

    });
    $(".eye-open").click(function () {
        $(".eye-open").hide();
        $(".eye-close").show();
        $(".password").attr("type","password");

    });
    //选项卡切换
    $(".opt ul li a").click(function(e) {
        $(".content").hide();
        var x=$(this).attr("href");
        $(x).fadeIn();
        $(".opt ul li a").removeClass("act");
        $(this).addClass("act");
        return false;
    });
});
function showBtn(tele,clearBtn){
    var teleNumberId=tele.id;
    var clearBtnId=clearBtn.id;
    if(document.getElementById(teleNumberId).value.length > 0){
        document.getElementById(clearBtnId).style.display = 'block';
    }else{
        document.getElementById(clearBtnId).style.display = 'none';
    }
}
function clearText(tele,clearBtn){
    var teleNumberId=tele.id;
    var clearBtnId=clearBtn.id;
    document.getElementById(teleNumberId).value = '';
    document.getElementById(clearBtnId).style.display = 'none';
}
function showSearchBtn(){
    if(document.getElementById('searchInput').value.length > 0){
        $(".cancelBtn").hide();
        $(".searchBtn").show();
    }else{
        $(".searchBtn").hide();
        $(".cancelBtn").show();
    }
}