package com.yilidi.o2o.schedule.system;

import org.apache.log4j.Logger;

import com.yilidi.o2o.system.service.ISmsReportHandleService;

/**
 * @Description: TODO(扫描并处理短信回执报告信息定时任务)
 * @author: chenlian
 * @date: 2016年6月7日 下午5:47:30
 */
public class SmsReportHandleJob {

    private Logger logger = Logger.getLogger(SmsReportHandleJob.class);

    private ISmsReportHandleService smsReportHandleService;

    protected synchronized void performance() {
        try {
            logger.info("===============处理短信回执信息开始===============");
            smsReportHandleService.handleSmsReport();
            logger.info("===============处理短信回执信息结束===============");
        } catch (Exception e) {
            logger.error("处理短信回执信息产生系统故障！", e);
            throw new IllegalStateException(e);
        }
    }

    public ISmsReportHandleService getSmsReportHandleService() {
        return smsReportHandleService;
    }

    public void setSmsReportHandleService(ISmsReportHandleService smsReportHandleService) {
        this.smsReportHandleService = smsReportHandleService;
    }

}
