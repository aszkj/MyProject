package com.yilidi.o2o.system.sms.huaxin.model.send;

import java.io.Serializable;

public class SendReturnInfo implements Serializable {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -2127480850888469217L;

    /**
     * 返回状态值：成功返回Success 失败返回：Faild
     */
    private String returnstatus;

    /**
     * 相关的错误描述
     */
    private String message;

    /**
     * 返回余额
     */
    private String remainpoint;

    /**
     * 返回本次任务的序列ID
     */
    private String taskID;

    /**
     * 成功短信数：当成功后返回提交成功短信数
     */
    private String successCounts;

    public String getReturnstatus() {
        return returnstatus;
    }

    public void setReturnstatus(String returnstatus) {
        this.returnstatus = returnstatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getRemainpoint() {
        return remainpoint;
    }

    public void setRemainpoint(String remainpoint) {
        this.remainpoint = remainpoint;
    }

    public String getTaskID() {
        return taskID;
    }

    public void setTaskID(String taskID) {
        this.taskID = taskID;
    }

    public String getSuccessCounts() {
        return successCounts;
    }

    public void setSuccessCounts(String successCounts) {
        this.successCounts = successCounts;
    }

}
