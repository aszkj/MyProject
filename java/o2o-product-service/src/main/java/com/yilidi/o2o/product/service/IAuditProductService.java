package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.AuditProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.AuditProductDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductQueryDto;

/**
 * 数据包产品Service接口
 * 
 * @author: chenlian
 * @date: 2016年12月10日 下午5:51:01
 */
public interface IAuditProductService {

    /**
     * 根据barCode和channelCode查询数据包产品信息
     * 
     * @param barCode
     *            产品barCode
     * @param channelCode
     *            产品渠道编码
     * @return 数据包产品信息
     * @throws ProductServiceException
     *             产品域服务异常 
     */
    public AuditProductDto loadAuditProductByBarCodeAndChannelCode(String barCode, String channelCode)
            throws ProductServiceException;

    /**
     * 根据id查询数据包产品信息
     * 
     * @param id
     *            产品id
     * @return 数据包产品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public AuditProductDto loadAuditProductById(Integer id) throws ProductServiceException;

    /**
     * 根据前台传过来的AuditProductDto保存数据包产品信息
     * 
     * @param batchNo
     *            数据包产品批次号
     * @param saveAuditProductDto
     *            数据包产品信息
     * @param channelCode
     *            渠道编码
     * @param createTime
     *            创建时间
     * @param createUserId
     *            创建人
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void saveAuditProduct(String batchNo, AuditProductDto saveAuditProductDto, String channelCode,
            Date createTime, Integer createUserId) throws ProductServiceException;
    /**
     * 根据前台传过来的AuditProductDto保存数据包产品信息(新增产品)
     * 
     * @param saveAuditProductDto
     *            数据包产品信息
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveAuditProduct(AuditProductDto saveAuditProductDto, String channelCode) throws ProductServiceException;
    /**
     * 
     * 产品批量导入保存至数据包产品表
     * 
     * @param packetProductDtoList
     *            数据包产品packetProductDtoList
     * @param objs
     *            其他参数数组
     * @throws ProductServiceException
     *             产品域异常
     */
    public void saveAuditProductBatch(List<AuditProductDto> packetProductDtoList, AuditProductBatchSaveDto objs)
            throws ProductServiceException;

    /**
     * 根据ID更新数据包产品基本信息
     * 
     * @param packetProductDto
     *            数据包产品DTO
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateAuditProductBasicInfoById(AuditProductDto packetProductDto, String channelCode)
            throws ProductServiceException;

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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateAuditStatusBySubmit(Integer id, List<String> preAuditStatusList, Date submitTime, String auditStatus,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 批量提交审批时更新审核状态信息
     * 
     * @param batchNo
     *            数据包产品导入批次编号
     * @param ids
     *            数据包产品ID列表
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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateAuditStatusBySubmitBatch(String batchNo, List<Integer> ids, List<String> preAuditStatusList,
            Date submitTime, String auditStatus, Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 初审更新审核状态信息
     * 
     * @param batchNo
     *            数据包产品导入批次编号
     * @param id
     *            数据包产品ID
     * @param preAuditStatus
     *            初审之前的审核状态
     * @param auditStatus
     *            初审之后的审核状态
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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateAuditStatusByInitAudit(String batchNo, Integer id, String preAuditStatus, String auditStatus,
            Integer initAuditUserId, Date initAuditTime, String initAuditRejectReason, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 终审更新审核状态信息
     * 
     * @param batchNo
     *            数据包产品导入批次编号
     * @param id
     *            数据包产品ID
     * @param preAuditStatus
     *            终审之前的审核状态
     * @param auditStatus
     *            终审之后的审核状态
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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateAuditStatusByFinalAudit(String batchNo, Integer id, String preAuditStatus, String auditStatus,
            Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId,
            Date modifyTime) throws ProductServiceException;

    /**
     * 终审通过后将数据包产品转化为标准库产品
     * 
     * @param batchNo
     *            数据包产品导入批次编号
     * @param id
     *            数据包产品ID
     * @param preAuditStatus
     *            终审之前的审核状态
     * @param auditStatus
     *            终审之后的审核状态
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
     * @throws ProductServiceException
     *             产品域异常
     */
    public void saveStandardProFromPacketProByFinalAuditPass(String batchNo, Integer id, String preAuditStatus,
            String auditStatus, Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 根据条件查询数据包产品相关信息
     * 
     * @param packetProductQueryDto
     *            数据包产品查询dto
     * @return 数据包产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public YiLiDiPage<AuditProductDto> findAuditProducts(AuditProductQueryDto packetProductQueryDto)
            throws ProductServiceException;

    /**
     * 
     * 该条形码产品是否已经存在数据包产品表中
     * 
     * @param barCode
     *            产品barCode
     * @param channelCode
     *            产品channelCode
     * @return boolean
     * @throws ProductServiceException
     *             产品域异常
     */
    public boolean checkBarCodeIsExistInAuditProduct(String barCode, String channelCode) throws ProductServiceException;

    /**
     * 
     * 依据id删除数据包产品表中产品
     * 
     * @param id
     *            数据包产品id
     * @param auditStatusList
     *            审核状态列表
     * @throws ProductServiceException
     *             产品域异常
     */
    public void deleteAuditProductById(Integer id, List<String> auditStatusList) throws ProductServiceException;

    /**
     * 
     * 依据id列表删除数据包产品表中产品
     * 
     * @param batchNo
     *            批次号
     * @param ids
     *            id列表
     * @param auditStatusList
     *            审核状态列表
     * @param modifyUserId
     *            更新人
     * @param modifyTime
     *            更新时间
     * @throws ProductServiceException
     *             产品域异常
     */
    public void deleteAuditProductByIdBatch(String batchNo, List<Integer> ids, List<String> auditStatusList,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 
     * 依据批次号删除数据包产品表中产品
     * 
     * @param batchNo
     *            批次号
     * @throws ProductServiceException
     *             产品域异常
     */
    public void deleteAuditProductByBatchNo(String batchNo) throws ProductServiceException;

    /**
     * 
     * 批量依据批次号删除数据包产品表中产品
     * 
     * @param batchNos
     *            批次号列表
     * @param submitStatusList
     *            提交状态列表
     * @throws ProductServiceException
     *             产品域异常
     */
    public void deleteAuditProductByBatchNoBatch(List<String> batchNos, List<String> submitStatusList)
            throws ProductServiceException;

    /**
     * 根据数据包产品导入批次号获取数据包产品列表
     * 
     * @param batchNo
     *            数据包产品导入批次号
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 数据包产品列表
     */
    List<AuditProductDto> listAuditProductsByBatchNo(String batchNo) throws ProductServiceException;

    /**
     * 获取所有数据包产品的条形码
     * 
     * @return 数据包产品条形码相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Set<String> getAuditProductBarCode() throws ProductServiceException;

}