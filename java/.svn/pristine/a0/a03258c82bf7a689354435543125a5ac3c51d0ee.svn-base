package com.yilidi.o2o.core.payment.tencent.service;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.protocol.refundquery.RefundQueryReqData;

/**
 * 退款查询服务类
 * 
 * @author simpson
 * 
 */
public class RefundQueryService extends BaseService {

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
    public RefundQueryService() throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        super(Configure.REFUND_QUERY_API);
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
    public String request(RefundQueryReqData refundQueryReqData) throws Exception {

        // --------------------------------------------------------------------
        // 发送HTTPS的Post请求到API地址
        // --------------------------------------------------------------------
        String responseString = sendPost(refundQueryReqData);

        return responseString;
    }

}
