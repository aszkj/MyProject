/**
 * Created by Administrator on 2016/12/28.
 */
//手机号码格式校验
$("#tele").blur("blur",function(){
    var tele=$("#tele").val();
    if(checkMobile(tele)){
        $("#errorTipForTele").css("display","none");
    }else{
        $("#errorTipForTele").css("display","block");
        $("#errorTipForTele").html("手机号码格式错误");
    }
    if(tele==""){
        $("#errorTipForTele").html("手机号码不能为空");
    }
    if(tele.length>11){
        $("#errorTipForTele").html("手机号码不能超过11位");
    }
});
$("#tele1").blur("blur",function(){
    var tele=$("#tele1").val();
    if(checkMobile(tele)){
        $("#errorTipForTele1").css("display","none");
    }else{
        $("#errorTipForTele1").css("display","block");
        $("#errorTipForTele1").html("手机号码格式错误");
    }
    if(tele==""){
        $("#errorTipForTele1").html("手机号码不能为空");
    }
    if(tele.length>11){
        $("#errorTipForTele1").html("手机号码不能超过11位");
    }
});
//密码格式校验
$("#password").blur("blur",function(){
    var password=$("#password").val();
    if(checkPassword(password)){
        $("#errorTipForPassword").css("display","none");
    }else{
        $("#errorTipForPassword").css("display","block");
        $("#errorTipForPassword").html("密码格式错误");
    }
    if(password==""){
        $("#errorTipForPassword").html("密码不能为空");
    }
    if(password.length>0&&password.length<6){
        $("#errorTipForPassword").html("密码不能少于6位");
    }
});
$("#password1").blur("blur",function(){
    var password=$("#password1").val();
    if(checkPassword(password)){
        $("#errorTipForPassword1").css("display","none");
    }else{
        $("#errorTipForPassword1").css("display","block");
        $("#errorTipForPassword1").html("密码格式错误");
    }
    if(!validaPassword()){
        $("#errorTipForPassword1").css("display","block");
        $("#errorTipForPassword1").html("两次密码输入不一致");
    }
    if(password==""){
        $("#errorTipForPassword1").html("密码不能为空");
    }
    if(password.length>0&&password.length<6){
        $("#errorTipForPassword1").html("密码不能少于6位");
    }

});
/*发送验证码倒计时*/
var interval = null;
function resetInterval(totalTime, elementId) {
    var sleep = totalTime;
    var element = document.getElementById(elementId);
    if (interval)
        clearInterval(interval);
    setBtnDisable(element, sleep);
    interval = setInterval(function() {
        sleep--;
        setBtnDisable(element, sleep);
        if (sleep <= 0) {
            clearInterval(interval);
            setBtnEnable(element);
            return false;
        }
    }, 1000);
}
function setBtnDisable(element, sleep) {
    element.style.color = '#ccc';
    element.disabled = "disabled";
    element.style.cursor = "wait";
    element.value = "(" + sleep-- + "s)后重发";
}
function setBtnEnable(element) {
    element.style.cursor = "pointer";
    element.removeAttribute('disabled');
    element.value = "发送验证码";
    element.style.backgroundColor = '';
}