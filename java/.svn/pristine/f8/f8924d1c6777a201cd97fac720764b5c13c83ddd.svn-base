package com.yilidi.o2o.core.payment.tencent.common.report;

import com.yilidi.o2o.core.payment.tencent.common.report.protocol.ReportReqData;

/**
 * 上报工厂类
 * 
 * @author simpson
 * 
 */
public final class ReporterFactory {

    private ReporterFactory() {
    }

    /**
     * 请求统计上报API
     * 
     * @param reportReqData
     *            这个数据对象里面包含了API要求提交的各种数据字段
     * @return 返回一个Reporter
     */
    public static Reporter getReporter(ReportReqData reportReqData) {
        return new Reporter(reportReqData);
    }

}
