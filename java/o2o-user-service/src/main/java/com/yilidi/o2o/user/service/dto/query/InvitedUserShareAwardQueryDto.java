/**
 * 文件名称：User.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 功能描述：用户分享记录 查询DTO封装类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class InvitedUserShareAwardQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 1592405843560203460L;

    /**
     * 用户分享码
     */
    private String shareCode;
    /**
     * 分享用户ID
     */
    private Integer shareUserId;
    /**
     * 分享用户手机号码
     */
    private String shareUserName;

    /**
     * 分享规则ID
     */
    private Integer shareRuleId;
    /**
     * 开始时间
     */
    private Date startTime;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 开始时间字符串
     */
    private String strStartTime;
    /**
     * 结束字符串
     */
    private String strEndTime;
    /**
     * 用户手机号码
     */
    private String userName;

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

    public Integer getShareUserId() {
        return shareUserId;
    }

    public void setShareUserId(Integer shareUserId) {
        this.shareUserId = shareUserId;
    }

    public String getShareUserName() {
        return shareUserName;
    }

    public void setShareUserName(String shareUserName) {
        this.shareUserName = shareUserName;
    }

    public Integer getShareRuleId() {
        return shareRuleId;
    }

    public void setShareRuleId(Integer shareRuleId) {
        this.shareRuleId = shareRuleId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStrStartTime() {
        return strStartTime;
    }

    public void setStrStartTime(String strStartTime) {
        this.strStartTime = strStartTime;
    }

    public String getStrEndTime() {
        return strEndTime;
    }

    public void setStrEndTime(String strEndTime) {
        this.strEndTime = strEndTime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

}