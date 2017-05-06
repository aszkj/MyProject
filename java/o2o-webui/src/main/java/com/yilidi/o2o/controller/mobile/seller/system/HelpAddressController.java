package com.yilidi.o2o.controller.mobile.seller.system;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.system.HelpAddressParam;
import com.yilidi.o2o.appvo.seller.system.HelpAddressVO;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;

/**
 * 帮助地址Controller
 * 
 * @author: chenlian
 * @date: 2016年6月1日 上午11:42:57
 */
@Controller("sellerHelpAddressController")
@RequestMapping(value = "/interfaces/seller")
public class HelpAddressController extends SellerBaseController {

	/** 关于我们 **/
	private static final String ABOUT_US_URL = "/seller/about-us.html";
	/** 常见问题 **/
	private static final String FAQ_URL = "/seller/faq.html";

	/**
	 * 获取帮助中心地址
	 * 
	 * @param req
	 *            HttpServletRequest 实例对象
	 * @param resp
	 *            HttpServletResponse 实例对象
	 * @return ResultParamModel
	 */
	@SellerLoginValidation
	@RequestMapping(value = "/setting/helpaddress")
	@ResponseBody
	public ResultParamModel helpAddress(HttpServletRequest req, HttpServletResponse resp) {
		HelpAddressParam helpAddressParam = super.getEntityParam(req, HelpAddressParam.class);
		Integer type = helpAddressParam.getType();
		HelpAddressVO helpAddressVO = new HelpAddressVO();
		String helpAddress = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.MOBILE_SYSTEM_DOMAIN)
				+ getUrl(type);
		helpAddressVO.setValue(helpAddress);
		return super.encapsulateParam(helpAddressVO, AppMsgBean.MsgCode.SUCCESS, "获取帮助中心地址成功");
	}

	private String getUrl(Integer type) {
		switch (type) {
		case 1:
			return ABOUT_US_URL;
		case 2:
			return FAQ_URL;
		default:
			return "";
		}
	}
}
