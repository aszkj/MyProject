package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.AuditProductImage;

/**
 * 数据包产品图片Mapper
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午2:17:46
 */
public interface AuditProductImageMapper {
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
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    AuditProductImage loadById(@Param("id") Integer id);

    /**
     * 保存产品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer save(AuditProductImage record);

    /**
     * 根据id删除某一张图片信息
     * 
     * @param id
     *            图片信息ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer deleteById(@Param("id") Integer id);

    /**
     * 根据数据包产品导入批次号删除该批次的所有产品图片
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer deleteByBatchNo(@Param("batchNo") String batchNo);

    /**
     * 根据产品ID和渠道编码删除某产品的图片信息（该产品所有图片）
     * 
     * @param productId
     *            产品ID
     * @param channelCode
     *            渠道编码
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer deleteByAuditProductIdAndChannelCode(@Param("auditProductId") Integer auditProductId,
            @Param("channelCode") String channelCode);

    /**
     * 根据imageUrl1删除某一张图片信息
     * 
     * @param 图片URL1
     *            imageUrl1
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer deleteByImageUrl1(@Param("imageUrl1") String imageUrl1);

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
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
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
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer updateImageOrderById(@Param("id") Integer id, @Param("imageOrder") Integer imageOrder,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 依据图片Id更新产品的图片信息
     * 
     * @param record
     *            图片信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    Integer updateById(AuditProductImage record);

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
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    List<AuditProductImage> listByAuditProductIdAndChannelCode(@Param("auditProductId") Integer auditProductId,
            @Param("channelCode") String channelCode);

    /**
     * 根据数据包产品导入批次号获取产品图片列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @return 图片信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_IMAGE })
    List<AuditProductImage> listByBatchNo(@Param("batchNo") String batchNo);

}