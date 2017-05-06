package com.yilidi.o2o.system.sms.huaxin;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.SmsException;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.sms.huaxin.model.report.ReportReturnInfo;
import com.yilidi.o2o.system.sms.huaxin.model.send.SendReturnInfo;

public final class SmsHuaxinUtils {

    private static Logger logger = Logger.getLogger(SmsHuaxinUtils.class);

    private String userid;

    private String account;

    private String password;

    private String sendUrl;

    private String sendTime;

    private String signature;

    private String extno;

    private String reportUrl;

    private String taskid;

    public SendReturnInfo send(String phones, String content) throws SmsException {
        PostMethod postMethod = null;
        SendReturnInfo sendReturnInfo = null;
        try {
            HttpClient httpClient = new HttpClient();
            httpClient.getParams().setBooleanParameter("http.protocol.expect-continue", false);
            HttpConnectionManagerParams managerParams = httpClient.getHttpConnectionManager().getParams();
            managerParams.setConnectionTimeout(30000);
            managerParams.setSoTimeout(120000);
            managerParams.setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CommonConstants.UTF_8);
            postMethod = new PostMethod(sendUrl);
            postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CommonConstants.UTF_8);
            NameValuePair[] data = { new NameValuePair("action", "send"), new NameValuePair("userid", userid),
                    new NameValuePair("account", account),
                    new NameValuePair("password", EncryptUtils.md5Crypt(password).toUpperCase()),
                    new NameValuePair("mobile", phones), new NameValuePair("content", signature + content),
                    new NameValuePair("sendTime", sendTime), new NameValuePair("extno", extno) };
            postMethod.setRequestBody(data);
            postMethod.addRequestHeader("Connection", "close");
            int statusCode = httpClient.executeMethod(postMethod);
            if (statusCode != HttpStatus.SC_OK) {
                throw new SmsException("" + postMethod.getStatusLine());
            }
            byte[] responseBody = postMethod.getResponseBody();
            String jsonStr = new String(responseBody, CommonConstants.UTF_8);
            sendReturnInfo = JsonUtils.parseObject(JsonUtils.parseObject(jsonStr), SendReturnInfo.class);
            logger.info("sendReturnInfo :" + JsonUtils.toJsonStringWithDateFormat(sendReturnInfo));
            return sendReturnInfo;
        } catch (Exception e) {
            String msg = "短信发送接口调用发生异常";
            logger.error(msg, e);
            throw new SmsException(msg);
        } finally {
            postMethod.releaseConnection();
        }
    }

    public ReportReturnInfo report() throws SmsException {
        PostMethod postMethod = null;
        ReportReturnInfo reportReturnInfo = null;
        try {
            HttpClient httpClient = new HttpClient();
            httpClient.getParams().setBooleanParameter("http.protocol.expect-continue", false);
            HttpConnectionManagerParams managerParams = httpClient.getHttpConnectionManager().getParams();
            managerParams.setConnectionTimeout(30000);
            managerParams.setSoTimeout(120000);
            managerParams.setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, CommonConstants.UTF_8);
            postMethod = new PostMethod(reportUrl);
            NameValuePair[] data = { new NameValuePair("action", "query"), new NameValuePair("userid", userid),
                    new NameValuePair("account", account),
                    new NameValuePair("password", EncryptUtils.md5Crypt(password).toUpperCase()) };
            postMethod.setRequestBody(data);
            postMethod.addRequestHeader("Connection", "close");
            int statusCode = httpClient.executeMethod(postMethod);
            if (statusCode != HttpStatus.SC_OK) {
                throw new SmsException("" + postMethod.getStatusLine());
            }
            byte[] responseBody = postMethod.getResponseBody();
            String jsonStr = new String(responseBody, CommonConstants.UTF_8);
            logger.info("jsonStr : " + jsonStr);
            reportReturnInfo = JsonUtils.parseObject(JsonUtils.parseObject(jsonStr), ReportReturnInfo.class);
            return reportReturnInfo;
        } catch (Exception e) {
            String msg = "状态报告接口调用发生异常";
            logger.error(msg, e);
            throw new SmsException(msg);
        } finally {
            postMethod.releaseConnection();
        }
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSendUrl() {
        return sendUrl;
    }

    public void setSendUrl(String sendUrl) {
        this.sendUrl = sendUrl;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getExtno() {
        return extno;
    }

    public void setExtno(String extno) {
        this.extno = extno;
    }

    public String getReportUrl() {
        return reportUrl;
    }

    public void setReportUrl(String reportUrl) {
        this.reportUrl = reportUrl;
    }

    public String getTaskid() {
        return taskid;
    }

    public void setTaskid(String taskid) {
        this.taskid = taskid;
    }

    public static class UTF8PostMethod extends PostMethod {
        public UTF8PostMethod(String url) {
            super(url);
        }

        @Override
        public String getRequestCharSet() {
            // return super.getRequestCharSet();
            return "UTF-8";
        }
    }

}
