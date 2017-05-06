package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.RedEnvelopeReward;

/**
 * 红包奖励信息Mapper
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午5:40:18
 */
public interface RedEnvelopeRewardMapper {

    /**
     * 新增红包奖励信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_RED_ENVELOPE_REWARD })
    Integer save(RedEnvelopeReward record);

    /**
     * 根据id更新红包奖励信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_RED_ENVELOPE_REWARD })
    Integer updateById(RedEnvelopeReward record);

    /**
     * 根据id加载红包奖励信息
     * 
     * @param id
     *            记录id
     * @return 红包奖励信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_REWARD })
    RedEnvelopeReward loadById(@Param("id") Integer id);

    /**
     * 获取红包奖励信息列表
     * 
     * @param redEnvelopeActivityId
     *            抢红包活动ID
     * @param rewardStatus
     *            奖励状态
     * @return 红包奖励信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_REWARD })
    List<RedEnvelopeReward> listRedEnvelopeRewards(@Param("redEnvelopeActivityId") Integer redEnvelopeActivityId,
            @Param("rewardStatus") String rewardStatus);

}