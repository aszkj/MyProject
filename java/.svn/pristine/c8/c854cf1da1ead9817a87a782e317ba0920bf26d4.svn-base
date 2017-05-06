package com.yilidi.o2o.core.payment.tencent.service;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.protocol.micropay.MicroPayReqData;

/**
 * 刷卡支付
 * 
 * @author simpson
 * 
 */
public class MicroPayService extends BaseService {

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
    public MicroPayService() throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        super(Configure.MICROPAY_API);
    }

    /**
     * 请求支付服务
     * 
     * @param scanPayReqData
     *            这个数据对象里面包含了API要求提交的各种数据字段
     * @return API返回的数据
     * @throws Exception
     *             异常
     */
    public String request(MicroPayReqData scanPayReqData) throws Exception {

        // --------------------------------------------------------------------
        // 发送HTTPS的Post请求到API地址
        // --------------------------------------------------------------------
        String responseString = sendPost(scanPayReqData);

        return responseString;
    }
}
