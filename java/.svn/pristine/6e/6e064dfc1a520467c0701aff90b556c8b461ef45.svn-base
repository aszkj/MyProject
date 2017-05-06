package com.yilidi.o2o.system.sms.huaxin.model.report;

import java.io.Serializable;
import java.util.List;

public class ReportReturnInfo implements Serializable {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -2398689450016350179L;

    /**
     * 错误码 1：用户名或密码不能为空 2：用户名或密码错误 3：该用户不允许查看状态报告 4：参数不正确
     */
    private String error;

    /**
     * 错误描述
     */
    private String remark;

    /**
     * 回执状态信息列表
     */
    private List<StatusInfo> statusbox;

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<StatusInfo> getStatusbox() {
        return statusbox;
    }

    public void setStatusbox(List<StatusInfo> statusbox) {
        this.statusbox = statusbox;
    }

}
