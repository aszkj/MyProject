package com.yilidi.o2o.product.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.AuditProductBatchInfoMapper;
import com.yilidi.o2o.product.model.AuditProductBatchInfo;
import com.yilidi.o2o.product.model.query.AuditProductBatchInfoQuery;
import com.yilidi.o2o.product.service.IAuditProductBatchInfoService;
import com.yilidi.o2o.product.service.dto.AuditProductBatchInfoDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductBatchInfoQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 数据包产品批次信息Service实现类
 * 
 * @author: chenlian
 * @date: 2016年12月13日 上午9:22:18
 */
@Service("auditProductBatchInfoService")
public class AuditProductBatchInfoServiceImpl extends BasicDataService implements IAuditProductBatchInfoService {

    @Autowired
    private AuditProductBatchInfoMapper auditProductBatchInfoMapper;

    @Override
    public AuditProductBatchInfoDto loadAuditProductBatchInfoById(Integer id) throws ProductServiceException {
        AuditProductBatchInfoDto auditProductBatchInfoDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            AuditProductBatchInfo auditProductBatchInfo = auditProductBatchInfoMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfo)) {
                auditProductBatchInfoDto = new AuditProductBatchInfoDto();
                ObjectUtils.fastCopy(auditProductBatchInfo, auditProductBatchInfoDto);
            }
            return auditProductBatchInfoDto;
        } catch (ProductServiceException e) {
            logger.error("loadAuditProductBatchInfoById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public AuditProductBatchInfoDto loadAuditProductBatchInfoByBatchNo(String batchNo) throws ProductServiceException {
        AuditProductBatchInfoDto auditProductBatchInfoDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            AuditProductBatchInfo auditProductBatchInfo = auditProductBatchInfoMapper.loadByBatchNo(batchNo);
            if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfo)) {
                auditProductBatchInfoDto = new AuditProductBatchInfoDto();
                ObjectUtils.fastCopy(auditProductBatchInfo, auditProductBatchInfoDto);
            }
            return auditProductBatchInfoDto;
        } catch (ProductServiceException e) {
            logger.error("loadAuditProductBatchInfoByBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveAuditProductBatchInfo(AuditProductBatchInfoDto saveAuditProductBatchInfoDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saveAuditProductBatchInfoDto)) {
                throw new ProductServiceException("参数saveAuditProductBatchInfoDto不能为空");
            }
            AuditProductBatchInfo auditProductBatchInfo = new AuditProductBatchInfo();
            ObjectUtils.fastCopy(saveAuditProductBatchInfoDto, auditProductBatchInfo);
            auditProductBatchInfoMapper.save(auditProductBatchInfo);
        } catch (Exception e) {
            logger.error("saveAuditProductBatchInfo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AuditProductBatchInfoDto> findAuditProductBatchInfos(
            AuditProductBatchInfoQueryDto auditProductBatchInfoQueryDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(auditProductBatchInfoQueryDto)) {
                throw new ProductServiceException("参数auditProductBatchInfoQueryDto不能为空");
            }
            if (null == auditProductBatchInfoQueryDto.getStart() || auditProductBatchInfoQueryDto.getStart() <= 0) {
                auditProductBatchInfoQueryDto.setStart(1);
            }
            if (null == auditProductBatchInfoQueryDto.getPageSize() || auditProductBatchInfoQueryDto.getPageSize() <= 0) {
                auditProductBatchInfoQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<AuditProductBatchInfoDto> pageDto = new Page<AuditProductBatchInfoDto>(
                    auditProductBatchInfoQueryDto.getStart(), auditProductBatchInfoQueryDto.getPageSize());
            AuditProductBatchInfoQuery auditProductBatchInfoQuery = new AuditProductBatchInfoQuery();
            ObjectUtils.fastCopy(auditProductBatchInfoQueryDto, auditProductBatchInfoQuery);
            PageHelper.startPage(auditProductBatchInfoQuery.getStart(), auditProductBatchInfoQuery.getPageSize());
            Page<AuditProductBatchInfo> page = auditProductBatchInfoMapper
                    .findAuditProductBatchInfos(auditProductBatchInfoQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<AuditProductBatchInfo> auditProductBatchInfos = page.getResult();
            for (AuditProductBatchInfo auditProductBatchInfo : auditProductBatchInfos) {
                AuditProductBatchInfoDto auditProductBatchInfoDto = new AuditProductBatchInfoDto();
                ObjectUtils.fastCopy(auditProductBatchInfo, auditProductBatchInfoDto);
                auditProductBatchInfoDto.setSubmitStatusName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.AUDITPRODUCTSUBMITSTATUS.getValue(),
                        auditProductBatchInfoDto.getSubmitStatus()));
                pageDto.add(auditProductBatchInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAuditProductBatchInfos异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductBatchInfoByBatchNo(String batchNo, List<String> submitStatusList)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(submitStatusList)) {
                throw new ProductServiceException("参数submitStatusList不能为空");
            }
            Integer effectedCount = auditProductBatchInfoMapper.deleteByBatchNo(batchNo, submitStatusList);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("只有提交审核状态为未提交的批次可被删除，该批次：" + batchNo + "的提交状态不正确，无法删除");
            }
        } catch (Exception e) {
            logger.error("deleteAuditProductBatchInfoByBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUploadCount(String batchNo, Integer deltaCount, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(deltaCount)) {
                throw new ProductServiceException("参数deltaCount不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("参数modifyTime不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("参数modifyUserId不能为空");
            }
            Integer effectedCount = auditProductBatchInfoMapper.updateUploadCount(batchNo, deltaCount, modifyTime,
                    modifyUserId);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("更新后的上传产品数量不能小于0");
            }
        } catch (Exception e) {
            logger.error("updateUploadCount异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubmitStatus(String batchNo, List<String> preSubmitStatusList, String submitStatus, Date modifyTime,
            Integer modifyUserId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(preSubmitStatusList)) {
                throw new ProductServiceException("参数preSubmitStatusList不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(submitStatus)) {
                throw new ProductServiceException("参数submitStatus不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("参数modifyTime不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("参数modifyUserId不能为空");
            }
            Integer effectedCount = auditProductBatchInfoMapper.updateSubmitStatus(batchNo, preSubmitStatusList,
                    submitStatus, modifyTime, modifyUserId);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("需更新的提交审核状态不正确，无法更新状态");
            }
        } catch (Exception e) {
            logger.error("updateSubmitStatus异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubmitTime(String batchNo, Date submitTime, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(submitTime)) {
                throw new ProductServiceException("参数submitTime不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("参数modifyTime不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("参数modifyUserId不能为空");
            }
            Integer effectedCount = auditProductBatchInfoMapper.updateSubmitTime(batchNo, submitTime, modifyTime,
                    modifyUserId);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("更新提交审核时间出现系统异常");
            }
        } catch (Exception e) {
            logger.error("updateSubmitTime异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateSubmitCount(String batchNo, Integer deltaCount, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("参数batchNo不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(deltaCount)) {
                throw new ProductServiceException("参数deltaCount不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("参数modifyTime不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("参数modifyUserId不能为空");
            }
            Integer effectedCount = auditProductBatchInfoMapper.updateSubmitCount(batchNo, deltaCount, modifyTime,
                    modifyUserId);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("更新后的提交审核产品数量不能小于0");
            }
        } catch (Exception e) {
            logger.error("updateSubmitCount异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
