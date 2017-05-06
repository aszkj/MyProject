package com.yilidi.o2o.core.payment.tencent.service;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;

import com.yilidi.o2o.core.payment.tencent.common.Configure;

/**
 * 服务的基类
 * 
 * @author simpson
 * 
 */
public class BaseService {

    /**
     * API的地址
     */
    private String apiURL;
    /**
     * 发请求的HTTPS请求器
     */
    private IServiceRequest serviceRequest;
    /**
     * 返回编码失败:FAIL
     */
    public static final String FAIL = "FAIL";
    /**
     * 返回编码成功:SUCCESS
     */
    public static final String SUCCESS = "SUCCESS";
    /**
     * 返回编码订单不存在:ORDERNOTEXIST
     */
    public static final String ORDERNOTEXIST = "ORDERNOTEXIST";
    /**
     * 返回编码订单已支付:ORDERPAID
     */
    public static final String ORDERPAID = "ORDERPAID";
    /**
     * 返回编码订单已关闭:ORDERCLOSED
     */
    public static final String ORDERCLOSED = "ORDERCLOSED";
    /**
     * 返回编码签名错误:SIGNERROR
     */
    public static final String SIGNERROR = "SIGNERROR";
    /**
     * ms字符串
     */
    public static final String MS_STR = "ms";

    /**
     * 构造器
     * 
     * @param api
     *            接口url
     * @throws ClassNotFoundException
     *             类异常
     * @throws IllegalAccessException
     *             非法异常
     * @throws InstantiationException
     *             初始化异常
     */
    public BaseService(String api) throws ClassNotFoundException, IllegalAccessException, InstantiationException {
        apiURL = api;
        Class<?> c = Class.forName(Configure.HTTPS_REQUEST_CLASS_NAME);
        serviceRequest = (IServiceRequest) c.newInstance();
    }

    protected String sendPost(Object xmlObj) throws UnrecoverableKeyException, IOException, NoSuchAlgorithmException,
            KeyStoreException, KeyManagementException {
        return serviceRequest.sendPost(apiURL, xmlObj);
    }

    /**
     * 供商户想自定义自己的HTTP请求器用
     * 
     * @param request
     *            实现了IserviceRequest接口的HttpsRequest
     */
    public void setServiceRequest(IServiceRequest request) {
        serviceRequest = request;
    }
}
