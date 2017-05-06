package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.AuditProduct;
import com.yilidi.o2o.product.model.query.AuditProductQuery;

/**
 * 数据包产品Mapper
 * 
 * @author: chenlian
 * @date: 2016年12月10日 下午5:31:17
 */
public interface AuditProductMapper {

    /**
     * 保存数据包产品信息
     * 
     * @param record
     *            数据包产品记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer save(AuditProduct record);

    /**
     * 根据ID更新数据包产品基本信息
     * 
     * @param record
     *            数据包产品记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer updateAuditProductBasicInfoById(AuditProduct record);

    /**
     * 提交审批时更新审核状态信息
     * 
     * @param id
     *            数据包产品ID
     * @param preAuditStatusList
     *            提交审批之前的审核状态列表
     * @param submitTime
     *            提交审批时间
     * @param auditStatus
     *            提交审批之后的审核状态
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer updateAuditStatusBySubmit(@Param("id") Integer id, @Param("preAuditStatusList") List<String> preAuditStatusList,
            @Param("submitTime") Date submitTime, @Param("auditStatus") String auditStatus,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 初审更新审核状态信息
     * 
     * @param id
     *            数据包产品ID
     * @param preAuditStatus
     *            提交审批之前的审核状态
     * @param auditStatus
     *            提交审批之后的审核状态
     * @param initAuditUserId
     *            初审用户ID
     * @param initAuditTime
     *            初审时间
     * @param initAuditRejectReason
     *            初审不通过理由
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer updateAuditStatusByInitAudit(@Param("id") Integer id, @Param("preAuditStatus") String preAuditStatus,
            @Param("auditStatus") String auditStatus, @Param("initAuditUserId") Integer initAuditUserId,
            @Param("initAuditTime") Date initAuditTime, @Param("initAuditRejectReason") String initAuditRejectReason,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 终审更新审核状态信息
     * 
     * @param id
     *            数据包产品ID
     * @param preAuditStatus
     *            提交审批之前的审核状态
     * @param auditStatus
     *            提交审批之后的审核状态
     * @param finalAuditUserId
     *            终审用户ID
     * @param finalAuditTime
     *            终审时间
     * @param finalAuditRejectReason
     *            终审不通过理由
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer updateAuditStatusByFinalAudit(@Param("id") Integer id, @Param("preAuditStatus") String preAuditStatus,
            @Param("auditStatus") String auditStatus, @Param("finalAuditUserId") Integer finalAuditUserId,
            @Param("finalAuditTime") Date finalAuditTime, @Param("finalAuditRejectReason") String finalAuditRejectReason,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据id查询数据包产品信息
     * 
     * @param id
     *            数据包产品id
     * @return 数据包产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    AuditProduct loadById(@Param("id") Integer id);

    /**
     * 根据条形码查询数据包产品信息
     * 
     * @param barCode
     *            数据包产品条形码
     * @param channelCode
     *            渠道编码
     * @return 数据包产品对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    AuditProduct loadByBarCodeAndChannelCode(@Param("barCode") String barCode, @Param("channelCode") String channelCode);

    /**
     * 根据id删除数据包产品信息
     * 
     * @param id
     *            数据包产品Id
     * @param auditStatusList
     *            审核状态列表
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Integer deleteById(@Param("id") Integer id, @Param("auditStatusList") List<String> auditStatusList);

    /**
     * 删除所有数据包产品信息
     * 
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    void deleteByBatchNo(@Param("batchNo") String batchNo);

    /**
     * 查询数据包产品列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param record
     *            数据包产品查询实体，
     * @return 产品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    Page<AuditProduct> findAuditProducts(AuditProductQuery record);

    /**
     * 根据数据包产品导入批次号获取数据包产品列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @return 数据包产品列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT })
    List<AuditProduct> listByBatchNo(@Param("batchNo") String batchNo);

    /**
     * 查询所有数据包产品的条形码列表
     * 
     * @return 产品列表
     */
    List<String> getAuditProductBarCode();
}