package com.yilidi.o2o.core.payment.tencent.common.report;

import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;
import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;

/**
 * 上报器
 * 
 * @author simpson
 * 
 */
public class Reporter {

    private ReportRunable r;
    private Thread t;
    private ReportService rs;

    /**
     * 请求统计上报API
     * 
     * @param reportReqData
     *            这个数据对象里面包含了API要求提交的各种数据字段
     */
    public Reporter(ReportReqData reportReqData) {
        rs = new ReportService(reportReqData);
    }

    /**
     * 执行上报线程
     */
    public void run() {
        r = new ReportRunable(rs);
        t = new Thread(r);
        t.setDaemon(true); // 后台线程
        t.start();
    }
}
