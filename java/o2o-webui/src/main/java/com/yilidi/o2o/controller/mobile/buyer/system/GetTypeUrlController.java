package com.yilidi.o2o.controller.mobile.buyer.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.system.GetTypeUrlParam;
import com.yilidi.o2o.appvo.buyer.system.GetTypeUrlVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;

/**
 * 页面跳转接口,前端页面跳转
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
@Controller("buyerPageRedirectController")
@RequestMapping(value = "/interfaces/buyer")
public class GetTypeUrlController extends BuyerBaseController {

	/** 关于我们 **/
	private static final String ABOUT_US_URL = "/buyer/about-us.html";
	/** 常见问题 **/
	private static final String FAQ_URL = "/buyer/faq.html";
	/** 合伙人加盟 **/
	private static final String PARTNER_URL = "/buyer/partner.html";
	/** 新版升级VIP **/
	private static final String VIP_UPGRADE_NEW_URL = "/buyer/market.html";
	/** 注册有礼 **/
	private static final String REGISTER_GIFT_URL = "/buyer/regift.html";
	/** 分享有礼 **/
	private static final String SHARE_GIFT_URL = "/share/shareForGift.html";

	/**
	 * 
	 * 页面跳转接口,前端页面跳转
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param resp
	 *            HttpServletResponse
	 * @return 跳转地址
	 */
	@RequestMapping(value = "/system/gettypeurl")
	@ResponseBody
	public ResultParamModel getTypeurl(HttpServletRequest req, HttpServletResponse resp) {
		GetTypeUrlParam getTypeUrlParam = super.getEntityParam(req, GetTypeUrlParam.class);
		Integer type = getTypeUrlParam.getType();
		String typeCode = getTypeUrlParam.getTypeCode();
		String helpAddress = "";
		if (!StringUtils.isEmpty(typeCode)) {
			helpAddress = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.MOBILE_SYSTEM_DOMAIN)
					+ getUrlForTypeCode(typeCode);
		} else {
			helpAddress = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.MOBILE_SYSTEM_DOMAIN)
					+ getUrlForType(type);
		}
		GetTypeUrlVO getTypeUrlVO = new GetTypeUrlVO(helpAddress);
		return super.encapsulateParam(getTypeUrlVO, AppMsgBean.MsgCode.SUCCESS, "获取地址成功");
	}

	private String getUrlForTypeCode(String typeCode) {
		switch (typeCode) {
		case SystemContext.ProductDomain.H5PAGETYPE_ABOUT_US:
			return ABOUT_US_URL;
		case SystemContext.ProductDomain.H5PAGETYPE_COMMON_QUESTION:
			return FAQ_URL;
		case SystemContext.ProductDomain.H5PAGETYPE_PARTNER_JOIN:
			return PARTNER_URL;
		case SystemContext.ProductDomain.H5PAGETYPE_UPGRADE_VIP_NEW:
			return VIP_UPGRADE_NEW_URL;
		case SystemContext.ProductDomain.H5PAGETYPE_REGISTER_GIFT:
			return REGISTER_GIFT_URL;
		case SystemContext.ProductDomain.H5PAGETYPE_SHARE_PAGE:
			return SHARE_GIFT_URL;
		default:
			return "";
		}
	}

	private String getUrlForType(Integer type) {
		switch (type) {
		case 1:
			return ABOUT_US_URL;
		case 2:
			return FAQ_URL;
		case 3:
			return PARTNER_URL;
		default:
			return "";
		}
	}
}
