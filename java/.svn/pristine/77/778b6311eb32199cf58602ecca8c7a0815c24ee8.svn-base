package com.yilidi.o2o.core.payment.tencent;

import com.yilidi.o2o.core.payment.tencent.business.DownloadBillBusiness;
import com.yilidi.o2o.core.payment.tencent.business.MicroPayBusiness;
import com.yilidi.o2o.core.payment.tencent.business.RefundBusiness;
import com.yilidi.o2o.core.payment.tencent.business.RefundQueryBusiness;
import com.yilidi.o2o.core.payment.tencent.business.UnifiedOrderBusiness;
import com.yilidi.o2o.core.payment.tencent.protocol.closeorder.CloseOrderReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.downloadbill.DownloadBillReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.micropay.MicroPayReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.orderquery.OrderQueryReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.refund.RefundReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundQueryReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.reverse.ReverseReqData;
import com.yilidi.o2o.core.payment.tencent.protocol.unifiedorder.UnifiedOrderReqData;
import com.yilidi.o2o.core.payment.tencent.service.CloseOrderService;
import com.yilidi.o2o.core.payment.tencent.service.DownloadBillService;
import com.yilidi.o2o.core.payment.tencent.service.MicroPayService;
import com.yilidi.o2o.core.payment.tencent.service.OrderQueryService;
import com.yilidi.o2o.core.payment.tencent.service.RefundQueryService;
import com.yilidi.o2o.core.payment.tencent.service.RefundService;
import com.yilidi.o2o.core.payment.tencent.service.ReverseService;
import com.yilidi.o2o.core.payment.tencent.service.UnifiedOrderService;

/**
 * 微信支付总入口类
 * 
 * @author simpson
 * 
 */
public final class WXPay {

	private WXPay() {
	}

	/**
	 * 请求统一下单服务
	 * 
	 * @param unifiedOrderReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestUnifiedOrderService(UnifiedOrderReqData unifiedOrderReqData) throws Exception {
		return new UnifiedOrderService().request(unifiedOrderReqData);
	}

	/**
	 * 请求刷卡支付服务
	 * 
	 * @param microPayReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestMicroPayService(MicroPayReqData microPayReqData) throws Exception {
		return new MicroPayService().request(microPayReqData);
	}

	/**
	 * 请求支付查询服务
	 * 
	 * @param orderQueryReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestOrderQueryService(OrderQueryReqData orderQueryReqData) throws Exception {
		return new OrderQueryService().request(orderQueryReqData);
	}

	/**
	 * 请求退款服务
	 * 
	 * @param refundReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestRefundService(RefundReqData refundReqData) throws Exception {
		return new RefundService().request(refundReqData);
	}

	/**
	 * 请求退款查询服务
	 * 
	 * @param refundQueryReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestRefundQueryService(RefundQueryReqData refundQueryReqData) throws Exception {
		return new RefundQueryService().request(refundQueryReqData);
	}

	/**
	 * 请求撤销服务
	 * 
	 * @param reverseReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestReverseService(ReverseReqData reverseReqData) throws Exception {
		return new ReverseService().request(reverseReqData);
	}

	/**
	 * 请求关闭订单服务
	 * 
	 * @param closeOrderReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestCloseOrderService(CloseOrderReqData closeOrderReqData) throws Exception {
		return new CloseOrderService().request(closeOrderReqData);
	}

	/**
	 * 请求对账单下载服务
	 * 
	 * @param downloadBillReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @return API返回的XML数据
	 * @throws Exception
	 *             异常
	 */
	public static String requestDownloadBillService(DownloadBillReqData downloadBillReqData) throws Exception {
		return new DownloadBillService().request(downloadBillReqData);
	}

	/**
	 * 调用统一下单业务逻辑
	 * 
	 * @param unifiedOrderReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            商户需要自己监听被扫支付业务逻辑可能触发的各种分支事件，并做好合理的响应处理
	 * @throws Exception
	 *             异常
	 */
	public static void doUnifiedOrderBusiness(UnifiedOrderReqData unifiedOrderReqData,
			UnifiedOrderBusiness.ResultListener resultListener) throws Exception {
		new UnifiedOrderBusiness().run(unifiedOrderReqData, resultListener);
	}

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
	public static void doMicroPayBusiness(MicroPayReqData microPayReqData, MicroPayBusiness.ResultListener resultListener,
			boolean isJsApi) throws Exception {
		new MicroPayBusiness(isJsApi).run(microPayReqData, resultListener);
	}

	/**
	 * 调用退款业务逻辑
	 * 
	 * @param refundReqData
	 *            这个数据对象里面包含了API要求提交的各种数据字段
	 * @param resultListener
	 *            业务逻辑可能走到的结果分支，需要商户处理
	 * @throws Exception
	 *             异常
	 */
	public static void doRefundBusiness(RefundReqData refundReqData, RefundBusiness.ResultListener resultListener,
			boolean isJsApi) throws Exception {
		new RefundBusiness(isJsApi).run(refundReqData, resultListener);
	}

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
	public static void doRefundQueryBusiness(RefundQueryReqData refundQueryReqData,
			RefundQueryBusiness.ResultListener resultListener, boolean isJsApi) throws Exception {
		new RefundQueryBusiness(isJsApi).run(refundQueryReqData, resultListener);
	}

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
	public static void doDownloadBillBusiness(DownloadBillReqData downloadBillReqData,
			DownloadBillBusiness.ResultListener resultListener, boolean isJsApi) throws Exception {
		new DownloadBillBusiness(isJsApi).run(downloadBillReqData, resultListener);
	}

}
