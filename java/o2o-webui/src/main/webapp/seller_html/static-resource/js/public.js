$(function(){
	$(document).on('click','.js_btn_buy',function(){
		var leftnum=$(this).offset().left;
		var topnum=$(this).offset().top;
		var scrolltops=$(document).scrollTop();
		alert('文档总宽度'+$(document).width());
		alert(leftnum+$(this).width()/2);
		alert(topnum-scrolltops);
		cordova.exec(function(result){
			
		}, null, "AddCartPlugin", "addCart", [leftnum+$(this).width()/2, topnum-scrolltops]);
	});
	$(document).on('scroll',function(){
		var tempnum=isbottom();
		if(tempnum==1){
			$('.douboxb').each(function(){
				if($(this).is(':hidden')){
					var brands=$(this).attr('id');
					var dates={
						"goodsinfo":[
							{ "imgsrc":"images/goods.jpg" , "infos":"【优选良食】精选珍品越香米5斤  100%越南进口香米","oldprice":"39.9","newprice":"19.9"},
							{ "imgsrc":"images/goods.jpg" , "infos":"【优选良食】精选珍品越香米5斤  100%越南进口香米","oldprice":"39.9","newprice":"19.9"},
							{ "imgsrc":"images/goods.jpg" , "infos":"【优选良食】精选珍品越香米5斤  100%越南进口香米","oldprice":"39.9","newprice":"19.9"},
							{ "imgsrc":"images/goods.jpg" , "infos":"【优选良食】精选珍品越香米5斤  100%越南进口香米","oldprice":"39.9","newprice":"19.9"},
						]
					}
					var htmls=dateReform(dates);
					$(this).find('.douulb').html(htmls);
					$(this).show();
					return false;
				}
			})
		}
	})
})
function isbottom() {
        var scrollTop = $(this).scrollTop();
        var scrollHeight = $(document).height();
        var windowHeight = $(this).height();
        if (scrollTop + windowHeight == scrollHeight) {  //滚动到底部执行事件
            return 1;
        }
        if (scrollTop == 0) {  //滚动到头部部执行事件
        	return 2;
        }
}
function dateReform(dates){
	var obj = dates.goodsinfo;
	var htmls='';
	var dateArr=obj;
	for(var i=0;i<dateArr.length;i++){
		var tempprice=obj[i].newprice;
		var temppricea=tempprice.substring(0,tempprice.lastIndexOf('.'));
		var temppriceb=tempprice.substring(tempprice.lastIndexOf('.')+1);
		htmls+='<li><p class="box-px alignc"><img src="'+obj[i].imgsrc+'"></p><p class="box-infoa">'+obj[i].infos+'</p><p class="box-infob"><del>￥'+obj[i].oldprice+'</del></p><p class="box-infoc">￥'+temppricea+'<span>.'+temppriceb+'</span><a href="javascript:void(0)" class="js_btn_buy"></a></p>';
	}
	return htmls;
}