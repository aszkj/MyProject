package com.yilidi.o2o.core.payment.tencent.business;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.Log;
import com.yilidi.o2o.core.payment.tencent.common.Signature;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.common.report.ReporterFactory;
import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;
import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderResData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryResData;
import com.yilidi.o2o.core.payment.tencent.protocol.unifiedorder.UnifiedOrderReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.unifiedorder.UnifiedOrderResData;
import com.yilidi.o2o.core.payment.tencent.service.CloseOrderService;
import com.yilidi.o2o.core.payment.tencent.service.OrderQueryService;
import com.yilidi.o2o.core.payment.tencent.service.UnifiedOrderService;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 统一下单业务实现类
 * 
 * @author simpson
 * 
 */
public class UnifiedOrderBusiness {

	/**
	 * 构造器
	 * 
	 * @throws IllegalAccessException
	 *             非法访问异常
	 * @throws InstantiationException
	 *             实例化异常
	 * @throws ClassNotFoundException
	 *             类不存在异常
	 */
	public UnifiedOrderBusiness() throws IllegalAccessException, ClassNotFoundException, InstantiationException {
		unifiedOrderService = new UnifiedOrderService();
	}

	/**
	 * 统一下单结果侦听器
	 */
	public interface ResultListener {
		/**
		 * API返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
		 * 
		 * @param unifiedOrderResData
		 *            统一下单返回结果
		 */
		void onFailByReturnCodeError(UnifiedOrderResData unifiedOrderResData);

		/**
		 * API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
		 * 
		 * @param unifiedOrderResData
		 *            统一下单返回结果
		 */
		void onFailByReturnCodeFail(UnifiedOrderResData unifiedOrderResData);

		/**
		 * 统一下单请求API返回的数据签名验证失败，有可能数据被篡改了
		 * 
		 * @param unifiedOrderResData
		 *            统一下单返回结果
		 */
		void onFailBySignInvalid(UnifiedOrderResData unifiedOrderResData);

		/**
		 * 统一下单订单已经支付成功
		 */
		void onFailByOrderPaid();

		/**
		 * 统一下单订单已经退款成功
		 */
		void onFailByOrderRefund();

		/**
		 * 订单查询失败
		 * 
		 * @param orderQueryResData
		 *            订单查询返回结果
		 */
		void onFailByOrderQuery(OrderQueryResData orderQueryResData);

		/**
		 * 关闭订单失败
		 * 
		 * @param closeOrderResData
		 *            关闭订单返回结果
		 */
		void onFailByCloseOrder(CloseOrderResData closeOrderResData);

		/**
		 * 关闭订单成功
		 * 
		 * @param outTradeNo
		 *            支付订单编码
		 * @param closeOrderResData
		 *            关闭订单返回结果
		 */
		void onCloseOrderSuccess(String outTradeNo, CloseOrderResData closeOrderResData);

		/**
		 * 统一下单失败
		 * 
		 * @param unifiedOrderResData
		 *            统一下单返回结果
		 */
		void onUnifiedOrderFail(UnifiedOrderResData unifiedOrderResData);

		/**
		 * 统一下单成功
		 * 
		 * @param unifiedOrderResData
		 *            统一下单返回结果
		 */
		void onUnifiedOrderSuccess(String outTradeNo, UnifiedOrderResData unifiedOrderResData);

	}

	// 打log用
	private static Log log = new Log(Logger.getLogger(UnifiedOrderBusiness.class));

	private UnifiedOrderService unifiedOrderService;

	private OrderQueryService orderQueryService;

	private CloseOrderService closeOrderService;

	/**
	 * 调用统一下单业务逻辑
	 * 
	 * @param unifiedOrderReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            业务逻辑可能走到的结果分支，需要商户处理
	 * @throws Exception
	 *             异常
	 */
	public void run(UnifiedOrderReqData unifiedOrderReqData, ResultListener resultListener) throws Exception {

		// 判断是否带有attach，如果有attach证明为有生成过支付订单，需要查询支付订单状态，并对支付订单进行关闭订单操作，再生成新的支付订单
		if (StringUtils.isNotEmpty(unifiedOrderReqData.getAttach())) {
			// 查询支付订单状态
			boolean isJsApi = Configure.JS_TRADE_TYPE.equals(unifiedOrderReqData.getTrade_type());
			String orderQueryResult = doOrderQuery(unifiedOrderReqData.getAttach(), isJsApi, resultListener);
			if ("NOTPAY".equals(orderQueryResult)) {
				// 关闭订单
				String closeOrderResult = doCloseOrder(unifiedOrderReqData.getAttach(), isJsApi, resultListener);
				if (CloseOrderService.ORDERPAID.equals(closeOrderResult)) {
					resultListener.onFailByOrderPaid();
					return;
				} else if (!CloseOrderService.ORDERCLOSED.equals(closeOrderResult)
						&& !CloseOrderService.ORDERNOTEXIST.equals(closeOrderResult)
						&& !CloseOrderService.SUCCESS.equals(closeOrderResult)) {
					return;
				}
			} else if (OrderQueryService.SUCCESS.equals(orderQueryResult)) {
				resultListener.onFailByOrderPaid();
				return;
			} else if ("REFUND".equals(orderQueryResult)) {
				resultListener.onFailByOrderRefund();
				return;
			} else if (StringUtils.EMPTY.equals(orderQueryResult)) {
				return;
			}
		}

		// --------------------------------------------------------------------
		// 构造请求“统一下单API”所需要提交的数据
		// --------------------------------------------------------------------

		// API返回的数据
		String unifiedOrderServiceResponseString;

		long costTimeStart = System.currentTimeMillis();

		log.i("统一下单API返回的数据如下：");
		unifiedOrderServiceResponseString = unifiedOrderService.request(unifiedOrderReqData);

		long costTimeEnd = System.currentTimeMillis();
		int totalTimeCost = (int) (costTimeEnd - costTimeStart);
		log.i("api请求总耗时：" + totalTimeCost + UnifiedOrderService.MS_STR);

		log.i(unifiedOrderServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		UnifiedOrderResData unifiedOrderResData = (UnifiedOrderResData) Util.getObjectFromXML(
				unifiedOrderServiceResponseString, UnifiedOrderResData.class);
		
		boolean isJsApi = Configure.JS_TRADE_TYPE.equals(unifiedOrderResData.getTrade_type());
		log.i("该次请求微信支付统一下单信息返回的支付方式为：" + (isJsApi ? "JS公众号支付" : "APP支付"));
		ReportReqData reportReqData = new ReportReqData(unifiedOrderResData.getDevice_info(), Configure.UNIFIED_ORDER_API,
				totalTimeCost, unifiedOrderResData.getReturn_code(), unifiedOrderResData.getReturn_msg(),
				unifiedOrderResData.getResult_code(), unifiedOrderResData.getErr_code(),
				unifiedOrderResData.getErr_code_des(), "", Configure.getIP(), isJsApi);

		long timeAfterReport;
		if (Configure.isUseThreadToDoReport()) {
			ReporterFactory.getReporter(reportReqData).run();
			timeAfterReport = System.currentTimeMillis();
			Util.log("refund+report总耗时（异步方式上报）：" + (timeAfterReport - costTimeStart) + UnifiedOrderService.MS_STR);
		} else {
			ReportService.request(reportReqData);
			timeAfterReport = System.currentTimeMillis();
			Util.log("refund+report总耗时（同步方式上报）：" + (timeAfterReport - costTimeStart) + UnifiedOrderService.MS_STR);
		}

		if (unifiedOrderResData == null || unifiedOrderResData.getReturn_code() == null) {
			setResult("Case1:统一下单API请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问", Log.LOG_TYPE_ERROR);
			resultListener.onFailByReturnCodeError(unifiedOrderResData);
			return;
		}

		// Debug:查看数据是否正常被填充到scanPayResponseData这个对象中
		// Util.reflect(refundResData);

		if (UnifiedOrderService.FAIL.equals(unifiedOrderResData.getReturn_code())) {
			// /注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			setResult("Case2:统一下单API系统返回失败，请检测Post给API的数据是否规范合法", Log.LOG_TYPE_ERROR);
			resultListener.onFailByReturnCodeFail(unifiedOrderResData);
		} else {
			log.i("统一下单API系统成功返回数据");
			// --------------------------------------------------------------------
			// 收到API的返回数据的时候得先验证一下数据有没有被第三方篡改，确保安全
			// --------------------------------------------------------------------

			if (!Signature.checkIsSignValidFromResponseString(unifiedOrderServiceResponseString, isJsApi)) {
				setResult("Case3:统一下单请求API返回的数据签名验证失败，有可能数据被篡改了", Log.LOG_TYPE_ERROR);
				resultListener.onFailBySignInvalid(unifiedOrderResData);
				return;
			}

			if (UnifiedOrderService.FAIL.equals(unifiedOrderResData.getResult_code())) {
				makeErrorLog(unifiedOrderResData.getErr_code(), unifiedOrderResData.getErr_code_des());
				setResult("Case4:【统一下单失败】", Log.LOG_TYPE_ERROR);
				// 统一下单失败
				resultListener.onUnifiedOrderFail(unifiedOrderResData);
			} else {
				// 统一下单成功
				setResult("Case5:【统一下单成功】", Log.LOG_TYPE_INFO);
				resultListener.onUnifiedOrderSuccess(unifiedOrderReqData.getOut_trade_no(), unifiedOrderResData);
			}
		}
	}

	private void makeErrorLog(String errCode, String errCodeDes) {
		log.i("出错，错误码：" + errCode + "     错误信息：" + errCodeDes);
	}

	/**
	 * 进行一次支付订单查询操作
	 * 
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @return 状态字符串
	 * @throws Exception
	 */
	private String doOrderQuery(String outTradeNo, boolean isJsApi, ResultListener resultListener) throws Exception {
		String orderQueryServiceResponseString;

		OrderQueryReqData orderQueryReqData = new OrderQueryReqData("", outTradeNo, isJsApi);
		orderQueryServiceResponseString = orderQueryService.request(orderQueryReqData);

		log.i("支付订单查询API返回的数据如下：");
		log.i(orderQueryServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		OrderQueryResData orderQueryResData = (OrderQueryResData) Util.getObjectFromXML(orderQueryServiceResponseString,
				OrderQueryResData.class);
		if (orderQueryResData == null || orderQueryResData.getReturn_code() == null) {
			log.i("支付订单查询请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
			resultListener.onFailByOrderQuery(orderQueryResData);
			return StringUtils.EMPTY;
		}

		if (OrderQueryService.FAIL.equals(orderQueryResData.getReturn_code())) {
			// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			log.i("支付订单查询API系统返回失败，失败信息为：" + orderQueryResData.getReturn_msg());
			resultListener.onFailByOrderQuery(orderQueryResData);
			return StringUtils.EMPTY;
		} else {
			if (!Signature.checkIsSignValidFromResponseString(orderQueryServiceResponseString, isJsApi)) {
				setResult("查询订单请求API返回的数据签名验证失败，有可能数据被篡改了", Log.LOG_TYPE_ERROR);
				resultListener.onFailByOrderQuery(orderQueryResData);
				return OrderQueryService.SIGNERROR;
			}

			if (OrderQueryService.SUCCESS.equals(orderQueryResData.getResult_code())) {
				// 业务层成功
				return orderQueryResData.getTrade_state();
			} else {
				makeErrorLog(orderQueryResData.getErr_code(), orderQueryResData.getErr_code_des());
				if (!OrderQueryService.ORDERNOTEXIST.equals(orderQueryResData.getErr_code())) {
					resultListener.onFailByOrderQuery(orderQueryResData);
				}
				return orderQueryResData.getErr_code();
			}
		}
	}

	/**
	 * 进行一次支付订单查询操作
	 * 
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @return 状态字符串
	 * @throws Exception
	 */
	private String doCloseOrder(String outTradeNo, boolean isJsApi, ResultListener resultListener) throws Exception {

		CloseOrderReqData closeOrderReqData = new CloseOrderReqData(outTradeNo, isJsApi);
		String closeOrderServiceResponseString = closeOrderService.request(closeOrderReqData);

		log.i("关闭订单API返回的数据如下：");
		log.i(closeOrderServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		CloseOrderResData closeOrderResData = (CloseOrderResData) Util.getObjectFromXML(closeOrderServiceResponseString,
				CloseOrderResData.class);
		if (closeOrderResData == null || closeOrderResData.getReturn_code() == null) {
			log.i("关闭订单请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
			resultListener.onFailByCloseOrder(closeOrderResData);
			return StringUtils.EMPTY;
		}

		if (CloseOrderService.FAIL.equals(closeOrderResData.getReturn_code())) {
			// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			log.i("关闭订单API系统返回失败，失败信息为：" + closeOrderResData.getReturn_msg());
			resultListener.onFailByCloseOrder(closeOrderResData);
			return StringUtils.EMPTY;
		} else {
			if (!Signature.checkIsSignValidFromResponseString(closeOrderServiceResponseString, isJsApi)) {
				setResult("关闭订单请求API返回的数据签名验证失败，有可能数据被篡改了", Log.LOG_TYPE_ERROR);
				resultListener.onFailByCloseOrder(closeOrderResData);
				return OrderQueryService.SIGNERROR;
			}
			if (CloseOrderService.SUCCESS.equals(closeOrderResData.getResult_code())) {
				// 业务层成功
				resultListener.onCloseOrderSuccess(outTradeNo, closeOrderResData);
				return CloseOrderService.SUCCESS;
			} else {
				makeErrorLog(closeOrderResData.getErr_code(), closeOrderResData.getErr_code_des());
				if (!CloseOrderService.ORDERPAID.equals(closeOrderResData.getErr_code())
						&& !CloseOrderService.ORDERCLOSED.equals(closeOrderResData.getErr_code())
						&& !CloseOrderService.ORDERNOTEXIST.equals(closeOrderResData.getErr_code())) {
					resultListener.onFailByCloseOrder(closeOrderResData);
				}
				return closeOrderResData.getErr_code();
			}
		}
	}

	public void setUnifiedOrderService(UnifiedOrderService service) {
		unifiedOrderService = service;
	}

	private void setResult(String result, String type) {
		log.log(type, result);
	}

}
