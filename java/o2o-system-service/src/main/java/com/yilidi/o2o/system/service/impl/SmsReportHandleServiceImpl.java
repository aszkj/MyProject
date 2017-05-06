package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.ISmsReportHandleService;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.sms.huaxin.SmsHuaxinUtils;
import com.yilidi.o2o.system.sms.huaxin.model.report.ReportReturnInfo;
import com.yilidi.o2o.system.sms.huaxin.model.report.StatusInfo;

/**
 * @Description: TODO(短信回执信息处理接口实现类)
 * @author: chenlian
 * @date: 2016年6月7日 下午5:49:26
 */
@Service("smsReportHandleService")
public class SmsReportHandleServiceImpl extends BasicDataService implements ISmsReportHandleService {

    private static final String REPORT_STATUS_SUCCESS_CODE = "DELIVRD";

    @Autowired
    private SmsHuaxinUtils smsHuaxinUtils;

    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;

    @Override
    public void handleSmsReport() throws SystemServiceException {
        try {
            ReportReturnInfo reportReturnInfo = smsHuaxinUtils.report();
            logger.info("reportReturnInfo : " + JsonUtils.toJsonStringWithDateFormat(reportReturnInfo));
            if (null != reportReturnInfo) {
                List<SmsNotifyMessageDto> smsNotifyMessageDtoList = null;
                List<StatusInfo> statusbox = reportReturnInfo.getStatusbox();
                if (!ObjectUtils.isNullOrEmpty(statusbox)) {
                    smsNotifyMessageDtoList = new ArrayList<SmsNotifyMessageDto>();
                    for (StatusInfo statusInfo : statusbox) {
                        SmsNotifyMessageDto smsNotifyMessageDto = new SmsNotifyMessageDto();
                        smsNotifyMessageDto.setSmsJobId(statusInfo.getTaskid());
                        smsNotifyMessageDto.setToUser(statusInfo.getMobile());
                        smsNotifyMessageDto
                                .setReportStatus(REPORT_STATUS_SUCCESS_CODE.equals(statusInfo.getErrorcode()) ? SystemContext.SystemDomain.NOTIFYMSGREPORTSTATUS_SUCCEED
                                        : SystemContext.SystemDomain.NOTIFYMSGREPORTSTATUS_FAILED);
                        smsNotifyMessageDto.setReportTime(DateUtils.parseDate(statusInfo.getReceivetime()));
                        smsNotifyMessageDtoList.add(smsNotifyMessageDto);
                    }
                    smsNotifyMessageService.updateReportStatus(smsNotifyMessageDtoList);
                }
            }
        } catch (Exception e) {
            String msg = "处理短信回执信息出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

}
