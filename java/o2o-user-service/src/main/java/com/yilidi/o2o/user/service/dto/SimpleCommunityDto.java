package com.yilidi.o2o.user.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 简单的小区基本信息DTO
 * 
 * @author: chenlian
 * @date: 2016年6月28日 上午11:29:06
 */
public class SimpleCommunityDto extends BaseDto {

    private static final long serialVersionUID = 2564056600842289936L;

    /**
     * 小区ID
     */
    private Integer communityId;

    /**
     * 小区名称
     */
    private String communityName;

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }
}
