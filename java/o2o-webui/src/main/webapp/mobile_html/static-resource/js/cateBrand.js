var myScroll,myScrollri;
var myScrollBrand;
var $ulLeft;var cataId = 0;

function pullUpAction () {
    setTimeout(function () {
        myScrollri.refresh();
    }, 500);
}

function init_left_li(){
    var total_hei = $ulLeft.height();//总高度
    var li_height = $ulLeft.find("li").height();//单个li高度
    var li_num = $ulLeft.find("li").length;//个数
    console.log($ulLeft.find(".off").offset().top);
}
/**
 * 初始化iScroll控件
 */
function brandLoad(){
    myScrollBrand = new IScroll("#brandConBox",{
        mouseWheel: false, click: true,
        preventDefault: false,
        bounce: false,
        useTransition: false
        //preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A)$/ }
    });
}
function loaded() {
    $ulLeft = $("#con_left");
    myScroll = new IScroll("#con_left",{
        mouseWheel: false,
        click: true,
        preventDefault: false,
        useTransition: false,
        bounce: false,
        preventDefaultException: { tagName: /^(INPUT|TEXTAREA|BUTTON|SELECT|A)$/ }
    });
    myScrollri = new IScroll("#con_right",{
        mouseWheel: false, click: true,
        useTransition: false,
        bounce: false
    });

    myScrollri.on("scrollStart",function(){
        pullUpAction();
    });
    myScrollri.on("scroll",function(){
        pullUpAction();
    });
    myScrollri.on("scrollEnd",function(){
        $('.fr_ite_'+cataId).find("img").lazyload({
            threshold: 200
        }).on('load', function() {
            pullUpAction();
        });
    });
    $('.job_sub li').eq(0).click();
}
//初始化绑定iScroll控件
document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);

/*隐藏浏览器的地址栏*/
window.onload=srcTop;
function srcTop(){
    setTimeout(function() {
        window.scrollTo(0, 1)
    }, 0);
    if(document.documentElement.scrollHeight <= document.documentElement.clientHeight) {
        bodyTag = document.getElementsByTagName('body')[0];
        bodyTag.style.height = document.documentElement.clientWidth / screen.width * screen.height + 'px';
    }
};
setInterval("myInterval()",1000);//1000为1秒钟
function myInterval(){
    $("body").height($(window).height());
}
