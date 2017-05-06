package com.yilidi.o2o.system.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.query.SmsNotifyMessageQuery;

/**
 * 短信通知消息Service接口
 * 
 * @Description:TODO(短信通知消息Service接口)
 * @author: chenlian
 * @date: 2015年10月28日 下午9:49:18
 * 
 */
public interface ISmsNotifyMessageService {

    /**
     * 保存短信通知信息
     * 
     * @param smsNotifyMessageDto
     * @return
     * @throws SystemServiceException
     */
    public void save(SmsNotifyMessageDto smsNotifyMessageDto) throws SystemServiceException;

    /**
     * @Description TODO(批量保存短信通知信息)
     * @param smsNotifyMessageDtoList
     * @return List<Integer> 批量新增的主键ID列表
     * @throws SystemServiceException
     */
    public List<Integer> saveBatch(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException;

    /**
     * 分页查询用户短信通知信息列表
     * 
     * @param query
     * @return Page<SmsNotifyMessageDto>
     * @throws SystemServiceException
     */
    public YiLiDiPage<SmsNotifyMessageDto> findSmsNotifyMessages(SmsNotifyMessageQuery query) throws SystemServiceException;

    /**
     * @Description TODO(调用短信发送接口后，更新短信通知信息发送状态)
     * @param smsNotifyMessageDtoList
     * @throws SystemServiceException
     */
    public void updateSendStatus(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException;

    /**
     * @Description TODO(调用短信回执报告接口后，更新短信通知信息回执报告状态)
     * @param smsNotifyMessageDtoList
     * @throws SystemServiceException
     */
    public void updateReportStatus(List<SmsNotifyMessageDto> smsNotifyMessageDtoList) throws SystemServiceException;

    /**
     * @Description TODO(获取每日每个用户发送非失败短信次数)
     * @param toUser
     * @param todayStartDate
     * @param todayEndDate
     * @return Integer
     * @throws SystemServiceException
     */
    public Integer dailySendSmsCountWithOneUser(String toUser, Date todayStartDate, Date todayEndDate)
            throws SystemServiceException;
}
