package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

public class VipUserStatisticInfo extends BaseModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7185579307802183692L;

    /**
     * 统计日期
     */
    private String statisticDate;
    /**
     * 注册会员数
     */
    private Integer registCount;
    /**
     * 铂金会员数
     */
    private Integer vipUserCount;

    public String getStatisticDate() {
        return statisticDate;
    }

    public void setStatisticDate(String statisticDate) {
        this.statisticDate = statisticDate;
    }

    public Integer getRegistCount() {
        return registCount;
    }

    public void setRegistCount(Integer registCount) {
        this.registCount = registCount;
    }

    public Integer getVipUserCount() {
        return vipUserCount;
    }

    public void setVipUserCount(Integer vipUserCount) {
        this.vipUserCount = vipUserCount;
    }

}
