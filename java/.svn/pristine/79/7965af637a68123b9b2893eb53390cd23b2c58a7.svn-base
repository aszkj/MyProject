/**
 * 文件名称：ProductProfileService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ProductProfileMapper;
import com.yilidi.o2o.product.model.ProductProfile;
import com.yilidi.o2o.product.service.IProductProfileService;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:产品附属服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productProfileService")
public class ProductProfileServiceImpl extends BasicDataService implements IProductProfileService {
    @Autowired
    private ProductProfileMapper productProfileMapper;

    @Override
    public ProductProfileDto loadProductProfileByProductIdAndChannelCode(Integer productId, String channelCode) {
        // 查询产品附属信息开始
        logger.debug("productId -> " + productId + "channelCode ->" + channelCode);
        ProductProfileDto productProfileDto = null;
        try {
            // 检查产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("loadProductProfileByProductIdAndChannelCode.productId => 产品ID参数为空");
                throw new ProductServiceException(
                        "ProductService的loadProductProfileByProductIdAndChannelCode方法参数productId为空");
            }
            // 检查产品渠道编码参数是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 查询产品附属信息
            ProductProfile productProfile = productProfileMapper.loadProductProfileByProductIdAndChannelCode(productId,
                    channelCode);
            // 检查产品附属信息参数是否为空
            if (!ObjectUtils.isNullOrEmpty(productProfile)) {
                productProfileDto = new ProductProfileDto();
                ObjectUtils.fastCopy(productProfile, productProfileDto);
            }
        } catch (ProductServiceException e) {
            logger.error("查询产品附属信息出错");
            throw new ProductServiceException("异常：查询产品附属信息出错");
        }
        return productProfileDto;
    }

    @Override
    public void saveProductProfile(ProductProfileDto saveProductProfileDto) {
        // 保存产品附属信息开始
        logger.debug("saveProductProfileDto -> " + saveProductProfileDto);
        // 保存产品附属信息
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductProfileDto)) {
                logger.error("ProductService.saveProductProfileDto => 产品参数为空");
                throw new ProductServiceException("ProductService的saveProductProfile方法参数为空");
            }
            // 检查产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductProfileDto.getProductId())) {
                logger.error("saveProductProfileDto.productId => 产品id参数为空");
                throw new ProductServiceException("异常：产品productId参数为空");
            }
            // 检查产品渠道编码参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductProfileDto.getChannelCode())) {
                logger.error("saveProductProfileDto.channelCode => 产品channelCode参数为空");
                throw new ProductServiceException("异常：产品channelCode参数为空");
            }

            ProductProfileDto productProfileDtoLoad = this.loadProductProfileByProductIdAndChannelCode(
                    saveProductProfileDto.getProductId(), saveProductProfileDto.getChannelCode());
            // 检查产品附属信息是否已经存在，不存在则新建，存在则更新
            if (ObjectUtils.isNullOrEmpty(productProfileDtoLoad)) {
                // 检查产品规格参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductProfileDto.getProductSpec())) {
                    logger.error("saveProductProfileDto.productSpec => 产品规格参数为空");
                    throw new ProductServiceException("异常：产品规格参数为空");
                }
                // 检查产品创建人ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductProfileDto.getCreateUserId())) {
                    logger.error("saveProductProfileDto.createUserId => 产品createUserId参数为空");
                    throw new ProductServiceException("异常：产品createUserId参数为空");
                }
                // 检查产品创建时间参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductProfileDto.getCreateTime())) {
                    logger.error("saveProductProfileDto.createTime => 产品createTime参数为空");
                    throw new ProductServiceException("异常：产品createTime参数为空");
                }
                ProductProfile productProfile = new ProductProfile();
                productProfile.setProductId(saveProductProfileDto.getProductId());
                productProfile.setChannelCode(saveProductProfileDto.getChannelCode());
                productProfile.setProductOwner(saveProductProfileDto.getProductOwner());
                productProfile.setHotSaleFlag(saveProductProfileDto.getHotSaleFlag());
                productProfile.setSaleStatus(saveProductProfileDto.getSaleStatus());
                productProfile.setProductSpec(saveProductProfileDto.getProductSpec());
                productProfile.setDisplayOrder(saveProductProfileDto.getDisplayOrder());
                productProfile.setContent(saveProductProfileDto.getSellPoint());
                productProfile.setContent(saveProductProfileDto.getContent());
                productProfile.setCreateUserId(saveProductProfileDto.getCreateUserId());
                productProfile.setCreateTime(saveProductProfileDto.getCreateTime());
                productProfileMapper.saveProductProfile(productProfile);
            } else {
                saveProductProfileDto.setModifyUserId(saveProductProfileDto.getCreateUserId());
                saveProductProfileDto.setModifyTime(saveProductProfileDto.getModifyTime());
                saveProductProfileDto.setId(productProfileDtoLoad.getId());
                this.updateProductProfile(saveProductProfileDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存产品附属信息出错");
            throw new ProductServiceException("异常：保存产品附属信息出错");
        }
    }

    @Override
    public void updateProductProfile(ProductProfileDto updateProductProfileDto) {
        logger.debug("updateProductProfileDto -> " + updateProductProfileDto);
        // 更新产品附属信息
        try {
            // 检查产品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductProfileDto)) {
                logger.error("ProductService.updateProductProfileDto => 产品附属信息参数为空");
                throw new ProductServiceException("ProductService的updateProductProfile方法参数为空");
            }
            // 检查产品附属信息参数修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductProfileDto.getModifyUserId())) {
                logger.error("ProductService.updateProductProfileDto.modifyUserId=> 产品附属信息参数修改人为空");
                throw new ProductServiceException("ProductService的updateProductProfile.modifyUserId方法参数modifyUserId为空");
            }
            // 检查产品附属信息参数修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductProfileDto.getModifyTime())) {
                logger.error("ProductService.updateProductProfileDto.modifyTime => 产品附属信息参数修改时间为空");
                throw new ProductServiceException("ProductService的updateProductProfile方法参数modifyTime为空");
            }
            // 检查产品渠道编码参数是否为空
            if (!ObjectUtils.isNullOrEmpty(updateProductProfileDto.getId())) {
                // 根据产品id和渠道编码查询产品的附属信息
                ProductProfile productProfile = productProfileMapper.loadProductProfileById(updateProductProfileDto.getId());
                if (ObjectUtils.whetherModified(productProfile.getSellPoint(), updateProductProfileDto.getSellPoint())
                        || ObjectUtils.whetherModified(productProfile.getContent(), updateProductProfileDto.getContent())
                        || ObjectUtils.whetherModified(productProfile.getProductOwner(),
                                updateProductProfileDto.getProductOwner())
                        || ObjectUtils.whetherModified(productProfile.getHotSaleFlag(),
                                updateProductProfileDto.getHotSaleFlag())
                        || ObjectUtils.whetherModified(productProfile.getSaleStatus(),
                                updateProductProfileDto.getSaleStatus())
                        || ObjectUtils.whetherModified(productProfile.getProductSpec(),
                                updateProductProfileDto.getProductSpec())
                        || ObjectUtils.whetherModified(productProfile.getDisplayOrder(),
                                updateProductProfileDto.getDisplayOrder())
                        || ObjectUtils.whetherModified(productProfile.getMaintainStoreFlag(),
                                updateProductProfileDto.getMaintainStoreFlag())) {
                    productProfile.setContent(updateProductProfileDto.getContent());
                    productProfile.setSellPoint(updateProductProfileDto.getSellPoint());
                    productProfile.setProductOwner(updateProductProfileDto.getProductOwner());
                    productProfile.setHotSaleFlag(updateProductProfileDto.getHotSaleFlag());
                    productProfile.setSaleStatus(updateProductProfileDto.getSaleStatus());
                    productProfile.setProductSpec(updateProductProfileDto.getProductSpec());
                    productProfile.setDisplayOrder(updateProductProfileDto.getDisplayOrder());
                    productProfile.setMaintainStoreFlag(updateProductProfileDto.getMaintainStoreFlag());
                    productProfile.setModifyTime(updateProductProfileDto.getModifyTime());
                    productProfile.setModifyUserId(updateProductProfileDto.getModifyUserId());
                    productProfileMapper.updateProductProfileById(productProfile);
                }
            }

        } catch (ProductServiceException e) {
            logger.error("更新产品附属信息出错");
            throw new ProductServiceException("异常：更新产品附属信息出错");
        }
    }

    @Override
    public void updateSaleStatusByProductIdAndChannelCode(Integer productId, String saleStatus, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        logger.debug("id -> " + productId);
        // 更新产品附属信息
        try {
            // 检查产品附属信息参数产品Id对象是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductService.productId => 产品附属信息参数产品productId为空");
                throw new ProductServiceException("ProductService的productId参数为空");
            }
            // 检查产品附属信息参数对象产品上下架状态是否为空
            if (ObjectUtils.isNullOrEmpty(saleStatus)) {
                logger.error("ProductService.updateSaleStatusByProductIdAndChannelCode.saleStatus => 产品附属信息参数产品saleStatus为空");
                throw new ProductServiceException(
                        "ProductService的updateSaleStatusByProductIdAndChannelCode方法的saleStatus参数为空");
            }
            // 检查产品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查产品附属信息参数修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateSaleStatusByProductIdAndChannelCode.modifyUserId=> 产品附属信息参数修改人为空");
                throw new ProductServiceException(
                        "ProductService的updateSaleStatusByProductIdAndChannelCode.modifyUserId方法参数modifyUserId为空");
            }
            // 检查产品附属信息参数修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("ProductService.updateSaleStatusByProductIdAndChannelCode.modifyTime => 产品附属信息参数修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleStatusByProductIdAndChannelCode方法参数modifyTime为空");
            }
            productProfileMapper.updateSaleStatusByProductIdAndChannelCode(productId, saleStatus, channelCode, modifyUserId,
                    modifyTime);
        } catch (ProductServiceException e) {
            logger.error("更新产品附属信息出错");
            throw new ProductServiceException("异常：更新产品附属信息出错");
        }

    }

    @Override
    public void updateHotSaleFlagByProductIdAndChannelCode(Integer productId, String hotSaleFlag, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        logger.debug("productId -> " + productId);
        // 更新产品附属信息
        try {
            // 检查产品附属信息参数产品Id对象是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductService.productId => 产品附属信息参数产品id为空");
                throw new ProductServiceException("ProductService的id参数为空");
            }
            // 检查产品附属信息参数对象产品上下架状态是否为空
            if (ObjectUtils.isNullOrEmpty(hotSaleFlag)) {
                logger.error("ProductService.updateHotSaleFlagByProductIdAndChannelCode.hotSaleFlag => 产品附属信息参数产品hotSaleFlag为空");
                throw new ProductServiceException(
                        "ProductService的updateHotSaleFlagByProductIdAndChannelCode方法的hotSaleFlag参数为空");
            }
            // 检查产品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查产品附属信息参数修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateHotSaleFlagByProductIdAndChannelCode.modifyUserId=> 产品附属信息参数修改人为空");
                throw new ProductServiceException(
                        "ProductService的updateHotSaleFlagByProductIdAndChannelCode方法参数modifyUserId为空");
            }
            // 检查产品附属信息参数修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("ProductService.updateSaleStatusById.modifyTime => 产品附属信息参数修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleStatusById方法参数modifyTime为空");
            }
            productProfileMapper.updateHotSaleFlagByProductIdAndChannelCode(productId, hotSaleFlag, channelCode,
                    modifyUserId, modifyTime);
        } catch (ProductServiceException e) {
            logger.error("更新产品附属信息出错");
            throw new ProductServiceException("异常：更新产品附属信息出错");
        }
    }

}
