package com.yilidi.o2o.system.sms.huaxin.model.report;

import java.io.Serializable;

public class StatusInfo implements Serializable {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -8464594887991562604L;

    /**
     * 对应的手机号码
     */
    private String mobile;

    /**
     * 同一批任务ID
     */
    private String taskid;

    /**
     * 接收时间
     */
    private String receivetime;

    /**
     * 上级网关返回值，不同网关返回值不同，仅作为参考
     */
    private String errorcode;

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getTaskid() {
        return taskid;
    }

    public void setTaskid(String taskid) {
        this.taskid = taskid;
    }

    public String getReceivetime() {
        return receivetime;
    }

    public void setReceivetime(String receivetime) {
        this.receivetime = receivetime;
    }

    public String getErrorcode() {
        return errorcode;
    }

    public void setErrorcode(String errorcode) {
        this.errorcode = errorcode;
    }

}
