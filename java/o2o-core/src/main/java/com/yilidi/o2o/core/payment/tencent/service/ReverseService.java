package com.yilidi.o2o.core.payment.tencent.service;

import com.yilidi.o2o.core.payment.tencent.common.Configure;
import com.yilidi.o2o.core.payment.tencent.protocol.reverse.ReverseReqData;

/**
 * 撤销订单服务
 * 
 * @author simpson
 * 
 */
public class ReverseService extends BaseService {

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
    public ReverseService() throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        super(Configure.REVERSE_API);
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
    public String request(ReverseReqData reverseReqData) throws Exception {

        // --------------------------------------------------------------------
        // 发送HTTPS的Post请求到API地址
        // --------------------------------------------------------------------
        String responseString = sendPost(reverseReqData);

        return responseString;
    }

}
