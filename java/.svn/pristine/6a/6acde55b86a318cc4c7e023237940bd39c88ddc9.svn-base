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
import com.yilidi.o2o.product.dao.ThemeColumnProductMapper;
import com.yilidi.o2o.product.model.ThemeColumnProduct;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.model.combination.ThemeColumnProductInfo;
import com.yilidi.o2o.product.service.IThemeColumnProductService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ThemeColumnProductDto;
import com.yilidi.o2o.product.service.dto.ThemeColumnProductInfoDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 专题栏目与产品关联关系Service实现类
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午4:11:15
 */
@Service("themeColumnProductService")
public class ThemeColumnProductServiceImpl extends BasicDataService implements IThemeColumnProductService {

    @Autowired
    private ThemeColumnProductMapper themeColumnProductMapper;

    @Override
    public void save(Integer themeColumnId, String productIdAndSorts, Integer userId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(themeColumnId)) {
                throw new IllegalArgumentException("参数themeColumnId为空");
            }
            themeColumnProductMapper.deleteByThemeColumnId(themeColumnId);
            if (!StringUtils.isEmpty(productIdAndSorts)) {
                String channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
                Date createTime = DateUtils.getCurrentDateTime();
                Integer createUserId = userId;
                if (!productIdAndSorts.contains(",")) {
                    String[] productIdAndSortArray = productIdAndSorts.split(CommonConstants.DELIMITER_MULTIPLY);
                    Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                    Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                    ThemeColumnProduct themeColumnProduct = new ThemeColumnProduct();
                    themeColumnProduct.setThemeColumnId(themeColumnId);
                    themeColumnProduct.setProductId(productId);
                    themeColumnProduct.setChannelCode(channelCode);
                    themeColumnProduct.setSort(sort);
                    themeColumnProduct.setCreateTime(createTime);
                    themeColumnProduct.setCreateUserId(createUserId);
                    themeColumnProductMapper.save(themeColumnProduct);
                } else {
                    StringTokenizer st = new StringTokenizer(productIdAndSorts, ",");
                    while (st.hasMoreTokens()) {
                        String str = st.nextToken();
                        String[] productIdAndSortArray = str.split(CommonConstants.DELIMITER_MULTIPLY);
                        Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                        Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                        ThemeColumnProduct themeColumnProduct = new ThemeColumnProduct();
                        themeColumnProduct.setThemeColumnId(themeColumnId);
                        themeColumnProduct.setProductId(productId);
                        themeColumnProduct.setChannelCode(channelCode);
                        themeColumnProduct.setSort(sort);
                        themeColumnProduct.setCreateTime(createTime);
                        themeColumnProduct.setCreateUserId(createUserId);
                        themeColumnProductMapper.save(themeColumnProduct);
                    }
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "新增专题栏目与产品关联关系出现系统异常" : e.getMessage();
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
            themeColumnProductMapper.deleteById(id);
        } catch (Exception e) {
            msg = null == msg ? "根据ID删除专题栏目与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteByThemeColumnId(Integer themeColumnId) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(themeColumnId)) {
                msg = "themeColumnId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            themeColumnProductMapper.deleteByThemeColumnId(themeColumnId);
        } catch (Exception e) {
            msg = null == msg ? "根据专题栏目ID删除专题栏目与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public ThemeColumnProductDto loadById(Integer id) throws ProductServiceException {
        String msg = null;
        ThemeColumnProductDto themeColumnProductDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            ThemeColumnProduct themeColumnProduct = themeColumnProductMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(themeColumnProduct)) {
                themeColumnProductDto = new ThemeColumnProductDto();
                ObjectUtils.fastCopy(themeColumnProduct, themeColumnProductDto);
            }
            return themeColumnProductDto;
        } catch (Exception e) {
            msg = null == msg ? "根据关联关系ID获取专题栏目与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<ThemeColumnProductDto> listByThemeColumnId(Integer themeColumnId) throws ProductServiceException {
        String msg = null;
        List<ThemeColumnProductDto> themeColumnProductDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(themeColumnId)) {
                msg = "themeColumnId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            List<ThemeColumnProduct> themeColumnProducts = themeColumnProductMapper.listByThemeColumnId(themeColumnId);
            if (!ObjectUtils.isNullOrEmpty(themeColumnProducts)) {
                themeColumnProductDtos = new ArrayList<ThemeColumnProductDto>();
                for (ThemeColumnProduct themeColumnProduct : themeColumnProducts) {
                    ThemeColumnProductDto themeColumnProductDto = new ThemeColumnProductDto();
                    ObjectUtils.fastCopy(themeColumnProduct, themeColumnProductDto);
                    themeColumnProductDtos.add(themeColumnProductDto);
                }
            }
            return themeColumnProductDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据专题栏目ID获取专题栏目与产品关联关系列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<ProductDto> listProductInfosByThemeColumnId(ThemeColumnProductInfoDto themeColumnProductInfoDto)
            throws ProductServiceException {
        String msg = null;
        List<ProductDto> productDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(themeColumnProductInfoDto)) {
                msg = "themeColumnProductProductInfoDto为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            ThemeColumnProductInfo themeColumnProductInfo = new ThemeColumnProductInfo();
            ObjectUtils.fastCopy(themeColumnProductInfoDto, themeColumnProductInfo);
            List<ProductRelatedInfo> productRelatedInfos = themeColumnProductMapper
                    .listProductInfosByThemeColumnId(themeColumnProductInfo);
            if (!ObjectUtils.isNullOrEmpty(productRelatedInfos)) {
                productDtos = new ArrayList<ProductDto>();
                for (ProductRelatedInfo productRelatedInfo : productRelatedInfos) {
                    ProductDto productDto = new ProductDto();
                    ObjectUtils.fastCopy(productRelatedInfo, productDto);
                    productDto.setSaleStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(),
                            productRelatedInfo.getSaleStatus()));
                    productDtos.add(productDto);
                }
            }
            return productDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据专题栏目查询信息获取其所关联的产品相关信息列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
