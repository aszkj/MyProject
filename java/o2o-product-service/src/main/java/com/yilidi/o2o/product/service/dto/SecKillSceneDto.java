package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：秒杀场次实体类，映射商品域表YiLiDiProductCenter.P_SECKILL_SCENE <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillSceneDto extends BaseDto {

    private static final long serialVersionUID = -6519444159788995710L;
    /**
     * 秒杀场次ID，自增主键
     */
    private Integer id;
    /**
     * 基础活动ID
     */
    private Integer activityId;
    /**
     * 秒杀场次名称
     */
    private String sceneName;
    /**
     * 场次开始时间
     */
    private Date startTime;
    /**
     * 场次结束时间
     */
    private Date endTime;
    /**
     * 场次重复类型,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SECKILLSCENEREPEATTYPE),默认不重复
     */
    private String repeatType;
    /**
     * 重复类型名称
     */
    private String repeatTypeName;
    /**
     * 场次状态,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SECKILLSCENESTATUSCODE),默认未开始
     */
    private String statusCode;
    /**
     * 场次状态名称
     */
    private String statusCodeName;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建用户名称
     */
    private String createUserName;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 最后操作用户ID
     */
    private Integer updateUserId;
    /**
     * 最后操作时间
     */
    private Date updateTime;
    /**
     * 开始时间字符串
     */
    private String strStartTime;

    private List<SecKillProductDto> secKillProductDtos;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public String getSceneName() {
        return sceneName;
    }

    public void setSceneName(String sceneName) {
        this.sceneName = sceneName;
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

    public String getRepeatType() {
        return repeatType;
    }

    public void setRepeatType(String repeatType) {
        this.repeatType = repeatType;
    }

    public String getRepeatTypeName() {
        return repeatTypeName;
    }

    public void setRepeatTypeName(String repeatTypeName) {
        this.repeatTypeName = repeatTypeName;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getStrStartTime() {
        return strStartTime;
    }

    public void setStrStartTime(String strStartTime) {
        this.strStartTime = strStartTime;
    }

    public List<SecKillProductDto> getSecKillProductDtos() {
        return secKillProductDtos;
    }

    public void setSecKillProductDtos(List<SecKillProductDto> secKillProductDtos) {
        this.secKillProductDtos = secKillProductDtos;
    }

}