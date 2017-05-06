package com.yilidi.o2o.core.payment.tencent.business;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.log4j.Logger;
import org.xml.sax.SAXException;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.Log;
import com.yilidi.o2o.core.payment.tencent.common.Signature;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.common.XMLParser;
import com.yilidi.o2o.core.payment.tencent.common.report.ReporterFactory;
import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;
import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;
import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundOrderData;
import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundQueryReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundQueryResData;
import com.yilidi.o2o.core.payment.tencent.service.RefundQueryService;

/**
 * 查询退款业务实现类
 * 
 * @author simpson
 * 
 */
public class RefundQueryBusiness {

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
	public RefundQueryBusiness(boolean isJsApi) throws IllegalAccessException, ClassNotFoundException,
			InstantiationException {
		refundQueryService = new RefundQueryService();
		this.isJsApi = isJsApi;
	}

	/**
	 * 查询退款结果侦听器
	 */
	public interface ResultListener {
		/**
		 * API返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
		 * 
		 * @param refundQueryResData
		 *            查询退款返回结果
		 */
		void onFailByReturnCodeError(RefundQueryResData refundQueryResData);

		/**
		 * API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
		 * 
		 * @param refundQueryResData
		 *            查询退款返回结果
		 */
		void onFailByReturnCodeFail(RefundQueryResData refundQueryResData);

		/**
		 * 支付请求API返回的数据签名验证失败，有可能数据被篡改了
		 * 
		 * @param refundQueryResData
		 *            查询退款返回结果
		 */
		void onFailBySignInvalid(RefundQueryResData refundQueryResData);

		/**
		 * 退款查询失败
		 * 
		 * @param refundQueryResData
		 *            查询退款返回结果
		 */
		void onRefundQueryFail(RefundQueryResData refundQueryResData);

		/**
		 * 退款查询成功
		 * 
		 * @param refundQueryResData
		 *            查询退款返回结果
		 */
		void onRefundQuerySuccess(RefundQueryResData refundQueryResData);

	}

	// 打log用
	private static Log log = new Log(Logger.getLogger(RefundQueryBusiness.class));

	private RefundQueryService refundQueryService;

	private boolean isJsApi = false;

	/**
	 * 运行退款查询的业务逻辑
	 * 
	 * @param refundQueryReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            商户需要自己监听被扫支付业务逻辑可能触发的各种分支事件，并做好合理的响应处理
	 * @throws Exception
	 *             异常
	 */
	public void run(RefundQueryReqData refundQueryReqData, RefundQueryBusiness.ResultListener resultListener)
			throws Exception {

		// --------------------------------------------------------------------
		// 构造请求“退款查询API”所需要提交的数据
		// --------------------------------------------------------------------

		// 接受API返回
		String refundQueryServiceResponseString;

		long costTimeStart = System.currentTimeMillis();

		// 表示是本地测试数据
		log.i("退款查询API返回的数据如下：");
		refundQueryServiceResponseString = refundQueryService.request(refundQueryReqData);

		long costTimeEnd = System.currentTimeMillis();
		int totalTimeCost = (int) (costTimeEnd - costTimeStart);
		log.i("api请求总耗时：" + totalTimeCost + RefundQueryService.MS_STR);

		log.i(refundQueryServiceResponseString);

		// 将从API返回的XML数据映射到Java对象
		RefundQueryResData refundQueryResData = (RefundQueryResData) Util.getObjectFromXML(refundQueryServiceResponseString,
				RefundQueryResData.class);

		ReportReqData reportReqData = new ReportReqData(refundQueryReqData.getDevice_info(), Configure.REFUND_QUERY_API,
				totalTimeCost, refundQueryResData.getReturn_code(), refundQueryResData.getReturn_msg(),
				refundQueryResData.getResult_code(), refundQueryResData.getErr_code(), refundQueryResData.getErr_code_des(),
				refundQueryResData.getOut_trade_no(), Configure.getIP(), isJsApi);

		long timeAfterReport;
		if (Configure.isUseThreadToDoReport()) {
			ReporterFactory.getReporter(reportReqData).run();
			timeAfterReport = System.currentTimeMillis();
			Util.log("refundquery+report总耗时（异步方式上报）：" + (timeAfterReport - costTimeStart) + RefundQueryService.MS_STR);
		} else {
			ReportService.request(reportReqData);
			timeAfterReport = System.currentTimeMillis();
			Util.log("refundquery+report总耗时（同步方式上报）：" + (timeAfterReport - costTimeStart) + RefundQueryService.MS_STR);
		}

		if (refundQueryResData == null || refundQueryResData.getReturn_code() == null) {
			setResult("Case1:退款查询API请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问", Log.LOG_TYPE_ERROR);
			resultListener.onFailByReturnCodeError(refundQueryResData);
			return;
		}

		// Debug:查看数据是否正常被填充到scanPayResponseData这个对象中
		// Util.reflect(refundQueryResData);

		if (RefundQueryService.FAIL.equals(refundQueryResData.getReturn_code())) {
			// /注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
			setResult("Case2:退款查询API系统返回失败，请检测Post给API的数据是否规范合法", Log.LOG_TYPE_ERROR);
			resultListener.onFailByReturnCodeFail(refundQueryResData);
		} else {
			log.i("退款查询API系统成功返回数据");
			// --------------------------------------------------------------------
			// 收到API的返回数据的时候得先验证一下数据有没有被第三方篡改，确保安全
			// --------------------------------------------------------------------

			if (!Signature.checkIsSignValidFromResponseString(refundQueryServiceResponseString, isJsApi)) {
				setResult("Case3:退款查询API返回的数据签名验证失败，有可能数据被篡改了", Log.LOG_TYPE_ERROR);
				resultListener.onFailBySignInvalid(refundQueryResData);
				return;
			}

			if (RefundQueryService.FAIL.equals(refundQueryResData.getResult_code())) {
				Util.log("出错，错误码：" + refundQueryResData.getErr_code() + "     错误信息：" + refundQueryResData.getErr_code_des());
				setResult("Case4:【退款查询失败】", Log.LOG_TYPE_ERROR);
				resultListener.onRefundQueryFail(refundQueryResData);
				// 退款失败时再怎么延时查询退款状态都没有意义，这个时间建议要么再手动重试一次，依然失败的话请走投诉渠道进行投诉
			} else {
				// 退款成功
				getRefundOrderListResult(refundQueryServiceResponseString);
				setResult("Case5:【退款查询成功】", Log.LOG_TYPE_INFO);
				resultListener.onRefundQuerySuccess(refundQueryResData);
			}
		}
	}

	/**
	 * 打印出服务器返回的订单查询结果
	 * 
	 * @param refundQueryResponseString
	 *            退款查询返回API返回的数据
	 * @throws javax.xml.parsers.ParserConfigurationException
	 * @throws org.xml.sax.SAXException
	 * @throws java.io.IOException
	 */
	private void getRefundOrderListResult(String refundQueryResponseString) throws ParserConfigurationException,
			SAXException, IOException {
		List<RefundOrderData> refundOrderList = XMLParser.getRefundOrderList(refundQueryResponseString);
		int count = 1;
		String orderListResult = "";
		for (RefundOrderData refundOrderData : refundOrderList) {
			Util.log("退款订单数据NO" + count + ":");
			Util.log(refundOrderData.toMap());
			orderListResult += refundOrderData.toMap().toString();
			count++;
		}
		log.i("查询到的结果如下：");
		log.i(orderListResult);
	}

	public void setRefundQueryService(RefundQueryService service) {
		refundQueryService = service;
	}

	private void setResult(String result, String type) {
		log.log(type, result);
	}

}
