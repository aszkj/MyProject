package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.ProductImage;

/**
 * 功能描述：产品图片信息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductImageMapper {
    /**
     * 根据图片id查询图片信息
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param id
     *            产品图片id
     * @return 图片信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    ProductImage loadProductImageById(@Param("id") Integer id);

    /**
     * 保存产品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer saveProductImage(ProductImage record);

    /**
     * 根据id删除某一张图片信息
     * 
     * @param id
     *            图片信息ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer deleteProductImageById(@Param("id") Integer id);

    /**
     * 根据产品ID和渠道编码删除某产品的图片信息（该产品所有图片）
     * 
     * @param productId
     *            产品ID
     * @param channelCode
     *            渠道编码
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer deleteProductImageByProductIdAndChannelCode(@Param("productId") Integer productId,
            @Param("channelCode") String channelCode);

    /**
     * 根据imageUrl1删除某一张图片信息
     * 
     * @param 图片URL1
     *            imageUrl1
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer deleteProductImageByImageUrl1(@Param("imageUrl1") String imageUrl1);

    /**
     * 根据id设置主图的标志
     * 
     * @param masterFlag
     *            设置是否为主图
     * @param id
     *            将被设置为主图的图片ID
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer updateMasterFlagById(@Param("masterFlag") String masterFlag, @Param("modifyTime") Date modifyTime,
            @Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据ID更新图片的排列顺序
     * 
     * @param id
     *            图片id
     * @param imageOrder
     *            排序序号
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer updateImageOrderById(@Param("id") Integer id, @Param("imageOrder") Integer imageOrder,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 依据图片Id更新产品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    Integer updateProductImageById(ProductImage record);

    /**
     * 根据产品id和渠道查询该产品该渠道的图片列表信息
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param productId
     *            产品id
     * @param channelCode
     *            渠道编码
     * @return 图片信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_IMAGE })
    List<ProductImage> listProductImagesByProductIdAndChannelCode(@Param("productId") Integer productId,
            @Param("channelCode") String channelCode);

}