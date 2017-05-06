package com.yilidi.o2o.system.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.PushNotifyMessage;
import com.yilidi.o2o.system.model.query.PushNotifyMessageQuery;

/**
 * 推送通知消息Mapper接口
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午2:03:35
 */
public interface PushNotifyMessageMapper {

    /**
     * 保存消息
     * 
     * @param record
     *            消息对象实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PUSH_NOTIFY_MESSAGE })
    Integer save(PushNotifyMessage record);

    /**
     * 分页查询用户推送通知信息列表
     * 
     * @param query
     * @return Page<PushNotifyMessage>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PUSH_NOTIFY_MESSAGE })
    Page<PushNotifyMessage> findPushNotifyMessages(PushNotifyMessageQuery query);

    /**
     * @Description TODO(调用推送发送接口后，更新推送通知信息发送状态)
     * @param pushNotifyMessage
     * @param sendStatus
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PUSH_NOTIFY_MESSAGE })
    void updateSendStatus(@Param("pushNotifyMessage") PushNotifyMessage pushNotifyMessage,
            @Param("sendStatus") String sendStatus);

}