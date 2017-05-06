package com.yilidi.o2o.core.payment.tencent.service;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;

/**
 * 定义服务层需要请求器标准接口
 * 
 * @author simpson
 * 
 */
public interface IServiceRequest {

    /**
     * Service依赖的底层https请求器必须实现这么一个接口
     * 
     * @param apiUrl
     *            url字符串
     * @param xmlObj
     *            xml对象
     * @return 返回字符串
     * @throws UnrecoverableKeyException
     *             keystore recover异常
     * @throws KeyManagementException
     *             key异常
     * @throws NoSuchAlgorithmException
     *             算法异常
     * @throws KeyStoreException
     *             keystore异常
     * @throws IOException
     *             IO异常
     */
    public String sendPost(String apiUrl, Object xmlObj) throws UnrecoverableKeyException, KeyManagementException,
            NoSuchAlgorithmException, KeyStoreException, IOException;

}
