package com.yilidi.o2o.controller.mobile.buyer.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.system.WXSdkParam;
import com.yilidi.o2o.appvo.buyer.system.WXSdkSign;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.connect.wechat.api.AccessTokenApi;
import com.yilidi.o2o.core.connect.wechat.javabean.JsTickSign;
import com.yilidi.o2o.core.connect.wechat.javabean.JsapiTicket;
import com.yilidi.o2o.core.connect.wechat.utils.WXSDKSignature;
import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * 图片轮播
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
@Controller("buyerWXSDKController")
@RequestMapping(value = "/interfaces/buyer")
public class WXSDKController extends BuyerBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 
	 * 获取轮播广告
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param resp
	 *            HttpServletResponse
	 * @return ResultParamModel
	 */
	@RequestMapping(value = "/wxsdk/wxsignbyurl")
	@ResponseBody
	public ResultParamModel getImageRotate(HttpServletRequest req, HttpServletResponse resp) {
		WXSdkParam param = super.getEntityParam(req, WXSdkParam.class);
		JsapiTicket jsapiTicket = AccessTokenApi.getSDKJsapiTicket();
		if (!jsapiTicket.isAvailable()) {
			logger.error("该次链接微信端获取信息无法成功");
			return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该次链接微信端获取信息无法成功");
		}
		JsTickSign jsTickSign = new JsTickSign(jsapiTicket.getTicket(), param.getUrl());
		WXSdkSign sdkSign = new WXSdkSign(jsTickSign.getTimestamp(), jsTickSign.getNoncestr(),
				WXSDKSignature.getSign(jsTickSign.toMap()));
		return super.encapsulateParam(sdkSign, AppMsgBean.MsgCode.SUCCESS, "请求获取成功");
	}
}
