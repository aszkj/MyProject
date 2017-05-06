package com.yilidi.o2o.schedule;

/**
 * @Description: TODO(定时扫描过期的Session接口)
 * @author: chenlian
 * @date: 2016年5月30日 上午9:31:46
 */
public interface ISessionTimeoutCheck {

    public void check() throws Exception;

}
