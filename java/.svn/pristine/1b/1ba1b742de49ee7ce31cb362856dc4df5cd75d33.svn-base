package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SecKillProduct;
import com.yilidi.o2o.product.model.combination.SecKillProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.SecKillSaleProductRelatedInfo;
import com.yilidi.o2o.product.model.query.SecKillProductQuery;

/**
 * 功能描述：秒杀商品基础信息数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SecKillProductMapper {

    /**
     * 保存秒杀商品基础信息
     * 
     * @param record
     *            秒杀商品基础信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT })
    Integer save(SecKillProduct record);

    /**
     * 根据秒杀商品ID删除秒杀商品
     * 
     * @param id
     *            秒杀商品ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT })
    Integer deleteById(Integer id);

    /**
     * 修改秒杀商品信息
     * 
     * @param secKillProduct
     *            秒杀商品信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT })
    Integer update(SecKillProduct secKillProduct);

    /**
     * 根据秒杀商品ID查找秒杀商品信息
     * 
     * @param id
     *            秒杀商品ID
     * @return 秒杀商品信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT })
    SecKillProduct loadById(Integer id);

    /**
     * 根据活动ID和产品ID获取秒杀商品信息
     * 
     * @param activityId
     *            活动ID
     * @param productId
     *            产品ID
     * @return 秒杀商品场次信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_PRODUCT, DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    SecKillProductRelatedInfo loadByActivityIdAndProductId(@Param("activityId") Integer activityId,
            @Param("productId") Integer productId);

    /**
     * 根据场次ID获取所关联的商品
     * 
     * @param sceneId
     *            场次ID
     * @return 秒杀商品分页列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_PRODUCT, DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    List<SecKillProductRelatedInfo> listSecKillProductBySeceneId(@Param("sceneId") Integer sceneId);

    /**
     * 查找秒杀商品分页列表
     * 
     * @param secKillProductQuery
     *            秒杀商品查询条件
     * @return 秒杀商品分页列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_PRODUCT })
    Page<SecKillProductRelatedInfo> findSecKillProducts(SecKillProductQuery secKillProductQuery);

    /**
     * 查找秒杀商品分页列表
     * 
     * @param secKillProductQuery
     *            秒杀商品查询条件
     * @return 秒杀商品分页列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_PRODUCT, DBTablesName.Product.P_SECKILL_SCENE,
            DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Page<SecKillProductRelatedInfo> findCommbinationSecKillProducts(SecKillProductQuery secKillProductQuery);

    /**
     * 查询秒杀商品分页信息列表,不包含场次已关联的秒杀商品
     * 
     * @param secKillProductQuery
     *            秒杀商品查询条件
     * @return 秒杀商品分页列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_PRODUCT, DBTablesName.Product.P_SECKILL_SCENE,
            DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    Page<SecKillProductRelatedInfo> findExcludeSecKillSceneRelationSecKillProducts(SecKillProductQuery secKillProductQuery);

    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SECKILL_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT, DBTablesName.Product.P_SECKILL_SCENE,
            DBTablesName.Product.P_SECKILL_SCENE_PRODUCT_RELATION })
    /**
     * 根据活动ID和店铺ID查找秒杀商品信息列表
     * 
     * @param storeId
     *            店铺ID
     * @param activityId
     *            活动ID
     * @param statusCode
     *            场次关联秒杀商品状态
     * @param secKillProductStatus
     * @param saleEnableFlag
     *            店铺商品是否有效状态
     * @param saleStatus
     *            店铺商品状态上下架状态
     * @return 秒杀商品信息列表
     */
    List<SecKillSaleProductRelatedInfo> listSecKillSaleProductByActivityIdAndStoreId(@Param("storeId") Integer storeId,
            @Param("activityId") Integer activityId, @Param("statusCode") String statusCode,
            @Param("secKillProductStatus") String secKillProductStatus, @Param("enableFlag") String saleEnableFlag,
            @Param("saleStatus") String saleStatus);
}