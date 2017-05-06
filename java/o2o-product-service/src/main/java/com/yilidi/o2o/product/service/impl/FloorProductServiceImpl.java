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
import com.yilidi.o2o.product.dao.FloorProductMapper;
import com.yilidi.o2o.product.model.FloorProduct;
import com.yilidi.o2o.product.model.combination.FloorProductInfo;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.service.IFloorProductService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.FloorProductDto;
import com.yilidi.o2o.product.service.dto.FloorProductInfoDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 楼层与产品关联关系Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午6:15:58
 */
@Service("floorProductService")
public class FloorProductServiceImpl extends BasicDataService implements IFloorProductService {

    @Autowired
    private FloorProductMapper floorProductMapper;
    @Autowired
    private IProductClassService productClassService;

    @Override
    public void save(Integer floorId, String productIdAndSorts, Integer userId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(floorId)) {
                throw new IllegalArgumentException("参数floorId为空");
            }
            floorProductMapper.deleteByFloorId(floorId);
            if (!StringUtils.isEmpty(productIdAndSorts)) {
                String channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
                Date createTime = DateUtils.getCurrentDateTime();
                Integer createUserId = userId;
                if (!productIdAndSorts.contains(",")) {
                    String[] productIdAndSortArray = productIdAndSorts.split(CommonConstants.DELIMITER_MULTIPLY);
                    Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                    Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                    FloorProduct floorProduct = new FloorProduct();
                    floorProduct.setFloorId(floorId);
                    floorProduct.setProductId(productId);
                    floorProduct.setChannelCode(channelCode);
                    floorProduct.setSort(sort);
                    floorProduct.setCreateTime(createTime);
                    floorProduct.setCreateUserId(createUserId);
                    floorProductMapper.save(floorProduct);
                } else {
                    StringTokenizer st = new StringTokenizer(productIdAndSorts, ",");
                    while (st.hasMoreTokens()) {
                        String str = st.nextToken();
                        String[] productIdAndSortArray = str.split(CommonConstants.DELIMITER_MULTIPLY);
                        Integer productId = Integer.parseInt(productIdAndSortArray[0]);
                        Integer sort = Integer.parseInt(productIdAndSortArray[1]);
                        FloorProduct floorProduct = new FloorProduct();
                        floorProduct.setFloorId(floorId);
                        floorProduct.setProductId(productId);
                        floorProduct.setChannelCode(channelCode);
                        floorProduct.setSort(sort);
                        floorProduct.setCreateTime(createTime);
                        floorProduct.setCreateUserId(createUserId);
                        floorProductMapper.save(floorProduct);
                    }
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "新增楼层与产品关联关系出现系统异常" : e.getMessage();
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
            floorProductMapper.deleteById(id);
        } catch (Exception e) {
            msg = null == msg ? "根据ID删除楼层与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public void deleteByFloorId(Integer floorId) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(floorId)) {
                msg = "floorId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            floorProductMapper.deleteByFloorId(floorId);
        } catch (Exception e) {
            msg = null == msg ? "根据楼层ID删除楼层与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public FloorProductDto loadById(Integer id) throws ProductServiceException {
        String msg = null;
        FloorProductDto floorProductDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "id为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            FloorProduct floorProduct = floorProductMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(floorProduct)) {
                floorProductDto = new FloorProductDto();
                ObjectUtils.fastCopy(floorProduct, floorProductDto);
            }
            return floorProductDto;
        } catch (Exception e) {
            msg = null == msg ? "根据关联关系ID获取楼层与产品关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<FloorProductDto> listByFloorId(Integer floorId) throws ProductServiceException {
        String msg = null;
        List<FloorProductDto> floorProductDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(floorId)) {
                msg = "floorId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            List<FloorProduct> floorProducts = floorProductMapper.listByFloorId(floorId);
            if (!ObjectUtils.isNullOrEmpty(floorProducts)) {
                floorProductDtos = new ArrayList<FloorProductDto>();
                for (FloorProduct floorProduct : floorProducts) {
                    FloorProductDto floorProductDto = new FloorProductDto();
                    ObjectUtils.fastCopy(floorProduct, floorProductDto);
                    floorProductDtos.add(floorProductDto);
                }
            }
            return floorProductDtos;
        } catch (Exception e) {
            msg = null == msg ? "根据楼层ID获取楼层与产品关联关系列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<ProductDto> listProductInfosByFloorId(FloorProductInfoDto floorProductInfoDto)
            throws ProductServiceException {
        String msg = null;
        List<ProductDto> productDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(floorProductInfoDto)) {
                msg = "floorProductProductInfoDto为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            FloorProductInfo floorProductInfo = new FloorProductInfo();
            ObjectUtils.fastCopy(floorProductInfoDto, floorProductInfo);
            if(!ObjectUtils.isNullOrEmpty(floorProductInfo.getProductClassCode())){
                List<Object> classCodes = productClassService.getSubClassCodes(floorProductInfo.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	floorProductInfo.setClassCodes(classCodes);
                }
            }
            List<ProductRelatedInfo> productRelatedInfos = floorProductMapper.listProductInfosByFloorId(floorProductInfo);
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
            msg = null == msg ? "根据楼层查询信息获取其所关联的产品相关信息列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
