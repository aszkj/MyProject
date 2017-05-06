/**
 * 文件名称：SaleProductImageService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductImageMapper;
import com.yilidi.o2o.product.model.SaleProductImage;
import com.yilidi.o2o.product.service.ISaleProductImageHistoryService;
import com.yilidi.o2o.product.service.ISaleProductImageService;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品图片服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductImageService")
public class SaleProductImageServiceImpl extends BasicDataService implements ISaleProductImageService {

    @Autowired
    private SaleProductImageMapper saleProductImageMapper;

    @Autowired
    private ISaleProductImageHistoryService saleProductImageHistoryService;

    @Override
    public void saveSaleProductImages(List<SaleProductImageDto> saveSaleProductImageDtos) throws ProductServiceException {
        logger.debug("saveSaleProductImageDtos -> " + saveSaleProductImageDtos);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDtos)) {
                logger.error("SaleProductImageService.saveSaleProductImageDtos => 商品图片参数为空");
                throw new ProductServiceException("SaleProductImageService的saveSaleProductImages方法参数为空");
            }
            // 保存商品所有图片
            for (SaleProductImageDto saleProductImageDto : saveSaleProductImageDtos) {
                this.saveSaleProductImage(saleProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存商品所有图片出错");
            throw new ProductServiceException("异常：保存商品所有图片出错");
        }

    }

    private void saveSaleProductImage(SaleProductImageDto saveSaleProductImageDto) throws ProductServiceException {
        logger.debug("saveSaleProductImageDto -> " + saveSaleProductImageDto);
        // 保存商品一张图片
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto)) {
                logger.error("SaleProductImageService.saveSaleProductImageDto => 保存商品单张图片参数为空");
                throw new ProductServiceException("SaleProductImageService的saveSaleProductImage方法参数为空");
            }
            // 商品ID是否为空
            // 如果图片id不存在，则新增
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto.getSaleProductId())) {
                logger.error("SaleProductImageService.saleProductId => 商品ID参数为空");
                throw new ProductServiceException("商品ID参数为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto.getChannelCode())) {
                logger.error("SaleProductImageService.channelCode => 保存商品channelCode参数为空");
                throw new ProductServiceException("商品渠道编码channelCode参数为空");
            }
            // 保存商品createUserId是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto.getCreateUserId())) {
                logger.error("SaleProductImageService.createUserId => 商品createUserId为空");
                throw new ProductServiceException("商品createUserId参数为空");
            }
            // 保存商品createTime是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto.getCreateTime())) {
                logger.error("SaleProductImageService.createTime => 商品createTime为空");
                throw new ProductServiceException("商品createTime参数为空");
            }
            // 商品imageUrl是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductImageDto.getImageUrl())) {
                logger.error("SaleProductImageService.imageUrl => 商品imageUrl为空");
                throw new ProductServiceException("商品imageUrl参数为空");
            } else {
                SaleProductImage saleProductImage = new SaleProductImage();
                saleProductImage.setSaleProductId(saveSaleProductImageDto.getSaleProductId());
                saleProductImage.setChannelCode(saveSaleProductImageDto.getChannelCode());
                // 获取图片路径
                String ext = this.getExtensionName(saveSaleProductImageDto.getImageUrl()).replace(".", "");
                saleProductImage.setImageUrl1(saveSaleProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_1." + ext));
                saleProductImage.setImageUrl2(saveSaleProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_2." + ext));
                saleProductImage.setImageUrl3(saveSaleProductImageDto.getImageUrl().replaceAll("\\." + ext, "\\_3." + ext));
                // 设置图片顺序
                saleProductImage.setImageOrder(saveSaleProductImageDto.getImageOrder());
                // 设置主图标示
                saleProductImage.setMasterFlag(saveSaleProductImageDto.getMasterFlag());
                saleProductImage.setCreateTime(saveSaleProductImageDto.getCreateTime());
                // 此处创建人id需要取到用户登录的id
                saleProductImage.setCreateUserId(saveSaleProductImageDto.getCreateUserId());
                saleProductImageMapper.saveSaleProductImage(saleProductImage);
                saveSaleProductImageDto.setId(saleProductImage.getId());

                // 同时创建一条有关该图片的一条历史记录
                SaleProductImageHistoryDto saleProductImageHistoryDto = new SaleProductImageHistoryDto();
                saleProductImageHistoryDto.setSaleProductImageId(saleProductImage.getId());
                saleProductImageHistoryDto.setSaleProductId(saveSaleProductImageDto.getSaleProductId());
                saleProductImageHistoryDto.setChannelCode(saveSaleProductImageDto.getChannelCode());
                saleProductImageHistoryDto.setImageUrl(saveSaleProductImageDto.getImageUrl());
                saleProductImageHistoryDto.setImageOrder(saveSaleProductImageDto.getImageOrder());
                saleProductImageHistoryDto.setMasterFlag(saveSaleProductImageDto.getMasterFlag());
                saleProductImageHistoryDto.setOperateUserId(saveSaleProductImageDto.getCreateUserId());
                saleProductImageHistoryDto.setOperateTime(saveSaleProductImageDto.getCreateTime());
                saleProductImageHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTIMAGEOPERTYPE_CREATE);
                saleProductImageHistoryService.saveSaleProductImageHistory(saleProductImageHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存商品单张图片出错");
            throw new ProductServiceException("异常：保存商品单张图片出错");
        }

    }

    /**
     * 
     * @Description TODO(获取文件的后缀名)
     * @param filename
     * @return String
     */
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
    public void updateSaleProductImage(SaleProductImageDto updateSaleProductImageDto) throws ProductServiceException {
        logger.debug("updateSaleProductImageDto -> " + updateSaleProductImageDto);
        // 更新商品某一张图片
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductImageDto)) {
                logger.error("SaleProductImageService.updateSaleProductImageDto => 商品其中一张图片的参数为空");
                throw new ProductServiceException("SaleProductImageService的updateSaleProductImage方法参数为空");
            }
            // 检查商品图片修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductImageDto.getModifyUserId())) {
                logger.error("ProductService.updateSaleProductImageDto.modifyUserId=> 商品图片修改人为空");
                throw new ProductServiceException("ProductService的updateSaleProductImage.modifyUserId方法参数modifyUserId为空");
            }
            // 检查商品图片修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductImageDto.getModifyTime())) {
                logger.error("ProductService.updateSaleProductImageDto.modifyTime => 商品图片修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleProductImage方法参数modifyTime为空");
            }
            // 检查产品图片ID是否为空
            if (!ObjectUtils.isNullOrEmpty(updateSaleProductImageDto.getId())) {
                SaleProductImage saleProductImage = saleProductImageMapper
                        .loadSaleProductImageById(updateSaleProductImageDto.getId());
                // 检查商品参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(saleProductImage)) {
                    String ext = this.getExtensionName(updateSaleProductImageDto.getImageUrl()).replace(".", "");
                    if (ObjectUtils.whetherModified(saleProductImage.getImageOrder(),
                            updateSaleProductImageDto.getImageOrder())
                            || ObjectUtils.whetherModified(saleProductImage.getMasterFlag(),
                                    updateSaleProductImageDto.getMasterFlag())
                            || ObjectUtils.whetherModified(saleProductImage.getImageUrl1(), updateSaleProductImageDto
                                    .getImageUrl().replaceAll("\\." + ext, "\\_1." + ext))) {
                        // 更新商品图片信息
                        saleProductImage.setImageUrl1(updateSaleProductImageDto.getImageUrl().replaceAll("\\." + ext,
                                "\\_1." + ext));
                        saleProductImage.setImageUrl2(updateSaleProductImageDto.getImageUrl().replaceAll("\\." + ext,
                                "\\_2." + ext));
                        saleProductImage.setImageUrl3(updateSaleProductImageDto.getImageUrl().replaceAll("\\." + ext,
                                "\\_3." + ext));
                        // 设置图片上顺序
                        saleProductImage.setImageOrder(updateSaleProductImageDto.getImageOrder());
                        // 设置主图标示
                        saleProductImage.setMasterFlag(updateSaleProductImageDto.getMasterFlag());
                        saleProductImage.setModifyTime(updateSaleProductImageDto.getModifyTime());
                        // 此处创建人id需要取到用户登录的id
                        saleProductImage.setModifyUserId(updateSaleProductImageDto.getModifyUserId());
                        saleProductImageMapper.updateSaleProductImage(saleProductImage);

                        // 创建一条更新记录到历史表
                        SaleProductImageHistoryDto saleProductImageHistoryDto = new SaleProductImageHistoryDto();
                        saleProductImageHistoryDto.setSaleProductImageId(saleProductImage.getId());
                        saleProductImageHistoryDto.setSaleProductId(saleProductImage.getSaleProductId());
                        saleProductImageHistoryDto.setChannelCode(saleProductImage.getChannelCode());
                        saleProductImageHistoryDto.setImageOrder(updateSaleProductImageDto.getImageOrder());
                        saleProductImageHistoryDto.setMasterFlag(updateSaleProductImageDto.getMasterFlag());
                        saleProductImageHistoryDto.setImageUrl(updateSaleProductImageDto.getImageUrl());
                        saleProductImageHistoryDto.setOperateTime(updateSaleProductImageDto.getModifyTime());
                        saleProductImageHistoryDto.setOperateUserId(updateSaleProductImageDto.getModifyUserId());
                        saleProductImageHistoryDto
                                .setOperateType(SystemContext.ProductDomain.SALEPRODUCTIMAGEOPERTYPE_MODIFY);
                        saleProductImageHistoryService.saveSaleProductImageHistory(saleProductImageHistoryDto);
                    }
                }
            } else {
                updateSaleProductImageDto.setCreateUserId(updateSaleProductImageDto.getModifyUserId());
                updateSaleProductImageDto.setCreateTime(updateSaleProductImageDto.getModifyTime());
                this.saveSaleProductImage(updateSaleProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品某一张图片出错");
            throw new ProductServiceException("异常：更新商品某一张图片出错");
        }

    }

    @Override
    public void updateSaleProductImages(List<SaleProductImageDto> updateSaleProductImageDtos) throws ProductServiceException {
        logger.debug("updateSaleProductImageDtos -> " + updateSaleProductImageDtos);
        // 更新商品所有图片
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductImageDtos)) {
                logger.error("SaleProductImageService.updateSaleProductImageDtos => 商品图片参数为空");
                throw new ProductServiceException("SaleProductImageService的updateSaleProductImages方法参数为空");
            }
            for (SaleProductImageDto saleProductImageDto : updateSaleProductImageDtos) {
                this.updateSaleProductImage(saleProductImageDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品图片出错");
            throw new ProductServiceException("异常：更新商品图片出错");
        }

    }

    @Override
    public List<SaleProductImageDto> listSaleProductImagesBySaleProductIdAndChannelCode(Integer saleProductId,
            String channelCode) throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
        try {
            // 检查商品参数商品Id是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductImageService.saleProductId => 商品Id参数为空");
                throw new ProductServiceException(
                        "SaleProductImageService的listSaleProductImagesBySaleProductIdAndChannelCode方法参数saleProductId为空");
            }
            // 检查商品参数商品编码渠道是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 查询商品所有图片
            List<SaleProductImage> listSaleProductImage = saleProductImageMapper
                    .listSaleProductImagesBySaleProductIdAndChannelCode(saleProductId, channelCode);
            List<SaleProductImageDto> saleProductImageDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listSaleProductImage)) {
                saleProductImageDtos = new ArrayList<SaleProductImageDto>();
                for (SaleProductImage saleProductImage : listSaleProductImage) {
                    SaleProductImageDto saleProductImageDto = null;
                    if (!ObjectUtils.isNullOrEmpty(saleProductImage)) {
                        saleProductImageDto = new SaleProductImageDto();
                        ObjectUtils.fastCopy(saleProductImage, saleProductImageDto);
                        saleProductImageDto.setImageUrl(saleProductImage.getImageUrl1().replace("_1.", "."));
                        saleProductImageDtos.add(saleProductImageDto);
                    }
                }
            }
            return saleProductImageDtos;
        } catch (ProductServiceException e) {
            logger.error("查询商品图片出错");
            throw new ProductServiceException("异常：查询商品图片出错");
        }
    }

    @Override
    public void deleteSaleProductImagesById(List<Integer> delSaleProductImageIds, Integer delUserId, Date delTime)
            throws ProductServiceException {
        logger.debug("delSaleProductImageIds -> " + delSaleProductImageIds);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(delSaleProductImageIds)) {
                logger.error("SaleProductImageService.delSaleProductImageIds => 商品图片参数为空");
                throw new ProductServiceException("SaleProductImageService的delSaleProductImageIds方法参数为空");
            }
            // 保存商品所有图片
            for (Integer delSaleProductImageId : delSaleProductImageIds) {
                this.deleteSaleProductImageById(delSaleProductImageId, delUserId, delTime);
            }
        } catch (ProductServiceException e) {
            logger.error("删除商品图片出错", e);
            throw new ProductServiceException("异常：删除商品图片出错");
        }

    }

    @Override
    public void deleteSaleProductImageById(Integer delSaleProductImageId, Integer delUserId, Date delTime)
            throws ProductServiceException {
        logger.debug("delSaleProductImageId -> " + delSaleProductImageId);
        // 保存商品一张图片
        try {
            // 商品ID是否为空
            if (ObjectUtils.isNullOrEmpty(delSaleProductImageId)) {
                logger.error("SaleProductImageService.saleProductId => 商品图片ID参数为空");
                throw new ProductServiceException("商品图片ID参数为空");
            } else {
                SaleProductImage saleProductImage = saleProductImageMapper.loadSaleProductImageById(delSaleProductImageId);
                saleProductImageMapper.deleteSaleProductImageById(delSaleProductImageId);

                // 同时创建一条有关该图片的一条历史记录
                SaleProductImageHistoryDto saleProductImageHistoryDto = new SaleProductImageHistoryDto();
                saleProductImageHistoryDto.setSaleProductImageId(saleProductImage.getId());
                saleProductImageHistoryDto.setSaleProductId(saleProductImage.getSaleProductId());
                saleProductImageHistoryDto.setChannelCode(saleProductImage.getChannelCode());
                saleProductImageHistoryDto.setImageUrl(saleProductImage.getImageUrl1().replace("_1.", "."));
                saleProductImageHistoryDto.setImageOrder(saleProductImage.getImageOrder());
                saleProductImageHistoryDto.setMasterFlag(saleProductImage.getMasterFlag());
                saleProductImageHistoryDto.setOperateUserId(delUserId);
                saleProductImageHistoryDto.setOperateTime(delTime);
                saleProductImageHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTIMAGEOPERTYPE_DELETE);
                saleProductImageHistoryService.saveSaleProductImageHistory(saleProductImageHistoryDto);

            }
        } catch (ProductServiceException e) {
            logger.error("保存商品单张图片出错");
            throw new ProductServiceException("异常：保存商品单张图片出错");
        }

    }

    @Override
    public SaleProductImageDto loadSaleProductImageMaster(Integer salesProductId, String channelCode) {
        SaleProductImage saleProductImage = saleProductImageMapper.loadSaleProductImageMasterBySaleProductIdAndChannelCode(
                salesProductId, channelCode, SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES);
        SaleProductImageDto saleProductImageDto = null;
        if (!ObjectUtils.isNullOrEmpty(saleProductImage)) {
            saleProductImageDto = new SaleProductImageDto();
            ObjectUtils.fastCopy(saleProductImage, saleProductImageDto);
            saleProductImageDto.setImageUrl(saleProductImage.getImageUrl1().replace("_1.", "."));
        }
        return saleProductImageDto;
    }

}