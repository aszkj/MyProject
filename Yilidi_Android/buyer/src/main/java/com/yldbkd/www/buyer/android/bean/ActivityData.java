package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 9:56
 * @描述  活动信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ActivityData extends BaseModel {
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
