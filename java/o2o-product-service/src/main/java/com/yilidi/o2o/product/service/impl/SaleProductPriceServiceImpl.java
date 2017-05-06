/**
 * 文件名称：SaleProductPriceService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductPriceMapper;
import com.yilidi.o2o.product.model.SaleProductPrice;
import com.yilidi.o2o.product.service.ISaleProductPriceHistoryService;
import com.yilidi.o2o.product.service.ISaleProductPriceService;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:商品价格记录服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductPriceService")
public class SaleProductPriceServiceImpl extends BasicDataService implements ISaleProductPriceService {

    @Autowired
    private SaleProductPriceMapper saleProductPriceMapper;

    @Autowired
    private ISaleProductPriceHistoryService saleProductPriceHistoryService;

    @Override
    public void saveSaleProductPrice(SaleProductPriceDto saveSaleProductPriceDto) throws ProductServiceException {
        // 保存商品价格表开始
        logger.debug("saveSaleProductPriceDto -> " + saveSaleProductPriceDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto)) {
                logger.error("SaleProductPriceService.saveSaleProductPriceDto => 商品参数为空");
                throw new ProductServiceException("SaleProductPriceService的saveSaleProductPriceDto方法参数为空");
            }
            SaleProductPriceDto saleProductPriceDto = this.loadSaleProductPriceBySaleProductIdAndChannelCode(
                    saveSaleProductPriceDto.getSaleProductId(), saveSaleProductPriceDto.getChannelCode());
            // 检查商品价格是否已经存在，不存在则创建，存在则更新
            if (ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                // 商品saleProductId是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto.getSaleProductId())) {
                    logger.error("saveSaleProductPriceDto.saleProductId => 商品saleProductId参数为空");
                    throw new ProductServiceException("商品saleProductId参数为空");
                }
                // 商品channelCode是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto.getChannelCode())) {
                    logger.error("saveSaleProductPriceDto.channelCode => 商品channelCode参数为空");
                    throw new ProductServiceException("商品channelCode参数为空");
                }
                // 商品零售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto.getRetailPrice())) {
                    logger.error("saveSaleProductPriceDto.retailPrice => 商品建议零售价参数为空");
                    throw new ProductServiceException("商品建议零售价参数为空");
                }
                // 商品createUserId是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto.getCreateUserId())) {
                    logger.error("saveSaleProductPriceDto.createUserId => 商品createUserId参数为空");
                    throw new ProductServiceException("商品createUserId参数为空");
                }
                // 商品createTime是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductPriceDto.getCreateTime())) {
                    logger.error("saveSaleProductPriceDto.createTime => 商品createTime参数为空");
                    throw new ProductServiceException("商品createTime参数为空");
                }
                SaleProductPrice saleProductPrice = new SaleProductPrice();
                saleProductPrice.setSaleProductId(saveSaleProductPriceDto.getSaleProductId());
                saleProductPrice.setPromotionalPrice(saveSaleProductPriceDto.getPromotionalPrice());
                saleProductPrice.setRetailPrice(saveSaleProductPriceDto.getRetailPrice());
                saleProductPrice.setChannelCode(saveSaleProductPriceDto.getChannelCode());
                saleProductPrice.setCreateTime(saveSaleProductPriceDto.getCreateTime());
                // 此处创建人id需要取到用户登录的id
                saleProductPrice.setCreateUserId(saveSaleProductPriceDto.getCreateUserId());
                saleProductPrice.setCommissionPrice(saveSaleProductPriceDto.getCommissionPrice());
                saleProductPrice.setCostPrice(saveSaleProductPriceDto.getCostPrice());
                saleProductPrice.setVipCommissionPrice(saveSaleProductPriceDto.getVipCommissionPrice());
                saleProductPriceMapper.saveSaleProductPrice(saleProductPrice);

                // 保存商品价格时创建商品历史价格记录
                SaleProductPriceHistoryDto saleProductPriceHistoryDto = new SaleProductPriceHistoryDto();
                saleProductPriceHistoryDto.setSaleProductPriceId(saleProductPrice.getId());
                saleProductPriceHistoryDto.setSaleProductId(saveSaleProductPriceDto.getSaleProductId());
                saleProductPriceHistoryDto.setPromotionalPrice(saveSaleProductPriceDto.getPromotionalPrice());
                saleProductPriceHistoryDto.setRetailPrice(saveSaleProductPriceDto.getRetailPrice());
                saleProductPriceHistoryDto.setChannelCode(saveSaleProductPriceDto.getChannelCode());
                saleProductPriceHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPRICEOPERTYPE_CREATE);
                saleProductPriceHistoryDto.setOperateTime(saveSaleProductPriceDto.getCreateTime());
                saleProductPriceHistoryDto.setOperateUserId(saveSaleProductPriceDto.getCreateUserId());
                saleProductPriceHistoryDto.setCommissionPrice(saveSaleProductPriceDto.getCommissionPrice());
                saleProductPriceHistoryDto.setCostPrice(saveSaleProductPriceDto.getCostPrice());
                saleProductPriceHistoryDto.setVipCommissionPrice(saveSaleProductPriceDto.getVipCommissionPrice());
                saleProductPriceHistoryService.saveSaleProductPriceHistory(saleProductPriceHistoryDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存商品价格出错");
            throw new ProductServiceException("异常：保存商品价格出错");
        }
    }

    @Override
    public void updateSaleProductPrice(SaleProductPriceDto updateSaleProductPriceDto) throws ProductServiceException {
        // 更新商品价格表开始
        logger.debug("updateSaleProductPriceDto -> " + updateSaleProductPriceDto);
        // 更新商品价格
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductPriceDto)) {
                logger.error("SaleProductPriceService.updateSaleProductPriceDto => 商品参数为空");
                throw new ProductServiceException("SaleProductPriceService的updateSaleProductPriceDto方法参数为空");
            }
            // 检查商品价格修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductPriceDto.getModifyUserId())) {
                logger.error("ProductService.updateSaleProductPriceDto.modifyUserId=> 商品价格修改人为空");
                throw new ProductServiceException("ProductService的updateSaleProductPrice.modifyUserId方法参数modifyUserId为空");
            }
            // 检查商品价格修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductPriceDto.getModifyTime())) {
                logger.error("ProductService.updateSaleProductPriceDto.modifyTime => 商品价格修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleProductPrice方法参数modifyTime为空");
            }

            SaleProductPrice saleProductPrice = saleProductPriceMapper.loadSaleProductPriceBySaleProductIdAndChannelCode(
                    updateSaleProductPriceDto.getSaleProductId(), updateSaleProductPriceDto.getChannelCode());

            // 更新商品零售价
            if (ObjectUtils.isNullOrEmpty(saleProductPrice)) {
                logger.error("updateSaleProductPriceDto.saleProductPrice => 需要更新的商品价格为空");
                throw new ProductServiceException("需要更新的商品价格为空");
            }

            if (ObjectUtils.whetherModified(saleProductPrice.getRetailPrice(), updateSaleProductPriceDto.getRetailPrice())
                    || ObjectUtils.whetherModified(saleProductPrice.getPromotionalPrice(),
                            updateSaleProductPriceDto.getPromotionalPrice())
                    || ObjectUtils.whetherModified(saleProductPrice.getCommissionPrice(),
                            updateSaleProductPriceDto.getCommissionPrice())
                    || ObjectUtils
                            .whetherModified(saleProductPrice.getCostPrice(), updateSaleProductPriceDto.getCostPrice())
                    || ObjectUtils.whetherModified(saleProductPrice.getVipCommissionPrice(),
                            updateSaleProductPriceDto.getVipCommissionPrice())) {
                // 更新商品价格时创建商品历史价格记录
                SaleProductPriceHistoryDto saleProductPriceHistoryDto = new SaleProductPriceHistoryDto();
                saleProductPriceHistoryDto.setSaleProductPriceId(saleProductPrice.getId());
                saleProductPriceHistoryDto.setSaleProductId(updateSaleProductPriceDto.getSaleProductId());
                saleProductPriceHistoryDto.setOriPromotionalPrice(saleProductPrice.getPromotionalPrice());
                saleProductPriceHistoryDto.setPromotionalPrice(updateSaleProductPriceDto.getPromotionalPrice());
                saleProductPriceHistoryDto.setOriRetailPrice(saleProductPrice.getRetailPrice());
                saleProductPriceHistoryDto.setRetailPrice(updateSaleProductPriceDto.getRetailPrice());
                saleProductPriceHistoryDto.setChannelCode(updateSaleProductPriceDto.getChannelCode());
                saleProductPriceHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTPRICEOPERTYPE_MODIFY);
                saleProductPriceHistoryDto.setOperateTime(updateSaleProductPriceDto.getModifyTime());
                saleProductPriceHistoryDto.setOperateUserId(updateSaleProductPriceDto.getModifyUserId());
                saleProductPriceHistoryDto.setOriCommissionPrice(saleProductPrice.getCommissionPrice());
                saleProductPriceHistoryDto.setCommissionPrice(updateSaleProductPriceDto.getCommissionPrice());
                saleProductPriceHistoryDto.setOriCostPrice(saleProductPrice.getCostPrice());
                saleProductPriceHistoryDto.setCostPrice(updateSaleProductPriceDto.getCostPrice());
                saleProductPriceHistoryDto.setVipCommissionPrice(saleProductPrice.getVipCommissionPrice());
                saleProductPriceHistoryDto.setVipCommissionPrice(updateSaleProductPriceDto.getVipCommissionPrice());
                saleProductPriceHistoryService.saveSaleProductPriceHistory(saleProductPriceHistoryDto);

                saleProductPrice.setModifyTime(updateSaleProductPriceDto.getModifyTime());
                saleProductPrice.setModifyUserId(updateSaleProductPriceDto.getModifyUserId());
                saleProductPrice.setRetailPrice(updateSaleProductPriceDto.getRetailPrice());
                saleProductPrice.setPromotionalPrice(updateSaleProductPriceDto.getPromotionalPrice());
                saleProductPrice.setCommissionPrice(updateSaleProductPriceDto.getCommissionPrice());
                saleProductPrice.setCostPrice(updateSaleProductPriceDto.getCostPrice());
                saleProductPrice.setVipCommissionPrice(updateSaleProductPriceDto.getVipCommissionPrice());
                saleProductPriceMapper.updateSaleProductPriceById(saleProductPrice);
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品价格出错");
            throw new ProductServiceException("异常：更新商品价格出错");
        }
    }

    @Override
    public SaleProductPriceDto loadSaleProductPriceBySaleProductIdAndChannelCode(Integer saleProductId, String channelCode)
            throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("SaleProductPriceService.loadSaleProductPriceBySaleProductIdAndChannelCode => 产品Id参数为空");
                throw new ProductServiceException("产品Id参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductPrice saleProductPrice = saleProductPriceMapper.loadSaleProductPriceBySaleProductIdAndChannelCode(
                    saleProductId, channelCode);
            // 检查产品对象是否为空
            SaleProductPriceDto saleProductPriceDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductPrice)) {
                saleProductPriceDto = new SaleProductPriceDto();
                ObjectUtils.fastCopy(saleProductPrice, saleProductPriceDto);
            }

            return saleProductPriceDto;
        } catch (ProductServiceException e) {
            logger.error("查询产品价格信息出错");
            throw new ProductServiceException("异常：查询产品价格信息出错");
        }
    }

    @Override
    public SaleProductPriceDto loadSaleProductPriceById(Integer id) throws ProductServiceException {
        logger.debug("id -> " + id);
        // 检查产品参数对象是否为空
        if (ObjectUtils.isNullOrEmpty(id)) {
            logger.error("SaleProductPriceService.loadSaleProductPriceById => 产品id参数为空");
            throw new ProductServiceException("产品id参数为空");
        }
        SaleProductPriceDto saleProductPriceDto = null;
        try {
            SaleProductPrice saleProductPrice = saleProductPriceMapper.loadSaleProductPriceById(id);
            // 检查产品对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductPrice)) {
                logger.error("SaleProductPriceService.loadSaleProductPriceBySaleProductIdAndChannelCode => 产品价格为空");
                throw new ProductServiceException("产品价格为空");
            }
            saleProductPriceDto = new SaleProductPriceDto();
            ObjectUtils.fastCopy(saleProductPrice, saleProductPriceDto);
        } catch (ProductServiceException e) {
            logger.error("依据价格ID查询产品价格信息出错");
            throw new ProductServiceException("异常：依据价格ID查询产品价格信息出错");
        }
        return saleProductPriceDto;
    }

}