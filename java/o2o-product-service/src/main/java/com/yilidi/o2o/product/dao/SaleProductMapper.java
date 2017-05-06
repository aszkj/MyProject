package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.combination.SaleProductRelatedInfo;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 功能描述：商品基础信息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleProductMapper {

    /**
     * 保存商品基础信息
     * 
     * @param record
     *            商品基础信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer saveSaleProduct(SaleProduct record);

    /**
     * 根据ID删除商品基础信息
     * 
     * @param id
     *            商品ID
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer deleteSaleProductById(@Param("id") Integer id);

    /**
     * 更新商品基础信息（如果字段值为null则不更新该字段）
     * 
     * @param record
     *            商品对象
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateSaleProductBasicInfoById(SaleProduct record);

    /**
     * 根据ID更新商品的审核状态
     * 
     * @param id
     *            商品id
     * @param auditStatusCode
     *            审核编码
     * @param auditNote
     *            审核意见
     * @param auditUserId
     *            审核用户ID
     * @param auditTime
     *            审核时间
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateAuditById(@Param("id") Integer id, @Param("auditStatusCode") String auditStatusCode,
            @Param("auditNote") String auditNote, @Param("auditUserId") Integer auditUserId,
            @Param("auditTime") Date auditTime);

    /**
     * 根据id更新商品类别
     * 
     * @param id
     *            商品id
     * @param productClassCode
     *            产品类别编码
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响 的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateProductClassById(@Param("id") Integer id, @Param("productClassCode") String productClassCode,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据id更新商品类别
     * 
     * @param id
     *            商品id
     * @param enabledFlag
     *            商品有效性
     * @param modifyUserId
     *            更新者id
     * @param modifyTime
     *            更新时间
     * @return 影响 的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateEnabledFlagById(@Param("id") Integer id, @Param("enabledFlag") String enabledFlag,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据商品id查询商品基础基础信息
     * 
     * @param id
     *            商品ID
     * @param enabledFlag
     *            有效标志
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadSaleProductBasicInfoById(@Param("id") Integer id, @Param("enabledFlag") String enabledFlag);

    /**
     * 根据店铺商品id和有效状态查询商品信息列表
     * 
     * @param id
     *            商品ID
     * @param enabledFlag
     *            是否有效商品标志
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadByIdAndEnabledFlag(@Param("id") Integer id, @Param("enabledFlag") String enabledFlag);

    /**
     * 根据商品id和有效状态查询商品信息列表
     * 
     * @param productId
     *            商品ID
     * @param storeId
     *            店铺ID
     * @param enabledFlag
     *            是否有效商品标志
     * @param saleStatus
     *            是否有效商品标志
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    SaleProduct loadByProductIdAndStoreIdEnabledFlag(@Param("productId") Integer productId,
            @Param("storeId") Integer storeId, @Param("enabledFlag") String enabledFlag,
            @Param("saleStatus") String saleStatus);

    /**
     * 根据商品id列表和有效状态查询商品信息列表
     * 
     * @param saleProductIds
     *            商品ID 列表
     * @param enabledFlag
     *            是否有效商品标志
     * @return 商品对象列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> loadByIdsAndEnabledFlag(@Param("saleProductIds") List<Integer> saleProductIds,
            @Param("enabledFlag") String enabledFlag);

    /**
     * 根据店铺ID和商品ID查询商品基础基础信息
     * 
     * @param storeId
     *            店铺ID
     * @param productId
     *            商品ID
     * @param enabledFlag
     *            是否有效商品标志
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadSaleProductBasicInfoByStoreIdAndProductId(@Param("storeId") Integer storeId,
            @Param("productId") Integer productId, @Param("enabledFlag") String enabledFlag);

    /**
     * 根据店铺ID和商品ID查询商品基础基础信息
     * 
     * @param storeId
     *            店铺ID
     * @param id
     *            商品ID
     * @param enabledFlag
     *            是否有效商品标志
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadSaleProductBasicInfoByStoreIdAndId(@Param("storeId") Integer storeId, @Param("id") Integer id,
            @Param("enabledFlag") String enabledFlag);

    /**
     * 根据店铺ID和商品barCode查询商品基础基础信息
     * 
     * @param storeId
     *            店铺ID
     * @param barCode
     *            商品barCode
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadSaleProductBasicInfoByStoreIdAndBarCode(@Param("storeId") Integer storeId,
            @Param("barCode") String barCode);

    /**
     * 根据店铺ID和商品条形码barCode查询商品基础基础信息
     * 
     * @param barCode
     *            商品条形码
     * @param storeId
     *            店铺ID
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProduct loadSaleProductBasicInfoByBarCodeAndStoreId(@Param("barCode") String barCode,
            @Param("storeId") Integer storeId);

    /**
     * 根据商店查询商品的基础信息（可以传上下架状态，审核状态，以及有效标志）
     * 
     * @param record
     *            商品信息记录
     * @return 商品基础信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductByStoreId(SaleProduct record);

    /**
     * 根据商品的基础信息查询商品列表（库存基础信息通过商品来关联获取）
     * 
     * @param saleProductQuery
     *            商品查询实体记录
     * @return 商品基础信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductBasicInfos(SaleProductQuery saleProductQuery);

    /**
     * 根据ID查询商品（库存基础信息通过商品来关联获取）
     * 
     * @param id
     *            商品ID
     * @param channelCode
     *            渠道编码
     * @return 商品信息(除图片列表以外)
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    SaleProductRelatedInfo loadSaleProductRelatedInfoByIdAndChannelCode(@Param("id") Integer id,
            @Param("channelCode") String channelCode);

    /**
     * 条件查询商品列表(先查询基础信息)（库存基础信息通过商品来关联获取）
     * 
     * @param saleProductQuery
     *            商品查询实体记录
     * @return 商品信息列表(除图片列表以外)
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Page<SaleProduct> findSaleProductsByBasicInfo(SaleProductQuery saleProductQuery);

    /**
     * 根据条件查询商品基础信息列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param saleProductQuery
     *            商品查询实体，
     * @return 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_SALE_PRODUCT_PRICE,
            DBTablesName.Product.P_SALE_PRODUCT_IMAGE, DBTablesName.Product.P_PRODUCT_CLASS })
    Page<SaleProductRelatedInfo> findSaleProductRelatedInfos(SaleProductQuery saleProductQuery);

    /**
     * 根据条件查询商品列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    Page<SaleProductRelatedInfo> findSaleProducts(SaleProductQuery saleProductQuery);

    /**
     * 
     * 获取需要导出的商品的数量
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @return long 商品数量
     */
    Long getCountsForExportSaleProduct(SaleProductQuery saleProductQuery);

    /**
     * 
     * 获取需要导出的商品列表
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<Product> 商品列表
     */
    List<SaleProductRelatedInfo> listDataForExportSaleProduct(@Param("saleProductQuery") SaleProductQuery saleProductQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 根据id更新商品审核状态
     * 
     * @param id
     *            商品id
     * @param auditStatusCode
     *            商品审核状态
     * @param auditNote
     *            商品审核描述
     * @param auditUserId
     *            审核者auditUserId
     * @param auditTime
     *            审核时间
     * @return 影响 的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateSaleProductAuditStatusCodeById(@Param("id") Integer id, @Param("auditStatusCode") String auditStatusCode,
            @Param("auditNote") String auditNote, @Param("auditUserId") Integer auditUserId,
            @Param("auditTime") Date auditTime);

    /**
     * 根据商品id查询商品基础基础信息
     * 
     * @param storeId
     *            店铺ID
     * @param enabledFlag
     *            商品状态
     * @return 商品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductBasicInfoByStoreId(@Param("storeId") Integer storeId,
            @Param("enabledFlag") String enabledFlag);

    /**
     * 
     * 查询店铺所有商品的条形码
     * 
     * @param storeId
     *            店铺ID
     * @return List<String> 产品条形码列表
     */
    Set<String> getSaleProductBarCode(@Param("storeId") Integer storeId);

    /**
     * 
     * 依据商品类别查询商品列表
     * 
     * @param classCodeList
     *            店铺商品类别列表
     * @param enabledFlag
     *            店铺商品类别状态
     * @return List<SaleProduct> 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductBasicInfosByClassCode(@Param("classCodeList") List<String> classCodeList,
            @Param("enabledFlag") String enabledFlag);

    /**
     * 
     * 依据商品类别与店铺类型查询商品列表
     * 
     * @param classCodeList
     *            店铺商品类别列表
     * @param storeType
     *            店铺类型
     * @param enabledFlag
     *            店铺商品类别状态
     * @return List<SaleProduct> 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductBasicInfosByClassCodeAndStoreType(@Param("classCodeList") List<String> classCodeList,
            @Param("storeType") String storeType, @Param("enabledFlag") String enabledFlag);

    /**
     * @Description TODO(卖家搜索分页商品列表)
     * @param saleProductQuery
     * @return Page<SaleProductRelatedInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_SALE_DAILY })
    Page<SaleProductRelatedInfo> findSaleProductsForSeller(SaleProductQuery saleProductQuery);

    /**
     * @Description TODO(根据店铺ID和若干条形码获取商品List)
     * @param storeId
     * @param barCodes
     * @return List<SaleProduct>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    List<SaleProduct> listSaleProductsByStoreIdAndBarCodes(@Param("storeId") Integer storeId,
            @Param("barCodes") List<String> barCodes);

    /**
     * 
     * 获取需要导出的商品的数量
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @return long 商品数量
     */
    Long getCountsForExportSaleProductInventory(SaleProductQuery saleProductQuery);

    /**
     * 获取卖家调拨微仓的商品列表
     * 
     * @param saleProductQuery
     * @return List<SaleProductRelatedInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE })
    List<SaleProductRelatedInfo> listSaleProductsForSellerFlitting(SaleProductQuery saleProductQuery);

    /**
     * 根据条件查询商品列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_CLASS })
    List<SaleProductRelatedInfo> listSaleProducts(SaleProductQuery saleProductQuery);

    /**
     * 根据条件查询店铺商品品牌codes
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_CLASS })
    List<String> listSaleProductBrandCodesByStoreId(SaleProductQuery saleProductQuery);

    /**
     * 修改商品变化库存
     * 
     * @param id
     *            商品ID
     * @param delta
     *            商品库存变化量
     * @param modifyTime
     *            修改时间
     * @param modifyUserId
     *            修改用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_SALE_PRODUCT })
    Integer updateRemainCountById(@Param("id") Integer id, @Param("delta") Integer delta,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 根据条件查询StoreIds
     * 
     * @param saleProductQuery
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
            DBTablesName.Product.P_SALE_PRODUCT_PROFILE, DBTablesName.Product.P_PRODUCT_CLASS })
    List<Integer> listStoreIdsByProductId(SaleProductQuery saleProductQuery);

    /**
     * 根据店铺ID和产品ID获取商品信息
     * 
     * @param storeId
     *            店铺ID
     * @param productId
     *            产品ID
     * @return 商品信息
     */
    SaleProduct loadByStoreIdAndProductId(@Param("storeId") Integer storeId, @Param("productId") Integer productId);
}