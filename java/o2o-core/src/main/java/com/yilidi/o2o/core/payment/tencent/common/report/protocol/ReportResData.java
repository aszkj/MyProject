package com.yilidi.o2o.core.payment.tencent.common.report.protocol;

/**
 * 上报返回数据类
 * 
 * @author simpson
 * 
 */
public class ReportResData {

    // 以下是API接口返回的对应数据
    private String return_code;
    private String return_msg;
    private String result_code;

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

    public String getResult_code() {
        return result_code;
    }

    public void setResult_code(String result_code) {
        this.result_code = result_code;
    }
}
