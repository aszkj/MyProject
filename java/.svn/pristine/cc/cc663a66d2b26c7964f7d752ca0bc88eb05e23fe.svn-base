package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.model.query.PushNotifyMessageQuery;
import com.yilidi.o2o.system.service.dto.PushNotifyMessageDto;

/**
 * 推送通知消息Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:08:15
 */
public interface IPushNotifyMessageService {

    /**
     * 保存推送通知信息
     * 
     * @param pushNotifyMessageDto
     * @throws SystemServiceException
     */
    public void save(PushNotifyMessageDto pushNotifyMessageDto) throws SystemServiceException;

    /**
     * @Description TODO(批量保存推送通知信息)
     * @param pushNotifyMessageDtoList
     * @return List<Integer> 批量新增的主键ID列表
     * @throws SystemServiceException
     */
    public List<Integer> saveBatch(List<PushNotifyMessageDto> pushNotifyMessageDtoList) throws SystemServiceException;

    /**
     * 分页查询用户推送通知信息列表
     * 
     * @param query
     * @return Page<PushNotifyMessageDto>
     * @throws SystemServiceException
     */
    public YiLiDiPage<PushNotifyMessageDto> findPushNotifyMessages(PushNotifyMessageQuery query)
            throws SystemServiceException;

    /**
     * @Description TODO(调用推送发送接口后，更新推送通知信息发送状态)
     * @param pushNotifyMessageDtoList
     * @throws SystemServiceException
     */
    public void updateSendStatus(List<PushNotifyMessageDto> pushNotifyMessageDtoList) throws SystemServiceException;

}
