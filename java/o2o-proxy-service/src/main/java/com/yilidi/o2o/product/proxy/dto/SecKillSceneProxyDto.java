package com.yilidi.o2o.product.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：秒杀场次代理DTO 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillSceneProxyDto extends BaseDto {

    private static final long serialVersionUID = -6519444159788995710L;
    /**
     * 秒杀场次ID
     */
    private Integer sceneId;
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

    public Integer getSceneId() {
        return sceneId;
    }

    public void setSceneId(Integer sceneId) {
        this.sceneId = sceneId;
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

}