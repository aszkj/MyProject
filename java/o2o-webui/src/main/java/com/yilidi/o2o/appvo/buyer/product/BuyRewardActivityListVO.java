package com.yilidi.o2o.appvo.buyer.product;

import com.yilidi.o2o.core.model.BaseVO;

/**
 * 商品买赠信息
 * 
 * @author: xiasl
 * @date: 2017年4月21日 09:45:47
 */
public class BuyRewardActivityListVO extends BaseVO {

    private static final long serialVersionUID = -1869850792551022030L;
    /**
     * 活动id
     */
    private Integer actId;
    /**
     * 活动名称
     */
    private String actName;
    /**
     * 活动类型：1：买赠
     */
    private Integer actType;
    /**
     * 活动类型名称
     */
    private String actTypeName;

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

    public String getActName() {
        return actName;
    }

    public void setActName(String actName) {
        this.actName = actName;
    }

    public Integer getActType() {
        return actType;
    }

    public void setActType(Integer actType) {
        this.actType = actType;
    }

    public String getActTypeName() {
        return actTypeName;
    }

    public void setActTypeName(String actTypeName) {
        this.actTypeName = actTypeName;
    }

}
