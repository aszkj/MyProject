package com.yilidi.o2o.controller.mobile.buyer.pay;

import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.pay.WXPayAppOrderParam;
import com.yilidi.o2o.appvo.buyer.pay.WxPayAppOrderParamVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.payment.tencent.WXPay;
import com.yilidi.o2o.core.payment.tencent.business.UnifiedOrderBusiness;
import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.Signature;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderResData;
import com.yilidi.o2o.core.payment.tencent.protocol.notify.NotifyResData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryResData;
import com.yilidi.o2o.core.payment.tencent.protocol.unifiedorder.UnifiedOrderReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.unifiedorder.UnifiedOrderResData;
import com.yilidi.o2o.core.payment.tencent.service.UnifiedOrderService;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.user.service.IConnectUserService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 微信支付
 * 
 * @author simpson
 * 
 */
@Controller("buyerWXPayController")
@RequestMapping(value = "/interfaces/buyer")
@Scope("prototype")
public class WXPayController extends BuyerBaseController {

	@Autowired
	private IOrderService orderService;
	@Autowired
	private IPayLogService payLogService;
	@Autowired
	private IMessageService messageService;
	@Autowired
	private IUserService userService;
	@Autowired
	private IConnectUserService connectUserService;

	private ResultParamModel resultParamModel;

	private static final String PACKAGE = "Sign=WXPay";

	private PayLogDto savePayLogDto(SaleOrderDto saleOrderDto, Date nowDate, String deviceId) {
		PayLogDto savePayLogDto = new PayLogDto();
		StringBuilder contentBuilder = new StringBuilder();
		contentBuilder.append("微信支付，订单编号：").append(saleOrderDto.getSaleOrderNo()).append("，订单金额：")
				.append(ArithUtils.convertToYuanStr(saleOrderDto.getOrderTotalAmount())).append("元");
		savePayLogDto.setDeviceId(deviceId);
		savePayLogDto.setContent(contentBuilder.toString());
		String payPlatformCode = SystemContext.UserDomain.CHANNELTYPE_WEIXIN.equals(saleOrderDto.getChannelCode()) ? SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXINPUBLIC
				: SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXIN;
		savePayLogDto.setPayPlatformCode(payPlatformCode);
		savePayLogDto.setCreateTime(nowDate);
		savePayLogDto.setCreateUserId(saleOrderDto.getUserId());
		savePayLogDto.setPayLogOrderNo(StringUtils.generatePayLogOrderNo());
		savePayLogDto.setPayLogType(SystemContext.OrderDomain.PAYLOGTYPE_PAY);
		savePayLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_INIT);
		savePayLogDto.setPayPrice(saleOrderDto.getOrderTotalAmount());
		savePayLogDto.setSaleOrderNo(saleOrderDto.getSaleOrderNo());
		savePayLogDto.setUserId(saleOrderDto.getUserId());
		//savePayLogDto.setUserName(saleOrderDto.getUserName());
		savePayLogDto.setOperUserType(SystemContext.OrderDomain.PAYLOGOPERUSERTYPE_BUYER);
		return payLogService.savePayLog(savePayLogDto);
	}

	private WxPayAppOrderParamVO makeWxPayAppOrderParamVO(String prepayId, String noncestr, boolean isJsInvoke) {
		String timestamp = String.valueOf(System.currentTimeMillis() / 1000);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (isJsInvoke) {
			// 微信公众号方式加密
			paramMap.put("appId", Configure.getAppid(isJsInvoke));
			paramMap.put("package", "prepay_id=" + prepayId);
			paramMap.put("nonceStr", noncestr);
			paramMap.put("signType", "MD5");
			paramMap.put("timeStamp", timestamp);
		} else {
			// 微信APP方式加密
			paramMap.put("appid", Configure.getAppid(isJsInvoke));
			paramMap.put("partnerid", Configure.getMchid(isJsInvoke));
			paramMap.put("prepayid", prepayId);
			paramMap.put("package", PACKAGE);
			paramMap.put("noncestr", noncestr);
			paramMap.put("timestamp", timestamp);
		}
		// 生成签名
		String sign = Signature.getSign(paramMap, isJsInvoke);
		paramMap.put("sign", sign);
		logger.info("支付接口信息：" + JsonUtils.toJsonString(paramMap));
		WxPayAppOrderParamVO wxPayAppOrderParamVO = new WxPayAppOrderParamVO();
		wxPayAppOrderParamVO.setAppId(Configure.getAppid(isJsInvoke));
		wxPayAppOrderParamVO.setNonceStr(noncestr);
		wxPayAppOrderParamVO.setPackageValue(PACKAGE);
		wxPayAppOrderParamVO.setPartnerId(Configure.getMchid(isJsInvoke));
		wxPayAppOrderParamVO.setPrepayId(prepayId);
		wxPayAppOrderParamVO.setTimeStamp(timestamp);
		wxPayAppOrderParamVO.setSign(sign);

		return wxPayAppOrderParamVO;
	}

	/**
	 * 微信支付信息接口
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param resp
	 *            HttpServletResponse
	 * @return ResultParamModel
	 * @throws Exception
	 *             异常
	 */
	@RequestMapping(value = "/pay/wxpayapporderparam")
	@ResponseBody
	public ResultParamModel wxpayAppOrderParam(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		WXPayAppOrderParam wxPayAppOrderParam = super.getEntityParam(req, WXPayAppOrderParam.class);
		boolean isJSInvoke = Configure.JS_TRADE_TYPE.equals(wxPayAppOrderParam.getTradeType());
		String openId = "";
		if (isJSInvoke) {
			UserSessionModel userSession = SessionUtils.getBuyerUserSession();
			if (ObjectUtils.isNullOrEmpty(userSession) || userSession.getUserId() == null) {
				return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "session失效");
			}
			ConnectUserDto connectUserDto = connectUserService.loadByUserIdAndConnectType(userSession.getUserId(),
					SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
			if (connectUserDto == null) {
				return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "微信公众号支付无法获取到相关支付信息，请重新登录后重试");
			}
			openId = connectUserDto.getOpenId();
		}

		SaleOrderDetailDto saleOrderDetailDto = orderService.findOrderDetailByOrderNo(wxPayAppOrderParam.getSaleOrderNo());
		if (ObjectUtils.isNullOrEmpty(saleOrderDetailDto)) {
			return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "查询不到订单信息");
		}
		SaleOrderDto saleOrderDto = saleOrderDetailDto.getSaleOrderDto();
		if (!SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY.equals(saleOrderDto.getStatusCode())) {
			return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "订单为非待付款订单，不能支付");
		}

		Date nowDate = new Date();
		boolean isNeedNewPayLog = true;
		String attachString = "";
		String payPlatformOrderId = "";
		String noneStr = "";
		// 获取带支付日志
		List<PayLogDto> payLogDtos = payLogService.listPayLogs(saleOrderDto.getSaleOrderNo());
		if (!ObjectUtils.isNullOrEmpty(payLogDtos)) {
			// 查询有尚未支付的支付订单信息，判断是否为本支付渠道，如果为本支付渠道，判断是否大于一个小时，如果在一个小时内，则直接返回统一订单信息。
			// 如果超过一个小时，则关闭本次支付日志，新生成一次支付日志信息。如果为非本支付渠道，则关闭支付订单。
			for (PayLogDto payLogDto : payLogDtos) {
				if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXIN.equals(payLogDto.getPayPlatformCode())) {
					if (DateUtils.secondsBetween(nowDate, payLogDto.getCreateTime()) > 60 * 60 * 100) {
						// 重新生成支付日志和支付订单
						attachString = payLogDto.getPayLogOrderNo();
					} else {
						isNeedNewPayLog = false;
						payPlatformOrderId = payLogDto.getPayPlatformOrderId();
						noneStr = payLogDto.getReturnContent();
					}
				} else if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_ALIPAY.equals(payLogDto.getPayPlatformCode())) {
					// 直接关闭支付宝订单
					// AlipayClient alipayClient = new
					// DefaultAlipayClient(AlipayConfig.OPEN_ALIPAY_URL,
					// AlipayConfig.APP_ID,
					// AlipayConfig.APP_PRIVATE_KEY, "json",
					// AlipayConfig.INPUT_CHARSET,
					// AlipayConfig.APP_ALI_PUBLIC_KEY);
					// AlipayTradeCloseRequest request = new
					// AlipayTradeCloseRequest();
					// StringBuilder alipayBuilder = new StringBuilder();
					// alipayBuilder.append("{\"out_trade_no\":\"").append(payLogDto.getPayLogOrderNo()).append("\"}");
					// request.setBizContent(alipayBuilder.toString());
					// AlipayTradeCloseResponse response =
					// alipayClient.execute(request);
					// if (!response.isSuccess()) {
					// return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE,
					// "关闭支付宝支付订单失败");
					// }
					// // 更新支付日志状态为已关闭
					// PayLogDto updatePayLogDto = new PayLogDto();
					// updatePayLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_CLOSE);
					// payLogService.updatePayLogForMakeOrder(updatePayLogDto,
					// payLogDto.getPayLogOrderNo());
				}
			}
		}

		if (isNeedNewPayLog) {
			final WXPayController that = this;
			// 保存支付日志信息
			Long totalFee = ArithUtils.convertToFen(saleOrderDto.getOrderTotalAmount());
			String deviceId = super.getDeviceId(req);
			StringBuffer detail = new StringBuffer();
			for (SaleOrderItemDto itemVO : saleOrderDetailDto.getItems()) {
				detail.append(itemVO.getProductClassName()).append(itemVO.getProductName()).append(" ")
						.append(itemVO.getQuantity()).append("件 ");
			}
			StringBuilder notifyUrlBuilder = new StringBuilder();
			notifyUrlBuilder.append(getBuyerSystemDomain()).append(Configure.NOTIFY_URL);
			PayLogDto savePayLogDto = savePayLogDto(saleOrderDto, nowDate, deviceId);
			UnifiedOrderReqData unifiedOrderReqData = new UnifiedOrderReqData(savePayLogDto.getPayLogOrderNo(),
					totalFee.intValue(), deviceId, savePayLogDto.getContent(), detail.toString(), attachString,
					super.getRealIP(req), "", "", notifyUrlBuilder.toString(), wxPayAppOrderParam.getTradeType(), openId);
			UnifiedOrderBusiness.ResultListener resultListener = new UnifiedOrderBusiness.ResultListener() {

				@Override
				public void onUnifiedOrderSuccess(String outTradeNo, UnifiedOrderResData unifiedOrderResData) {
					boolean isJsInvoke = Configure.JS_TRADE_TYPE.equals(unifiedOrderResData.getTrade_type());
					logger.info("该次请求微信支付统一下单信息返回的支付方式为：" + (isJsInvoke ? "JS公众号支付" : "APP支付"));
					WxPayAppOrderParamVO wxPayAppOrderParamVO = makeWxPayAppOrderParamVO(unifiedOrderResData.getPrepay_id(),
							unifiedOrderResData.getNonce_str(), isJsInvoke);
					// 更新支付日志
					PayLogDto updatePayLogDto = new PayLogDto();
					updatePayLogDto.setPayPlatformOrderId(unifiedOrderResData.getPrepay_id());
					updatePayLogDto.setReturnContent(unifiedOrderResData.getNonce_str());
					payLogService.updatePayLogForMakeOrder(updatePayLogDto, outTradeNo);
					resultParamModel = that.encapsulateParam(wxPayAppOrderParamVO, AppMsgBean.MsgCode.SUCCESS,
							"成功生成统一下单，并获取微信支付信息成功");
				}

				@Override
				public void onUnifiedOrderFail(UnifiedOrderResData unifiedOrderResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "微信统一下单失败");
				}

				@Override
				public void onFailBySignInvalid(UnifiedOrderResData unifiedOrderResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "统一下单请求API返回的数据签名验证失败，有可能数据被篡改了");
				}

				@Override
				public void onFailByReturnCodeFail(UnifiedOrderResData unifiedOrderResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE,
							"统一下单API系统返回失败，请检测Post给API的数据是否规范合法");
				}

				@Override
				public void onFailByReturnCodeError(UnifiedOrderResData unifiedOrderResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE,
							"统一下单API请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问");
				}

				@Override
				public void onFailByOrderRefund() {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "微信支付订单已经进入退款，不能发起支付");
				}

				@Override
				public void onFailByOrderQuery(OrderQueryResData orderQueryResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "获取微信支付信息失败");
				}

				@Override
				public void onFailByOrderPaid() {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "微信支付订单已经完成付款，不能发起支付");
				}

				@Override
				public void onFailByCloseOrder(CloseOrderResData closeOrderResData) {
					resultParamModel = that.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "关闭微信支付订单失败");
				}

				@Override
				public void onCloseOrderSuccess(String outTradeNo, CloseOrderResData closeOrderResData) {
					// 更新支付日志状态为已关闭
					PayLogDto updatePayLogDto = new PayLogDto();
					updatePayLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_CLOSE);
					payLogService.updatePayLogForMakeOrder(updatePayLogDto, outTradeNo);
				}
			};
			WXPay.doUnifiedOrderBusiness(unifiedOrderReqData, resultListener);
		} else {
			resultParamModel = super.encapsulateParam(makeWxPayAppOrderParamVO(payPlatformOrderId, noneStr, isJSInvoke),
					AppMsgBean.MsgCode.SUCCESS, "获取微信支付信息成功");
		}

		return resultParamModel;
	}

	/**
	 * 微信支付返回信息接口
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param resp
	 *            HttpServletResponse
	 * @return ResultParamModel
	 */
	@RequestMapping(value = "/pay/wxpayappnotify")
	@ResponseBody
	public ResultParamModel wxpayAppNotify(HttpServletRequest req, HttpServletResponse resp) {
		try {
			String xmlString = new String(Util.readInput(req.getInputStream()), "utf-8");

			logger.info("支付订单查询API返回的数据如下：");
			logger.info(xmlString);

			// 将从API返回的XML数据映射到Java对象
			NotifyResData notifyResData = (NotifyResData) Util.getObjectFromXML(xmlString, NotifyResData.class);

			if (notifyResData == null || notifyResData.getReturn_code() == null) {
				logger.error("Case1:【支付通知返回请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问】");
				resp.getWriter().write(
						makeResponseString(UnifiedOrderService.FAIL, "支付通知返回请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问"));
				return null;
			}

			if (UnifiedOrderService.FAIL.equals(notifyResData.getReturn_code())) {
				// /注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
				logger.error("Case2:【支付通知返回失败，请检测Post给API的数据是否规范合法】");
				resp.getWriter().write(makeResponseString(UnifiedOrderService.FAIL, "支付通知返回失败，请检测Post给API的数据是否规范合法"));
				return null;
			} else {
				logger.info("支付通知返回成功返回数据");
				PayLogDto payLogDto = payLogService.loadByPayLogOrderNo(notifyResData.getOut_trade_no());
				if (null == payLogDto) {
					logger.info("支付通知返回在校验之前确定其支付平台数据信息时无法找到支付日志信息。");
				}
				boolean isJs = null != payLogDto
						&& SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXINPUBLIC
								.equals(payLogDto.getPayPlatformCode());// 是否是JS-微信公众号平台支付类型
				logger.info("支付通知返回的支付类型为：" + (isJs ? "微信公众号支付" : "微信APP支付"));
				// --------------------------------------------------------------------
				// 收到API的返回数据的时候得先验证一下数据有没有被第三方篡改，确保安全
				// --------------------------------------------------------------------
				if (!Signature.checkIsSignValidFromResponseString(xmlString, isJs)) {
					logger.error("Case3:【支付通知返回的数据签名验证失败，有可能数据被篡改了】");
					resp.getWriter().write(makeResponseString(UnifiedOrderService.FAIL, "支付通知返回的数据签名验证失败，有可能数据被篡改了"));
					return null;
				}

				if (UnifiedOrderService.FAIL.equals(notifyResData.getResult_code())) {
					logger.error("出错，错误码：" + notifyResData.getErr_code() + "     错误信息：" + notifyResData.getErr_code_des());
					logger.error("Case4:【支付失败】");
					// 更新支付日志状态为支付失败
					PayLogDto updatePayLogDto = new PayLogDto();
					updatePayLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_PAYFAILURE);
					payLogService.updatePayLogForMakeOrder(updatePayLogDto, notifyResData.getOut_trade_no());
				} else {
					// 统一下单成功
					logger.info("Case5:【支付成功】");
					// 完成微信支付返回的订单状态变更
					orderService.updateOrderOnlinePay(notifyResData.getOut_trade_no(), notifyResData.getTransaction_id(),
							notifyResData.getOpenid(), "");
					try {
						// 发送接单推送通知给卖家
		                SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(payLogDto.getSaleOrderNo());
		                Integer forAcceptOrderCount = orderService.getForAcceptOrderCount(saleOrderDto.getStoreId());
		                //获取所有可以接单的用户
		                List<Integer> userIdList = userService.getAcceptOrderUserId(saleOrderDto.getStoreId());
		                if (!ObjectUtils.isNullOrEmpty(userIdList)) {
		                    messageService.sendPushOrderMessage(PushTypeModelClassMapping.ORDERACCEPT, userIdList,
		                            null == forAcceptOrderCount ? "0" : Integer.toString(forAcceptOrderCount));
		                }
					} catch (Exception e) {
						logger.error("发送接单推送通知给卖家出现系统异常！", e);
					}
				}
				resp.getWriter().write(makeResponseString(UnifiedOrderService.SUCCESS, "OK"));
			}
		} catch (Exception e) {
			logger.error("微信支付回调失败！", e);
		}
		return null;
	}

	private String makeResponseString(String returnCode, String returnMsg) {
		StringBuilder resultBuilder = new StringBuilder();
		resultBuilder.append("<xml><return_code><![CDATA[").append(returnCode)
				.append("]]></return_code><return_msg><![CDATA[").append(returnMsg).append("]]></return_msg></xml>");
		return resultBuilder.toString();
	}
}
