package com.yilidi.o2o.user.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 分享规则查询实体
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午10:33:36
 */
public class ShareRuleQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 4185694725504759033L;

    /**
     * 分享规则名称
     */
    private String shareRuleName;

    /**
     * 有效开始时间
     */
    private Date startValidTime;
    /**
     * 有效结束时间
     */
    private Date endValidTime;
    /**
     * 角色类型,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEROLETYPE)
     */
    private String roleType;
    /**
     * 有效状态,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULESTATUS)
     */
    private String status;

    /**
     * 活动开始时间,字符串
     */
    private String strStartValidTime;
    /**
     * 活动结束时间,字符串
     */
    private String strEndValidTime;

    public String getShareRuleName() {
        return shareRuleName;
    }

    public void setShareRuleName(String shareRuleName) {
        this.shareRuleName = shareRuleName;
    }

    public Date getStartValidTime() {
        return startValidTime;
    }

    public void setStartValidTime(Date startValidTime) {
        this.startValidTime = startValidTime;
    }

    public Date getEndValidTime() {
        return endValidTime;
    }

    public void setEndValidTime(Date endValidTime) {
        this.endValidTime = endValidTime;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStrStartValidTime() {
        return strStartValidTime;
    }

    public void setStrStartValidTime(String strStartValidTime) {
        this.strStartValidTime = strStartValidTime;
    }

    public String getStrEndValidTime() {
        return strEndValidTime;
    }

    public void setStrEndValidTime(String strEndValidTime) {
        this.strEndValidTime = strEndValidTime;
    }

}
