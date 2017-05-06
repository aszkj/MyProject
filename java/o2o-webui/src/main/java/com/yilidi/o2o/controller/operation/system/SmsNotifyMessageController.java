package com.yilidi.o2o.controller.operation.system;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.query.SmsNotifyMessageQuery;

/**
 * 短信通知Controller
 * 
 * @author: llp
 * @date: 2015年12月9日 下午5:48:24
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class SmsNotifyMessageController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;

    /**
     * 分页查询用户短信通知
     * 
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/searchSmsNotifyMessages")
    @ResponseBody
    public MsgBean searchSmsNotifyMessages(@RequestBody SmsNotifyMessageQuery query) {
        try {
            if (!StringUtils.isEmpty(query.getStartSendTime())) {
                query.setStartSendDate(DateUtils.getSpecificStartDate(query.getStartSendTime()));
            }
            if (!StringUtils.isEmpty(query.getEndSendTime())) {
                query.setEndSendDate(DateUtils.getSpecificEndDate(query.getEndSendTime()));
            }
            if (!StringUtils.isEmpty(query.getStartReportTime())) {
                query.setStartReportDate(DateUtils.getSpecificStartDate(query.getStartReportTime()));
            }
            if (!StringUtils.isEmpty(query.getEndReportTime())) {
                query.setEndReportDate(DateUtils.getSpecificEndDate(query.getEndReportTime()));
            }
            YiLiDiPage<SmsNotifyMessageDto> page = smsNotifyMessageService.findSmsNotifyMessages(query);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "分页查询用户短信通知成功");
        } catch (Exception e) {
            logger.error("分页查询用户短信通知失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}