package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.AuditProductImageMapper;
import com.yilidi.o2o.product.model.AuditProductImage;
import com.yilidi.o2o.product.service.IAuditProductImageService;
import com.yilidi.o2o.product.service.dto.AuditProductImageDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 数据包产品图片Service实现类
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午3:57:59
 */
@Service("auditProductImageService")
public class AuditProductImageServiceImpl extends BasicDataService implements IAuditProductImageService {

    @Autowired
    private AuditProductImageMapper auditProductImageMapper;

    @Override
    public void saveAuditProductImages(List<AuditProductImageDto> saveAuditProductImageDtos) {
        try {
            // 检查产品图片列表参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDtos)) {
                throw new ProductServiceException("产品图片列表参数为空");
            }
            for (AuditProductImageDto auditProductImageDto : saveAuditProductImageDtos) {
                this.saveAuditProductImage(auditProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("saveAuditProductImages异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveAuditProductImage(AuditProductImageDto saveAuditProductImageDto) {
        try {
            // 检查产品图片参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto)) {
                throw new ProductServiceException("产品图片参数为空");
            }
            // 保存产品单张图片
            // 如果图片id不存在，则新增
            if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getId())) {
                // 检查数据包产品ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getAuditProductId())) {
                    throw new ProductServiceException("数据包产品ID参数为空");
                }
                // 检查产品主图标志参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getMasterFlag())) {
                    throw new ProductServiceException("产品主图标志参数为空");
                }
                // 检查产品渠道编码参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getChannelCode())) {
                    throw new ProductServiceException("产品渠道编码为空");
                }
                // 检查产品创建人ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getCreateUserId())) {
                    throw new ProductServiceException("产品创建人ID参数为空");
                }
                // 检查产品创建时间参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getCreateTime())) {
                    throw new ProductServiceException("产品创建时间参数为空");
                }
                // 检查产品创建图片url参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getImageUrl())) {
                    throw new ProductServiceException("产品创建图片url参数为空");
                }
                // 检查产品图片Url参数是否为空
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductImageDto.getImageUrl())) {
                    AuditProductImage auditProductImage = new AuditProductImage();
                    auditProductImage.setBatchNo(saveAuditProductImageDto.getBatchNo());
                    auditProductImage.setAuditProductId(saveAuditProductImageDto.getAuditProductId());
                    auditProductImage.setChannelCode(saveAuditProductImageDto.getChannelCode());
                    // 获取图片路径
                    String ext = this.getExtensionName(saveAuditProductImageDto.getImageUrl()).replace(".", "");
                    auditProductImage.setImageUrl1(saveAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_1." + ext));
                    auditProductImage.setImageUrl2(saveAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_2." + ext));
                    auditProductImage.setImageUrl3(saveAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_3." + ext));
                    // 图片只有一张的时候设置值为1，数据库该字段为非null
                    auditProductImage.setImageOrder(saveAuditProductImageDto.getImageOrder());
                    // 设置主图标示
                    auditProductImage.setMasterFlag(saveAuditProductImageDto.getMasterFlag());
                    auditProductImage.setCreateTime(saveAuditProductImageDto.getCreateTime());
                    // 此处创建人id需要取到用户登录的id
                    auditProductImage.setCreateUserId(saveAuditProductImageDto.getCreateUserId());
                    auditProductImage.setDataResource(saveAuditProductImageDto.getDataResource());
                    auditProductImageMapper.save(auditProductImage);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("saveAuditProductImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    @Override
    public void updateAuditProductImage(AuditProductImageDto updateAuditProductImageDto) throws ProductServiceException {
        try {
            // 检查数据包产品图片参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateAuditProductImageDto)) {
                throw new ProductServiceException("数据包产品图片参数为空");
            }
            // 检查产品图片ID是否为空
            if (!ObjectUtils.isNullOrEmpty(updateAuditProductImageDto.getId())) {
                AuditProductImage auditProductImage = auditProductImageMapper.loadById(updateAuditProductImageDto
                        .getId());
                String ext = this.getExtensionName(updateAuditProductImageDto.getImageUrl()).replace(".", "");
                if (ObjectUtils.whetherModified(auditProductImage.getImageUrl1(), updateAuditProductImageDto.getImageUrl()
                        .replaceAll("\\." + ext, "\\_1." + ext))
                        || ObjectUtils.whetherModified(auditProductImage.getImageOrder(),
                                updateAuditProductImageDto.getImageOrder())
                        || ObjectUtils.whetherModified(auditProductImage.getMasterFlag(),
                                updateAuditProductImageDto.getMasterFlag())) {
                    auditProductImage.setImageUrl1(updateAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_1." + ext));
                    auditProductImage.setImageUrl2(updateAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_2." + ext));
                    auditProductImage.setImageUrl3(updateAuditProductImageDto.getImageUrl().replaceAll("\\." + ext,
                            "\\_3." + ext));
                    // 图片顺序
                    auditProductImage.setImageOrder(updateAuditProductImageDto.getImageOrder());
                    // 设置主图标示
                    auditProductImage.setMasterFlag(updateAuditProductImageDto.getMasterFlag());
                    auditProductImage.setModifyTime(updateAuditProductImageDto.getModifyTime());
                    auditProductImage.setModifyUserId(updateAuditProductImageDto.getModifyUserId());
                    auditProductImage.setDataResource(updateAuditProductImageDto.getDataResource());
                    auditProductImageMapper.updateById(auditProductImage);
                }
            } else {
                updateAuditProductImageDto.setCreateUserId(updateAuditProductImageDto.getModifyUserId());
                updateAuditProductImageDto.setCreateTime(updateAuditProductImageDto.getModifyTime());
                this.saveAuditProductImage(updateAuditProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditProductImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditProductImages(List<AuditProductImageDto> updateAuditProductImageDtos)
            throws ProductServiceException {
        try {
            // 检查数据包产品图片列表参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateAuditProductImageDtos)) {
                throw new ProductServiceException("数据包产品图片列表参数为空");
            }
            for (AuditProductImageDto auditProductImageDto : updateAuditProductImageDtos) {
                this.updateAuditProductImage(auditProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditProductImages异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public AuditProductImageDto loadAuditProductImageById(Integer id) throws ProductServiceException {
        AuditProductImageDto auditProductImageDto = null;
        try {
            // 检查产品图片Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("产品图片id参数为空");
            }
            AuditProductImage auditProductImage = auditProductImageMapper.loadById(id);
            // 检查产品参数对象是否为空
            if (!ObjectUtils.isNullOrEmpty(auditProductImage)) {
                auditProductImageDto = new AuditProductImageDto();
                ObjectUtils.fastCopy(auditProductImage, auditProductImageDto);
            }
            return auditProductImageDto;
        } catch (ProductServiceException e) {
            logger.error("loadAuditProductImageById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<AuditProductImageDto> listImagesByAuditProductIdAndChannelCode(Integer auditProductId, String channelCode)
            throws ProductServiceException {
        try {
            // 检查数据包产品ID是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductId)) {
                throw new ProductServiceException("数据包产品ID参数为空");
            }
            // 检查产品编码渠道是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 查询产品所有图片
            List<AuditProductImage> listAuditProductImage = auditProductImageMapper.listByAuditProductIdAndChannelCode(
                    auditProductId, channelCode);
            List<AuditProductImageDto> auditProductImageDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listAuditProductImage)) {
                auditProductImageDtos = new ArrayList<AuditProductImageDto>();
                for (AuditProductImage auditProductImage : listAuditProductImage) {
                    AuditProductImageDto auditProductImageDto = null;
                    if (!ObjectUtils.isNullOrEmpty(auditProductImage)) {
                        auditProductImageDto = new AuditProductImageDto();
                        ObjectUtils.fastCopy(auditProductImage, auditProductImageDto);
                        auditProductImageDto.setImageUrl(auditProductImage.getImageUrl1().replace("_1.", "."));
                        auditProductImageDtos.add(auditProductImageDto);
                    }
                }
            }
            return auditProductImageDtos;
        } catch (ProductServiceException e) {
            logger.error("listImagesByAuditProductIdAndChannelCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductImageById(Integer id) throws ProductServiceException {
        // 依据产品图片id删除图片
        try {
            // 检查产品图片Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("产品图片id参数为空");
            }
            auditProductImageMapper.deleteById(id);
        } catch (ProductServiceException e) {
            logger.error("deleteAuditProductImageById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    public void deleteAuditProductImageByBatchNo(String batchNo) throws ProductServiceException {
        // 根据数据包产品导入批次号删除该批次的所有产品图片
        try {
            // 检查数据包产品导入批次号参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("数据包产品导入批次号参数为空");
            }
            auditProductImageMapper.deleteByBatchNo(batchNo);
        } catch (ProductServiceException e) {
            logger.error("deleteAuditProductImageByBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteImageByAuditProductIdAndChannelCode(Integer auditProductId, String channelCode)
            throws ProductServiceException {
        // 删除产品该渠道所有图片
        try {
            // 检查数据包产品图片id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductId)) {
                throw new ProductServiceException("数据包产品图片id参数为空");
            }
            // 检查产品图片渠道编码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            auditProductImageMapper.deleteByAuditProductIdAndChannelCode(auditProductId, channelCode);
        } catch (ProductServiceException e) {
            logger.error("deleteImageByAuditProductIdAndChannelCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateMasterFlagById(String masterFlag, Date modifyTime, Integer id, Integer modifyUserId)
            throws ProductServiceException {
        try {
            // 检查产品图片主图标示参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(masterFlag)) {
                throw new ProductServiceException("产品图片主图标示masterFlag参数为空");
            }
            // 检查产品图片图片id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("产品图片id参数为空");
            }
            // 检查产品修改人id是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("产品图片修改人modifyUserId参数为空");
            }
            // 检查产品修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("产品图片修改时间参数为空");
            }
            auditProductImageMapper.updateMasterFlagById(masterFlag, modifyTime, id, modifyUserId);
        } catch (ProductServiceException e) {
            logger.error("updateMasterFlagById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateImageOrderById(Integer id, Integer imageOrder, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {
        try {
            // 检查产品图片顺序参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(imageOrder)) {
                throw new ProductServiceException("产品图片顺序imageOrder参数为空");
            }
            // 检查产品图片渠道编码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("产品图片id参数为空");
            }
            // 检查产品修改人id是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("产品图片顺序修改人modifyUserId参数为空");
            }
            // 检查产品修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("产品图片顺序修改时间参数为空");
            }
            auditProductImageMapper.updateImageOrderById(imageOrder, id, modifyTime, modifyUserId);
        } catch (ProductServiceException e) {
            logger.error("updateImageOrderById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductImageByImageUrl1(String imageUrl1) throws ProductServiceException {
        try {
            // 检查产品图片imageUrl1参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(imageUrl1)) {
                throw new ProductServiceException("产品图片imageUrl1参数为空");
            }
            auditProductImageMapper.deleteByImageUrl1(imageUrl1);
        } catch (ProductServiceException e) {
            logger.error("deleteAuditProductImageByImageUrl1异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<AuditProductImageDto> listImagesByBatchNo(String batchNo) throws ProductServiceException {
        try {
            // 检查数据包产品导入批次号是否为空
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("数据包产品导入批次号参数为空");
            }
            List<AuditProductImage> listAuditProductImage = auditProductImageMapper.listByBatchNo(batchNo);
            List<AuditProductImageDto> auditProductImageDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listAuditProductImage)) {
                auditProductImageDtos = new ArrayList<AuditProductImageDto>();
                for (AuditProductImage auditProductImage : listAuditProductImage) {
                    AuditProductImageDto auditProductImageDto = null;
                    if (!ObjectUtils.isNullOrEmpty(auditProductImage)) {
                        auditProductImageDto = new AuditProductImageDto();
                        ObjectUtils.fastCopy(auditProductImage, auditProductImageDto);
                        auditProductImageDto.setImageUrl(auditProductImage.getImageUrl1().replace("_1.", "."));
                        auditProductImageDtos.add(auditProductImageDto);
                    }
                }
            }
            return auditProductImageDtos;
        } catch (ProductServiceException e) {
            logger.error("listImagesBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
