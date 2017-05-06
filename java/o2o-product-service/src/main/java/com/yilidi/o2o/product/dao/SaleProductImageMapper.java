package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProductImage;

/**
 * 功能描述：商品图片信息数据层操作接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductImageMapper {
    /**
     * 根据图片id查询图片信息
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param id
     *            商品图片id
     * @return 图片信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    SaleProductImage loadSaleProductImageById(@Param("id") Integer id);

    /**
     * 保存商品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer saveSaleProductImage(SaleProductImage record);

    /**
     * 根据id删除图片信息
     * 
     * @param id
     *            图片信息ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer deleteSaleProductImageById(@Param("id") Integer id);

    /**
     * 根据商品id和渠道编码将该类商品的主图状态设置为0
     * 
     * @param saleProductId
     *            商品id（用来更新该商品的所有图片主图状态）
     * @param channelCode
     *            渠道编码
     * @param modifyUserId
     *            更新用户id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer updateMasterFlagDisabled(@Param("saleProductId") Integer saleProductId,
            @Param("channelCode") String channelCode, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据id设置主图的标志
     * 
     * @param id
     *            将被设置为主图的图片id
     * @param modifyUserId
     *            更新用户id
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer updateMasterFlagById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据ID更新图片的排列顺序
     * 
     * @param id
     *            图片id
     * @param sort
     *            排序
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer updateSortById(@Param("id") Integer id, @Param("sort") Integer sort);

    /**
     * 根据商品id和渠道查询该商品该渠道的图片列表信息
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param saleProductId
     *            商品id
     * @param channelCode
     *            渠道编码
     * @return 图片信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    List<SaleProductImage> listSaleProductImagesBySaleProductIdAndChannelCode(@Param("saleProductId") Integer saleProductId,
            @Param("channelCode") String channelCode);

    /**
     * 更新商品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    Integer updateSaleProductImage(SaleProductImage record);

    /**
     * 根据商品id和渠道查询该商品该渠道的主图片
     * 
     * <pre>
     * 注：使用缓存查询数据
     * 
     * @param salesProductId
     *            商品ID
     * @param channelCode
     *            渠道编码
     * @param masterFlag
     *            主图标识
     * @return SaleProductImage
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT_IMAGE })
    SaleProductImage loadSaleProductImageMasterBySaleProductIdAndChannelCode(@Param("saleProductId") Integer salesProductId,
            @Param("channelCode") String channelCode, @Param("masterFlag") String masterFlag);

}