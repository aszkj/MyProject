package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.AuditProductBatchInfoDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductBatchInfoQueryDto;

/**
 * 数据包产品批次Service接口
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午7:52:37
 */
public interface IAuditProductBatchInfoService {

    /**
     * 根据id查询数据包产品批次信息
     * 
     * @param id
     *            数据包产品批次id
     * @return 数据包产品批次信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public AuditProductBatchInfoDto loadAuditProductBatchInfoById(Integer id) throws ProductServiceException;

    /**
     * 根据批次编号查询数据包产品批次信息
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @return 数据包产品批次信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public AuditProductBatchInfoDto loadAuditProductBatchInfoByBatchNo(String batchNo) throws ProductServiceException;

    /**
     * 根据前台传过来的AuditProductBatchInfoDto保存数据包产品批次信息
     * 
     * @param saveAuditProductBatchInfoDto
     *            数据包产品批次信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void saveAuditProductBatchInfo(AuditProductBatchInfoDto saveAuditProductBatchInfoDto)
            throws ProductServiceException;

    /**
     * 根据条件查询数据包产品批次相关信息
     * 
     * @param auditProductBatchInfoQueryDto
     *            数据包产品批次查询dto
     * @return 数据包产品批次相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public YiLiDiPage<AuditProductBatchInfoDto> findAuditProductBatchInfos(
            AuditProductBatchInfoQueryDto auditProductBatchInfoQueryDto) throws ProductServiceException;

    /**
     * 
     * 依据id删除数据包产品批次信息
     * 
     * @param batchNo
     *            数据包产品批次编号
     * @param submitStatusList
     *            提交状态列表
     * @throws ProductServiceException
     *             产品域异常
     */
    public void deleteAuditProductBatchInfoByBatchNo(String batchNo, List<String> submitStatusList)
            throws ProductServiceException;

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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateUploadCount(String batchNo, Integer deltaCount, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException;

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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateSubmitStatus(String batchNo, List<String> preSubmitStatusList, String submitStatus, Date modifyTime,
            Integer modifyUserId) throws ProductServiceException;

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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateSubmitTime(String batchNo, Date submitTime, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException;

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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateSubmitCount(String batchNo, Integer deltaCount, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException;

}