package com.yilidi.o2o.core.payment.tencent.business;

import org.apache.log4j.Logger;

import com.thoughtworks.xstream.io.StreamException;
import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.common.Log;
import com.yilidi.o2o.core.payment.tencent.common.Util;
import com.yilidi.o2o.core.payment.tencent.common.report.ReporterFactory;
import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;
import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;
import com.yilidi.o2o.core.payment.tencent.protocol.downloadbill.DownloadBillReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.downloadbill.DownloadBillResData;
import com.yilidi.o2o.core.payment.tencent.service.DownloadBillService;

/**
 * 下载对账单业务实现类
 * 
 * @author simpson
 * 
 */
public class DownloadBillBusiness {

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
	public DownloadBillBusiness(boolean isJsApi) throws IllegalAccessException, ClassNotFoundException,
			InstantiationException {
		downloadBillService = new DownloadBillService();
		this.isJsApi = isJsApi;
	}

	/**
	 * 下载对账单结果侦听器
	 */
	public interface ResultListener {
		/**
		 * API返回ReturnCode不合法，支付请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问
		 * 
		 * @param downloadBillResData
		 *            下载对账单返回结果
		 */
		void onFailByReturnCodeError(DownloadBillResData downloadBillResData);

		/**
		 * API返回ReturnCode为FAIL，支付API系统返回失败，请检测Post给API的数据是否规范合法
		 * 
		 * @param downloadBillResData
		 *            下载对账单返回结果
		 */
		void onFailByReturnCodeFail(DownloadBillResData downloadBillResData);

		/**
		 * 下载对账单失败
		 * 
		 * @param response
		 *            响应字符串
		 */
		void onDownloadBillFail(String response);

		/**
		 * 下载对账单成功
		 * 
		 * @param response
		 *            响应字符串
		 */
		void onDownloadBillSuccess(String response);
	}

	// 打log用
	private static Log log = new Log(Logger.getLogger(DownloadBillBusiness.class));

	private DownloadBillService downloadBillService;

	private boolean isJsApi = false;

	/**
	 * 请求对账单下载服务
	 * 
	 * @param downloadBillReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            商户需要自己监听被扫支付业务逻辑可能触发的各种分支事件，并做好合理的响应处理
	 * @throws Exception
	 *             异常
	 */
	public void run(DownloadBillReqData downloadBillReqData, ResultListener resultListener) throws Exception {

		// --------------------------------------------------------------------
		// 构造请求“对账单API”所需要提交的数据
		// --------------------------------------------------------------------

		// API返回的数据
		String downloadBillServiceResponseString;

		long costTimeStart = System.currentTimeMillis();

		// 支持加载本地测试数据进行调试

		log.i("对账单API返回的数据如下：");
		downloadBillServiceResponseString = downloadBillService.request(downloadBillReqData);

		long costTimeEnd = System.currentTimeMillis();
		int totalTimeCost = (int) (costTimeEnd - costTimeStart);
		log.i("api请求总耗时：" + totalTimeCost + DownloadBillService.MS_STR);

		log.i(downloadBillServiceResponseString);

		DownloadBillResData downloadBillResData;

		String returnCode = "";
		String returnMsg = "";

		try {
			// 注意，这里失败的时候是返回xml数据，成功的时候反而返回非xml数据
			downloadBillResData = (DownloadBillResData) Util.getObjectFromXML(downloadBillServiceResponseString,
					DownloadBillResData.class);

			if (downloadBillResData == null || downloadBillResData.getReturn_code() == null) {
				setResult("Case1:对账单API请求逻辑错误，请仔细检测传过去的每一个参数是否合法，或是看API能否被正常访问", Log.LOG_TYPE_ERROR);
				resultListener.onFailByReturnCodeError(downloadBillResData);
				return;
			}
			if (DownloadBillService.FAIL.equals(downloadBillResData.getReturn_code())) {
				// /注意：一般这里返回FAIL是出现系统级参数错误，请检测Post给API的数据是否规范合法
				setResult("Case2:对账单API系统返回失败，请检测Post给API的数据是否规范合法", Log.LOG_TYPE_ERROR);
				resultListener.onFailByReturnCodeFail(downloadBillResData);
				returnCode = DownloadBillService.FAIL;
				returnMsg = downloadBillResData.getReturn_msg();
			}
		} catch (StreamException e) {
			// 注意，这里成功的时候是直接返回纯文本的对账单文本数据，非XML格式
			if (null == downloadBillServiceResponseString || "".equals(downloadBillServiceResponseString)) {
				setResult("Case4:对账单API系统返回数据为空", Log.LOG_TYPE_ERROR);
				resultListener.onDownloadBillFail(downloadBillServiceResponseString);
			} else {
				setResult("Case3:对账单API系统成功返回数据", Log.LOG_TYPE_INFO);
				resultListener.onDownloadBillSuccess(downloadBillServiceResponseString);
			}
			returnCode = DownloadBillService.SUCCESS;
		} finally {
			ReportReqData reportReqData = new ReportReqData(downloadBillReqData.getDevice_info(),
					Configure.DOWNLOAD_BILL_API, totalTimeCost, returnCode, returnMsg, "", "", "", "", Configure.getIP(),
					isJsApi);

			long timeAfterReport;
			if (Configure.isUseThreadToDoReport()) {
				ReporterFactory.getReporter(reportReqData).run();
				timeAfterReport = System.currentTimeMillis();
				Util.log("downloadbill+report总耗时（异步方式上报）：" + (timeAfterReport - costTimeStart) + DownloadBillService.MS_STR);
			} else {
				ReportService.request(reportReqData);
				timeAfterReport = System.currentTimeMillis();
				Util.log("downloadbill+report总耗时（同步方式上报）：" + (timeAfterReport - costTimeStart) + DownloadBillService.MS_STR);
			}
		}
	}

	public void setDownloadBillService(DownloadBillService service) {
		downloadBillService = service;
	}

	private void setResult(String result, String type) {
		log.log(type, result);
	}

}
