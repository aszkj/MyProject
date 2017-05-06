
/**
 * 同步加载JS实现类Skip
 */
var Skip = {
	// 获取XMLHttpRequest对象(提供客户端同http服务器通讯的协议)
	getXmlHttpRequest : function() {
		if (window.XMLHttpRequest) // 除了IE外的其它浏览器
			return new XMLHttpRequest();
		else if (window.ActiveXObject) // IE
			return new ActiveXObject("MsXml2.XmlHttp");
	},
	// 导入内容
	includeJsText : function(rootObject, jsText) {
		if (rootObject != null) {
			var oScript = document.createElement("script");
			oScript.type = "text/javascript";
			oScript.text = jsText;
			rootObject.appendChild(oScript);
		}
	},
	// 导入文件
	includeJsSrc : function(rootObject, fileUrl) {
		if (rootObject != null) {
			var oScript = document.createElement("script");
			oScript.type = "text/javascript";
			oScript.src = fileUrl;
			rootObject.appendChild(oScript);
		}
	},
	// 同步加载
	addJs : function(rootObject, url) {
		var oXmlHttp = Skip.getXmlHttpRequest();
		oXmlHttp.onreadystatechange = function() {// 其实当在第二次调用导入js时,因为在浏览器当中存在这个*.js文件了,它就不在访问服务器,也就不在执行这个方法了,这个方法也只有设置成异步时才用到
			if (oXmlHttp.readyState == 4) { // 当执行完成以后(返回了响应)所要执行的
				if (oXmlHttp.status == 200 || oXmlHttp.status == 304) { // 200有读取对应的url文件,404表示不存在这个文件
					Skip.includeJsSrc(rootObject, url);
				} else {
					alert('XML request error: ' + oXmlHttp.statusText + ' ('
							+ oXmlHttp.status + ')');
				}
			}
		}
		// 1.True 表示脚本会在 send()
		// 方法之后继续执行，而不等待来自服务器的响应,并且在open()方法当中有调用到onreadystatechange()这个方法。通过把该参数设置为
		// "false"，可以省去额外的 onreadystatechange 代码,它表示服务器返回响应后才执行send()后面的方法.
		// 2.同步执行oXmlHttp.send()方法后oXmlHttp.responseText有返回对应的内容,而异步还是为空,只有在oXmlHttp.readyState
		// == 4时才有内容,反正同步的在oXmlHttp.send()后的操作就相当于oXmlHttp.readyState ==
		// 4下的操作,它相当于只有了这一种状态.
		// url为js文件时,ie会自动生成 '<script src="*.js" type="text/javascript"> </script>',ff不会
		oXmlHttp.open('GET', url, false);
		oXmlHttp.send(null);
		Skip.includeJsText(rootObject, oXmlHttp.responseText);
	}
};


/***************************************************************common说明开始**************************************************/
//所有以下划线"_"开始的函数都是不支持外面调用的
/***************************************************************common说明结束**************************************************/
/***************************************************************common开发配置开始**************************************************/
//主体.顶级域名,方便于跨子域访问
var stUrlReg=/[^\.]*?\.com\.cn|[^\.]*?\.net\.cn|[^\.]*?\.org\.cn|[^\.]*?\.edu\.cn|[^\.]*?\.com|[^\.]*?\.cn|[^\.]*?\.net|[^\.]*?\.org|[^\.]*?\.edu|[^\.]*?\.tk/i;
var sBaseAreaName=window.location.host.toLowerCase().match(stUrlReg)[0];
/***************************************************************common开发配置结束**************************************************/
/***************************************************************ajax跨域打包开始**************************************************/
function ajax(stAjaxOB)
{	stAjaxOB.url=$.trim(stAjaxOB.url);
	stAjaxOB.waitTagId=$.trim(stAjaxOB.waitTagId);
	if(stAjaxOB.url=='')
	{
		alert('url不能为空!');
		return;
	}
	
	var _loginflag=0;
	if(isUserLogin())_loginflag=1;
	if(stAjaxOB.url.indexOf('?')==-1)stAjaxOB.url+='?_loginflag='+_loginflag;
	else stAjaxOB.url+='&_loginflag='+_loginflag;
	
	//加载等待图片
	if(typeof(stAjaxOB.waitTagId)!='undefined'&&stAjaxOB.waitTagId!='')
	{	var sTime=(new Date()).getTime();
		var stIDOB=document.getElementById(stAjaxOB.waitTagId);
		if(!stIDOB)stIDOB=document.body;
		var stPosition=getElementPosition(stIDOB);
		//等待图片为32*32的格式，所以要减去16
		var iTop=stPosition.top+stIDOB.offsetHeight/2-16;
		var iLeft=stPosition.left+stIDOB.offsetWidth/2-16;
		var src='/static-resource/images/base/loadingAnimation.gif';
		var sImg='<img id="WaitImg'+sTime+'" style="border:0;position:';
		if(stIDOB.tagName.toLowerCase()=="body"){
			sImg+="fixed;top:50%;left:50%;margin-left:-16px;margin-top:-16px;";
		}else {
			sImg+='absolute;top:'+iTop+'px;left:'+iLeft+'px;';
		}
		var pathName=window.location.pathname;
		if(pathName=='/'||pathName=='/index.html')src='/static-resource/images/base/loadingAnimation.gif';
		sImg+='_position:absolute;" src="'+src+'"/>';
		stAjaxOB.waitPicId="WaitImg"+sTime;
		$("body").append(sImg);
	}
	if(typeof(stAjaxOB.uploadForm)!='undefined'&&stAjaxOB.uploadForm!=''){
		var uploadForm=document.getElementById($.trim(stAjaxOB.uploadForm));
		if(uploadForm&&uploadForm.nodeName.toLowerCase()=='form'){
			ajaxUploadForm(arguments);
		}
	}else{
		_doAjax($,arguments);
	}
}
//二级函数,不能直接调用
function _doAjax(stJquery,stParam)
{	var stAjaxOB=stParam[0];
	var errorFun=typeof(stAjaxOB.error)!='undefined'?stAjaxOB.error:function(){};
	var successFun=typeof(stAjaxOB.success)!='undefined'?stAjaxOB.success:function(){};
	stJquery.ajax({ 
		url:typeof(stAjaxOB.url)!='undefined'?stAjaxOB.url:'',
		type:typeof(stAjaxOB.type)!='undefined'?stAjaxOB.type:'get',
		data:typeof(stAjaxOB.data)!='undefined'?stAjaxOB.data:'',
		dataType:typeof(stAjaxOB.dataType)!='undefined'?stAjaxOB.dataType:'text',
		async:typeof(stAjaxOB.async)!='undefined'?stAjaxOB.async:true,
		cache:typeof(stAjaxOB.cache)!='undefined'?stAjaxOB.cache:false,
		timeout:typeof(stAjaxOB.timeout)!='undefined'?stAjaxOB.timeout:30000,
		error:function(data){
			stParam[0]=data;
			errorFun.apply(stAjaxOB,stParam);
			if(typeof(stAjaxOB.waitPicId)!='undefined')$("#"+stAjaxOB.waitPicId).remove();
		}, 
		success:function(data)
		{	stParam[0]=data;
			successFun.apply(stAjaxOB,stParam);
			if(typeof(stAjaxOB.waitPicId)!='undefined')$("#"+stAjaxOB.waitPicId).remove();
		}
	})	
}
/****************** form 上传 ***************/
function ajaxUploadForm(stParam){
		var stAjaxOB=stParam[0];
		stAjaxOB.url=$.trim(stAjaxOB.url);
		stAjaxOB.uploadForm=$.trim(stAjaxOB.uploadForm);
		var uploadForm=document.getElementById(stAjaxOB.uploadForm);
		if(stAjaxOB.url==''||stAjaxOB.uploadForm==''||!uploadForm||uploadForm.nodeName.toLowerCase()!='form')return;
		var time=(new Date()).getTime();
		var singleUpload=typeof(stAjaxOB.singleUpload)!='undefined'?stAjaxOB.singleUpload:false;
		var dataType=typeof(stAjaxOB.dataType)!='undefined'?stAjaxOB.dataType:'text';
		var cache=typeof(stAjaxOB.cache)!='undefined'?stAjaxOB.cache:false;
		if(!cache){
			if(stAjaxOB.url.indexOf('?')==-1)stAjaxOB.url+='?_t='+time;
			else stAjaxOB.url+='&_t='+time;
		}
		//单个上传begin
		if(singleUpload){
			if(!uploadForm.uploadList&&!uploadForm.uploadIndex){
				var stFile=[];
				var stTemp=uploadForm.getElementsByTagName('input');
				for(var i=0,iLength=stTemp.length;i<iLength;i++){
					if(stTemp[i].type.toLowerCase()=='file'&&stTemp[i].name!=''&&stTemp[i].value!=''){
						stTemp[i].backName=stTemp[i].name;
						stTemp[i].name='';
						stFile.push(stTemp[i]);
					}
				}
				uploadForm.uploadList=stFile;
				uploadForm.uploadIndex=0;
			}
			var stList=uploadForm.uploadList;
			var iIndex=uploadForm.uploadIndex;
			for(var i=0,iLength=stList.length;i<iLength;i++)stList[i].name='';
			stList[iIndex].name=stList[iIndex].backName;
			//生成等待图标
			var stPosition=getElementPosition(stList[iIndex]);
			//等待图片为32*32的格式，所以要减去16
			var iHeight=stList[iIndex].offsetHeight;
			var iTop=stPosition.top;
			var iLeft=stPosition.left+stList[iIndex].offsetWidth/2-iHeight/2;
			var sImg='<img id="ajaxUploadFormWaitImg'+time+'" style="border:0;position:absolute;top:'+iTop+'px;left:'+iLeft+'px;height:'+iHeight+'px" src="/static-resource/images/module/loadingAnimation.gif"/>';
			$("body").append(sImg);
		}
		//单个上传end
		uploadForm.target='ajaxUploadForm'+time;
		uploadForm.enctype='multipart/form-data';//IE这样设置无效
		uploadForm.encoding="multipart/form-data";//IE这样设置有效
		uploadForm.method='post';
		uploadForm.action=stAjaxOB.url; 
		//创建iframe  
		var proxy=null;
		try{
			if(isIE())proxy=document.createElement('<iframe name="ajaxUploadForm'+time+'"></iframe>');
		}catch(e){
				
		}
		if(!proxy)proxy=document.createElement("iframe");
		proxy.name='ajaxUploadForm'+time;
		proxy.style.display="none"; 
		proxy.stParam=stParam;
		//IE这样设置box.onload无效
		if(proxy.attachEvent)
		{
			proxy.attachEvent('onload',function(){
				_doAjaxUploadForm(proxy);
			});
		}
		else
		{	
			proxy.onload=function(){
				_doAjaxUploadForm(this);
			}
		}
		$("body").append(proxy);
		uploadForm.submit();
}
function _doAjaxUploadForm(stIframe){
	var sHref=stIframe.contentWindow.location.href.replace(/\s/g,'');
	if(sHref=='about:blank')return;
	var data=_ajaxResponseFilter(stIframe.contentWindow.document.body.innerHTML);
	var stParam=stIframe.stParam;
	var stAjaxOB=stParam[0];
	stParam[0]=data;
	var errorFun=typeof(stAjaxOB.error)!='undefined'?stAjaxOB.error:function(){};
	var successFun=typeof(stAjaxOB.success)!='undefined'?stAjaxOB.success:function(){};
	if(stAjaxOB.dataType=='json'){
		var reg = /<pre.*?>(.+)<\/pre>/;  
		var result = stParam[0].match(reg);  
		stParam[0] = RegExp.$1;
		stParam[0]=$.parseJSON(stParam[0]);
		if(stParam[0])successFun.apply(stAjaxOB,stParam);
		else errorFun.apply(stAjaxOB,stParam);
	}else successFun.apply(stAjaxOB,stParam);
	//还原原始参数
	stParam[0]=stAjaxOB;
	//单个上传begin
	stAjaxOB.uploadForm=$.trim(stAjaxOB.uploadForm);
	var uploadForm=document.getElementById(stAjaxOB.uploadForm);
	if(stAjaxOB.url==''||stAjaxOB.uploadForm==''||!uploadForm||uploadForm.nodeName.toLowerCase()!='form')return;
	var singleUpload=typeof(stAjaxOB.singleUpload)!='undefined'?stAjaxOB.singleUpload:false;
	if(singleUpload){
		//删除单个上传的等待图标
		var sTime=uploadForm.target.replace(/ajaxUploadForm/g,'');
		var stUploadImg=document.getElementById('ajaxUploadFormWaitImg'+sTime);
		if(stUploadImg)$(stUploadImg).remove();
		if(uploadForm.uploadIndex>=(uploadForm.uploadList.length-1)){
			for(var i=0,iLength=uploadForm.uploadList.length;i<iLength;i++)uploadForm.uploadList[i].name=uploadForm.uploadList[i].backName;
			uploadForm.uploadList=null;
			uploadForm.uploadIndex=null;
		}else{
			uploadForm.uploadIndex++;
			ajaxUploadForm(stParam);
		}
	}
	//单个上传end
	if(stIframe){
		setTimeout(function(){
			$(stIframe).remove();
		},1000);
	}
	if(typeof(stAjaxOB.waitPicId)!='undefined')$("#"+stAjaxOB.waitPicId).remove();		
}
function _ajaxResponseFilter(sResponse){
	var stResponse=$.trim(sResponse);
	return stResponse;
}
/***************************************************************ajax跨域打包结束**************************************************/
function toCenti(num,len){
	len=len||2;
	if(num==null){num = 0}
	if(isNaN(parseFloat(num)))return num;
	else return (num/1000).toFixed(len);
}
function toFloat(num,len){
	len=len||2;
	if(isNaN(parseFloat(num)))return num;
	else return (num).toFixed(len);
}
function trim(sStr){
	if(typeof(sStr)!='string')return sStr;
	return sStr.replace(/(^\s*)|(\s*$)/g,"");
}
/**时间去掉.0的2位**/ 
function totime(value){
	if(!value){
		return "-";
	}
	var istime = value;
	if(value.lastIndexOf(".") != -1){
		istime = value.substring(0,value.lastIndexOf("."));
	}
	return istime;
}

/**如果为空显示- 小横线**/
function emptyToLine(value){
	if(value){
		return value;
	}else{
		return '-';
	}
}

/** 验证只有2位小数 **/
function staypoint(value,len){
	  var lengthP = len;
	  if(!len){
	     lengthP = 2;
	  }
	  if(!value){
	  	alert("请输入数值");
	  	return false;
	  }
	  if(value.indexOf(".") != -1){
		  var point2 = value.length - (value .indexOf(".") + 1);
		  if(point2 > lengthP ){
		  	  var msg = "只能保留"+lengthP+"位小数";
			  alert(msg);
			  return false;
	  	  }
	  }
	  return true;
	}

/** 解决js浮点型乘法运算bug **/
function toMul(value,arg){
	var m=0,s1=value.toString(),s2=arg.toString();   
 	try{m+=s1.split(".")[1].length}catch(e){}   
    try{m+=s2.split(".")[1].length}catch(e){}   
    return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);   
}
