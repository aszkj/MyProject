package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleZoneMapper;
import com.yilidi.o2o.product.model.SaleZone;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.SaleZoneProductInfo;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.ISaleZoneService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.SaleZoneDto;
import com.yilidi.o2o.product.service.dto.SaleZoneProductInfoDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 专区（专题与产品关联）Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月22日 上午9:57:19
 */
@Service("saleZoneService")
public class SaleZoneServiceImpl extends BasicDataService implements ISaleZoneService {

    @Autowired
    private SaleZoneMapper saleZoneMapper;

    @Autowired
    private IProductClassService productClassService;

    @Override
    public void save(String typeCode, String productIdAndSorts, Integer userId) throws ProductServiceException {
        try {
            if (StringUtils.isEmpty(typeCode)) {
                throw new IllegalArgumentException("参数typeCode为空");
            }
            saleZoneMapper.deleteByTypeCode(typeCode);
            if (!StringUtils.isEmpty(productIdAndSorts)) {
                String channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
                Date createTime = DateUtils.getCurrentDateTime();
                Integer createUserId = userId;
                Date modifyTime = createTime;
                Integer modifyUserId = userId;
                if (!productIdAndSorts.contains(",")) {
                    String[] productIdAndSortArray = productIdAndSorts.split(CommonConstants.DELIMITER_MULTIPLY);
                    Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                    Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                    SaleZone saleZone = new SaleZone();
                    saleZone.setTypeCode(typeCode);
                    saleZone.setProductId(productId);
                    saleZone.setChannelCode(channelCode);
                    saleZone.setSort(sort);
                    saleZone.setCreateTime(createTime);
                    saleZone.setCreateUserId(createUserId);
                    saleZone.setModifyTime(modifyTime);
                    saleZone.setModifyUserId(modifyUserId);
                    saleZoneMapper.save(saleZone);
                } else {
                    StringTokenizer st = new StringTokenizer(productIdAndSorts, ",");
                    while (st.hasMoreTokens()) {
                        String str = st.nextToken();
                        String[] productIdAndSortArray = str.split(CommonConstants.DELIMITER_MULTIPLY);
                        Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                        Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                        SaleZone saleZone = new SaleZone();
                        saleZone.setTypeCode(typeCode);
                        saleZone.setProductId(productId);
                        saleZone.setChannelCode(channelCode);
                        saleZone.setSort(sort);
                        saleZone.setCreateTime(createTime);
                        saleZone.setCreateUserId(createUserId);
                        saleZone.setModifyTime(modifyTime);
                        saleZone.setModifyUserId(modifyUserId);
                        saleZoneMapper.save(saleZone);
                    }
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "保存专题与产品关联关系出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteById(Integer id) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            saleZoneMapper.deleteById(id);
        } catch (Exception e) {
            msg = null == msg ? "根据ID删除专题与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteByTypeCode(String typeCode) throws ProductServiceException {
        String msg = null;
        try {
            if (StringUtils.isEmpty(typeCode)) {
                msg = "typeCode为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            saleZoneMapper.deleteByTypeCode(typeCode);
        } catch (Exception e) {
            msg = null == msg ? "根据ID删除专题与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public SaleZoneDto loadById(Integer id) throws ProductServiceException {
        String msg = null;
        SaleZoneDto saleZoneDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            SaleZone saleZone = saleZoneMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(saleZone)) {
                saleZoneDto = new SaleZoneDto();
                ObjectUtils.fastCopy(saleZone, saleZoneDto);
            }
            return saleZoneDto;
        } catch (Exception e) {
            msg = null == msg ? "根据ID获取专区出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<SaleZoneDto> listByTypeCode(String typeCode) throws ProductServiceException {
        String msg = null;
        List<SaleZoneDto> saleZoneDtos = null;
        try {
            if (StringUtils.isEmpty(typeCode)) {
                msg = "typeCode为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            List<SaleZone> saleZones = saleZoneMapper.listByTypeCode(typeCode);
            if (!ObjectUtils.isNullOrEmpty(saleZones)) {
                saleZoneDtos = new ArrayList<SaleZoneDto>();
                for (SaleZone saleZone : saleZones) {
                    SaleZoneDto saleZoneDto = new SaleZoneDto();
                    ObjectUtils.fastCopy(saleZone, saleZoneDto);
                    saleZoneDtos.add(saleZoneDto);
                }
            }
            return saleZoneDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据专区类型编码获取专区列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<ProductDto> listProductInfosByThemeTypeCode(SaleZoneProductInfoDto saleZoneProductInfoDto)
            throws ProductServiceException {
        String msg = null;
        List<ProductDto> productDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(saleZoneProductInfoDto)) {
                msg = "saleZoneProductInfoDto为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            SaleZoneProductInfo saleZoneProductInfo = new SaleZoneProductInfo();
            ObjectUtils.fastCopy(saleZoneProductInfoDto, saleZoneProductInfo);
            if (!ObjectUtils.isNullOrEmpty(saleZoneProductInfo.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(saleZoneProductInfo.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	saleZoneProductInfo.setClassCodes(classCodes);
                }
            }
            List<ProductRelatedInfo> productRelatedInfos = saleZoneMapper
                    .listProductInfosByThemeTypeCode(saleZoneProductInfo);
            if (!ObjectUtils.isNullOrEmpty(productRelatedInfos)) {
                productDtos = new ArrayList<ProductDto>();
                for (ProductRelatedInfo productRelatedInfo : productRelatedInfos) {
                    ProductDto productDto = new ProductDto();
                    ObjectUtils.fastCopy(productRelatedInfo, productDto);
                    productDto.setSaleStatusName(
                            super.getSystemDictName(SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(),
                                    productRelatedInfo.getSaleStatus()));
                    productDtos.add(productDto);
                }
            }
            return productDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据专区产品查询信息获取其所关联的产品相关信息列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
