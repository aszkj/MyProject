package com.yilidi.o2o.core.payment.tencent.service;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.protocol.downloadbill.DownloadBillReqData;

/**
 * 下载对账单服务类
 * 
 * @author simpson
 * 
 */
public class DownloadBillService extends BaseService {

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
    public DownloadBillService() throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        super(Configure.DOWNLOAD_BILL_API);
    }

    /**
     * ALL，返回当日所有订单信息，默认值
     */
    public static final String BILL_TYPE_ALL = "ALL";

    /**
     * SUCCESS，返回当日成功支付的订单
     */
    public static final String BILL_TYPE_SUCCESS = "SUCCESS";

    /**
     * REFUND，返回当日退款订单
     */
    public static final String BILL_TYPE_REFUND = "REFUND";

    /**
     * REVOKED，已撤销的订单
     */
    public static final String BILL_TYPE_REVOKE = "REVOKE";

    /**
     * 请求对账单下载服务
     * 
     * @param downloadBillReqData
     *            这个数据对象里面包含了API要求提交的各种数据字段
     * @return API返回的XML数据
     * @throws Exception
     *             异常
     */
    public String request(DownloadBillReqData downloadBillReqData) throws Exception {

        // --------------------------------------------------------------------
        // 发送HTTPS的Post请求到API地址
        // --------------------------------------------------------------------
        String responseString = sendPost(downloadBillReqData);

        return responseString;
    }

}
