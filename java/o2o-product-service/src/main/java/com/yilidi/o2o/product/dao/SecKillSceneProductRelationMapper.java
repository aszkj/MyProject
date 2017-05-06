package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SecKillSceneProductRelation;

/**
 * 功能描述：场次产品关联数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SecKillSceneProductRelationMapper {

    /**
     * 保存场次产品关联信息
     * 
     * @param record
     *            场次产品关联信息
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Integer save(SecKillSceneProductRelation record);

    /**
     * 批量保存场次商品关联信息
     * 
     * @param list
     *            场次商品关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    void batchSave(List<SecKillSceneProductRelation> list);

    /**
     * 根据ID删除场次产品关联信息
     * 
     * @param id
     *            场次产品关联ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Integer deleteById(@Param("id") Integer id);

    /**
     * 根据场次产品关联ID获取场次产品关联基本信息
     * 
     * @param id
     *            场次产品关联ID
     * @return 场次产品关联信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    SecKillSceneProductRelation loadById(@Param("id") Integer id);

    /**
     * 根据场次ID和秒杀商品ID获取场次产品关联基本信息
     * 
     * @param secKillSceneId
     *            场次ID
     * @param secKillProductId
     *            秒杀商品ID
     * @return 场次产品关联信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    SecKillSceneProductRelation loadBySceneIdAndSecKillProductId(@Param("secKillSceneId") Integer secKillSceneId,
            @Param("secKillProductId") Integer secKillProductId);

    /**
     * 根据场次ID和产品ID获取场次产品关联基本信息
     * 
     * @param secKillSceneId
     *            场次ID
     * @param productId
     *            产品ID
     * @return 场次产品关联信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION,
            DBTablesName.Product.P_SECKILL_PRODUCT })
    SecKillSceneProductRelation loadBySceneIdAndProductId(@Param("secKillSceneId") Integer secKillSceneId,
            @Param("productId") Integer productId);

    /**
     * 根据场次ID查询场次秒杀商品关联列表
     * 
     * @param secKillSceneId
     *            场次ID
     * @return 场次产品关联信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    List<SecKillSceneProductRelation> listBySceneId(@Param("secKillSceneId") Integer secKillSceneId);

    /**
     * 根据场次ID和产品ID获取场次产品关联基本信息（不用缓存）
     * 
     * @param secKillSceneId
     *            场次ID
     * @param productId
     *            产品ID
     * @return 场次产品关联信息
     */
    SecKillSceneProductRelation loadBySceneIdAndProductIdNoCache(@Param("secKillSceneId") Integer secKillSceneId,
            @Param("productId") Integer productId);

    /**
     * 根据场次ID和秒杀商品ID删除信息
     * 
     * @param secKillSceneId
     *            场次ID
     * @param secKillProductId
     *            秒杀商品ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Integer deleteBySceneIdAndSecKillProductId(@Param("secKillSceneId") Integer secKillSceneId,
            @Param("secKillProductId") Integer secKillProductId);

    /**
     * 修改场次关联秒杀商品的状态
     * 
     * @param secKillSceneId
     *            场次ID
     * @param secKillProductId
     *            秒杀商品ID
     * @param statusCode
     *            场次关联秒杀商品状态编码
     * @param updateUserId
     *            操作用户ID
     * @param updateTime
     *            操作时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Integer updateStatusCodeBySceneIdAndSecKillProductId(@Param("secKillSceneId") Integer secKillSceneId,
            @Param("secKillProductId") Integer secKillProductId, @Param("statusCode") String statusCode,
            @Param("updateUserId") Integer updateUserId, @Param("updateTime") Date updateTime);
}