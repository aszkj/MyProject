package com.yilidi.o2o.controller.mobile.buyer.pay;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.pay.AliPayAppOrderParam;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.payment.alipay.config.AlipayConfig;
import com.yilidi.o2o.core.payment.alipay.sign.RSA;
import com.yilidi.o2o.core.payment.alipay.util.AlipayCore;
import com.yilidi.o2o.core.payment.alipay.util.AlipayNotify;
import com.yilidi.o2o.core.payment.tencent.WXPay;
import com.yilidi.o2o.core.payment.tencent.common.Signature;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderResData;
import com.yilidi.o2o.core.payment.tencent.service.CloseOrderService;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemDto;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 支付宝支付
 * 
 * @author simpson
 * 
 */
@Controller("buyerAliPayController")
@RequestMapping(value = "/interfaces/buyer")
public class AliPayController extends BuyerBaseController {

	private static final String ALI_BODY = "body";
	private static final String ALI_SUBJECT = "subject";
	private static final String ALI_OUT_TRADE_NO = "out_trade_no";
	private static final String ALI_PARTNER = "partner";
	private static final String ALI_NOTIFY_URL = "notify_url";
	private static final String ALI_TOTAL_FEE = "total_fee";
	private static final String ALI_SERVICE = "service";
	private static final String ALI_INPUT_CHARSET = "_input_charset";
	private static final String ALI_PAYMENT_TYPE = "payment_type";
	private static final String ALI_SELLER_ID = "seller_id";
	private static final String ALI_IT_B_PAY = "it_b_pay";
	private static final String ALI_SIGN = "sign";
	private static final String ALI_SIGN_TYPE = "sign_type";
	private static final String ALI_TRADE_NO = "trade_no";
	private static final String ALI_TRADE_STATUS = "trade_status";
	private static final String ALI_BUYER_ID = "buyer_id";
	private static final String ALI_BUYER_EMAIL = "buyer_email";

	@Autowired
	private IOrderService orderService;
	@Autowired
	private IPayLogService payLogService;
	@Autowired
	private IMessageService messageService;
	@Autowired
	private IUserService userService;

	private String getKeyParam(String s) {
		StringBuilder resultBuilder = new StringBuilder();
		resultBuilder.append(CommonConstants.DELIMITER_DQM).append(s).append(CommonConstants.DELIMITER_DQM);
		return resultBuilder.toString();
	}

	/**
	 * 组装待签名的参数MAP
	 */
	private Map<String, String> getParameterMap(PayLogDto payLogDto, SaleOrderDetailDto saleOrderDetailDto) {
		Map<String, String> map = new HashMap<String, String>();
		StringBuffer subj = new StringBuffer();
		for (SaleOrderItemDto itemVO : saleOrderDetailDto.getItems()) {
			subj.append(itemVO.getProductClassName()).append(itemVO.getProductName()).append(" ")
					.append(itemVO.getQuantity()).append("件 ");
		}
		SaleOrderDto saleOrderDto = saleOrderDetailDto.getSaleOrderDto();
		map.put(ALI_BODY, getKeyParam(subj.toString()));
		map.put(ALI_SUBJECT, getKeyParam(payLogDto.getContent()));
		map.put(ALI_OUT_TRADE_NO, getKeyParam(payLogDto.getPayLogOrderNo()));
		map.put(ALI_PARTNER, getKeyParam(AlipayConfig.PARTNER_ID));
		try {
			StringBuilder notifyUrlBuilder = new StringBuilder();
			notifyUrlBuilder.append(getBuyerSystemDomain()).append(AlipayConfig.NOTIFY_URL);
			map.put(ALI_NOTIFY_URL, getKeyParam(URLEncoder.encode(notifyUrlBuilder.toString(), CommonConstants.UTF_8)));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		map.put(ALI_TOTAL_FEE, getKeyParam(ArithUtils.convertToYuanStr(saleOrderDto.getOrderTotalAmount())));
		map.put(ALI_SERVICE, getKeyParam("mobile.securitypay.pay"));
		map.put(ALI_INPUT_CHARSET, getKeyParam(CommonConstants.UTF_8));
		map.put(ALI_PAYMENT_TYPE, getKeyParam("1"));
		map.put(ALI_SELLER_ID, getKeyParam(AlipayConfig.DEFAULT_SELLER));
		map.put(ALI_IT_B_PAY, getKeyParam("24h"));
		return map;
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
	@RequestMapping(value = "/pay/alipayapporderparam")
	@ResponseBody
	public ResultParamModel alipayAppOrderParam(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		AliPayAppOrderParam aliPayAppOrderParam = super.getEntityParam(req, AliPayAppOrderParam.class);

		SaleOrderDetailDto saleOrderDetailDto = orderService.findOrderDetailByOrderNo(aliPayAppOrderParam.getSaleOrderNo());
		if (ObjectUtils.isNullOrEmpty(saleOrderDetailDto)) {
			return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "查询不到订单信息");
		}

		SaleOrderDto saleOrderDto = saleOrderDetailDto.getSaleOrderDto();
		if (!SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY.equals(saleOrderDto.getStatusCode())) {
			return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "订单为非待付款订单，不能支付");
		}

		Date nowDate = new Date();
		// 获取带支付日志
		List<PayLogDto> payLogDtos = payLogService.listPayLogs(saleOrderDto.getSaleOrderNo());
		if (!ObjectUtils.isNullOrEmpty(payLogDtos)) {
			// 查询有尚未支付的支付订单信息，判断是否为本支付渠道，如果为本支付渠道，判断是否大于一个小时，如果在一个小时内，则直接返回统一订单信息。
			// 如果超过一个小时，则关闭本次支付日志，新生成一次支付日志信息。如果为非本支付渠道，则关闭支付订单。
			for (PayLogDto payLogDto : payLogDtos) {
				boolean isJsPublishPay = SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXINPUBLIC.equals(payLogDto
						.getPayPlatformCode());
				if (SystemContext.OrderDomain.SALEORDERPAYPLATFORM_WEIXIN.equals(payLogDto.getPayPlatformCode())
						|| isJsPublishPay) {
					// 直接关闭微信订单
					CloseOrderReqData closeOrderReqData = new CloseOrderReqData(payLogDto.getPayLogOrderNo(), isJsPublishPay);
					String closeOrderServiceResponseString = WXPay.requestCloseOrderService(closeOrderReqData);

					logger.info("关闭订单API返回的数据如下：");
					logger.info(closeOrderServiceResponseString);

					// 将从API返回的XML数据映射到Java对象
					CloseOrderResData closeOrderResData = (CloseOrderResData) Util.getObjectFromXML(
							closeOrderServiceResponseString, CloseOrderResData.class);
					if (closeOrderResData == null || closeOrderResData.getReturn_code() == null) {
						logger.error("Case1:关闭订单请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
						return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "关闭订单请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
					}

					if (CloseOrderService.FAIL.equals(closeOrderResData.getReturn_code())) {
						// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
						logger.error("Case2:关闭订单API系统返回失败，失败信息为：" + closeOrderResData.getReturn_msg());
						return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE,
								"关闭订单API系统返回失败，失败信息为：" + closeOrderResData.getReturn_msg());
					} else {
						if (!Signature.checkIsSignValidFromResponseString(closeOrderServiceResponseString, isJsPublishPay)) {
							logger.error("Case3:关闭订单请求API返回的数据签名验证失败，有可能数据被篡改了");
							return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "关闭订单请求API返回的数据签名验证失败，有可能数据被篡改了");
						}
						if (CloseOrderService.SUCCESS.equals(closeOrderResData.getResult_code())) {
							// 业务层成功
							// 更新支付日志状态为已关闭
							PayLogDto updatePayLogDto = new PayLogDto();
							updatePayLogDto.setPayLogStatus(SystemContext.OrderDomain.PAYLOGSTATUS_CLOSE);
							payLogService.updatePayLogForMakeOrder(updatePayLogDto, payLogDto.getPayLogOrderNo());
						} else if (CloseOrderService.ORDERPAID.equals(closeOrderResData.getErr_code())) {
							// 订单已付款
							logger.error("Case4:支付订单已经付款");
							return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "支付订单已经付款，不能再次发起支付");
						} else {
							logger.error("出错，错误码：" + closeOrderResData.getErr_code() + "     错误信息："
									+ closeOrderResData.getErr_code_des());
							if (!CloseOrderService.ORDERCLOSED.equals(closeOrderResData.getErr_code())
									&& !CloseOrderService.ORDERNOTEXIST.equals(closeOrderResData.getErr_code())) {
								return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "关闭支付订单失败");
							}
						}
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

		// 保存支付日志信息
		PayLogDto savePayLogDto = new PayLogDto();
		StringBuilder contentBuilder = new StringBuilder();
		contentBuilder.append("支付宝支付，订单编号：").append(saleOrderDto.getSaleOrderNo()).append("，订单金额：")
				.append(ArithUtils.convertToYuanStr(saleOrderDto.getOrderTotalAmount())).append("元");
		savePayLogDto.setDeviceId(super.getDeviceId(req));
		savePayLogDto.setContent(contentBuilder.toString());
		savePayLogDto.setPayPlatformCode(SystemContext.OrderDomain.SALEORDERPAYPLATFORM_ALIPAY);
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
		savePayLogDto = payLogService.savePayLog(savePayLogDto);

		Map<String, String> paramMap = getParameterMap(savePayLogDto, saleOrderDetailDto);
		String key = AlipayCore.createLinkString(paramMap);
		String rsaKey = RSA.sign(key, AlipayConfig.PRIVATE_KEY, AlipayConfig.INPUT_CHARSET);
		try {
			rsaKey = URLEncoder.encode(rsaKey, CommonConstants.UTF_8);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		paramMap.put(ALI_SIGN, getKeyParam(rsaKey));
		paramMap.put(ALI_SIGN_TYPE, getKeyParam("RSA"));
		// 在生成签名完成以后组装的参数列表的时候需要进行URLencode转换对特殊的字符
		String alipayKey = AlipayCore.createLinkString(paramMap);

		PayLogDto payLogDto = new PayLogDto();
		payLogDto.setInterfaceContent(alipayKey);
		payLogService.updatePayLogForMakeOrder(payLogDto, savePayLogDto.getPayLogOrderNo());

		return super.encapsulateParam(alipayKey, AppMsgBean.MsgCode.SUCCESS, "获取微信支付PayReq成功");
	}

	/**
	 * 微信支付返回信息接口
	 * 
	 * @param req
	 *            HttpServletRequest
	 * @param resp
	 *            HttpServletResponse
	 */
	@RequestMapping(value = "/pay/alipayappnotify")
	@ResponseBody
	public void alipayAppNotify(HttpServletRequest req, HttpServletResponse resp) {
		try {
			// 获取支付宝GET过来反馈信息
			Map<String, String> params = new HashMap<String, String>();
			Map requestParams = req.getParameterMap();
			for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
				String name = (String) iter.next();
				String[] values = (String[]) requestParams.get(name);
				String valueStr = "";
				for (int i = 0; i < values.length; i++) {
					if (!"".equals(valueStr)) {
						valueStr += ",";
					}
					valueStr += values[i];
				}
				valueStr = new String(valueStr.getBytes(), "UTF-8");
				params.put(name, valueStr);
			}
			logger.info("支付返回信息：" + JsonUtils.toJsonString(params));
			// 商户订单号
			String outTradeNo = params.get(ALI_OUT_TRADE_NO);
			// 支付宝交易号
			String tradeNo = params.get(ALI_TRADE_NO);
			// 交易状态
			String tradeStatus = params.get(ALI_TRADE_STATUS);
			// 买家支付宝用户号
			String payerId = params.get(ALI_BUYER_ID);
			// 买家支付宝账号
			String payerEmail = params.get(ALI_BUYER_EMAIL);
			PayLogDto payLogDto = payLogService.loadByPayLogOrderNo(outTradeNo);
			if (ObjectUtils.isNullOrEmpty(payLogDto)) {
				logger.error("根据out_trade_no:" + outTradeNo + "查询不到支付日志信息");
				resp.getWriter().println("failure, can't query paylog info");
			}
			if (AlipayNotify.verify(params)) {
				logger.info("验证成功,开始开始判断交易状态状态");
				if ("TRADE_FINISHED".equals(tradeStatus) || "TRADE_SUCCESS".equals(tradeStatus)) {
					// 完成支付宝支付返回订单状态变更处理
					orderService.updateOrderOnlinePay(outTradeNo, tradeNo, payerId, payerEmail);
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
					logger.info("成功完成支付宝支付返回订单状态变更处理");
					resp.getWriter().println("success");
				} else {
					resp.getWriter().println("failure, not paid status");
				}
			} else {
				SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(payLogDto.getSaleOrderNo());
				logger.error("支付宝支付失败。支付宝回调验证失败，订单号： " + saleOrderDto.getSaleOrderNo());
				resp.getWriter().println("failure, verify error");
			}
		} catch (Exception e) {
			logger.error("支付宝异步通知失败", e);
		}
	}

}
