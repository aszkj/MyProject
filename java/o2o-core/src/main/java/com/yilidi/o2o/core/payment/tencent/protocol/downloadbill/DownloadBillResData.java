package com.yilidi.o2o.core.payment.tencent.protocol.downloadbill;

/**
 * 下载对账单返回结构
 * 
 * @author simpson
 * 
 */
public class DownloadBillResData {

    // 协议层
    private String return_code = "";
    private String return_msg = "";

    public String getReturn_code() {
        return return_code;
    }

    public void setReturn_code(String return_code) {
        this.return_code = return_code;
    }

    public String getReturn_msg() {
        return return_msg;
    }

    public void setReturn_msg(String return_msg) {
        this.return_msg = return_msg;
    }
}
