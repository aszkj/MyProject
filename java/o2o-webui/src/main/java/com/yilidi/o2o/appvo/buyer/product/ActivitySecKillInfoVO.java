package com.yilidi.o2o.appvo.buyer.product;

import java.util.Date;

/**
 * 根据秒杀活动ID查询活动商品列表接口出参实体
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class ActivitySecKillInfoVO extends SecKillSceneVO {

    private static final long serialVersionUID = -671382910287269872L;
    /**
     * 系统当前时间
     */
    private Date systemTime;

    public Date getSystemTime() {
        return systemTime;
    }

    public void setSystemTime(Date systemTime) {
        this.systemTime = systemTime;
    }

}
