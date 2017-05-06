package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductProfile;

/**
 * 功能描述：商品附属数据层接口操作类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductProfileMapper {
    /**
     * 保存商品附属信息
     * 
     * @param record
     *            商品附属信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer saveSaleProductProfile(SaleProductProfile record);

    /**
     * 根据ID删除商品附属信息
     * 
     * @param id
     *            附属信息id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer deleteSaleProductProfileById(@Param("id") Integer id);

    /**
     * 根据商品id和渠道类型删除商品附属信息
     * 
     * @param saleProductId
     *            商品ID
     * @param channelCode
     *            渠道编码
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer deleteSaleProductProfileByProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
            @Param("channelCode") String channelCode);

    /**
     * 根据附属信息ID更新商品信息
     * 
     * @param record
     *            商品信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer updateSaleProductProfileById(SaleProductProfile record);

    /**
     * 根据商品ID和渠道编码更新商品附属信息
     * 
     * @param record
     *            商品信息
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer updateSaleProductProfileBySaleProductIdAndChannelCode(SaleProductProfile record);

    /**
     * 根据id更新商品的上下架状态
     * 
     * @param saleProductId
     *            商品id
     * @param saleStatus
     *            上下架状态
     * @param channelCode
     *            渠道编码
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer updateSaleStatusBySaleProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
            @Param("saleStatus") String saleStatus, @Param("channelCode") String channelCode,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据id更新商品的上下架状态
     * 
     * @param saleProductId
     *            商品productId
     * @param hotSaleFlag
     *            热卖状态
     * @param channelCode
     *            渠道编码
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer updateHotSaleFlagBySaleProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
            @Param("hotSaleFlag") String hotSaleFlag, @Param("channelCode") String channelCode,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据id更新商品的顺序
     * 
     * @param saleProductId
     *            商品productId
     * @param displayOrder
     *            商品顺序
     * @param channelCode
     *            渠道编码
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Integer updateSaleProductDisplayOrder(@Param("saleProductId") Integer saleProductId,
            @Param("displayOrder") Integer displayOrder, @Param("channelCode") String channelCode,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据商品附属信息id查询商品附属信息
     * 
     * <pre>
     * 注： 使用缓存查询数据
     * </pre>
     * 
     * @param id
     *            附属id
     * @return 商品附属信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    SaleProductProfile loadSaleProductProfileById(@Param("id") Integer id);

    /**
     * 根据商品id和渠道查询商品的附属信息
     * 
     * <pre>
     * 注： 使用缓存查询数据
     * </pre>
     * 
     * @param saleProductId
     *            商品ID
     * @param saleStatus
     *            上下架状态
     * @param channelCode
     *            渠道编码
     * @return 商品附属信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    SaleProductProfile loadSaleProductProfileBySaleProductIdAndSaleStatusAndChannelCode(
            @Param("saleProductId") Integer saleProductId, @Param("saleStatus") String saleStatus,
            @Param("channelCode") String channelCode);

    /**
     * 根据商品条形码以及店铺Id和渠道编码查询商品的附属信息
     * 
     * <pre>
     * 注： 使用缓存查询数据
     * </pre>
     * 
     * @param barCode
     *            条形码
     * @param storeId
     *            店铺ID
     * @param channelCode
     *            渠道编码
     * @return 商品附属信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE,
            DBTablesName.Product.P_SALE_PRODUCT })
    SaleProductProfile loadSaleProductProfileByBarCodeAndChannelCode(@Param("barCode") String barCode,
            @Param("storeId") Integer storeId, @Param("channelCode") String channelCode);

    /**
     * 根据商品ID列表查询商品上架的数量
     * 
     * <pre>
     * 注： 使用缓存查询数据
     * </pre>
     * 
     * @param saleProductIds
     *            商品ID列表
     * @return 商品上架的数量
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Long getOnSaleCountsBySaleProductIds(@Param("saleProductIds") List<Integer> saleProductIds);

}