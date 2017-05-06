package com.yilidi.o2o.product.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.UserRedEnvelopeActivity;

/**
 * 用户抢红包信息Mapper
 * 
 * @author: chenlian
 * @date: 2016年11月3日 上午9:56:46
 */
public interface UserRedEnvelopeActivityMapper {

    /**
     * 新增用户抢红包信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    Integer save(UserRedEnvelopeActivity record);

    /**
     * 根据id更新用户抢红包信息
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    Integer updateById(UserRedEnvelopeActivity record);

    /**
     * 根据id更新用户抢红包次数
     * 
     * @param record
     *            记录
     * @param playCountLimit
     *            限参与抢红包活动次数
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    Integer updateByIdWithCountLimit(@Param("record") UserRedEnvelopeActivity record,
            @Param("playCountLimit") Integer playCountLimit);

    /**
     * 根据id更新用户抢到的红包数量
     * 
     * @param recordId
     *            记录ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    Integer updateByIdWithRedEnvelopeCount(@Param("recordId") Integer recordId);

    /**
     * 根据id加载用户抢红包信息
     * 
     * @param id
     *            记录id
     * @return 用户抢红包信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    UserRedEnvelopeActivity loadById(@Param("id") Integer id);

    /**
     * 根据红包活动id和用户id以及活动参与日期加载用户抢红包信息
     * 
     * @param redEnvelopeActivityId
     *            抢红包活动id
     * @param userId
     *            用户id
     * @param playDate
     *            抢红包日期
     * @return 用户抢红包信息记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_USER_RED_ENVELOPE_ACTIVITY })
    UserRedEnvelopeActivity loadByActivityIdAndUserIdAndPlayDate(
            @Param("redEnvelopeActivityId") Integer redEnvelopeActivityId, @Param("userId") Integer userId,
            @Param("playDate") Date playDate);

}