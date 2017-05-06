package com.yilidi.o2o.appvo.buyer.product;

import java.util.Date;

/**
 * 查询秒杀活动信息列表出参实体
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class SecKillInfoListVO extends SecKillSceneVO {

    private static final long serialVersionUID = -6431644011064995087L;
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
