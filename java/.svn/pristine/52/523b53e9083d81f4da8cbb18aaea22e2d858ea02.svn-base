package com.yilidi.o2o.core.payment.tencent.business;

import static java.lang.Thread.sleep;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.Log;
import com.yilidi.o2o.core.payment.tencent.common.Signature;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.common.report.ReporterFactory;
import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;
import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;
import com.yilidi.o2o.core.payment.tencent.protocol.micropay.MicroPayReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.micropay.MicroPayResData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryResData;
import com.yilidi.o2o.core.payment.tencent.protocol.reverse.ReverseReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.reverse.ReverseResData;
import com.yilidi.o2o.core.payment.tencent.service.MicroPayService;
import com.yilidi.o2o.core.payment.tencent.service.OrderQueryService;
import com.yilidi.o2o.core.payment.tencent.service.ReverseService;

/**
 * 刷卡支付业务实现类
 * 
 * @author simpson
 * 
 */
public class MicroPayBusiness {

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
	public MicroPayBusiness(boolean isJsApi) throws IllegalAccessException, ClassNotFoundException, InstantiationException {
		microPayService = new MicroPayService();
		orderQueryService = new OrderQueryService();
		reverseService = new ReverseService();
		this.isJsApi = isJsApi;
	}

	/**
	 * 刷卡支付结果侦听器
	 */
	public interface ResultListener {

		/**
		 * API返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailByReturnCodeError(MicroPayResData microPayResData);

		/**
		 * API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailByReturnCodeFail(MicroPayResData microPayResData);

		/**
		 * 支付请求API返回的数据签名验证失败，有可能数据被篡改了
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailBySignInvalid(MicroPayResData microPayResData);

		/**
		 * 用户用来支付的二维码已经过期，提示收银员重新扫一下用户微信“刷卡”里面的二维码
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailByAuthCodeExpire(MicroPayResData microPayResData);

		/**
		 * 授权码无效，提示用户刷新一维码/二维码，之后重新扫码支付"
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailByAuthCodeInvalid(MicroPayResData microPayResData);

		/**
		 * 用户余额不足，换其他卡支付或是用现金支付
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFailByMoneyNotEnough(MicroPayResData microPayResData);

		/**
		 * 支付失败
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onFail(MicroPayResData microPayResData);

		/**
		 * 支付成功
		 * 
		 * @param microPayResData
		 *            刷卡支付返回结果
		 */
		void onSuccess(MicroPayResData microPayResData);

	}

	// 打log用
	private static Log log = new Log(Logger.getLogger(MicroPayBusiness.class));

	/**
	 * 每次调用订单查询API时的等待时间，因为当出现支付失败的时候，如果马上发起查询不一定就能查到结果，所以这里建议先等待一定时间再发起查询
	 */
	private int waitingTimeBeforePayQueryServiceInvoked = 5000;

	/**
	 * 循环调用订单查询API的次数
	 */
	private int payQueryLoopInvokedCount = 3;

	/**
	 * 每次调用撤销API的等待时间
	 */
	private int waitingTimeBeforeReverseServiceInvoked = 5000;

	private MicroPayService microPayService;

	private OrderQueryService orderQueryService;

	private ReverseService reverseService;

	private boolean isJsApi = false;

	/**
	 * 直接执行被扫支付业务逻辑（包含最佳实践流程）
	 * 
	 * @param microPayReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            商户需要自己监听被扫支付业务逻辑可能触发的各种分支事件，并做好合理的响应处理
	 * @throws Exception
	 *             异常
	 */
	public void run(MicroPayReqData microPayReqData, ResultListener resultListener) throws Exception {

		// --------------------------------------------------------------------
		// 构造请求“被扫支付API”所需要提交的数据
		// --------------------------------------------------------------------

		String outTradeNo = microPayReqData.getOut_trade_no();

		// 接受API返回
		String payServiceResponseString;

		long costTimeStart = System.currentTimeMillis();

		log.i("支付API返回的数据如下：");
		payServiceResponseString = microPayService.request(microPayReqData);

		long costTimeEnd = System.currentTimeMillis();
		int totalTimeCost = (int) (costTimeEnd - costTimeStart);
		log.i("api请求总耗时：" + totalTimeCost + MicroPayService.MS_STR);

		// 打印回包数据
		log.i(payServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		MicroPayResData scanPayResData = (MicroPayResData) Util.getObjectFromXML(payServiceResponseString,
				MicroPayResData.class);

		// 异步发送统计请求
		ReportReqData reportReqData = new ReportReqData(microPayReqData.getDevice_info(), Configure.MICROPAY_API,
				totalTimeCost, scanPayResData.getReturn_code(), scanPayResData.getReturn_msg(),
				scanPayResData.getResult_code(), scanPayResData.getErr_code(), scanPayResData.getErr_code_des(),
				scanPayResData.getOut_trade_no(), microPayReqData.getSpbill_create_ip(), isJsApi);
		long timeAfterReport;
		if (Configure.isUseThreadToDoReport()) {
			ReporterFactory.getReporter(reportReqData).run();
			timeAfterReport = System.currentTimeMillis();
			log.i("micropay+report总耗时（异步方式上报）：" + (timeAfterReport - costTimeStart) + MicroPayService.MS_STR);
		} else {
			ReportService.request(reportReqData);
			timeAfterReport = System.currentTimeMillis();
			log.i("micropay+report总耗时（同步方式上报）：" + (timeAfterReport - costTimeStart) + MicroPayService.MS_STR);
		}

		if (scanPayResData == null || scanPayResData.getReturn_code() == null) {
			log.e("【支付失败】支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问");
			resultListener.onFailByReturnCodeError(scanPayResData);
			return;
		}

		if (MicroPayService.FAIL.equals(scanPayResData.getReturn_code())) {
			// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			log.e("【支付失败】支付API系统返回失败，请检测Post给API的数据是否规范合法");
			resultListener.onFailByReturnCodeFail(scanPayResData);
			return;
		} else {
			log.i("支付API系统成功返回数据");
			// --------------------------------------------------------------------
			// 收到API的返回数据的时候得先验证一下数据有没有被第三方篡改，确保安全
			// --------------------------------------------------------------------
			if (!Signature.checkIsSignValidFromResponseString(payServiceResponseString, isJsApi)) {
				log.e("【支付失败】支付请求API返回的数据签名验证失败，有可能数据被篡改了");
				resultListener.onFailBySignInvalid(scanPayResData);
				return;
			}

			// 获取错误码
			String errorCode = scanPayResData.getErr_code();
			// 获取错误描述
			String errorCodeDes = scanPayResData.getErr_code_des();

			if (MicroPayService.SUCCESS.equals(scanPayResData.getResult_code())) {

				// --------------------------------------------------------------------
				// 1)直接扣款成功
				// --------------------------------------------------------------------

				log.i("【一次性支付成功】");
				resultListener.onSuccess(scanPayResData);
			} else {

				// 出现业务错误
				log.i("业务返回失败");
				log.i("err_code:" + errorCode);
				log.i("err_code_des:" + errorCodeDes);

				// 业务错误时错误码有好几种，商户重点提示以下几种
				// --------------------------------------------------------------------
				// 2)扣款明确失败
				// --------------------------------------------------------------------
				String tipsPrefix = "【支付扣款明确失败】原因是：";
				// 以下几种情况建议明确提示用户，指导接下来的工作
				if ("AUTHCODEEXPIRE".equals(errorCode)) {
					// 对于扣款明确失败的情况直接走撤销逻辑
					doReverseLoop(outTradeNo);
					// 表示用户用来支付的二维码已经过期，提示收银员重新扫一下用户微信“刷卡”里面的二维码
					log.w(tipsPrefix + errorCodeDes);
					resultListener.onFailByAuthCodeExpire(scanPayResData);
				} else if ("AUTH_CODE_INVALID".equals(errorCode)) {
					// 对于扣款明确失败的情况直接走撤销逻辑
					doReverseLoop(outTradeNo);
					// 授权码无效，提示用户刷新一维码/二维码，之后重新扫码支付
					log.w(tipsPrefix + errorCodeDes);
					resultListener.onFailByAuthCodeInvalid(scanPayResData);
				} else if ("NOTENOUGH".equals(errorCode)) {
					// 对于扣款明确失败的情况直接走撤销逻辑
					doReverseLoop(outTradeNo);
					// 提示用户余额不足，换其他卡支付或是用现金支付
					log.w(tipsPrefix + errorCodeDes);
					resultListener.onFailByMoneyNotEnough(scanPayResData);
				} else if ("USERPAYING".equals(errorCode)) {
					// --------------------------------------------------------------------
					// 3)需要输入密码
					// --------------------------------------------------------------------

					// 表示有可能单次消费超过300元，或是免输密码消费次数已经超过当天的最大限制，这个时候提示用户输入密码，商户自己隔一段时间去查单，查询一定次数，看用户是否已经输入了密码
					if (doPayQueryLoop(payQueryLoopInvokedCount, outTradeNo)) {
						log.i("【需要用户输入密码、查询到支付成功】");
						resultListener.onSuccess(scanPayResData);
					} else {
						log.i("【需要用户输入密码、在一定时间内没有查询到支付成功、走撤销流程】");
						doReverseLoop(outTradeNo);
						resultListener.onFail(scanPayResData);
					}
				} else {
					// --------------------------------------------------------------------
					// 4)扣款未知失败
					// --------------------------------------------------------------------

					if (doPayQueryLoop(payQueryLoopInvokedCount, outTradeNo)) {
						log.i("【支付扣款未知失败、查询到支付成功】");
						resultListener.onSuccess(scanPayResData);
					} else {
						log.i("【支付扣款未知失败、在一定时间内没有查询到支付成功、走撤销流程】");
						doReverseLoop(outTradeNo);
						resultListener.onFail(scanPayResData);
					}
				}
			}
		}
	}

	/**
	 * 进行一次支付订单查询操作
	 * 
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @return 该订单是否支付成功
	 * @throws Exception
	 */
	private boolean doOnePayQuery(String outTradeNo) throws Exception {
		// 等待一定时间再进行查询，避免状态还没来得及被更新
		sleep(waitingTimeBeforePayQueryServiceInvoked);

		String payQueryServiceResponseString;

		OrderQueryReqData scanPayQueryReqData = new OrderQueryReqData("", outTradeNo, isJsApi);
		payQueryServiceResponseString = orderQueryService.request(scanPayQueryReqData);

		log.i("支付订单查询API返回的数据如下：");
		log.i(payQueryServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		OrderQueryResData orderQueryResData = (OrderQueryResData) Util.getObjectFromXML(payQueryServiceResponseString,
				OrderQueryResData.class);
		if (orderQueryResData == null || orderQueryResData.getReturn_code() == null) {
			log.i("支付订单查询请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
			return false;
		}

		if (MicroPayService.FAIL.equals(orderQueryResData.getReturn_code())) {
			// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			log.i("支付订单查询API系统返回失败，失败信息为：" + orderQueryResData.getReturn_msg());
			return false;
		} else {
			if (MicroPayService.SUCCESS.equals(orderQueryResData.getResult_code())) {
				// 业务层成功
				if (MicroPayService.SUCCESS.equals(orderQueryResData.getTrade_state())) {
					// 表示查单结果为“支付成功”
					log.i("查询到订单支付成功");
					return true;
				} else {
					// 支付不成功
					log.i("查询到订单支付不成功");
					return false;
				}
			} else {
				log.i("查询出错，错误码：" + orderQueryResData.getErr_code() + "    错误信息：" + orderQueryResData.getErr_code_des());
				return false;
			}
		}
	}

	/**
	 * 由于有的时候是因为服务延时，所以需要商户每隔一段时间（建议5秒）后再进行查询操作，多试几次（建议3次）
	 * 
	 * @param loopCount
	 *            循环次数，至少一次
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @return 该订单是否支付成功
	 * @throws InterruptedException
	 */
	private boolean doPayQueryLoop(int loopCount, String outTradeNo) throws Exception {
		// 至少查询一次
		if (loopCount == 0) {
			loopCount = 1;
		}
		// 进行循环查询
		for (int i = 0; i < loopCount; i++) {
			if (doOnePayQuery(outTradeNo)) {
				return true;
			}
		}
		return false;
	}

	// 是否需要再调一次撤销，这个值由撤销API回包的recall字段决定
	private boolean needRecallReverse = false;

	/**
	 * 进行一次撤销操作
	 * 
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @return 该订单是否支付成功
	 * @throws Exception
	 */
	private boolean doOneReverse(String outTradeNo) throws Exception {
		// 等待一定时间再进行查询，避免状态还没来得及被更新
		sleep(waitingTimeBeforeReverseServiceInvoked);

		String reverseResponseString;

		ReverseReqData reverseReqData = new ReverseReqData("", outTradeNo, isJsApi);
		reverseResponseString = reverseService.request(reverseReqData);

		log.i("撤销API返回的数据如下：");
		log.i(reverseResponseString);
		// 将从API返回的XML数据映射到Java对象
		ReverseResData reverseResData = (ReverseResData) Util.getObjectFromXML(reverseResponseString, ReverseResData.class);
		if (reverseResData == null) {
			log.i("支付订单撤销请求逻辑错误，请仔细检测传过去的每一个参数是否合法");
			return false;
		}
		if (ReverseService.FAIL.equals(reverseResData.getReturn_code())) {
			// 注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			log.i("支付订单撤销API系统返回失败，失败信息为：" + reverseResData.getReturn_msg());
			return false;
		} else {
			if (ReverseService.FAIL.equals(reverseResData.getResult_code())) {
				log.i("撤销出错，错误码：" + reverseResData.getErr_code() + "     错误信息：" + reverseResData.getErr_code_des());
				if ("Y".equals(reverseResData.getRecall())) {
					// 表示需要重试
					needRecallReverse = true;
					return false;
				} else {
					// 表示不需要重试，也可以当作是撤销成功
					needRecallReverse = false;
					return true;
				}
			} else {
				// 查询成功，打印交易状态
				log.i("支付订单撤销成功");
				return true;
			}
		}
	}

	/**
	 * 由于有的时候是因为服务延时，所以需要商户每隔一段时间（建议5秒）后再进行查询操作，
	 * 是否需要继续循环调用撤销API由撤销API回包里面的recall字段决定。
	 * 
	 * @param outTradeNo
	 *            商户系统内部的订单号,32个字符内可包含字母, [确保在商户系统唯一]
	 * @throws InterruptedException
	 */
	private void doReverseLoop(String outTradeNo) throws Exception {
		// 初始化这个标记
		needRecallReverse = true;
		// 进行循环撤销，直到撤销成功，或是API返回recall字段为"Y"
		while (needRecallReverse) {
			if (doOneReverse(outTradeNo)) {
				return;
			}
		}
	}

	/**
	 * 设置循环多次调用订单查询API的时间间隔
	 * 
	 * @param duration
	 *            时间间隔，默认为5秒
	 */
	public void setWaitingTimeBeforePayQueryServiceInvoked(int duration) {
		waitingTimeBeforePayQueryServiceInvoked = duration;
	}

	/**
	 * 设置循环多次调用订单查询API的次数
	 * 
	 * @param count
	 *            调用次数，默认为三次
	 */
	public void setPayQueryLoopInvokedCount(int count) {
		payQueryLoopInvokedCount = count;
	}

	/**
	 * 设置循环多次调用撤销API的时间间隔
	 * 
	 * @param duration
	 *            时间间隔，默认为5秒
	 */
	public void setWaitingTimeBeforeReverseServiceInvoked(int duration) {
		waitingTimeBeforeReverseServiceInvoked = duration;
	}

	public void setScanPayService(MicroPayService service) {
		microPayService = service;
	}

	public void setScanPayQueryService(OrderQueryService service) {
		orderQueryService = service;
	}

	public void setReverseService(ReverseService service) {
		reverseService = service;
	}

}
