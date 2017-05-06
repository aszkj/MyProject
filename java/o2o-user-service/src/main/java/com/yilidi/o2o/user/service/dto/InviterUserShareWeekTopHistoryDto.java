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
 * 功能描述：用户邀请排行榜修改历史DTO<br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class InviterUserShareWeekTopHistoryDto extends BaseDto {

    private static final long serialVersionUID = 6712690932318649399L;
    /**
     * 主键,自增
     */
    private Integer id;
    /**
     * 邀请用户名称
     */
    private String userName;
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
     * 修改批次编号,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE)
     */
    private String revisionBatchCode;

    /**
     * 操作描述
     */
    private String operationDesc;
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

    public String getRevisionBatchCode() {
        return revisionBatchCode;
    }

    public void setRevisionBatchCode(String revisionBatchCode) {
        this.revisionBatchCode = revisionBatchCode;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
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
}