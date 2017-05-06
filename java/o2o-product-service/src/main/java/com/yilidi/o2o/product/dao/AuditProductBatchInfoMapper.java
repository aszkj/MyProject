package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.AuditProductBatchInfo;
import com.yilidi.o2o.product.model.query.AuditProductBatchInfoQuery;

/**
 * 数据包产品批次信息Mapper
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午6:02:30
 */
public interface AuditProductBatchInfoMapper {

    /**
     * 保存数据包产品批次信息
     * 
     * @param record
     *            数据包产品批次记录
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer save(AuditProductBatchInfo record);

    /**
     * 根据id查询数据包产品批次信息
     * 
     * @param id
     *            数据包产品批次id
     * @return 数据包产品批次对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    AuditProductBatchInfo loadById(@Param("id") Integer id);

    /**
     * 根据id查询数据包产品批次信息
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @return 数据包产品批次对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    AuditProductBatchInfo loadByBatchNo(@Param("batchNo") String batchNo);

    /**
     * 根据id删除数据包产品批次信息
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param submitStatusList
     *            提交状态列表
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer deleteByBatchNo(@Param("batchNo") String batchNo, @Param("submitStatusList") List<String> submitStatusList);

    /**
     * 更新上传产品数量
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param deltaCount
     *            上传产品变化数量，可以为负数
     * @param modifyTime
     *            修改时间
     * @param modifyUserId
     *            修改用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer updateUploadCount(@Param("batchNo") String batchNo, @Param("deltaCount") Integer deltaCount,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 更新提交审核状态
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param preSubmitStatusList
     *            之前提交审核状态列表
     * @param submitStatus
     *            提交审核状态
     * @param modifyTime
     *            修改时间
     * @param modifyUserId
     *            修改用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer updateSubmitStatus(@Param("batchNo") String batchNo,
            @Param("preSubmitStatusList") List<String> preSubmitStatusList, @Param("submitStatus") String submitStatus,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 更新提交审核时间
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param submitTime
     *            提交审核时间
     * @param modifyTime
     *            修改时间
     * @param modifyUserId
     *            修改用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer updateSubmitTime(@Param("batchNo") String batchNo, @Param("submitTime") Date submitTime,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 更新提交审核产品数量
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param deltaCount
     *            提交审核产品变化数量，可以为负数
     * @param modifyTime
     *            修改时间
     * @param modifyUserId
     *            修改用户ID
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Integer updateSubmitCount(@Param("batchNo") String batchNo, @Param("deltaCount") Integer deltaCount,
            @Param("modifyTime") Date modifyTime, @Param("modifyUserId") Integer modifyUserId);

    /**
     * 查询数据包产品批次列表
     * 
     * <pre>
     * 注：使用缓存查询数据
     * </pre>
     * 
     * @param record
     *            数据包产品批次查询实体
     * @return 产品批次列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PACKET_PRODUCT_BATCH_INFO })
    Page<AuditProductBatchInfo> findAuditProductBatchInfos(AuditProductBatchInfoQuery record);

}