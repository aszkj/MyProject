package com.yilidi.o2o.core.payment.tencent.common.report;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;

import com.yilidi.o2o.core.payment.tencent.common.report.service.ReportService;

/**
 * 上报运行实现类
 * 
 * @author simpson
 * 
 */
public class ReportRunable implements Runnable {

    private ReportService reportService;

    ReportRunable(ReportService rs) {
        reportService = rs;
    }

    @Override
    public void run() {
        try {
            reportService.request();
        } catch (UnrecoverableKeyException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyStoreException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
