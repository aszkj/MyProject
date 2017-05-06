package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
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
import com.yilidi.o2o.system.dao.PushNotifyMessageMapper;
import com.yilidi.o2o.system.model.PushNotifyMessage;
import com.yilidi.o2o.system.model.query.PushNotifyMessageQuery;
import com.yilidi.o2o.system.service.IPushNotifyMessageService;
import com.yilidi.o2o.system.service.dto.PushNotifyMessageDto;

/**
 * 推送通知消息Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:05:24
 */
@Service("pushNotifyMessageService")
public class PushNotifyMessageServiceImpl extends BasicDataService implements IPushNotifyMessageService {

    @Autowired
    private PushNotifyMessageMapper pushNotifyMessageMapper;

    @Override
    public void save(PushNotifyMessageDto pushNotifyMessageDto) throws SystemServiceException {
        try {
            PushNotifyMessage pushNotifyMessage = new PushNotifyMessage();
            ObjectUtils.fastCopy(pushNotifyMessageDto, pushNotifyMessage);
            pushNotifyMessageMapper.save(pushNotifyMessage);
        } catch (Exception e) {
            String msg = "保存发送推送日志信息出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<PushNotifyMessageDto> findPushNotifyMessages(PushNotifyMessageQuery query)
            throws SystemServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<PushNotifyMessage> page = pushNotifyMessageMapper.findPushNotifyMessages(query);
            Page<PushNotifyMessageDto> pageDto = new Page<PushNotifyMessageDto>(query.getStart(), query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<PushNotifyMessage> pushNotifyMessages = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(pushNotifyMessages)) {
                for (PushNotifyMessage message : pushNotifyMessages) {
                    PushNotifyMessageDto messageDto = new PushNotifyMessageDto();
                    ObjectUtils.fastCopy(message, messageDto);
                    pageDto.add(messageDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findPushNotifyMessages查找推送通知异常", e);
            throw new UserServiceException("查找推送通知异常", e);
        }
    }

    @Override
    public List<Integer> saveBatch(List<PushNotifyMessageDto> pushNotifyMessageDtoList) throws SystemServiceException {
        try {
            List<Integer> idList = new ArrayList<Integer>();
            for (PushNotifyMessageDto pushNotifyMessageDto : pushNotifyMessageDtoList) {
                PushNotifyMessage pushNotifyMessage = new PushNotifyMessage();
                ObjectUtils.fastCopy(pushNotifyMessageDto, pushNotifyMessage);
                pushNotifyMessageMapper.save(pushNotifyMessage);
                idList.add(pushNotifyMessage.getId());
            }
            return idList;
        } catch (Exception e) {
            String msg = "批量保存发送推送日志信息出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public void updateSendStatus(List<PushNotifyMessageDto> pushNotifyMessageDtoList) throws SystemServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(pushNotifyMessageDtoList)) {
                for (PushNotifyMessageDto pushNotifyMessageDto : pushNotifyMessageDtoList) {
                    PushNotifyMessage pushNotifyMessage = new PushNotifyMessage();
                    ObjectUtils.fastCopy(pushNotifyMessageDto, pushNotifyMessage);
                    pushNotifyMessageMapper.updateSendStatus(pushNotifyMessage,
                            SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT);
                }
            }
        } catch (Exception e) {
            String msg = "更新推送通知信息发送状态出现异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

}
