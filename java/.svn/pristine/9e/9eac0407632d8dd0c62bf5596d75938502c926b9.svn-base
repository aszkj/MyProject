/**
 * 文件名称：ProductProxySerivce.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.proxy.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.ProductClassMapper;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.product.service.IProductPriceService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductPriceService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 功能描述：产品代理服务接口实现 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productProxyService")
public class ProductProxySerivce extends BaseService implements IProductProxyService {

    @Autowired
    private SaleProductMapper saleProductMapper;
    @Autowired
    private ProductClassMapper productClassMapper;
    @Autowired
    private IProductPriceService productPriceService;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISaleProductPriceService saleProductPriceService;
    @Autowired
    private IProductService productService;

    @Override
    public SaleProductProxyDto loadById(Integer saleProductId) throws ProductServiceException {
        logger.debug("saleProductId => " + saleProductId);
        if (ObjectUtils.isNullOrEmpty(saleProductId)) {
            logger.error("ProductProxySerivce.loadById => 参数为null");
            throw new ProductServiceException("商品id为null，请检查！");
        }

        SaleProduct product = saleProductMapper.loadSaleProductBasicInfoById(saleProductId, null);

        logger.debug("saleProduct -> " + product);
        if (ObjectUtils.isNullOrEmpty(product)) {
            logger.error("ProductProxySerivce.loadById => 查询结果为null");
            throw new ProductServiceException("商品[" + saleProductId + "]对应的记录不存在，请核实后查询");
        }

        SaleProductProxyDto proxyDto = new SaleProductProxyDto();
        ObjectUtils.fastCopy(product, proxyDto);
        return proxyDto;
    }

    @Override
    public SaleProductProxyDto loadDetailById(Integer saleProductId) throws ProductServiceException {
        SaleProductAppDto saleProductAppDto = saleProductService.loadSaleProductById(saleProductId, null, null, null);
        SaleProductProxyDto saleProductProxyDto = new SaleProductProxyDto();
        ObjectUtils.fastCopy(saleProductAppDto, saleProductProxyDto);
        if (null != saleProductAppDto.getSaleProductProfileDto()) {
            saleProductProxyDto.setSaleStatus(saleProductAppDto.getSaleProductProfileDto().getSaleStatus());
            saleProductProxyDto.setSaleProductSpec(saleProductAppDto.getSaleProductProfileDto().getSaleProductSpec());
        }
        saleProductProxyDto.setRemainCount(saleProductAppDto.getStockNum());
        return saleProductProxyDto;
    }

    @Override
    public ProductPriceProxyDto loadBySaleProductIdAndUserId(Integer saleProductId, Integer retailerId)
            throws ProductServiceException {

        ProductPriceDto dto = productPriceService.loadProductPriceByProductIdAndUserId(saleProductId, retailerId);
        ProductPriceProxyDto proxyDto = new ProductPriceProxyDto();
        ObjectUtils.fastCopy(dto, proxyDto);
        return proxyDto;
    }

    @Override
    public List<String> listProductClassNamesByCodes(List<String> codesList) throws ProductServiceException {
        if (ObjectUtils.isNullOrEmpty(codesList)) {
            return new ArrayList<String>();
        }
        return productClassMapper.listProductClassNamesByCodes(codesList);
    }

    @Override
    public List<SaleProductProxyDto> listSaleProductByIdsAndChannelCode(List<Integer> saleProductIds, String enabledFlag,
            String saleStatus, String channelCode) throws ProductServiceException {
        List<SaleProductAppDto> saleProductAppDtoList = saleProductService.listSaleProductByIdsAndChannelCode(saleProductIds,
                enabledFlag, saleStatus, channelCode);
        List<SaleProductProxyDto> saleProductProxyDtoList = new ArrayList<SaleProductProxyDto>();
        if (!ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
            for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                SaleProductProxyDto saleProductProxyDto = new SaleProductProxyDto();
                ObjectUtils.fastCopy(saleProductAppDto, saleProductProxyDto);
                if (null != saleProductAppDto.getSaleProductProfileDto()) {
                    saleProductProxyDto.setSaleStatus(saleProductAppDto.getSaleProductProfileDto().getSaleStatus());
                    saleProductProxyDto
                            .setSaleProductSpec(saleProductAppDto.getSaleProductProfileDto().getSaleProductSpec());
                }
                saleProductProxyDto.setRemainCount(saleProductAppDto.getStockNum());
                saleProductProxyDtoList.add(saleProductProxyDto);
            }
        }
        return saleProductProxyDtoList;
    }

    @Override
    public List<SaleProductPriceProxyDto> listSaleProductPriceByIdsAndChannelCode(List<Integer> saleProductIds,
            String channelCode) throws ProductServiceException {
        try {
            List<SaleProductPriceProxyDto> resultList = new ArrayList<SaleProductPriceProxyDto>();
            for (Integer saleProductId : saleProductIds) {
                SaleProductPriceDto saleProductPriceDto = saleProductPriceService
                        .loadSaleProductPriceBySaleProductIdAndChannelCode(saleProductId, channelCode);
                SaleProductPriceProxyDto saleProductPriceProxyDto = new SaleProductPriceProxyDto();
                ObjectUtils.fastCopy(saleProductPriceDto, saleProductPriceProxyDto);
                resultList.add(saleProductPriceProxyDto);
            }
            return resultList;
        } catch (Exception e) {
            logger.error("listSaleProductPriceByIdsAndChannelCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductProxyDto> listSaleProductByProductIdsAndStoreId(List<Integer> productIds, String enabledFlag,
            String saleStatus, Integer storeId) throws ProductServiceException {
        try {
            List<SaleProductAppDto> saleProductAppDtoList = saleProductService
                    .listSaleProductByProductIdsAndStoreIdAndChannelCode(productIds, enabledFlag, saleStatus, storeId, null);
            List<SaleProductProxyDto> saleProductProxyDtoList = new ArrayList<SaleProductProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
                for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                    SaleProductProxyDto saleProductProxyDto = new SaleProductProxyDto();
                    ObjectUtils.fastCopy(saleProductAppDto, saleProductProxyDto);
                    if (null != saleProductAppDto.getSaleProductProfileDto()) {
                        saleProductProxyDto.setSaleStatus(saleProductAppDto.getSaleProductProfileDto().getSaleStatus());
                        saleProductProxyDto
                                .setSaleProductSpec(saleProductAppDto.getSaleProductProfileDto().getSaleProductSpec());
                    }
                    saleProductProxyDto.setRemainCount(saleProductAppDto.getStockNum());
                    saleProductProxyDtoList.add(saleProductProxyDto);
                }
            }
            return saleProductProxyDtoList;
        } catch (Exception e) {
            logger.error("listSaleProductByProductIdsAndStoreId异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveSaleProductByProductIdsAndStoreId(Integer storeId, String storeType, List<Integer> productIds,
            Integer operateUserId, Date operateTime) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(productIds) || ObjectUtils.isNullOrEmpty(storeId)
                    || ObjectUtils.isNullOrEmpty(storeType) || ObjectUtils.isNullOrEmpty(operateUserId)
                    || ObjectUtils.isNullOrEmpty(operateTime)) {
                throw new ProductServiceException("参数异常");
            }
            List<ProductDto> productDtos = new ArrayList<>();
            for (Integer productId : productIds) {
                ProductDto productDto = productService.loadProductByProductIdAndChannelCode(productId, null);
                productDto.setPerOperCount(1);
                productDtos.add(productDto);
            }
            SaleProductBatchSaveDto saleProductBatchSaveDto = new SaleProductBatchSaveDto(storeId, operateUserId,
                    operateTime, SystemContext.UserDomain.CHANNELTYPE_ALL, storeType);
            saleProductService.saveSaleProductBatchSync(productDtos, saleProductBatchSaveDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<ProductProxyDto> listProductByProductIds(List<Integer> productIds) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(productIds)) {
                throw new ProductServiceException("产品不能为空");
            }
            List<ProductDto> productDtoList = productService.listProductByIdsAndStatusCode(productIds,
                    SystemContext.ProductDomain.PRODUCTSTATUS_ON);
            if (ObjectUtils.isNullOrEmpty(productDtoList)) {
                return null;
            }
            List<ProductProxyDto> productProxyDtoList = new ArrayList<ProductProxyDto>();
            for (ProductDto productDto : productDtoList) {
                ProductProxyDto productProxyDto = new ProductProxyDto();
                ObjectUtils.fastCopy(productDto, productProxyDto);
                productProxyDto.setProductClassName(productDto.getClassName());
                ProductProfileDto productProfileDto = productDto.getProductProfileDto();
                if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                    productProxyDto.setProductSpec(productProfileDto.getProductSpec());
                    productProxyDto.setSaleStatus(productProfileDto.getSaleStatus());
                }
                ProductPriceDto productPriceDto = productDto.getProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                    productProxyDto.setCommissionPrice(productPriceDto.getCommissionPrice());
                    productProxyDto.setVipCommissionPrice(productPriceDto.getVipCommissionPrice());
                    productProxyDto.setCostPrice(productPriceDto.getCostPrice());
                    productProxyDto.setPromotionalPrice(productPriceDto.getPromotionalPrice());
                    productProxyDto.setRetailPrice(productPriceDto.getRetailPrice());
                }
                List<ProductImageDto> productImageDtos = productDto.getProductImageDtos();
                if (!ObjectUtils.isNullOrEmpty(productImageDtos)) {
                    productProxyDto.setProductImageUrl(productImageDtos.get(0).getImageUrl());
                }
                productProxyDtoList.add(productProxyDto);
            }
            return productProxyDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

	@Override
	public List<Integer> listStoreIdsByProductId(String enabledFlag, String saleStatus, Integer productId)
			throws ProductServiceException {
		SaleProductQuery saleProductQuery = new SaleProductQuery();
		if(null == productId){
			throw new ProductServiceException("产品id为空");
		}
		saleProductQuery.setProductId(productId);
		if(null != enabledFlag){
			saleProductQuery.setEnabledFlag(enabledFlag);
		}else{
			saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
		}
		if(null != saleStatus){
			saleProductQuery.setSaleStatus(saleStatus);
		}else{
			saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
		}
		saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
		String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
		String sort = CommonConstants.SORT_ORDER_ASC;
		saleProductQuery.setOrder(order);
		saleProductQuery.setSort(sort);
		List<Integer> storeIds = saleProductService.listStoreIdsByProductId(saleProductQuery);
		return storeIds;
	}

	@Override
	public SaleProductProxyDto loadSaleProductInfoByStoreIdAndBarCode(Integer storeId, String storeName, String barCode,
			String saleProductName) throws ProductServiceException {
		try {
            if (ObjectUtils.isNullOrEmpty(storeId) || StringUtils.isEmpty(barCode)|| StringUtils.isEmpty(storeName)|| StringUtils.isEmpty(saleProductName)) {
                return null;
            }
            SaleProductDto saleProductDto = saleProductService.loadSaleProductInfoByStoreIdAndBarCode(storeId, storeName, barCode, saleProductName);
            SaleProductProxyDto saleProductProxyDto = new SaleProductProxyDto();
            if (ObjectUtils.isNullOrEmpty(saleProductDto) ){
                return null;
            }
            ObjectUtils.fastCopy(saleProductDto, saleProductProxyDto);
            return saleProductProxyDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
	}

    @Override
    public void updateBatchSaleProductRemainCount(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIdAndRemainCountDeltaKeys)) {
                return;
            }
            saleProductService.updateBatchRemainCountById(saleProductIdAndRemainCountDeltaKeys, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

}
