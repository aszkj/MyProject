package com.yilidi.o2o.core.payment.tencent.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.SocketTimeoutException;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import com.yilidi.o2o.core.payment.tencent.service.IServiceRequest;
import com.yilidi.o2o.core.CommonConstants;

/**
 * https请求类
 * 
 * @author simpson
 * 
 */
public class HttpsRequest implements IServiceRequest {

    /**
     * 结果侦听器
     * 
     * @author simpson
     * 
     */
    public interface ResultListener {

        /**
         * 连接池超时
         */
        public void onConnectionPoolTimeoutError();

    }

    private static Log log = new Log(Logger.getLogger(HttpsRequest.class));

    // 表示请求器是否已经做了初始化工作
    private boolean hasInit = false;

    // 连接超时时间，默认10秒
    private int socketTimeout = 10000;

    // 传输超时时间，默认30秒
    private int connectTimeout = 30000;

    // 请求器的配置
    private RequestConfig requestConfig;

    // HTTP请求器
    private CloseableHttpClient httpClient;

    /**
     * 构造器
     * 
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
    public HttpsRequest() throws UnrecoverableKeyException, KeyManagementException, NoSuchAlgorithmException,
            KeyStoreException, IOException {
        init();
    }

    private void init() throws IOException, KeyStoreException, UnrecoverableKeyException, NoSuchAlgorithmException,
            KeyManagementException {

        KeyStore keyStore = KeyStore.getInstance("PKCS12");
        // 加载本地的证书进行https加密传输
        log.i(Configure.getCertLocalPath(false));
        FileInputStream instream = new FileInputStream(new File(Configure.getCertLocalPath(false)));
        try {
            // 设置证书密码
            keyStore.load(instream, Configure.getCertPassword(false).toCharArray());
        } catch (CertificateException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } finally {
            instream.close();
        }

        // Trust own CA and all self-signed certs
        SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, Configure.getCertPassword(false).toCharArray())
                .build();
        // Allow TLSv1 protocol only
        SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null,
                SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);

        httpClient = HttpClients.custom().setSSLSocketFactory(sslsf).build();

        // 根据默认超时限制初始化requestConfig
        requestConfig = RequestConfig.custom().setSocketTimeout(socketTimeout).setConnectTimeout(connectTimeout).build();

        hasInit = true;
    }

    /**
     * 通过Https往API post xml数据
     * 
     * @param url
     *            API地址
     * @param xmlObj
     *            要提交的XML数据对象
     * @return API回包的实际数据
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

    public String sendPost(String url, Object xmlObj) throws IOException, KeyStoreException, UnrecoverableKeyException,
            NoSuchAlgorithmException, KeyManagementException {

        if (!hasInit) {
            init();
        }

        String result = null;

        HttpPost httpPost = new HttpPost(url);

        // 解决XStream对出现双下划线的bug
        XStream xStreamForRequestPostData = new XStream(new DomDriver(CommonConstants.UTF_8, new XmlFriendlyNameCoder("-_",
                "_")));

        // 将要提交给API的数据对象转换成XML格式数据Post给API
        String postDataXML = xStreamForRequestPostData.toXML(xmlObj);

        Util.log("API，POST过去的数据是：");
        Util.log(postDataXML);

        // 得指明使用UTF-8编码，否则到API服务器XML的中文不能被成功识别
        StringEntity postEntity = new StringEntity(postDataXML, CommonConstants.UTF_8);
        httpPost.addHeader("Content-Type", "text/xml");
        httpPost.setEntity(postEntity);

        // 设置请求器的配置
        httpPost.setConfig(requestConfig);
        Util.log("executing request" + httpPost.getRequestLine());

        try {
            HttpResponse response = httpClient.execute(httpPost);
            HttpEntity entity = response.getEntity();
            result = EntityUtils.toString(entity, CommonConstants.UTF_8);
        } catch (ConnectionPoolTimeoutException e) {
            log.e("http get throw ConnectionPoolTimeoutException(wait time out)");
        } catch (ConnectTimeoutException e) {
            log.e("http get throw ConnectTimeoutException");
        } catch (SocketTimeoutException e) {
            log.e("http get throw SocketTimeoutException");
        } catch (Exception e) {
            log.e("http get throw Exception");
        } finally {
            httpPost.abort();
        }

        return result;
    }

    /**
     * 设置连接超时时间
     * 
     * @param socketTimeout
     *            连接时长，默认10秒
     */
    public void setSocketTimeout(int socketTimeout) {
        this.socketTimeout = socketTimeout;
        resetRequestConfig();
    }

    /**
     * 设置传输超时时间
     * 
     * @param connectTimeout
     *            传输时长，默认30秒
     */
    public void setConnectTimeout(int connectTimeout) {
        this.connectTimeout = connectTimeout;
        resetRequestConfig();
    }

    private void resetRequestConfig() {
        requestConfig = RequestConfig.custom().setSocketTimeout(socketTimeout).setConnectTimeout(connectTimeout).build();
    }

    /**
     * 允许商户自己做更高级更复杂的请求器配置
     * 
     * @param requestConfig
     *            设置HttpsRequest的请求器配置
     */
    public void setRequestConfig(RequestConfig requestConfig) {
        this.requestConfig = requestConfig;
    }
}
