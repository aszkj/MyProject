package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 抵用券基础信息DTO
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午6:50:17
 */
public class VoucherBasicInfoDto extends BaseDto {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * 抵用券ID
     */
    private Integer vouPackId;

    /**
     * 抵用券包名称
     */
    private String vouPackName;

    /**
     * 抵用券发放时间
     */
    private Date grantTime;

    public Integer getVouPackId() {
        return vouPackId;
    }

    public void setVouPackId(Integer vouPackId) {
        this.vouPackId = vouPackId;
    }

    public String getVouPackName() {
        return vouPackName;
    }

    public void setVouPackName(String vouPackName) {
        this.vouPackName = vouPackName;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

}
