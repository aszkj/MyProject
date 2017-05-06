package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.RedEnvelopeActivity;
import com.yilidi.o2o.product.model.combination.RedEnvelopeActivityInfo;
import com.yilidi.o2o.product.model.query.RedEnvelopeActivityQuery;

/**
 * 抢红包活动Mapper
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午4:14:32
 */
public interface RedEnvelopeActivityMapper {

    /**
     * 新增抢红包活动
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    Integer save(RedEnvelopeActivity record);

    /**
     * 根据id更新抢红包活动（如果字段值为null，则不更新该字段）
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    Integer updateByIdSelective(RedEnvelopeActivity record);

    /**
     * 根据id加载抢红包活动
     * 
     * @param id
     *            记录id
     * @return 抢红包活动记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    RedEnvelopeActivity loadById(@Param("id") Integer id);

    /**
     * 根据当前时间获取抢红包活动信息
     * 
     * @param currentDateTime
     *            当前时间
     * @return 抢红包活动记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    RedEnvelopeActivity loadByCurrentDateTime(@Param("currentDateTime") Date currentDateTime);

    /**
     * 根据全局活动ID获取抢红包活动信息
     * 
     * @param globalActivityId
     *            全局活动ID
     * @return 抢红包活动记录
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    RedEnvelopeActivity loadByGlobalActivityId(@Param("globalActivityId") Integer globalActivityId);

    /**
     * 分页获取抢红包活动列表
     * 
     * @param redEnvelopeActivityQuery
     *            抢红包活动查询实体
     * @return 抢红包活动列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    Page<RedEnvelopeActivityInfo> findRedEnvelopeActivities(RedEnvelopeActivityQuery redEnvelopeActivityQuery);

    /**
     * 获取抢红包活动列表
     * 
     * @return 抢红包活动列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_RED_ENVELOPE_ACTIVITY })
    List<RedEnvelopeActivity> listRedEnvelopeActivities();

}