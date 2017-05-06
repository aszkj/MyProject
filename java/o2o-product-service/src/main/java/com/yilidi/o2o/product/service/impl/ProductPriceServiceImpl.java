/**
 * 文件名称：ProductPriceService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.PriceOthernessMapper;
import com.yilidi.o2o.product.dao.ProductPriceMapper;
import com.yilidi.o2o.product.model.PriceOtherness;
import com.yilidi.o2o.product.model.ProductPrice;
import com.yilidi.o2o.product.service.IProductPriceHistoryService;
import com.yilidi.o2o.product.service.IProductPriceService;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductPriceHistoryDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.ICustomerProxyService;
import com.yilidi.o2o.user.proxy.dto.CustomerProxyDto;

/**
 * 功能描述：产品价格信息类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productPriceService")
public class ProductPriceServiceImpl extends BasicDataService implements IProductPriceService {

    @Autowired
    private ProductPriceMapper productPriceMapper;

    @Autowired
    private PriceOthernessMapper priceOthernessMapper;

    @Autowired
    private ICustomerProxyService customerProxyService;

    @Autowired
    private IProductPriceHistoryService productPriceHistoryService;

    @Override
    public ProductPriceDto loadProductPriceByProductIdAndUserId(Integer productId, Integer retailerId)
            throws ProductServiceException {
        logger.debug("loadBySaleProductIdAndUserId => [saleProductId:" + productId + ", retailerId:" + retailerId + "]");

        CustomerProxyDto customer;
        try {
            customer = customerProxyService.loadCustomerInfoById(retailerId);
            if (ObjectUtils.isNullOrEmpty(customer)) {
                logger.error("获取客户信息为null");
                throw new UserServiceException("客户信息为null");
            }
        } catch (UserServiceException e) {
            throw new ProductServiceException("ProductPriceService => 获取客户信息异常");
        }
        ProductPriceDto priceDto = new ProductPriceDto();
        priceDto.setProductId(productId);
        // 1 获取商品的发布价格
        List<ProductPrice> priceList = productPriceMapper.listProductPricesByProductId(productId);
        if (ObjectUtils.isNullOrEmpty(priceList)) {
            logger.error("获取产品价格信息为null");
            throw new ProductServiceException("商品价格信息为null");
        } else {
            // 2 获取商品的差异化价
            PriceOtherness otherness = priceOthernessMapper.loadByProductIdAndAreaCode(productId,
                    customer.getProvinceCode(), customer.getCityCode());
            if (ObjectUtils.isNullOrEmpty(otherness)) {
                Map<String, Map<String, Long>> priceMap = new HashMap<String, Map<String, Long>>();
                for (ProductPrice price : priceList) {
                    Map<String, Long> pMap = new HashMap<String, Long>();
                    // 产品基础促销价不為0就取促銷价，否則取产品基础零售价
                    // pMap.put(SystemContext.ProductPrice.CURRENTPRICE, price.getPromotionalPrice() == null ?
                    // price.getRetailPrice() : price.getPromotionalPrice());
                    priceMap.put(price.getChannelCode(), pMap);
                }
            } else {
                Map<String, Map<String, Long>> priceMap = new HashMap<String, Map<String, Long>>();
                for (ProductPrice price : priceList) {
                    Map<String, Long> pMap = new HashMap<String, Long>();
                    // 产品基础促销价不為0就取促銷价，否則取产品基础零售价
                    // pMap.put(SystemContext.ProductPrice.CURRENTPRICE, price.getPromotionalPrice() == null ?
                    // price.getRetailPrice() : price.getPromotionalPrice());
                    priceMap.put(price.getChannelCode(), pMap);
                }
            }
        }
        return priceDto;
    }

    @Override
    public void saveProductPrice(ProductPriceDto saveProductPriceDto) throws ProductServiceException {
        // 保存产品价格表开始
        logger.debug("saveProductPriceDto -> " + saveProductPriceDto);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductPriceDto)) {
                logger.error("ProductService.saveProductPriceDto => 产品参数为空");
                throw new ProductServiceException("ProductService的saveProductPrice方法参数为空");
            }
            // 检查产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getProductId())) {
                logger.error("saveProductPriceDto.productId => 产品id参数为空");
                throw new ProductServiceException("异常：保存价格时产品productId参数为空");
            }
            // 检查产品渠道编码参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getChannelCode())) {
                logger.error("saveProductPriceDto.channelCode => 产品channelCode参数为空");
                throw new ProductServiceException("异常：保存价格时产品channelCode参数为空");
            }
            ProductPriceDto productPriceDtoLoadDto = this.loadProductPriceByProductIdAndChannelCode(
                    saveProductPriceDto.getProductId(), saveProductPriceDto.getChannelCode());
            // 该产品该渠道的价格是否已经存在，如果不存在则新建，存在则更新
            if (ObjectUtils.isNullOrEmpty(productPriceDtoLoadDto)) {
                // 普通会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getCostPrice())) {
                    logger.error("saveProductPriceDto.getCostPrice => 采购价格参数为空");
                    throw new ProductServiceException("采购价格参数为空");
                }
                // 普通会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getRetailPrice())) {
                    logger.error("saveProductPriceDto.retailPrice => 普通会员售价参数为空");
                    throw new ProductServiceException("普通会员售价参数为空");
                }
                // 检查产品创建人ID参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getCreateUserId())) {
                    logger.error("saveProductPriceDto.createUserId => 产品createUserId参数为空");
                    throw new ProductServiceException("异常：产品createUserId参数为空");
                }
                // 检查产品创建时间参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductPriceDto.getCreateTime())) {
                    logger.error("saveProductPriceDto.createTime => 产品createTime参数为空");
                    throw new ProductServiceException("异常：产品createTime参数为空");
                }
                ProductPrice productPrice = new ProductPrice();
                productPrice.setProductId(saveProductPriceDto.getProductId());
                productPrice.setRetailPrice(saveProductPriceDto.getRetailPrice());
                productPrice.setChannelCode(saveProductPriceDto.getChannelCode());
                productPrice.setCreateTime(saveProductPriceDto.getCreateTime());
                productPrice.setPromotionalPrice(saveProductPriceDto.getPromotionalPrice());
                productPrice.setCreateUserId(saveProductPriceDto.getCreateUserId());
                productPrice.setCommissionPrice(null == saveProductPriceDto.getCommissionPrice() ? 0L : saveProductPriceDto
                        .getCommissionPrice());
                productPrice.setCostPrice(saveProductPriceDto.getCostPrice());
                productPrice.setVipCommissionPrice(null == saveProductPriceDto.getVipCommissionPrice() ? 0L
                        : saveProductPriceDto.getVipCommissionPrice());
                productPriceMapper.saveProductPrice(productPrice);

                // 保存产品价格时创建产品历史价格记录
                ProductPriceHistoryDto productPriceHistoryDto = new ProductPriceHistoryDto();
                productPriceHistoryDto.setProductPriceId(productPrice.getId());
                productPriceHistoryDto.setProductId(saveProductPriceDto.getProductId());
                productPriceHistoryDto.setPromotionalPrice(saveProductPriceDto.getPromotionalPrice());
                productPriceHistoryDto.setRetailPrice(saveProductPriceDto.getRetailPrice());
                productPriceHistoryDto.setChannelCode(saveProductPriceDto.getChannelCode());
                productPriceHistoryDto.setOperateType(SystemContext.ProductDomain.PRODUCTPRICEOPERTYPE_CREATE);
                productPriceHistoryDto.setOperateTime(saveProductPriceDto.getCreateTime());
                productPriceHistoryDto.setOperateUserId(saveProductPriceDto.getCreateUserId());
                productPriceHistoryDto.setCommissionPrice(null == saveProductPriceDto.getCommissionPrice() ? 0L
                        : saveProductPriceDto.getCommissionPrice());
                productPriceHistoryDto.setCostPrice(saveProductPriceDto.getCostPrice());
                productPriceHistoryDto.setVipCommissionPrice(null == saveProductPriceDto.getVipCommissionPrice() ? 0L
                        : saveProductPriceDto.getVipCommissionPrice());
                productPriceHistoryService.saveProductPriceHistory(productPriceHistoryDto);
            } else {
                saveProductPriceDto.setModifyUserId(saveProductPriceDto.getCreateUserId());
                saveProductPriceDto.setModifyTime(saveProductPriceDto.getCreateTime());
                saveProductPriceDto.setId(productPriceDtoLoadDto.getId());
                this.updateProductPrice(saveProductPriceDto);
            }
        } catch (ProductServiceException e) {
            logger.error("保存产品价格出错");
            throw new ProductServiceException("异常：保存产品价格出错");
        }
    }

    @Override
    public void updateProductPrice(ProductPriceDto updateProductPriceDto) throws ProductServiceException {
        // 更新产品价格表开始
        logger.debug("updateProductPriceDto -> " + updateProductPriceDto);
        // 更新产品价格
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductPriceDto)) {
                logger.error("ProductService.updateProductPriceDto => 产品参数为空");
                throw new ProductServiceException("ProductService的updateProductPrice方法参数为空");
            }
            // 检查产品价格修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductPriceDto.getModifyUserId())) {
                logger.error("ProductService.updateProductPriceDto.modifyUserId=> 产品价格修改人为空");
                throw new ProductServiceException("ProductService的updateProductPrice.modifyUserId方法参数modifyUserId为空");
            }
            // 检查产品价格修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductPriceDto.getModifyTime())) {
                logger.error("ProductService.updateProductPriceDto.modifyTime => 产品价格修改时间为空");
                throw new ProductServiceException("ProductService的updateProductPrice方法参数modifyTime为空");
            }

            // 检查产品价格ID参数是否为空
            if (!ObjectUtils.isNullOrEmpty(updateProductPriceDto.getId())) {
                ProductPrice productPrice = productPriceMapper.loadProductPriceById(updateProductPriceDto.getId());

                if (ObjectUtils.whetherModified(productPrice.getRetailPrice(), updateProductPriceDto.getRetailPrice())
                        || ObjectUtils.whetherModified(productPrice.getPromotionalPrice(),
                                updateProductPriceDto.getPromotionalPrice())
                        || ObjectUtils.whetherModified(productPrice.getCostPrice(), updateProductPriceDto.getCostPrice())
                        || ObjectUtils.whetherModified(productPrice.getCommissionPrice(),
                                updateProductPriceDto.getCommissionPrice())
                        || ObjectUtils.whetherModified(productPrice.getVipCommissionPrice(),
                                updateProductPriceDto.getVipCommissionPrice())) {

                    // 更新产品价格时创建产品历史价格记录
                    ProductPriceHistoryDto productPriceHistoryDto = new ProductPriceHistoryDto();
                    productPriceHistoryDto.setProductPriceId(productPrice.getId());
                    productPriceHistoryDto.setProductId(updateProductPriceDto.getProductId());
                    productPriceHistoryDto.setOriPromotionalPrice(productPrice.getPromotionalPrice());
                    productPriceHistoryDto.setPromotionalPrice(updateProductPriceDto.getPromotionalPrice());
                    productPriceHistoryDto.setOriRetailPrice(productPrice.getRetailPrice());
                    productPriceHistoryDto.setRetailPrice(updateProductPriceDto.getRetailPrice());
                    productPriceHistoryDto.setChannelCode(updateProductPriceDto.getChannelCode());
                    productPriceHistoryDto.setOperateType(SystemContext.ProductDomain.PRODUCTPRICEOPERTYPE_MODIFY);
                    productPriceHistoryDto.setOperateTime(updateProductPriceDto.getModifyTime());
                    productPriceHistoryDto.setOperateUserId(updateProductPriceDto.getModifyUserId());
                    productPriceHistoryDto.setOriCommissionPrice(productPrice.getCommissionPrice());
                    productPriceHistoryDto.setCommissionPrice(null == updateProductPriceDto.getCommissionPrice() ? 0L
                            : updateProductPriceDto.getCommissionPrice());
                    productPriceHistoryDto.setOriCostPrice(productPrice.getCostPrice());
                    productPriceHistoryDto.setCostPrice(updateProductPriceDto.getCostPrice());
                    productPriceHistoryDto.setOriVipCommissionPrice(productPrice.getVipCommissionPrice());
                    productPriceHistoryDto.setVipCommissionPrice(null == updateProductPriceDto.getVipCommissionPrice() ? 0L
                            : updateProductPriceDto.getVipCommissionPrice());
                    productPriceHistoryService.saveProductPriceHistory(productPriceHistoryDto);

                    productPrice.setRetailPrice(updateProductPriceDto.getRetailPrice());
                    productPrice.setPromotionalPrice(updateProductPriceDto.getPromotionalPrice());
                    productPrice.setModifyTime(updateProductPriceDto.getModifyTime());
                    productPrice.setModifyUserId(updateProductPriceDto.getModifyUserId());
                    productPrice.setModifyTime(updateProductPriceDto.getModifyTime());
                    productPrice.setCommissionPrice(null == updateProductPriceDto.getCommissionPrice() ? 0L
                            : updateProductPriceDto.getCommissionPrice());
                    productPrice.setCostPrice(updateProductPriceDto.getCostPrice());
                    productPrice.setVipCommissionPrice(null == updateProductPriceDto.getVipCommissionPrice() ? 0L
                            : updateProductPriceDto.getVipCommissionPrice());
                    productPriceMapper.updateProductPriceById(productPrice);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("更新产品价格出错");
            throw new ProductServiceException("异常：更新产品价格出错");
        }
    }

    @Override
    public ProductPriceDto loadProductPriceByProductIdAndChannelCode(Integer productId, String channelCode)
            throws ProductServiceException {
        logger.debug("loadProductPriceByProductId -> " + productId);
        ProductPriceDto productPriceDto = null;
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductService.loadProductPriceByProductId => 产品Id参数为空");
                throw new ProductServiceException("产品Id参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            ProductPrice productPrice = productPriceMapper.loadProductPriceByProductIdAndChannelCode(productId, channelCode);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(productPrice)) {
                productPriceDto = new ProductPriceDto();
                ObjectUtils.fastCopy(productPrice, productPriceDto);
            }

        } catch (ProductServiceException e) {
            logger.error("查询产品基础信息出错");
            throw new ProductServiceException("异常：查询产品基础信息出错");
        }
        return productPriceDto;
    }

}
