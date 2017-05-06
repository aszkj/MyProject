package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.dao.SmsNotifyMessageMapper;
import com.yilidi.o2o.system.model.SmsNotifyMessage;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.query.SmsNotifyMessageQuery;

/**
 * 短信通知消息Service实现类
 * 
 * @Description:TODO(短信通知消息Service实现类)
 * @author: chenlian
 * @date: 2015年10月28日 下午9:59:51
 * 
 */
@Service("smsNotifyMessageService")
public class SmsNotifyMessageServiceImpl extends BasicDataService implements ISmsNotifyMessageService {

    @Autowired
    private SmsNotifyMessageMapper smsNotifyMessageMapper;

    /**
     * 保存发送短信日志信息
     * 
     * @param smsNotifyMessageDto
     * @throws SystemServiceException
     */
    @Override
    public void save(SmsNotifyMessageDto smsNotifyMessageDto) throws SystemServiceException {
        try {
            SmsNotifyMessage smsNotifyMessage = new SmsNotifyMessage();
            ObjectUtils.fastCopy(smsNotifyMessageDto, smsNotifyMessage);
            smsNotifyMessageMapper.save(smsNotifyMessage);
        } catch (Exception e) {
            String msg = "保存发送短信日志信息出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<SmsNotifyMessageDto> findSmsNotifyMessages(SmsNotifyMessageQuery query) throws SystemServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<SmsNotifyMessage> page = smsNotifyMessageMapper.findSmsNotifyMessages(query);
            Page<SmsNotifyMessageDto> pageDto = new Page<SmsNotifyMessageDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<SmsNotifyMessage> smsNotifyMessages = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(smsNotifyMessages)) {
                for (SmsNotifyMessage message : smsNotifyMessages) {
                    SmsNotifyMessageDto messageDto = new SmsNotifyMessageDto();
                    ObjectUtils.fastCopy(message, messageDto);
                    pageDto.add(messageDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findSmsNotifyMessages查找短信通知异常", e);
            throw new UserServiceException("查找短信通知异常", e);
        }
    }

    @Override
    public List<Integer> saveBatch(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException {
        try {
            List<Integer> idList = new ArrayList<Integer>();
            for (SmsNotifyMessageDto smsNotifyMessageDto : smsNotifyMessageDtoList) {
                SmsNotifyMessage smsNotifyMessage = new SmsNotifyMessage();
                ObjectUtils.fastCopy(smsNotifyMessageDto, smsNotifyMessage);
                smsNotifyMessageMapper.save(smsNotifyMessage);
                idList.add(smsNotifyMessage.getId());
            }
            return idList;
        } catch (Exception e) {
            String msg = "批量保存发送短信日志信息出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public void updateSendStatus(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(smsNotifyMessageDtoList)) {
                for (SmsNotifyMessageDto smsNotifyMessageDto : smsNotifyMessageDtoList) {
                    SmsNotifyMessage smsNotifyMessage = new SmsNotifyMessage();
                    ObjectUtils.fastCopy(smsNotifyMessageDto, smsNotifyMessage);
                    smsNotifyMessageMapper.updateSendStatus(smsNotifyMessage,
                            SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT);
                }
            }
        } catch (Exception e) {
            String msg = "更新短信通知信息发送状态出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public void updateReportStatus(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(smsNotifyMessageDtoList)) {
                for (SmsNotifyMessageDto smsNotifyMessageDto : smsNotifyMessageDtoList) {
                    SmsNotifyMessage smsNotifyMessage = new SmsNotifyMessage();
                    ObjectUtils.fastCopy(smsNotifyMessageDto, smsNotifyMessage);
                    smsNotifyMessageMapper.updateReportStatus(smsNotifyMessage,
                            SystemContext.SystemDomain.NOTIFYMSGREPORTSTATUS_NOTYET);
                }
            }
        } catch (Exception e) {
            String msg = "更新短信通知信息回执报告状态出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public Integer dailySendSmsCountWithOneUser(String toUser, Date todayStartDate, Date todayEndDate)
            throws SystemServiceException {
        try {
            return smsNotifyMessageMapper.dailySendSmsCountWithOneUser(toUser,
                    SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT, SystemContext.SystemDomain.NOTIFYMSGSTATUS_SUCCEED,
                    todayStartDate, todayEndDate);
        } catch (Exception e) {
            String msg = "获取每日每个用户发送非失败短信次数出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

}
