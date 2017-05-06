/**
 * 文件名称：ProductService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ProductTempMapper;
import com.yilidi.o2o.product.model.ProductTemp;
import com.yilidi.o2o.product.model.combination.ProductTempInfo;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.IProductTempService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.ProductTempBatchSaveDto;
import com.yilidi.o2o.product.service.dto.ProductTempDto;
import com.yilidi.o2o.product.service.dto.query.ProductTempQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:临时产品服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productTempService")
public class ProductTempServiceImpl extends BasicDataService implements IProductTempService {

    @Autowired
    private ProductTempMapper productTempMapper;
    @Autowired
    private IProductClassService productClassService;
    @Autowired
    private IProductService productService;

    @Override
    public ProductTempDto loadProductTempByBarCodeAndChannelCode(String barCode, String channelCode)
            throws ProductServiceException {
        ProductTempDto productTempDto = null;
        logger.debug("loadProductTempByBarCodeAndChannelCode -> " + barCode);
        try {
            // 检查产品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.loadProductTempByBarCodeAndChannelCode => 临时产品条形码参数为空");
                throw new ProductServiceException("临时产品条形码参数为空");
            }
            // 临时产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            ProductTemp productTemp = productTempMapper.loadProductTempByBarCodeAndChannelCode(barCode, channelCode);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(productTemp)) {
                productTempDto = new ProductTempDto();
                ObjectUtils.fastCopy(productTemp, productTempDto);

            }
        } catch (ProductServiceException e) {
            logger.error("查询临时产品信息出错");
            throw new ProductServiceException("异常：查询临时产品信息出错");
        }
        return productTempDto;
    }

    @Override
    public void saveProductTempDto(ProductTempDto saveProductTempDto, String channelCode) throws ProductServiceException {
        logger.debug("saveProductTempDto -> " + saveProductTempDto);
        // 保存产品基础信息开始
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductTempDto)) {
                logger.error("ProductService.saveProductTempDto => 临时产品参数为空");
                throw new ProductServiceException("临时产品参数为空");
            }
            // 产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getBarCode())) {
                logger.error("saveProductTempDto.barCode => 临时产品条形码参数为空");
                throw new ProductServiceException("临时产品条形码参数为空");
            }
            // 临时产品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 判断产品是否是重复添加
            ProductTempDto productTempDtoLoad = this.loadProductTempByBarCodeAndChannelCode(saveProductTempDto.getBarCode(),
                    channelCode);
            if (ObjectUtils.isNullOrEmpty(productTempDtoLoad)) {
                // 判断产品类别参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getProductClassCode())) {
                    logger.error("saveProductTempDto.productClassCode => 产品类别参数为空");
                    throw new ProductServiceException("产品类别参数为空");
                }
                // 产品名称是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getProductName())) {
                    logger.error("saveProductTempDto.productName => 产品名称参数为空");
                    throw new ProductServiceException("产品名称参数为空");
                }
                // 产品规格是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getProductSpec())) {
                    logger.error("saveProductTempDto.productSpec => 产品规格参数为空");
                    throw new ProductServiceException("产品规格参数为空");
                }
                // 产品采购价是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getCostPrice())) {
                    logger.error("saveProductTempDto.costPrice => 产品采购价参数为空");
                    throw new ProductServiceException("产品采购价参数为空");
                }
                // 产品普通会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getRetailPrice())) {
                    logger.error("saveProductTempDto.retailPrice => 产品普通会员售价参数为空");
                    throw new ProductServiceException("产品普通会员售价参数为空");
                }
                // 产品VIP会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getPromotionalPrice())) {
                    logger.error("saveProductTempDto.promotionalPrice => 产品VIP会员售价参数为空");
                    throw new ProductServiceException("产品VIP会员售价参数为空");
                }
                // 产品上下架状态是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getSaleStatus())) {
                    logger.error("saveProductTempDto.saleStatus => 产品上下架状态参数为空");
                    throw new ProductServiceException("产品上下架状态参数为空");
                }
                // 产品显示顺序是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductTempDto.getDisplayOrder())) {
                    logger.error("saveProductTempDto.displayOrder => 产品显示顺序参数为空");
                    throw new ProductServiceException("产品显示顺序参数为空");
                }
                ProductTemp productTemp = new ProductTemp();
                productTemp.setProductName(saveProductTempDto.getProductName());
                productTemp.setBarCode(saveProductTempDto.getBarCode());
                productTemp.setProductSpec(saveProductTempDto.getProductSpec());
                productTemp.setProductClassCode(saveProductTempDto.getProductClassCode());
                productTemp.setCostPrice(saveProductTempDto.getCostPrice());
                productTemp.setRetailPrice(saveProductTempDto.getRetailPrice());
                productTemp.setPromotionalPrice(saveProductTempDto.getPromotionalPrice());
                productTemp.setCommissionPrice(null == saveProductTempDto.getCommissionPrice() ? 0L : saveProductTempDto
                        .getCommissionPrice());
                productTemp.setVipCommissionPrice(null == saveProductTempDto.getVipCommissionPrice() ? 0L
                        : saveProductTempDto.getVipCommissionPrice());
                productTemp.setSaleStatus(saveProductTempDto.getSaleStatus());
                productTemp.setDisplayOrder(saveProductTempDto.getDisplayOrder());
                productTemp.setChannelCode(channelCode);
                productTempMapper.saveProductTemp(productTemp);
            }
        } catch (ProductServiceException e) {
            logger.error("保存临时产品信息出错");
            throw new ProductServiceException("异常：保存临时产品信息出错");
        }
    }

    @Override
    public void saveProductTempDtoBatch(List<ProductTempDto> productTempDtoList, ProductTempBatchSaveDto objs)
            throws ProductServiceException {
        logger.debug("productTempDtoList -> " + productTempDtoList);
        try {
            // 检查产品列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(productTempDtoList)) {
                logger.error("ProductService.saveProductTempBatch => 需要保存的产品列表参数为空");
                throw new ProductServiceException("需要保存的产品列表为空");
            }
            // 检查产品参数渠道编码是否为空(objs[3]为渠道编码)
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                logger.error("ProductService.saveProductTempBatch => 需要保存的产品渠道编码参数为空");
                throw new ProductServiceException("需要保存的产品渠道编码参数为空");
            }
            if (!ObjectUtils.isNullOrEmpty(productTempDtoList)) {
                for (ProductTempDto productTempDtoSave : productTempDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(productTempDtoSave)) {
                        this.saveProductTempDto(productTempDtoSave, objs.getChannelCode());
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("将产品批量保存至临时表出错");
            throw new ProductServiceException("异常：将产品批量保存至临时表出错");
        }

    }

    @Override
    public ProductTempDto loadProductTempById(Integer tempId) throws ProductServiceException {
        ProductTempDto productTempDto = null;
        logger.debug("loadProductTempById.tempId -> " + tempId);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(tempId)) {
                logger.error("ProductService.loadProductTempById => 临时产品id参数为空");
                throw new ProductServiceException("临时产品id参数为空");
            }
            ProductTemp productTemp = productTempMapper.loadProductTempById(tempId);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(productTemp)) {
                productTempDto = new ProductTempDto();
                ObjectUtils.fastCopy(productTemp, productTempDto);

            }
        } catch (ProductServiceException e) {
            logger.error("依据Id查询临时产品信息出错");
            throw new ProductServiceException("异常：依据Id查询临时产品信息出错");
        }
        return productTempDto;
    }

    @Override
    public YiLiDiPage<ProductTempDto> findProductTemps(ProductTempQuery productTempQuery) throws ProductServiceException {
        try {
            if (null == productTempQuery.getStart() || productTempQuery.getStart() <= 0) {
                productTempQuery.setStart(1);
            }
            if (null == productTempQuery.getPageSize() || productTempQuery.getPageSize() <= 0) {
                productTempQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(productTempQuery.getStart(), productTempQuery.getPageSize());
            if(!ObjectUtils.isNullOrEmpty(productTempQuery.getProductClassCode())){
                List<Object> classCodes = productClassService.getSubClassCodes(productTempQuery.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	productTempQuery.setClassCodes(classCodes);
                }
            }
            Page<ProductTempInfo> page = productTempMapper.findProductTemps(productTempQuery);
            Page<ProductTempDto> pageDto = new Page<ProductTempDto>(productTempQuery.getStart(),
                    productTempQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<ProductTempInfo> productTempInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(productTempInfos)) {
                for (ProductTempInfo pt : productTempInfos) {
                    ProductTempDto pDto = null;
                    if (!ObjectUtils.isNullOrEmpty(pt)) {
                        pDto = new ProductTempDto();
                        ObjectUtils.fastCopy(pt, pDto);
                        // 上下架状态编码转换为上下架状态描述
                        pDto.setSaleStatusName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(), pt.getSaleStatus()));
                        // 热卖状态编码转换为热卖状态描述
                        pDto.setHotSaleFlagName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), pt.getHotSaleFlag()));
                        pageDto.add(pDto);
                    }
                }
            }

            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findProductTemps异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public boolean checkBarCodeIsExistInProductTemp(String barCode, String channelCode) throws ProductServiceException {
        try {
            // 检查产品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.checkBarCodeIsExistInProductTemp => 临时产品条形码参数为空");
                throw new ProductServiceException("临时产品条形码参数为空");
            }
            // 临时产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            ProductTempDto productTempDto = this.loadProductTempByBarCodeAndChannelCode(barCode, channelCode);
            return productTempDto != null;
        } catch (Exception e) {
            logger.error("checkBarCodeIsExistInProductTemp异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteProductTemp(Integer tempId) throws ProductServiceException {
        try {
            // 检查临时产品的Id是否为空
            if (ObjectUtils.isNullOrEmpty(tempId)) {
                logger.error("ProductService.deleteProductTemp.tempId => 临时产品的Id参数为空");
                throw new ProductServiceException("临时产品的Id参数为空");
            }
            productTempMapper.deleteProductTemp(tempId);
        } catch (Exception e) {
            logger.error("checkBarCodeIsExistInProductTemp异常", e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void deleteAllProductTemp() throws ProductServiceException {
        try {
            productTempMapper.deleteAllProductTemp();
        } catch (Exception e) {
            logger.error("checkBarCodeIsExistInProductTemp异常", e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public List<String> addAllTempProductToStandard(ProductTempQuery productTempQuery, String channelCode,
            Integer createUserId, Date createTime) throws ProductServiceException {
        logger.debug("addAllTempProduct -> " + channelCode);
        try {
            // 临时产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查产品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(createUserId)) {
                logger.error("SaleProductService.addAllTempProductToStandard.createUserId=> 产品创建人为空");
                throw new ProductServiceException("产品创建人为空");
            }
            // 检查产品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(createTime)) {
                logger.error("SaleProductService.addAllTempProductToStandard.createTime => 产品创建时间为空");
                throw new ProductServiceException("产品创建时间为空");
            }
            List<ProductTempInfo> productTempDtoList = this.listProductTemp(productTempQuery);
            List<String> errorAllString = null;
            if (!ObjectUtils.isNullOrEmpty(productTempDtoList)) {
                errorAllString = new ArrayList<String>();
                for (ProductTempInfo productTempInfo : productTempDtoList) {
                    // 检查产品参数对象是否为空
                    String errorString = "";
                    if (!ObjectUtils.isNullOrEmpty(productTempInfo)) {
                        ProductDto productDtoStandard = this.pakageProductTempToProductDto(productTempInfo, createUserId,
                                createTime);

                        if (!ObjectUtils.isNullOrEmpty(productDtoStandard)) {
                            errorString = productService.saveProduct(productDtoStandard, channelCode);
                            if (!ObjectUtils.isNullOrEmpty(errorString)) {
                                errorAllString.add(errorString);
                            }
                        }
                    }
                }
                // 保存成功之后需要将所有的临时表数据删除
                this.deleteAllProductTemp();
            }
            return errorAllString;
        } catch (ProductServiceException e) {
            logger.error("添加所有临时产品到标准库出错", e);
            throw new ProductServiceException("异常：添加所有临时产品到标准库出错");
        }
    }

    /**
     * 将临时产品Dto封装成产品Dto
     * 
     * @param productDto
     *            商品Dto
     * @param tempId
     *            用户临时产品Id
     * @param createUserId
     *            用户Id
     * @param createTime
     *            用户createTime
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private ProductDto pakageProductTempToProductDto(ProductTempInfo productTempInfo, Integer createUserId, Date createTime) {
        ProductDto productDtoStandard = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(productTempInfo)) {
                productDtoStandard = new ProductDto();
                productDtoStandard.setProductClassCode(productTempInfo.getProductClassCode());
                productDtoStandard.setProductName(productTempInfo.getProductName());
                productDtoStandard.setBarCode(productTempInfo.getBarCode());
                // 默认为有效状态
                productDtoStandard.setStatusCode(SystemContext.ProductDomain.PRODUCTSTATUS_ON);
                productDtoStandard.setCreateTime(createTime);
                productDtoStandard.setCreateUserId(createUserId);
                // 封装产品的价格信息
                ProductPriceDto productPriceDto = null;
                if (!ObjectUtils.isNullOrEmpty(productTempInfo.getRetailPrice())) {
                    productPriceDto = new ProductPriceDto();
                    productPriceDto.setRetailPrice(productTempInfo.getRetailPrice());
                    productPriceDto.setPromotionalPrice(productTempInfo.getPromotionalPrice());
                    productPriceDto.setCommissionPrice(productTempInfo.getCommissionPrice());
                    productPriceDto.setCostPrice(productTempInfo.getCostPrice());
                    productPriceDto.setVipCommissionPrice(productTempInfo.getVipCommissionPrice());
                    productDtoStandard.setProductPriceDto(productPriceDto);
                }
                // 封装产品的附属信息
                ProductProfileDto productProfileDto = new ProductProfileDto();
                productProfileDto.setDisplayOrder(productTempInfo.getDisplayOrder());
                productProfileDto.setHotSaleFlag(productTempInfo.getHotSaleFlag());
                productProfileDto.setSaleStatus(productTempInfo.getSaleStatus());
                productProfileDto.setProductSpec(productTempInfo.getProductSpec());
                productDtoStandard.setProductProfileDto(productProfileDto);
                // 封装产品的图片信息(没有图片信息)
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将临时产品Dto封装成产品Dto失败" + e.getMessage());
            throw new ProductServiceException("异常：将临时产品Dto封装成产品Dto出错");
        }
        return productDtoStandard;
    }

    @Override
    public List<ProductTempInfo> listProductTemp(ProductTempQuery productTempQuery) throws ProductServiceException {
        try {
            List<ProductTempInfo> productTempInfoList = productTempMapper.listProductTemp(productTempQuery);
            return productTempInfoList;
        } catch (Exception e) {
            logger.error("listProductTemp异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Set<String> getProductTempBarCode() throws ProductServiceException {
        try {
            List<String> productTempBarCodeList = productTempMapper.getProductTempBarCode();
            Set<String> productTempBarCodeSet = null;
            if (!ObjectUtils.isNullOrEmpty(productTempBarCodeList)) {
                productTempBarCodeSet = new HashSet<String>();
                for (String barCode : productTempBarCodeList) {
                    if (!ObjectUtils.isNullOrEmpty(barCode)) {
                        productTempBarCodeSet.add(barCode);
                    }
                }

            }
            return productTempBarCodeSet;
        } catch (Exception e) {
            logger.error("listProductTemp异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
