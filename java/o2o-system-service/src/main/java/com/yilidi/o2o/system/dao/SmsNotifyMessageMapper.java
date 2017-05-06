package com.yilidi.o2o.system.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.SmsNotifyMessage;
import com.yilidi.o2o.system.service.dto.query.SmsNotifyMessageQuery;

/**
 * 短信通知消息Mapper接口
 * 
 * @Description:TODO(短信通知消息Mapper接口)
 * @author: chenlian
 * @date: 2015-9-21 上午10:12:56
 * 
 */
public interface SmsNotifyMessageMapper {

    /**
     * 保存消息
     * 
     * @param record
     *            消息对象实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    Integer save(SmsNotifyMessage record);

    /**
     * 根据ID删除通知消息
     * 
     * @param id
     *            消息ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    Integer deleteById(Integer id);

    /**
     * 根据ID加载通知消息
     * 
     * @param id
     *            消息ID
     * @return 消息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    SmsNotifyMessage loadById(Integer id);

    /**
     * 根据接收者的名称加载消息列表
     * 
     * @param toUser
     *            消息接收者
     * @return 消息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    List<SmsNotifyMessage> listByReciever(String toUser);

    /**
     * 分页查询用户短信通知信息列表
     * 
     * @param query
     * @return Page<SmsNotifyMessage>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    Page<SmsNotifyMessage> findSmsNotifyMessages(SmsNotifyMessageQuery query);

    /**
     * @Description TODO(调用短信发送接口后，更新短信通知信息发送状态)
     * @param smsNotifyMessage
     * @param sendStatus
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    void updateSendStatus(@Param("smsNotifyMessage") SmsNotifyMessage smsNotifyMessage,
            @Param("sendStatus") String sendStatus);

    /**
     * @Description TODO(调用短信回执报告接口后，更新短信通知信息回执报告状态)
     * @param smsNotifyMessage
     * @param reportStatus
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    void updateReportStatus(@Param("smsNotifyMessage") SmsNotifyMessage smsNotifyMessage,
            @Param("reportStatus") String reportStatus);

    /**
     * @Description TODO(获取每日每个用户发送非失败短信次数)
     * @param toUser
     * @param massageStatusInit
     * @param massageStatusSucceed
     * @param todayStartDate
     * @param todayEndDate
     * @return Integer
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SMS_NOTIFY_MESSAGE })
    Integer dailySendSmsCountWithOneUser(@Param("toUser") String toUser,
            @Param("massageStatusInit") String massageStatusInit,
            @Param("massageStatusSucceed") String massageStatusSucceed, @Param("todayStartDate") Date todayStartDate,
            @Param("todayEndDate") Date todayEndDate);
}