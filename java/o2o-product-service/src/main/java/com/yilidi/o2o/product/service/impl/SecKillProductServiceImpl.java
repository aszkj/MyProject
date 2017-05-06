package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.ISaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.ISecKillSaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SaleProductInventoryProxyDto;
import com.yilidi.o2o.order.proxy.dto.SecKillSaleProductInventoryProxyDto;
import com.yilidi.o2o.product.dao.ProductBrandMapper;
import com.yilidi.o2o.product.dao.ProductMapper;
import com.yilidi.o2o.product.dao.ProductPriceMapper;
import com.yilidi.o2o.product.dao.ProductProfileMapper;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.dao.SecKillProductMapper;
import com.yilidi.o2o.product.dao.SecKillSceneMapper;
import com.yilidi.o2o.product.dao.SecKillSceneProductRelationMapper;
import com.yilidi.o2o.product.model.Product;
import com.yilidi.o2o.product.model.ProductBrand;
import com.yilidi.o2o.product.model.ProductPrice;
import com.yilidi.o2o.product.model.ProductProfile;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.SecKillProduct;
import com.yilidi.o2o.product.model.SecKillScene;
import com.yilidi.o2o.product.model.SecKillSceneProductRelation;
import com.yilidi.o2o.product.model.combination.SecKillProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.SecKillSaleProductRelatedInfo;
import com.yilidi.o2o.product.model.query.SecKillProductQuery;
import com.yilidi.o2o.product.service.ISaleProductImageService;
import com.yilidi.o2o.product.service.ISecKillProductService;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SecKillProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSaleProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.product.service.dto.query.SecKillProductQueryDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 秒杀商品服务接口实现类
 * 
 * @author: chenb
 * @date: 2016年8月19日 上午11:26:29
 */
@Service("secKillProductService")
public class SecKillProductServiceImpl extends BasicDataService implements ISecKillProductService {

    @Autowired
    private SecKillProductMapper secKillProductMapper;
    @Autowired
    private SecKillSceneMapper secKillSceneMapper;
    @Autowired
    private SecKillSceneProductRelationMapper secKillSceneProductRelationMapper;
    @Autowired
    private ISecKillSceneService secKillSceneService;

    @Autowired
    private SaleProductMapper saleProductMapper;
    @Autowired
    private ProductPriceMapper productPriceMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private ProductProfileMapper productProfileMapper;
    @Autowired
    private ProductBrandMapper productBrandMapper;
    @Autowired
    private ISaleProductImageService saleProductImageService;
    @Autowired
    private ISaleProductInventoryProxyService saleProductInventoryProxyService;
    @Autowired
    private ISecKillSaleProductInventoryProxyService secKillSaleProductInventoryProxyService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private IStoreWarehouseProxyService storeWarehouseProxyService;

    @Override
    public Integer save(SecKillProductDto secKillProductDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductDto) || ObjectUtils.isNullOrEmpty(secKillProductDto.getProductId())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillProductPrice())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getDisplayOrder())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getRemainCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillTime())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getQualifyType())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getLimitOrderCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getCreateUserId())) {
                throw new ProductServiceException("必填参数不能为空");
            }
            if (secKillProductDto.getSecKillCount() > secKillProductDto.getRemainCount()) {
                throw new ProductServiceException("允许秒中商品数量不能大于库存");
            }
            if (secKillProductDto.getLimitOrderCount() > secKillProductDto.getSecKillCount()) {
                throw new ProductServiceException("限购数量不能大于允许秒中数量");
            }
            Date operationDate = new Date();
            SecKillProduct secKillProduct = new SecKillProduct();
            ObjectUtils.fastCopy(secKillProductDto, secKillProduct);
            secKillProduct.setSecKillProductStatus(SystemContext.ProductDomain.SECKILLPRODUCTSTATUS_ON);
            secKillProduct.setCreateTime(operationDate);
            secKillProduct.setUpdateUserId(secKillProduct.getCreateUserId());
            secKillProduct.setUpdateTime(operationDate);
            return secKillProductMapper.save(secKillProduct);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer deleteById(Integer secKillProductId) throws ProductServiceException {
        try {
            return null;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer update(SecKillProductDto secKillProductDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductDto) || ObjectUtils.isNullOrEmpty(secKillProductDto.getId())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillProductPrice())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getDisplayOrder())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getRemainCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getSecKillTime())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getQualifyType())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getLimitOrderCount())
                    || ObjectUtils.isNullOrEmpty(secKillProductDto.getUpdateUserId())) {
                throw new ProductServiceException("必填参数不能为空");
            }
            if (secKillProductDto.getSecKillCount() > secKillProductDto.getRemainCount()) {
                throw new ProductServiceException("允许秒中商品数量不能大于库存");
            }
            if (secKillProductDto.getLimitOrderCount() > secKillProductDto.getSecKillCount()) {
                throw new ProductServiceException("限购数量不能大于允许秒中数量");
            }
            Date nowDate = new Date();
            List<SecKillSceneDto> startedAndStartingSecKillSceneList = secKillSceneService
                    .listSecKillSceneBeforOrEqualsStartTime(nowDate, 2);
            if (!ObjectUtils.isNullOrEmpty(startedAndStartingSecKillSceneList)) {
                for (SecKillSceneDto secKillSceneDto : startedAndStartingSecKillSceneList) {
                    SecKillSceneProductRelation secKillSceneProductRelation = secKillSceneProductRelationMapper
                            .loadBySceneIdAndSecKillProductId(secKillSceneDto.getId(), secKillProductDto.getId());
                    if (!ObjectUtils.isNullOrEmpty(secKillSceneProductRelation)) {
                        SecKillProduct secKillProductTemp = secKillProductMapper
                                .loadById(secKillSceneProductRelation.getSecKillProductId());
                        if (!ObjectUtils.isNullOrEmpty(secKillProductTemp) && secKillProductTemp.getRemainCount()
                                .intValue() != secKillProductDto.getRemainCount().intValue()) {
                            throw new ProductServiceException("已开始的场次不能修改库存");
                        }
                    }
                }
            }
            Date operationDate = new Date();
            SecKillProduct secKillProduct = new SecKillProduct();
            ObjectUtils.fastCopy(secKillProductDto, secKillProduct);
            secKillProduct.setUpdateUserId(secKillProduct.getUpdateUserId());
            secKillProduct.setUpdateTime(operationDate);
            return secKillProductMapper.update(secKillProduct);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SecKillProductDto loadById(Integer secKillProductId) throws ProductServiceException {
        try {
            SecKillProduct secKillProduct = secKillProductMapper.loadById(secKillProductId);
            SecKillProductDto secKillProductDto = null;
            if (!ObjectUtils.isNullOrEmpty(secKillProduct)) {
                secKillProductDto = new SecKillProductDto();
                ObjectUtils.fastCopy(secKillProduct, secKillProductDto);
                ProductPrice productPrice = productPriceMapper
                        .loadProductPriceByProductIdAndChannelCode(secKillProduct.getProductId(), null);
                if (!ObjectUtils.isNullOrEmpty(productPrice)) {
                    secKillProductDto.setPromotionalPrice(productPrice.getPromotionalPrice());
                }
                Product product = productMapper.loadProductBasicInfoById(secKillProduct.getProductId());
                if (!ObjectUtils.isNullOrEmpty(product)) {
                    secKillProductDto.setProductName(product.getProductName());
                    secKillProductDto.setBarCode(product.getBarCode());
                }
            }
            return secKillProductDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SecKillProductDto> findSecKillProducts(SecKillProductQueryDto secKillProductQueryDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto)) {
                throw new ProductServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getStart())) {
                secKillProductQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getPageSize())) {
                secKillProductQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            SecKillProductQuery secKillProductQuery = new SecKillProductQuery();
            ObjectUtils.fastCopy(secKillProductQueryDto, secKillProductQuery);
            PageHelper.startPage(secKillProductQuery.getStart(), secKillProductQuery.getPageSize());
            Page<SecKillProductRelatedInfo> secKillProductPage = secKillProductMapper
                    .findSecKillProducts(secKillProductQuery);
            Page<SecKillProductDto> pageDto = new Page<SecKillProductDto>(secKillProductQuery.getStart(),
                    secKillProductQuery.getPageSize());
            ObjectUtils.fastCopy(secKillProductPage, pageDto);
            List<SecKillProductRelatedInfo> secKillProductList = secKillProductPage.getResult();
            if (!ObjectUtils.isNullOrEmpty(secKillProductList)) {
                for (SecKillProductRelatedInfo secKillProduct : secKillProductList) {
                    SecKillProductDto secKillProductDto = new SecKillProductDto();
                    ObjectUtils.fastCopy(secKillProduct, secKillProductDto);
                    ProductProfile productProfile = productProfileMapper
                            .loadProductProfileByProductIdAndChannelCode(secKillProductDto.getProductId(), null);
                    if (!ObjectUtils.isNullOrEmpty(productProfile)) {
                        secKillProductDto.setProductSpec(productProfile.getProductSpec());
                    }
                    pageDto.add(secKillProductDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SecKillProductDto> findCommbinationSecKillProducts(SecKillProductQueryDto secKillProductQueryDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto)) {
                throw new ProductServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getStart())) {
                secKillProductQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getPageSize())) {
                secKillProductQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            SecKillProductQuery secKillProductQuery = new SecKillProductQuery();
            ObjectUtils.fastCopy(secKillProductQueryDto, secKillProductQuery);
            PageHelper.startPage(secKillProductQuery.getStart(), secKillProductQuery.getPageSize());
            Page<SecKillProductRelatedInfo> secKillProductPage = secKillProductMapper
                    .findSecKillProducts(secKillProductQuery);
            Page<SecKillProductDto> pageDto = new Page<SecKillProductDto>(secKillProductQuery.getStart(),
                    secKillProductQuery.getPageSize());
            ObjectUtils.fastCopy(secKillProductPage, pageDto);
            List<SecKillProductRelatedInfo> secKillProductList = secKillProductPage.getResult();
            if (!ObjectUtils.isNullOrEmpty(secKillProductList)) {
                for (SecKillProductRelatedInfo secKillProduct : secKillProductList) {
                    SecKillProductDto secKillProductDto = new SecKillProductDto();
                    ObjectUtils.fastCopy(secKillProduct, secKillProductDto);
                    ProductProfile productProfile = productProfileMapper
                            .loadProductProfileByProductIdAndChannelCode(secKillProductDto.getProductId(), null);
                    if (!ObjectUtils.isNullOrEmpty(productProfile)) {
                        secKillProductDto.setProductSpec(productProfile.getProductSpec());
                    }
                    pageDto.add(secKillProductDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SecKillProductDto> findExcludeSecKillSceneRelationSecKillProducts(
            SecKillProductQueryDto secKillProductQueryDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto)
                    || ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getSceneId())) {
                throw new ProductServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getStart())) {
                secKillProductQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(secKillProductQueryDto.getPageSize())) {
                secKillProductQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            List<SecKillProductRelatedInfo> secKillProductRelatedInfos = secKillProductMapper
                    .listSecKillProductBySeceneId(secKillProductQueryDto.getSceneId());
            List<Integer> excludeSecKillProductIds = null;
            if (!ObjectUtils.isNullOrEmpty(secKillProductRelatedInfos)) {
                excludeSecKillProductIds = new ArrayList<Integer>();
                for (SecKillProductRelatedInfo secKillProductRelatedInfo : secKillProductRelatedInfos) {
                    excludeSecKillProductIds.add(secKillProductRelatedInfo.getId());
                }
            }
            SecKillProductQuery secKillProductQuery = new SecKillProductQuery();
            ObjectUtils.fastCopy(secKillProductQueryDto, secKillProductQuery);
            secKillProductQuery.setExcludeSecKillProductIds(excludeSecKillProductIds);
            PageHelper.startPage(secKillProductQuery.getStart(), secKillProductQuery.getPageSize());
            Page<SecKillProductRelatedInfo> secKillProductPage = secKillProductMapper
                    .findExcludeSecKillSceneRelationSecKillProducts(secKillProductQuery);
            Page<SecKillProductDto> pageDto = new Page<SecKillProductDto>(secKillProductQuery.getStart(),
                    secKillProductQuery.getPageSize());
            ObjectUtils.fastCopy(secKillProductPage, pageDto);
            List<SecKillProductRelatedInfo> secKillProductList = secKillProductPage.getResult();
            if (!ObjectUtils.isNullOrEmpty(secKillProductList)) {
                for (SecKillProductRelatedInfo secKillProduct : secKillProductList) {
                    SecKillProductDto secKillProductDto = new SecKillProductDto();
                    ObjectUtils.fastCopy(secKillProduct, secKillProductDto);
                    ProductProfile productProfile = productProfileMapper
                            .loadProductProfileByProductIdAndChannelCode(secKillProductDto.getProductId(), null);
                    if (!ObjectUtils.isNullOrEmpty(productProfile)) {
                        secKillProductDto.setProductSpec(productProfile.getProductSpec());
                    }
                    pageDto.add(secKillProductDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSaleProductDto> listSecKillSaleProductByActivityIdAndStoreId(Integer storeId, Integer actId)
            throws ProductServiceException {
        try {
            List<SecKillSaleProductDto> secKillSaleProductDtos = new ArrayList<SecKillSaleProductDto>();
            if (ObjectUtils.isNullOrEmpty(storeId) || ObjectUtils.isNullOrEmpty(actId)) {
                return secKillSaleProductDtos;
            }
            Integer usedStoreId = storeId;
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(usedStoreId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("找不到店铺信息");
                return Collections.emptyList();
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            List<SecKillSaleProductRelatedInfo> secKillSaleProductRelatedInfoList = secKillProductMapper
                    .listSecKillSaleProductByActivityIdAndStoreId(usedStoreId, actId, null,
                            SystemContext.ProductDomain.SECKILLPRODUCTSTATUS_ON,
                            SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                            SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
            if (ObjectUtils.isNullOrEmpty(secKillSaleProductRelatedInfoList)) {
                return secKillSaleProductDtos;
            }
            for (SecKillSaleProductRelatedInfo secKillSaleProductRelatedInfo : secKillSaleProductRelatedInfoList) {
                SecKillSaleProductDto secKillSaleProductDto = new SecKillSaleProductDto();
                ObjectUtils.fastCopy(secKillSaleProductRelatedInfo, secKillSaleProductDto);
                setSecKillSaleProductBrandInfo(secKillSaleProductDto, secKillSaleProductDto.getBrandCode());
                setSecKillSaleProductImageInfo(secKillSaleProductDto, secKillSaleProductDto.getSaleProductId(), null);
                secKillSaleProductDtos.add(secKillSaleProductDto);
            }
            setSaleSecKillProductInventoryInfos(secKillSaleProductDtos, actId);
            return secKillSaleProductDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    // 设置多个商品库存
    private void setSaleSecKillProductInventoryInfos(List<SecKillSaleProductDto> secKillSaleProductDtoList, Integer actId) {
        if (ObjectUtils.isNullOrEmpty(secKillSaleProductDtoList)) {
            return;
        }
        List<Integer> saleProductIds = new ArrayList<Integer>();
        for (SecKillSaleProductDto secKillSaleProductDto : secKillSaleProductDtoList) {
            saleProductIds.add(secKillSaleProductDto.getSaleProductId());
        }
        List<SaleProductInventoryProxyDto> saleProductInventoryProxyDtoList = saleProductInventoryProxyService
                .listByStoreIdAndSaleProductIds(null, saleProductIds);
        List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtoList = secKillSaleProductInventoryProxyService
                .listByActivityIdAndStoreIdAndSaleProductIds(actId, null, saleProductIds);
        if (ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDtoList)) {
            return;
        }
        logger.info("saleProductInventoryProxyDtoList:" + JsonUtils.toJsonString(saleProductInventoryProxyDtoList));
        logger.info("secKillSaleProductInventoryProxyDtoList:" + JsonUtils.toJsonString(secKillSaleProductInventoryProxyDtoList));
        Map<Integer, SaleProductInventoryProxyDto> inventoryMap = new HashMap<Integer, SaleProductInventoryProxyDto>();
        for (SaleProductInventoryProxyDto saleProductInventoryProxyDto : saleProductInventoryProxyDtoList) {
            inventoryMap.put(saleProductInventoryProxyDto.getSaleProductId(), saleProductInventoryProxyDto);
        }
        Map<Integer, SecKillSaleProductInventoryProxyDto> secKillProductInventoryMap = new HashMap<Integer, SecKillSaleProductInventoryProxyDto>();
        if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryProxyDtoList)) {
            for (SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto : secKillSaleProductInventoryProxyDtoList) {
                secKillProductInventoryMap.put(secKillSaleProductInventoryProxyDto.getSaleProductId(),
                        secKillSaleProductInventoryProxyDto);
            }
        }
        for (SecKillSaleProductDto secKillSaleProductDto : secKillSaleProductDtoList) {
            SaleProductInventoryProxyDto saleProductInventoryProxyDto = inventoryMap
                    .get(secKillSaleProductDto.getSaleProductId());
            SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto = secKillProductInventoryMap
                    .get(secKillSaleProductDto.getSaleProductId());
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDto)) {
                Integer remainCount = saleProductInventoryProxyDto.getRemainCount();
                Integer orderCount = saleProductInventoryProxyDto.getOrderedCount();
                int secKillProductRemainCount = 0;
                if (null == remainCount) {
                    remainCount = 0;
                }
                if (null == orderCount) {
                    orderCount = 0;
                }
                if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryProxyDto)) {
                    secKillProductRemainCount = secKillSaleProductInventoryProxyDto.getRemainCount();
                }
                if (remainCount - orderCount >= secKillProductRemainCount) {
                    secKillSaleProductDto.setSaleProductRemainCount(secKillProductRemainCount);
                } else {
                    secKillSaleProductDto.setSaleProductRemainCount(remainCount - orderCount);
                }
                logger.info("remainCount:" + secKillSaleProductDto.getSaleProductRemainCount());
            }
        }
    }

    // 设设置商品品牌
    private void setSecKillSaleProductBrandInfo(SecKillSaleProductDto secKillSaleProductDto, String brandCode) {
        if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto) || ObjectUtils.isNullOrEmpty(brandCode)) {
            return;
        }
        ProductBrand productBrand = productBrandMapper.loadProductBrandByBrandCode(brandCode);
        if (!ObjectUtils.isNullOrEmpty(productBrand)) {
            secKillSaleProductDto.setBrandName(productBrand.getBrandName());
        }
    }

    // 设设置商品图片
    private void setSecKillSaleProductImageInfo(SecKillSaleProductDto secKillSaleProductDto, Integer saleProductId,
            String channelCode) {
        if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto)) {
            return;
        }
        SaleProductImageDto saleProductImageDto = saleProductImageService.loadSaleProductImageMaster(saleProductId,
                channelCode);
        if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
            secKillSaleProductDto.setSaleProductImageUrl(saleProductImageDto.getImageUrl());
        }
    }

    @Override
    public SecKillSaleProductDto loadSecKillSaleProductByActivityIdAndSaleProductId(Integer saleProductId, Integer actId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(actId) || ObjectUtils.isNullOrEmpty(saleProductId)) {
                return null;
            }
            SaleProduct saleProduct = saleProductMapper.loadByIdAndEnabledFlag(saleProductId, null);
            if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                return null;
            }
            SecKillProductRelatedInfo secKillProductRelatedInfo = secKillProductMapper.loadByActivityIdAndProductId(actId,
                    saleProduct.getProductId());
            if (ObjectUtils.isNullOrEmpty(secKillProductRelatedInfo)) {
                return null;
            }
            SecKillSaleProductDto secKillSaleProductDto = new SecKillSaleProductDto();
            ObjectUtils.fastCopy(secKillProductRelatedInfo, secKillSaleProductDto);
            secKillSaleProductDto.setSaleProductName(saleProduct.getSaleProductName());
            secKillSaleProductDto.setSaleProductId(saleProductId);
            SecKillScene nextSecKillScene = secKillSceneMapper
                    .loadNextSecKillSceneByCurrentTime(secKillProductRelatedInfo.getStartTime());
            if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                secKillSaleProductDto.setEndTime(nextSecKillScene.getStartTime());
            }
            if (ObjectUtils.isNullOrEmpty(secKillSaleProductDto.getEndTime())) {
                secKillSaleProductDto.setEndTime(
                        DateUtils.addHours(secKillSaleProductDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
            }
            return secKillSaleProductDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private int getSystemParamSecKillSceneEndTime() {
        String endTime = super.getSystemParamValue(SystemContext.SystemParams.SECKILLSCENE_ENDTIME);
        if (ObjectUtils.isNullOrEmpty(endTime)) {
            return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
        }
        try {
            return Integer.parseInt(endTime.trim());
        } catch (Exception e) {
            logger.warn(e);
        }
        return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
    }
}
