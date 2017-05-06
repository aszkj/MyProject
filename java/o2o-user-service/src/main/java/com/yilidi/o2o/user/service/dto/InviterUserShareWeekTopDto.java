/**
 * 文件名称：User.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：用户邀请排行榜DTO<br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class InviterUserShareWeekTopDto extends BaseDto {

    private static final long serialVersionUID = -2104898883588297956L;

    /**
     * 主键,自增
     */
    private Integer id;
    /**
     * 邀请用户名称
     */
    private String userName;
    /**
     * 修改后的邀请用户名称
     */
    private String revisionUserName;
    /**
     * 年
     */
    private Integer year;
    /**
     * 月
     */
    private Integer month;
    /**
     * 周数
     */
    private Integer weekNumber;
    /**
     * 邀请人数
     */
    private Integer inviterCount;
    /**
     * 修改后的邀请人数
     */
    private Integer revisionInviterCount;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建记录时间
     */
    private Date createTime;
    /**
     * 最后操作记录用户ID
     */
    private Integer modifyUserId;
    /**
     * 最后操作记录时间
     */
    private Date modifyTime;
    /**
     * 接收修改字符串参数
     */
    private String weekTopDataStr;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public Integer getWeekNumber() {
        return weekNumber;
    }

    public void setWeekNumber(Integer weekNumber) {
        this.weekNumber = weekNumber;
    }

    public Integer getInviterCount() {
        return inviterCount;
    }

    public void setInviterCount(Integer inviterCount) {
        this.inviterCount = inviterCount;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getRevisionUserName() {
        return revisionUserName;
    }

    public void setRevisionUserName(String revisionUserName) {
        this.revisionUserName = revisionUserName;
    }

    public Integer getRevisionInviterCount() {
        return revisionInviterCount;
    }

    public void setRevisionInviterCount(Integer revisionInviterCount) {
        this.revisionInviterCount = revisionInviterCount;
    }

    public String getWeekTopDataStr() {
        return weekTopDataStr;
    }

    public void setWeekTopDataStr(String weekTopDataStr) {
        this.weekTopDataStr = weekTopDataStr;
    }

}