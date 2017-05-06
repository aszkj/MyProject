/**
 * 文件名称：SaleProductProfileService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductProfileMapper;
import com.yilidi.o2o.product.model.SaleProductProfile;
import com.yilidi.o2o.product.service.ISaleProductProfileHistoryService;
import com.yilidi.o2o.product.service.ISaleProductProfileService;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品附属信息服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductProfileService")
public class SaleProductProfileServiceImpl extends BasicDataService implements ISaleProductProfileService {

    @Autowired
    private SaleProductProfileMapper saleProductProfileMapper;

    @Autowired
    private ISaleProductProfileHistoryService saleProductProfileHistoryService;

    @Override
    public SaleProductProfileDto loadSaleProductProfileBySaleProductIdAndChannelCode(Integer saleProductId,
            String saleStatus, String channelCode) throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductProfileService.loadSaleProductPriceBySaleProductIdAndChannelCode => 商品Id参数为空");
                throw new ProductServiceException("商品Id参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductProfile saleProductProfile = saleProductProfileMapper
                    .loadSaleProductProfileBySaleProductIdAndSaleStatusAndChannelCode(saleProductId, saleStatus,
                            channelCode);
            // 检查商品对象是否为空
            SaleProductProfileDto saleProductProfileDto = null;
            // 检查商品附属信息参数是否为空
            if (!ObjectUtils.isNullOrEmpty(saleProductProfile)) {
                saleProductProfileDto = new SaleProductProfileDto();
                ObjectUtils.fastCopy(saleProductProfile, saleProductProfileDto);
            }

            return saleProductProfileDto;
        } catch (ProductServiceException e) {
            logger.error("查询商品附属信息信息出错");
            throw new ProductServiceException("异常：查询商品附属信息信息出错");
        }
    }

    @Override
    public SaleProductProfileDto loadSaleProductProfileByBarCodeAndChannelCode(String barCode, Integer storeId,
            String channelCode) throws ProductServiceException {
        logger.debug("barCode -> " + barCode + "storeId -> " + storeId + "channelCode -> " + channelCode);
        try {
            // 检查商品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("SaleProductProfileService.loadSaleProductProfileByBarCodeAndChannelCode => 商品barCode参数为空");
                throw new ProductServiceException("商品barCode参数为空");
            }
            // 检查商品商店Id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("SaleProductProfileService.loadSaleProductProfileByBarCodeAndChannelCode => 商品storeId参数为空");
                throw new ProductServiceException("商品店铺Id参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductProfile saleProductProfile = saleProductProfileMapper
                    .loadSaleProductProfileByBarCodeAndChannelCode(barCode, storeId, channelCode);
            // 检查商品对象是否为空
            SaleProductProfileDto saleProductProfileDto = null;
            // 检查商品附属信息参数是否为空
            if (!ObjectUtils.isNullOrEmpty(saleProductProfile)) {
                saleProductProfileDto = new SaleProductProfileDto();
                ObjectUtils.fastCopy(saleProductProfile, saleProductProfileDto);
            }

            return saleProductProfileDto;
        } catch (ProductServiceException e) {
            logger.error("查询商品附属信息信息出错");
            throw new ProductServiceException("异常：查询商品附属信息信息出错");
        }
    }

    @Override
    public void saveSaleProductProfile(SaleProductProfileDto saveSaleProductProfileDto) throws ProductServiceException {
        logger.debug("saveSaleProductProfileDto -> " + saveSaleProductProfileDto);
        // 保存商品附属信息
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto)) {
                logger.error("SaleProductProfileService.saveSaleProductProfileDto => 商品附属信息参数为空");
                throw new ProductServiceException("SaleProductProfileService的saveSaleProductImages方法参数为空");
            }
            SaleProductProfileDto saleProductProfileDto = this.loadSaleProductProfileBySaleProductIdAndChannelCode(
                    saveSaleProductProfileDto.getSaleProductId(), null, saveSaleProductProfileDto.getChannelCode());

            // 商品相同渠道的附加属性是否已经存在,不存在则创建，存在则更新
            if (ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                // 商品ID是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getSaleProductId())) {
                    logger.error("SaleProductProfileService.saleProductId => 商品ID参数为空");
                    throw new ProductServiceException("商品ID参数为空");
                }
                // 商品渠道编码是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getChannelCode())) {
                    logger.error("SaleProductProfileService.channelCode => 保存商品channelCode参数为空");
                    throw new ProductServiceException("商品渠道编码channelCode参数为空");
                }
                // 商品附属信息商品归属是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getProductOwner())) {
                    logger.error("SaleProductProfileService.productOwner => 保存商品productOwner参数为空");
                    throw new ProductServiceException("商品商品归属productOwner参数为空");
                }
                // 商品productSpec是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getSaleProductSpec())) {
                    logger.error("SaleProductProfileService.productSpec => 商品productSpec为空");
                    throw new ProductServiceException("商品productSpec参数为空");
                }
                // 保存商品createUserId是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getCreateUserId())) {
                    logger.error("SaleProductProfileService.createUserId => 商品createUserId为空");
                    throw new ProductServiceException("商品createUserId参数为空");
                }
                // 保存商品createTime是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductProfileDto.getCreateTime())) {
                    logger.error("SaleProductProfileService.createTime => 商品createTime为空");
                    throw new ProductServiceException("商品createTime参数为空");
                }
                SaleProductProfile saleProductProfile = new SaleProductProfile();
                saleProductProfile.setSaleProductId(saveSaleProductProfileDto.getSaleProductId());
                saleProductProfile.setChannelCode(saveSaleProductProfileDto.getChannelCode());
                saleProductProfile.setContent(saveSaleProductProfileDto.getContent());
                saleProductProfile.setSellPoint(saveSaleProductProfileDto.getSellPoint());
                saleProductProfile.setProductOwner(saveSaleProductProfileDto.getProductOwner());
                saleProductProfile.setHotSaleFlag(saveSaleProductProfileDto.getHotSaleFlag());
                saleProductProfile.setSaleProductSource(saveSaleProductProfileDto.getSaleProductSource());
                saleProductProfile.setSaleProductSpec(saveSaleProductProfileDto.getSaleProductSpec());
                saleProductProfile.setDisplayOrder(saveSaleProductProfileDto.getDisplayOrder());
                saleProductProfile.setSaleStatus(saveSaleProductProfileDto.getSaleStatus());
                saleProductProfile.setCreateUserId(saveSaleProductProfileDto.getCreateUserId());
                saleProductProfile.setCreateTime(saveSaleProductProfileDto.getCreateTime());
                saleProductProfileMapper.saveSaleProductProfile(saleProductProfile);

                // 创建商品附属信息时创建商品历史附属信息记录
                SaleProductProfileHistoryDto saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
                saleProductProfileHistoryDto.setSaleProductProfileId(saleProductProfile.getId());
                saleProductProfileHistoryDto.setSaleProductId(saveSaleProductProfileDto.getSaleProductId());
                saleProductProfileHistoryDto.setChannelCode(saveSaleProductProfileDto.getChannelCode());
                saleProductProfileHistoryDto.setContent(saveSaleProductProfileDto.getContent());
                saleProductProfileHistoryDto.setProductOwner(saveSaleProductProfileDto.getProductOwner());
                saleProductProfileHistoryDto.setSellPoint(saveSaleProductProfileDto.getSellPoint());
                saleProductProfileHistoryDto.setHotSaleFlag(saveSaleProductProfileDto.getHotSaleFlag());
                saleProductProfileHistoryDto.setSaleStatus(saveSaleProductProfileDto.getSaleStatus());
                saleProductProfileHistoryDto.setSaleProductSpec(saveSaleProductProfileDto.getSaleProductSpec());
                saleProductProfileHistoryDto.setSaleProductSource(saveSaleProductProfileDto.getSaleProductSource());
                saleProductProfileHistoryDto.setDisplayOrder(saveSaleProductProfileDto.getDisplayOrder());
                saleProductProfileHistoryDto.setOperateTime(saveSaleProductProfileDto.getCreateTime());
                saleProductProfileHistoryDto.setOperateUserId(saveSaleProductProfileDto.getCreateUserId());
                saleProductProfileHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPROFILEOPERTYPE_CREATE);
                saleProductProfileHistoryService.saveSaleProductProfileHistory(saleProductProfileHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存商品附属信息出错");
            throw new ProductServiceException("异常：保存商品附属信息出错");
        }

    }

    @Override
    public void updateSaleProductProfile(SaleProductProfileDto updateSaleProductProfileDto) throws ProductServiceException {
        // 更新商品附属信息表开始
        logger.debug("updateSaleProductPriceDto -> " + updateSaleProductProfileDto);
        // 更新商品附属信息
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductProfileDto)) {
                logger.error("SaleProductProfileService.updateSaleProductProfileDto => 更新的商品参数为空");
                throw new ProductServiceException("SaleProductProfileService的updateSaleProductProfile方法参数为空");
            }
            // 检查商品附属信息id为空是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductProfileDto.getId())) {
                logger.error("SaleProductProfileService.updateSaleProductProfileDto.id=> 商品附属信息id为空");
                throw new ProductServiceException("ProductService的updateSaleProductProfileDto.id方法参数商品附属信息id为空");
            }
            // 检查附属信息修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductProfileDto.getModifyUserId())) {
                logger.error("SaleProductProfileService.updateSaleProductProfileDto.modifyUserId=> 商品附属信息修改人为空");
                throw new ProductServiceException("ProductService的updateSaleProductProfileDto方法参数modifyUserId为空");
            }
            // 检查附属信息修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductProfileDto.getModifyTime())) {
                logger.error("SaleProductProfileService.updateSaleProductProfileDto.modifyTime => 商品附属信息修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleProductProfileDto方法参数modifyTime为空");
            }
            SaleProductProfile saleProductProfile = saleProductProfileMapper
                    .loadSaleProductProfileById(updateSaleProductProfileDto.getId());
            // 更新商品附属信息
            if (ObjectUtils.isNullOrEmpty(saleProductProfile)) {
                logger.error("SaleProductProfileService.saleProductProfile => 需要更新的商品附属信息为空");
                throw new ProductServiceException("需要更新的商品附属信息为空");
            }
            // 附属信息相关信息有任何一个有修改就需要更新并且创建历史附属信息信息
            if (ObjectUtils.whetherModified(saleProductProfile.getContent(), updateSaleProductProfileDto.getContent())
                    || ObjectUtils.whetherModified(saleProductProfile.getHotSaleFlag(),
                            updateSaleProductProfileDto.getHotSaleFlag())
                    || ObjectUtils.whetherModified(saleProductProfile.getSellPoint(),
                            updateSaleProductProfileDto.getSellPoint())
                    || ObjectUtils.whetherModified(saleProductProfile.getSaleProductSpec(),
                            updateSaleProductProfileDto.getSaleProductSpec())
                    || ObjectUtils.whetherModified(saleProductProfile.getProductOwner(),
                            updateSaleProductProfileDto.getProductOwner())
                    || ObjectUtils.whetherModified(saleProductProfile.getSaleStatus(),
                            updateSaleProductProfileDto.getSaleStatus())
                    || ObjectUtils.whetherModified(saleProductProfile.getDisplayOrder(),
                            updateSaleProductProfileDto.getDisplayOrder())
                    || ObjectUtils.whetherModified(saleProductProfile.getSaleProductSource(),
                            updateSaleProductProfileDto.getSaleProductSource())) {
                saleProductProfile.setContent(updateSaleProductProfileDto.getContent());
                saleProductProfile.setProductOwner(updateSaleProductProfileDto.getProductOwner());
                saleProductProfile.setSellPoint(updateSaleProductProfileDto.getSellPoint());
                saleProductProfile.setHotSaleFlag(updateSaleProductProfileDto.getHotSaleFlag());
                saleProductProfile.setSaleStatus(updateSaleProductProfileDto.getSaleStatus());
                saleProductProfile.setSaleProductSpec(updateSaleProductProfileDto.getSaleProductSpec());
                saleProductProfile.setSaleProductSource(saleProductProfile.getSaleProductSource());
                saleProductProfile.setDisplayOrder(updateSaleProductProfileDto.getDisplayOrder());
                saleProductProfile.setModifyTime(updateSaleProductProfileDto.getModifyTime());
                saleProductProfile.setModifyUserId(updateSaleProductProfileDto.getModifyUserId());
                saleProductProfileMapper.updateSaleProductProfileById(saleProductProfile);
                // 更新商品附属信息时创建商品历史附属信息记录
                SaleProductProfileHistoryDto saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
                saleProductProfileHistoryDto.setSaleProductProfileId(saleProductProfile.getId());
                saleProductProfileHistoryDto.setSaleProductId(saleProductProfile.getSaleProductId());
                saleProductProfileHistoryDto.setChannelCode(saleProductProfile.getChannelCode());
                saleProductProfileHistoryDto.setContent(updateSaleProductProfileDto.getContent());
                saleProductProfileHistoryDto.setProductOwner(updateSaleProductProfileDto.getProductOwner());
                saleProductProfileHistoryDto.setSellPoint(updateSaleProductProfileDto.getSellPoint());
                saleProductProfileHistoryDto.setHotSaleFlag(updateSaleProductProfileDto.getHotSaleFlag());
                saleProductProfileHistoryDto.setSaleProductSource(updateSaleProductProfileDto.getSaleProductSource());
                saleProductProfileHistoryDto.setSaleStatus(updateSaleProductProfileDto.getSaleStatus());
                saleProductProfileHistoryDto.setSaleProductSpec(updateSaleProductProfileDto.getSaleProductSpec());
                saleProductProfileHistoryDto.setDisplayOrder(updateSaleProductProfileDto.getDisplayOrder());
                saleProductProfileHistoryDto.setOperateTime(updateSaleProductProfileDto.getModifyTime());
                saleProductProfileHistoryDto.setOperateUserId(updateSaleProductProfileDto.getModifyUserId());
                saleProductProfileHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPROFILEOPERTYPE_MODIFY);
                saleProductProfileHistoryService.saveSaleProductProfileHistory(saleProductProfileHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品附属信息出错");
            throw new ProductServiceException("异常：更新商品附属信息出错");
        }

    }

    @Override
    public void updateSaleStatusBySaleProductIdAndChannelCode(Integer saleProductId, String saleStatus, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId);
        // 更新商品附属信息
        try {
            // 检查商品附属信息参数商品Id对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductProfileService.saleProductId => 商品附属信息参数商品saleProductId为空");
                throw new ProductServiceException("SaleProductProfileService的saleProductId参数为空");
            }
            // 检查商品附属信息参数对象商品上下架状态是否为空
            if (ObjectUtils.isNullOrEmpty(saleStatus)) {
                logger.error(
                        "SaleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode.saleStatus => 商品附属信息参数商品saleStatus为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateSaleStatusBySaleProductIdAndChannelCode方法的saleStatus参数为空");
            }
            // 检查商品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品附属信息参数修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error(
                        "SaleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode.modifyUserId=> 商品附属信息参数修改人modifyUserId为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateSaleStatusBySaleProductIdAndChannelCode.modifyUserId方法参数modifyUserId为空");
            }
            // 检查商品附属信息参数修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error(
                        "SaleProductProfileService.updateSaleStatusBySaleProductIdAndChannelCode.modifyTime => 商品附属信息参数修改时间为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateSaleStatusBySaleProductIdAndChannelCode方法参数modifyTime为空");
            }
            SaleProductProfileDto saleProductProfileDto = this
                    .loadSaleProductProfileBySaleProductIdAndChannelCode(saleProductId, null, channelCode);
            if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)
                    && ObjectUtils.whetherModified(saleProductProfileDto.getSaleStatus(), saleStatus)) {
                // 状态需要更改才更新
                saleProductProfileMapper.updateSaleStatusBySaleProductIdAndChannelCode(saleProductId, saleStatus,
                        channelCode, modifyUserId, modifyTime);
                // 修改上下架状态时时创建商品历史附属信息记录
                SaleProductProfileHistoryDto saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
                saleProductProfileHistoryDto.setSaleProductProfileId(saleProductProfileDto.getId());
                saleProductProfileHistoryDto.setSaleProductId(saleProductId);
                saleProductProfileHistoryDto.setChannelCode(channelCode);
                saleProductProfileHistoryDto.setContent(saleProductProfileDto.getContent());
                saleProductProfileHistoryDto.setProductOwner(saleProductProfileDto.getProductOwner());
                saleProductProfileHistoryDto.setSellPoint(saleProductProfileDto.getSellPoint());
                saleProductProfileHistoryDto.setHotSaleFlag(saleProductProfileDto.getHotSaleFlag());
                saleProductProfileHistoryDto.setSaleStatus(saleStatus);
                saleProductProfileHistoryDto.setSaleProductSpec(saleProductProfileDto.getSaleProductSpec());
                saleProductProfileHistoryDto.setSaleProductSource(saleProductProfileDto.getSaleProductSource());
                saleProductProfileHistoryDto.setDisplayOrder(saleProductProfileDto.getDisplayOrder());
                saleProductProfileHistoryDto.setOperateTime(modifyTime);
                saleProductProfileHistoryDto.setOperateUserId(modifyUserId);
                saleProductProfileHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPROFILEOPERTYPE_MODIFY);
                saleProductProfileHistoryService.saveSaleProductProfileHistory(saleProductProfileHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品附属信息出错");
            throw new ProductServiceException("异常：更新商品附属信息出错");
        }

    }

    @Override
    public void updateHotSaleFlagBySaleProductIdAndChannelCode(Integer saleProductId, String hotSaleFlag, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        logger.debug("productId -> " + saleProductId);
        // 更新商品附属信息
        try {
            // 检查商品附属信息参数商品Id对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductProfileService.saleProductId => 商品附属信息参数商品saleProductId为空");
                throw new ProductServiceException("SaleProductProfileService的id参数为空");
            }
            // 检查商品附属信息参数对象商品上下架状态是否为空
            if (ObjectUtils.isNullOrEmpty(hotSaleFlag)) {
                logger.error(
                        "SaleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode.hotSaleFlag => 商品附属信息参数商品hotSaleFlag为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateHotSaleFlagBySaleProductIdAndChannelCode方法的hotSaleFlag参数为空");
            }
            // 检查商品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品附属信息参数修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error(
                        "SaleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode.modifyUserId=> 商品附属信息参数修改人为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateHotSaleFlagBySaleProductIdAndChannelCode方法参数modifyUserId为空");
            }
            // 检查商品附属信息参数修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error(
                        "SaleProductProfileService.updateHotSaleFlagBySaleProductIdAndChannelCode.modifyTime => 商品附属信息参数修改时间为空");
                throw new ProductServiceException(
                        "SaleProductProfileService的updateHotSaleFlagBySaleProductIdAndChannelCode方法参数modifyTime为空");
            }
            SaleProductProfileDto saleProductProfileDto = this
                    .loadSaleProductProfileBySaleProductIdAndChannelCode(saleProductId, null, channelCode);
            if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)
                    && ObjectUtils.whetherModified(saleProductProfileDto.getHotSaleFlag(), hotSaleFlag)) {
                // 状态需要更改才更新
                saleProductProfileMapper.updateHotSaleFlagBySaleProductIdAndChannelCode(saleProductId, hotSaleFlag,
                        channelCode, modifyUserId, modifyTime);
                // 修改热卖状态时时创建商品历史附属信息记录
                SaleProductProfileHistoryDto saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
                saleProductProfileHistoryDto.setSaleProductProfileId(saleProductProfileDto.getId());
                saleProductProfileHistoryDto.setSaleProductId(saleProductId);
                saleProductProfileHistoryDto.setChannelCode(channelCode);
                saleProductProfileHistoryDto.setContent(saleProductProfileDto.getContent());
                saleProductProfileHistoryDto.setProductOwner(saleProductProfileDto.getProductOwner());
                saleProductProfileHistoryDto.setSellPoint(saleProductProfileDto.getSellPoint());
                saleProductProfileHistoryDto.setHotSaleFlag(hotSaleFlag);
                saleProductProfileHistoryDto.setSaleStatus(saleProductProfileDto.getSaleStatus());
                saleProductProfileHistoryDto.setSaleProductSpec(saleProductProfileDto.getSaleProductSpec());
                saleProductProfileHistoryDto.setSaleProductSource(saleProductProfileDto.getSaleProductSource());
                saleProductProfileHistoryDto.setDisplayOrder(saleProductProfileDto.getDisplayOrder());
                saleProductProfileHistoryDto.setOperateTime(modifyTime);
                saleProductProfileHistoryDto.setOperateUserId(modifyUserId);
                saleProductProfileHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPROFILEOPERTYPE_MODIFY);
                saleProductProfileHistoryService.saveSaleProductProfileHistory(saleProductProfileHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品附属信息出错");
            throw new ProductServiceException("异常：更新商品附属信息出错");
        }

    }

    @Override
    public boolean updateSaleProductDisplayOrder(Integer saleProductId, Integer displayOrder, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        logger.debug("productId -> " + saleProductId);
        boolean updateFlag = false;
        // 更新商品附属信息
        try {
            // 检查商品附属信息参数商品Id对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductProfileService.saleProductId => 商品附属信息参数商品saleProductId为空");
                throw new ProductServiceException("SaleProductProfileService的id参数为空");
            }
            // 检查商品附属信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductProfileDto saleProductProfileDto = this
                    .loadSaleProductProfileBySaleProductIdAndChannelCode(saleProductId, null, channelCode);
            this.updateDisplayOrderForHistory(saleProductProfileDto, displayOrder, modifyUserId, modifyTime);

        } catch (ProductServiceException e) {
            logger.error("更新商品附属信息出错");
            throw new ProductServiceException("异常：更新商品附属信息出错");
        }
        return updateFlag;
    }

    private void updateDisplayOrderForHistory(SaleProductProfileDto saleProductProfileDto, Integer displayOrder,
            Integer modifyUserId, Date modifyTime) {
        // 检查商品附属信息参数商品对象是否为空
        if (ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
            logger.error("SaleProductProfileService.saleProductProfileDto => 商品附属信息为空");
            throw new ProductServiceException("SaleProductProfileService的商品附属信息为空");
        }
        // 检查商品附属信息参数对象商品上下架状态是否为空
        if (ObjectUtils.isNullOrEmpty(displayOrder)) {
            logger.error("SaleProductProfileService.updateSaleProductDisplayOrder.displayOrder => 商品附属信息参数商品displayOrder为空");
            throw new ProductServiceException("SaleProductProfileService的updateSaleProductDisplayOrder方法的displayOrder参数为空");
        }
        // 检查商品附属信息参数修改人是否为空
        if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
            logger.error("SaleProductProfileService.updateSaleProductDisplayOrder.modifyUserId=> 商品附属信息参数修改人为空");
            throw new ProductServiceException("SaleProductProfileService的updateSaleProductDisplayOrder方法参数modifyUserId为空");
        }
        // 检查商品附属信息参数修改时间是否为空
        if (ObjectUtils.isNullOrEmpty(modifyTime)) {
            logger.error("SaleProductProfileService.updateSaleProductDisplayOrder.modifyTime => 商品附属信息参数修改时间为空");
            throw new ProductServiceException("SaleProductProfileService的updateSaleProductDisplayOrder方法参数modifyTime为空");
        }

        if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)
                && ObjectUtils.whetherModified(saleProductProfileDto.getDisplayOrder(), displayOrder)) {
            // 状态需要更改才更新
            saleProductProfileMapper.updateSaleProductDisplayOrder(saleProductProfileDto.getSaleProductId(), displayOrder,
                    saleProductProfileDto.getChannelCode(), modifyUserId, modifyTime);
            // 修改商品顺序时时时创建商品历史附属信息记录
            SaleProductProfileHistoryDto saleProductProfileHistoryDto = new SaleProductProfileHistoryDto();
            saleProductProfileHistoryDto.setSaleProductProfileId(saleProductProfileDto.getId());
            saleProductProfileHistoryDto.setSaleProductId(saleProductProfileDto.getId());
            saleProductProfileHistoryDto.setChannelCode(saleProductProfileDto.getChannelCode());
            saleProductProfileHistoryDto.setContent(saleProductProfileDto.getContent());
            saleProductProfileHistoryDto.setProductOwner(saleProductProfileDto.getProductOwner());
            saleProductProfileHistoryDto.setSellPoint(saleProductProfileDto.getSellPoint());
            saleProductProfileHistoryDto.setHotSaleFlag(saleProductProfileDto.getHotSaleFlag());
            saleProductProfileHistoryDto.setSaleStatus(saleProductProfileDto.getSaleStatus());
            saleProductProfileHistoryDto.setSaleProductSpec(saleProductProfileDto.getSaleProductSpec());
            saleProductProfileHistoryDto.setSaleProductSource(saleProductProfileDto.getSaleProductSource());
            saleProductProfileHistoryDto.setDisplayOrder(displayOrder);
            saleProductProfileHistoryDto.setOperateTime(modifyTime);
            saleProductProfileHistoryDto.setOperateUserId(modifyUserId);
            saleProductProfileHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPROFILEOPERTYPE_MODIFY);
            saleProductProfileHistoryService.saveSaleProductProfileHistory(saleProductProfileHistoryDto);
        }
    }

    @Override
    public void updateDisplayOrderByBarCodeAndChannelCode(String barCode, Integer displayOrder, Integer storeId,
            Integer modifyUserId, Date modifyTime, String channelCode) throws ProductServiceException {
        logger.debug("barCode -> " + barCode + "displayOrder -> " + displayOrder);
        try {
            // 检查商品参数店铺id是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.updateDisplayOrderByBarCodeAndChannelCode => 更新店铺商品barCode参数为空");
                throw new ProductServiceException(" 更新店铺商品barCode参数为空");
            }
            // 检查商品参数店铺id是否为空
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("ProductService.updateDisplayOrderByBarCodeAndChannelCode => 更新店铺商品的店铺Id参数为空");
                throw new ProductServiceException(" 更新店铺商品的店铺Id参数为空");
            }
            // 检查商品参数渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductProfileDto saleProductProfileDto = this.loadSaleProductProfileByBarCodeAndChannelCode(barCode,
                    storeId, channelCode);
            this.updateDisplayOrderForHistory(saleProductProfileDto, displayOrder, modifyUserId, modifyTime);

        } catch (ProductServiceException e) {
            logger.error("更新店铺商品顺序出错");
            throw new ProductServiceException("异常：更新店铺商品顺序出错");
        }

    }

    @Override
    public void updateSaleStatusBatchBySeller(List<Integer> saleProductIdList, String saleStatus, String channelCode,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductIdList)) {
                for (Integer saleProductId : saleProductIdList) {
                    this.updateSaleStatusBySaleProductIdAndChannelCode(saleProductId, saleStatus, channelCode, modifyUserId,
                            modifyTime);
                }
            }
        } catch (ProductServiceException e) {
            String msg = "卖家批量设置商品上下架出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }
}