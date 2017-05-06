package com.yilidi.o2o.schedule.web;

import org.apache.log4j.Logger;

import com.yilidi.o2o.schedule.ISessionTimeoutCheck;

/**
 * @Description: TODO(通过定时任务扫描过期的Session)
 * @author: chenlian
 * @date: 2016年5月30日 上午9:30:59
 */
public class SessionTimeoutCheckJob {

    private Logger logger = Logger.getLogger(SessionTimeoutCheckJob.class);

    private ISessionTimeoutCheck sessionTimeoutCheck;

    protected synchronized void performance() {
        try {
            sessionTimeoutCheck.check();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    public ISessionTimeoutCheck getSessionTimeoutCheck() {
        return sessionTimeoutCheck;
    }

    public void setSessionTimeoutCheck(ISessionTimeoutCheck sessionTimeoutCheck) {
        this.sessionTimeoutCheck = sessionTimeoutCheck;
    }

}
