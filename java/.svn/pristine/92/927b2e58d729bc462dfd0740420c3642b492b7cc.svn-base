/**
 * 
 * 文件名称：SaleProductService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.support.json.JSONUtils;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.proxy.ISaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SaleProductInventoryProxyDto;
import com.yilidi.o2o.product.dao.ProductBrandMapper;
import com.yilidi.o2o.product.dao.ProductClassMappingMapper;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.dao.SaleProductPriceMapper;
import com.yilidi.o2o.product.dao.SaleProductProfileMapper;
import com.yilidi.o2o.product.dao.SaleZoneMapper;
import com.yilidi.o2o.product.dao.StoreTypeProductClassMapper;
import com.yilidi.o2o.product.model.ProductBrand;
import com.yilidi.o2o.product.model.ProductClassMapping;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.SaleProductPrice;
import com.yilidi.o2o.product.model.SaleProductProfile;
import com.yilidi.o2o.product.model.SaleZone;
import com.yilidi.o2o.product.model.StoreTypeProductClass;
import com.yilidi.o2o.product.model.combination.SaleProductRelatedInfo;
import com.yilidi.o2o.product.model.query.ProductBrandQuery;
import com.yilidi.o2o.product.service.IFloorProductService;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductHistoryService;
import com.yilidi.o2o.product.service.ISaleProductImageService;
import com.yilidi.o2o.product.service.ISaleProductPriceService;
import com.yilidi.o2o.product.service.ISaleProductProfileService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.ISaleZoneService;
import com.yilidi.o2o.product.service.dto.FloorProductDto;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductImageProfileDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductHistoryDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductOtherBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductSortBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleZoneDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 功能描述:商品服务类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductService")
public class SaleProductServiceImpl extends BasicDataService implements ISaleProductService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
    @Autowired
    private SaleProductMapper saleProductMapper;
    @Autowired
    private ISaleProductProfileService saleProductProfileService;
    @Autowired
    private SaleProductProfileMapper saleProductProfileMapper;
    @Autowired
    private ProductClassMappingMapper productClassMappingMapper;
    @Autowired
    private ISaleProductPriceService saleProductPriceService;
    @Autowired
    private SaleProductPriceMapper saleProductPriceMapper;
    @Autowired
    private SaleZoneMapper saleZoneMapper;
    @Autowired
    private ProductBrandMapper productBrandMapper;
    @Autowired
    private IProductBrandService productBrandService;
    @Autowired
    private ISaleProductImageService saleProductImageService;
    @Autowired
    private ISaleProductHistoryService saleProductHistoryService;
    @Autowired
    private IProductClassService productClassService;
    @Autowired
    private IProductService productService;
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    @Autowired
    private ISaleProductInventoryProxyService saleProductInventoryProxyService;
    @Autowired
    private StoreTypeProductClassMapper storeTypeProductClassMapper;
    @Autowired
    private IFloorProductService floorProductService;
    @Autowired
    private ISaleZoneService saleZoneService;
    @Autowired
    private IStoreWarehouseProxyService storeWarehouseProxyService;

    private String saveSaleProduct(SaleProductDto saveSaleProductDto, String channelCode, String storeType)
            throws ProductServiceException {
        logger.debug("saveSaleProductDto -> " + saveSaleProductDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto)) {
                logger.error("ProductService.saveSaleProductDto => 保存商品参数为空");
                throw new ProductServiceException("保存商品参数为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品所属店铺ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getStoreId())) {
                logger.error("ProductService.saveSaleProductDto.storeId => 商品所属店铺ID为空");
                throw new ProductServiceException("商品所属店铺ID为空");
            }
            // 保存商品createUserId是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getCreateUserId())) {
                logger.error("ProductService.saveSaleProductDto.createUserId => 商品createUserId为空");
                throw new ProductServiceException("商品createUserId参数为空");
            }
            // 保存商品createTime是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getCreateTime())) {
                logger.error("ProductService.saveSaleProductDto.createTime => 商品createTime为空");
                throw new ProductServiceException("商品createTime参数为空");
            }
            // 保存商品基础信息
            String errorString = this.saveSaleProductBasicInfo(saveSaleProductDto, channelCode, storeType);
            // 保存商品描述信息
            if (ObjectUtils.isNullOrEmpty(errorString)) {
                SaleProductProfileDto saleProductProfileDto = saveSaleProductDto.getSaleProductProfileDto();
                // if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                saleProductProfileDto.setSaleProductId(saveSaleProductDto.getId());
                saleProductProfileDto.setCreateUserId(saveSaleProductDto.getCreateUserId());
                if (!ObjectUtils.isNullOrEmpty(saveSaleProductDto.getContentString())) {
                    saleProductProfileDto.setContent(saveSaleProductDto.getContentString());
                }
                saleProductProfileDto.setCreateTime(saveSaleProductDto.getCreateTime());
                saleProductProfileDto.setChannelCode(channelCode);
                saleProductProfileService.saveSaleProductProfile(saleProductProfileDto);

                this.operateContentImage(saveSaleProductDto.getLoadContentImageUrls(),
                        saveSaleProductDto.getAddContentImageUrls());
                // }
                // 保存商品价格信息
                SaleProductPriceDto saleProductPriceDto = saveSaleProductDto.getSaleProductPriceDto();
                // if (!ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                saleProductPriceDto.setSaleProductId(saveSaleProductDto.getId());
                saleProductPriceDto.setCreateUserId(saveSaleProductDto.getCreateUserId());
                saleProductPriceDto.setCreateTime(saveSaleProductDto.getCreateTime());
                saleProductPriceDto.setChannelCode(channelCode);
                saleProductPriceService.saveSaleProductPrice(saleProductPriceDto);
                // }
                // 保存商品图片信息
                List<SaleProductImageDto> saleProductImageDtos = null;
                if (!ObjectUtils.isNullOrEmpty(saveSaleProductDto.getSaleProductImageDtos())) {
                    saleProductImageDtos = saveSaleProductDto.getSaleProductImageDtos();
                    for (SaleProductImageDto saleProductImageDto : saleProductImageDtos) {
                        if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
                            saleProductImageDto.setSaleProductId(saveSaleProductDto.getId());
                            saleProductImageDto.setCreateUserId(saveSaleProductDto.getCreateUserId());
                            saleProductImageDto.setCreateTime(saveSaleProductDto.getCreateTime());
                            saleProductImageDto.setChannelCode(channelCode);
                        }
                    }
                    saleProductImageService.saveSaleProductImages(saleProductImageDtos);
                }
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("保存商品出错");
            throw new ProductServiceException("异常：保存商品出错");
        }
    }

    // 增加商品图片到正式服务器
    private void operateContentImage(String loadContentImageUrls, String addContentImageUrls)
            throws ProductServiceException {
        try {
            List<String> delImageUrls = this.getDelImageUrls(loadContentImageUrls, addContentImageUrls);
            List<String> addImageUrls = this.getAddImageUrls(loadContentImageUrls, addContentImageUrls);
            // 商品保存成功之后，处理商品临时图片
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
                for (String imageUrl : delImageUrls) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                        fileUploadUtils.deletePublishFile(imageUrl);
                    }
                }
            }
            if (!ObjectUtils.isNullOrEmpty(addImageUrls)) {
                for (String imageUrl : addImageUrls) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                        fileUploadUtils.uploadPublishFile(imageUrl);
                    }
                }
            }

        } catch (ProductServiceException e) {
            logger.error("增加和删除商品图片到正式服务器出错！");
            throw new ProductServiceException("异常：增加和删除商品图片到正式服务器出错！");
        }
    }

    /**
     * 封装前获取内容详情需要删除的图片Url
     * 
     * @param loadContentImageUrls
     *            内容详情原加载出来的图片
     * @param addContentImageUrls
     *            内容详情需要上传图片的图片
     * @return String 需要删除的URL字符串和id列表
     * @throws SaleProductServiceException
     */
    private List<String> getDelImageUrls(String loadContentImageUrls, String addContentImageUrls)
            throws ProductServiceException {
        List<String> delImageUrls = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(loadContentImageUrls)) {
                delImageUrls = new ArrayList<String>();
                String loadString[] = loadContentImageUrls.split(",");
                for (String loadImageUrl : loadString) {
                    boolean isDel = true;
                    if (!ObjectUtils.isNullOrEmpty(addContentImageUrls)) {
                        String addString[] = addContentImageUrls.split(",");
                        for (String addImageUrl : addString) {
                            if (addImageUrl.equals(loadImageUrl)) {
                                isDel = false;
                            }
                        }
                    }
                    if (isDel && !ObjectUtils.isNullOrEmpty(loadImageUrl)) {
                        delImageUrls.add(loadImageUrl);
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("获取内容详情需要删除的临时图片url失败" + e.getMessage());
            throw new ProductServiceException("异常：获取内容详情需要删除的临时图片url失败");
        }
        return delImageUrls;

    }

    /**
     * 封装前获取内容详情需要删除的图片Url
     * 
     * @param loadContentImageUrls
     *            原内容详情图片字符串
     * @param addContentImageUrls
     *            内容详情更新后的图片Dto
     * @return List<String> 需要增加的URL字符串
     * @throws ProductServiceException
     */
    private List<String> getAddImageUrls(String loadContentImageUrls, String addContentImageUrls)
            throws ProductServiceException {
        List<String> addImageUrls = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(addContentImageUrls)) {
                addImageUrls = new ArrayList<String>();
                String addString[] = addContentImageUrls.split(",");
                for (String addImageUrl : addString) {
                    boolean isAdd = true;
                    if (!ObjectUtils.isNullOrEmpty(loadContentImageUrls)) {
                        String loadString[] = loadContentImageUrls.split(",");
                        for (String loadImageUrl : loadString) {
                            if (loadImageUrl.equals(addImageUrl)) {
                                isAdd = false;
                            }
                        }
                    }
                    if (isAdd && !ObjectUtils.isNullOrEmpty(addImageUrl)) {
                        addImageUrls.add(addImageUrl);
                    }
                }
            }
        } catch (Exception e) {
            logger.info("获取详情内容需要增加的临时图片url失败" + e.getMessage());
            throw new ProductServiceException("异常：获取详情内容需要增加的临时图片url失败");
        }
        return addImageUrls;

    }

    // 保存商品基础信息
    private String saveSaleProductBasicInfo(SaleProductDto saveSaleProductDto, String channelCode, String storeType) {
        logger.debug("saveSaleProductBasicInfo -> " + saveSaleProductDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto)) {
                logger.error("ProductService.saveSaleProductDto => 商品参数为空");
                throw new ProductServiceException("商品参数为空");
            }
            // 保存商品基础信息开始
            // 判断店铺ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getStoreId())) {
                logger.error("saveSaleProductDto.storeId => 店铺ID参数为空");
                throw new ProductServiceException("店铺ID参数为空");
            }
            // 判断商品的条形码参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getBarCode())) {
                logger.error("saveSaleProductDto.barCode => 商品的条形码参数为空");
                throw new ProductServiceException("商品的条形码参数为空");
            }
            // 商品创建人是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getCreateUserId())) {
                logger.error("saveSaleProductDto.createUserId => 商品创建人参数为空");
                throw new ProductServiceException("商品创建人参数为空");
            }
            // 商品创建时间是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getCreateTime())) {
                logger.error("saveSaleProductDto.createTime => 商品创建时间参数为空");
                throw new ProductServiceException("商品创建时间参数为空");
            }

            // 判断商品基础信息是否是重复添加
            SaleProduct saleProductLoad = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndBarCode(
                    saveSaleProductDto.getStoreId(), saveSaleProductDto.getBarCode());
            // 如果不存在该商品的基础信息，则保存，否则更新原SaleProduct
            String errorString = "";
            if (!ObjectUtils.isNullOrEmpty(saleProductLoad)) {
                errorString = "商品条形码为：" + saleProductLoad.getBarCode() + "，商品名称为：" + saleProductLoad.getSaleProductName()
                        + "&nbsp&nbsp的商品在已经存在";
                // 更新商品基础信息
                saveSaleProductDto.setId(saleProductLoad.getId());
                this.updateSaleProductBasicInfo(saveSaleProductDto);
                // 更新商品附属信息
                SaleProductProfileDto saleProductProfileDto = saveSaleProductDto.getSaleProductProfileDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                    SaleProductProfileDto dto = saleProductProfileService
                            .loadSaleProductProfileBySaleProductIdAndChannelCode(saleProductLoad.getId(), null, channelCode);
                    saleProductProfileDto.setId(dto.getId());
                    saleProductProfileService.updateSaleProductProfile(saleProductProfileDto);
                }
                // 更新商品价格信息
                SaleProductPriceDto saleProductPriceDto = saveSaleProductDto.getSaleProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                    SaleProductPriceDto dto = saleProductPriceService
                            .loadSaleProductPriceBySaleProductIdAndChannelCode(saleProductLoad.getId(), channelCode);
                    saleProductPriceDto.setSaleProductId(dto.getSaleProductId());
                    saleProductPriceDto.setChannelCode(dto.getChannelCode());
                    saleProductPriceService.updateSaleProductPrice(saleProductPriceDto);
                }
                // 更新商品图片信息
                List<SaleProductImageDto> saleProductImageDtos = saveSaleProductDto.getSaleProductImageDtos();
                if (!ObjectUtils.isNullOrEmpty(saleProductImageDtos)) {
                    List<SaleProductImageDto> dtoList = saleProductImageService
                            .listSaleProductImagesBySaleProductIdAndChannelCode(saleProductLoad.getId(), channelCode);
                    if (!ObjectUtils.isNullOrEmpty(saleProductImageDtos)) {
                        for (SaleProductImageDto saleProductImageDto : saleProductImageDtos) {
                            boolean isFound = false;
                            if (!ObjectUtils.isNullOrEmpty(dtoList)) {
                                for (SaleProductImageDto dto : dtoList) {
                                    if (saleProductImageDto.getImageUrl().equals(dto.getImageUrl())) {
                                        saleProductImageDto.setId(dto.getId());
                                        isFound = true;
                                        break;
                                    }
                                }
                            }
                            if (!isFound) {
                                saleProductImageDto.setSaleProductId(saleProductLoad.getId());
                                saleProductImageDto.setChannelCode(channelCode);
                            }
                        }
                    }
                    if (!ObjectUtils.isNullOrEmpty(dtoList)) {
                        for (SaleProductImageDto dto : dtoList) {
                            boolean isFound = false;
                            for (SaleProductImageDto saleProductImageDto : saleProductImageDtos) {
                                if (dto.getImageUrl().equals(saleProductImageDto.getImageUrl())) {
                                    isFound = true;
                                    break;
                                }
                            }
                            if (!isFound) {
                                saleProductImageService.deleteSaleProductImageById(dto.getId(),
                                        saveSaleProductDto.getModifyUserId(), saveSaleProductDto.getModifyTime());
                            }
                        }
                    }
                    saleProductImageService.updateSaleProductImages(saleProductImageDtos);
                }
            } else {
                // 判断商品类别参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getProductClassCode())) {
                    logger.error("saveSaleProductDto.productClassCode => 商品类别参数为空");
                    throw new ProductServiceException("商品类别参数为空");
                }
                // 商品品牌参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getBrandCode())) {
                    logger.error("saveSaleProductDto.brandCode => 商品品牌参数为空");
                    throw new ProductServiceException("商品品牌参数为空");
                }
                // 商品名称是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getSaleProductName())) {
                    logger.error("saveSaleProductDto.productName => 商品名称参数为空");
                    throw new ProductServiceException("商品名称参数为空");
                }
                // 商品条形码是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getBarCode())) {
                    logger.error("saveSaleProductDto.barCode => 商品条形码参数为空");
                    throw new ProductServiceException("商品条形码参数为空");
                }
                // 商品审核状态编码是否为空
                if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getAuditStatusCode())) {
                    logger.error("saveSaleProductDto.auditStatusCode => 商品审核状态编码参数为空");
                    throw new ProductServiceException("商品审核状态编码参数为空");
                }
                SaleProduct saleProduct = new SaleProduct();
                saleProduct.setStoreId(saveSaleProductDto.getStoreId());
                saleProduct.setStoreType(storeType);
                saleProduct.setProductId(saveSaleProductDto.getProductId());
                saleProduct.setProductClassCode(saveSaleProductDto.getProductClassCode());
                saleProduct.setBrandCode(saveSaleProductDto.getBrandCode());
                saleProduct.setSaleProductName(saveSaleProductDto.getSaleProductName());
                saleProduct.setBarCode(saveSaleProductDto.getBarCode());
                if (null != saveSaleProductDto.getPerOperCount()) {
                    saleProduct.setPerOperCount(saveSaleProductDto.getPerOperCount());
                }
                saleProduct.setAuditNote(saveSaleProductDto.getAuditNote());
                saleProduct.setMarketTime(saveSaleProductDto.getMarketTime());
                saleProduct.setAuditStatusCode(saveSaleProductDto.getAuditStatusCode());
                saleProduct.setEnabledFlag(saveSaleProductDto.getEnabledFlag());
                saleProduct.setAuditUserId(saveSaleProductDto.getAuditUserId());
                saleProduct.setAuditTime(saveSaleProductDto.getAuditTime());
                saleProduct.setCreateUserId(saveSaleProductDto.getCreateUserId());
                saleProduct.setCreateTime(saveSaleProductDto.getCreateTime());
                saleProductMapper.saveSaleProduct(saleProduct);
                saveSaleProductDto.setId(saleProduct.getId());

                // 创建一条商品的基础信息到商品基础信息历史表
                SaleProductHistoryDto saleProductHistoryDto = new SaleProductHistoryDto();
                saleProductHistoryDto.setSaleProductId(saleProduct.getId());
                saleProductHistoryDto.setStoreId(saveSaleProductDto.getStoreId());
                saleProductHistoryDto.setProductId(saveSaleProductDto.getProductId());
                saleProductHistoryDto.setSaleProductName(saveSaleProductDto.getSaleProductName());
                saleProductHistoryDto.setProductClassCode(saveSaleProductDto.getProductClassCode());
                saleProductHistoryDto.setBrandCode(saveSaleProductDto.getBrandCode());
                saleProductHistoryDto.setPerOperCount(saveSaleProductDto.getPerOperCount());
                saleProductHistoryDto.setBarCode(saveSaleProductDto.getBarCode());
                saleProductHistoryDto.setMarketTime(saveSaleProductDto.getMarketTime());
                saleProductHistoryDto.setAuditStatusCode(saveSaleProductDto.getAuditStatusCode());
                saleProductHistoryDto.setEnabledFlag(saveSaleProductDto.getEnabledFlag());
                saleProductHistoryDto.setOperateUserId(saveSaleProductDto.getCreateUserId());
                saleProductHistoryDto.setOperateTime(saveSaleProductDto.getCreateTime());
                saleProductHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTOPERTYPE_CREATE);
                saleProductHistoryService.saveSaleProductHistoryBasicInfo(saleProductHistoryDto);
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("保存商品基础信息出错");
            throw new ProductServiceException("异常：保存商品基础信息出错");
        }
    }

    @Override
    public List<String> saveSaleProducts(List<SaleProductDto> listSaleProductDto, String storeType, String channelCode)
            throws ProductServiceException {
        logger.debug("listSaleProductDto -> " + listSaleProductDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(listSaleProductDto)) {
                logger.error("SaleProductService.batchSaveSaleProduct => 商品列表参数为空");
                throw new ProductServiceException("商品列表参数为空");
            }
            List<HashMap<String, String>> storeProductClasslist = productClassService.listProductClassByStoreType(storeType,
                    SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            List<String> errorString = new ArrayList<String>();
            String saleProductExistString = null;
            List<Integer> saleProductIds = new ArrayList<Integer>();
            Integer storeId = null;
            Integer createUserId = null;
            for (SaleProductDto saleProductDto : listSaleProductDto) {
                // 判断该需要保存的的商品类别是否是该店铺所有的
                boolean isStoreProductClass = false;
                if (!ObjectUtils.isNullOrEmpty(storeProductClasslist)) {
                    for (HashMap<String, String> hashMap : storeProductClasslist) {
                        if (!ObjectUtils.isNullOrEmpty(hashMap.get("classCode"))
                                && hashMap.get("classCode").equals(saleProductDto.getProductClassCode())) {
                            isStoreProductClass = true;
                            break;
                        }
                    }
                }
                if (!isStoreProductClass) {
                    String errorClassString = "&nbsp&nbsp产品条形码为：" + saleProductDto.getBarCode() + "，产品名称为："
                            + saleProductDto.getSaleProductName() + "&nbsp&nbsp的产品不能添加到该店铺，因为店铺不应该存在此种类别的商品";
                    errorString.add(errorClassString);
                } else { // 店铺允许存在该类型的产品才保存到店铺中
                    saleProductExistString = this.saveSaleProduct(saleProductDto, channelCode, storeType);
                    if (ObjectUtils.isNullOrEmpty(saleProductExistString)) {
                        saleProductIds.add(saleProductDto.getId());
                        storeId = saleProductDto.getStoreId();
                        createUserId = saleProductDto.getCreateUserId();
                    }
                }
            }
            // 初始化商品库存数据
            if (!ObjectUtils.isNullOrEmpty(saleProductIds)) {
                saleProductInventoryProxyService.saveSaleProductInventory(storeId, saleProductIds, createUserId);
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("批量保存商品出错");
            throw new ProductServiceException("异常：批量保存商品出错");
        }
    }

    @Override
    public YiLiDiPage<SaleProductDto> findSaleProductRelativeInfos(SaleProductQuery querySaleProduct)
            throws ProductServiceException {
        try {
            if (null == querySaleProduct.getStart() || querySaleProduct.getStart() <= 0) {
                querySaleProduct.setStart(1);
            }
            if (null == querySaleProduct.getPageSize() || querySaleProduct.getPageSize() <= 0) {
                querySaleProduct.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(querySaleProduct.getStart(), querySaleProduct.getPageSize());
            querySaleProduct.setOrder(DBTablesColumnsName.SaleProduct.CREATETIME);
            querySaleProduct.setSort(CommonConstants.SORT_ORDER_DESC);
            // modified by chenb for warehouse share inventory at 2016/12/10
            // 5:14
            StoreProfileProxyDto storeProfileProxyDto = null;
            String isShare = "N";
            if (!ObjectUtils.isNullOrEmpty(querySaleProduct.getStoreId())) {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(querySaleProduct.getStoreId());
                if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)
                        && SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                        && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                    Integer wareHouseId = storeWarehouseProxyService
                            .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                    querySaleProduct.setStoreId(wareHouseId);
                    querySaleProduct.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
                    isShare = "Y";
                }
            }
            // modified over
            if (!StringUtils.isEmpty(querySaleProduct.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(querySaleProduct.getProductClassCode());
                if (!ObjectUtils.isNullOrEmpty(classCodes)) {
                    querySaleProduct.setClassCodes(classCodes);
                }
            }
            Page<SaleProductRelatedInfo> page = saleProductMapper.findSaleProductRelatedInfos(querySaleProduct);
            Page<SaleProductDto> pageDto = new Page<SaleProductDto>(querySaleProduct.getStart(),
                    querySaleProduct.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<SaleProductRelatedInfo> saleProductRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(saleProductRelatedInfos)) {
                List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
                for (SaleProductRelatedInfo spri : saleProductRelatedInfos) {
                    SaleProductDto spDto = new SaleProductDto();
                    SaleProductAppDto spaDto = new SaleProductAppDto();
                    spaDto.setId(spri.getId());
                    ObjectUtils.fastCopy(spri, spDto);
                    StoreTypeProductClass storeTypeProductClass = storeTypeProductClassMapper
                            .loadStoreProductClassByStoreTypeAndClassCode(querySaleProduct.getStoreType(),
                                    spDto.getProductClassCode());
                    if (null == storeTypeProductClass) {
                        spDto.setIsAllowedExistClassCode("N");
                    }
                    if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                        spDto.setStoreId(storeProfileProxyDto.getStoreId());
                        spDto.setStoreType(storeProfileProxyDto.getStoreType());
                    }
                    spDto.setIsStockShare(isShare);
                    // 商品上下架状态转换为上下架状态描述，供前台显示
                    spDto.setSaleStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTSALESTATUS.getValue(), spri.getSaleStatus()));
                    // 热卖状态编码转换为热卖状态描述
                    spDto.setHotSaleFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), spri.getHotSaleFlag()));
                    // 商品来源转换为来源描述，供前台显示
                    spDto.setSaleProductSourceName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTSOURCE.getValue(), spri.getSaleProductSource()));
                    // 商品状态转换为商品状态描述，供前台显示
                    spDto.setEnabledFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTENABLEDFLAG.getValue(), spri.getEnabledFlag()));
                    saleProductAppDtoList.add(spaDto);
                    pageDto.add(spDto);
                }
                setSaleProductInventoryInfos(saleProductAppDtoList);
                List<SaleProductDto> saleProductDtoList = pageDto.getResult();
                if (ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
                    for (SaleProductDto saleProductDto : saleProductDtoList) {
                        saleProductDto.setRemainCount(0);
                        saleProductDto.setOrderCount(0);
                    }
                } else {
                    for (SaleProductDto saleProductDto : saleProductDtoList) {
                        boolean isFound = false;
                        for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
                            if (saleProductDto.getId().intValue() == saleProductAppDto.getId().intValue()) {
                                saleProductDto.setRemainCount(saleProductAppDto.getRemainCount());
                                saleProductDto.setOrderCount(saleProductAppDto.getOrderCount());
                                isFound = true;
                            }
                        }
                        if (!isFound) {
                            saleProductDto.setRemainCount(0);
                            saleProductDto.setOrderCount(0);
                        }
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (

        Exception e) {
            logger.error("findSaleProductRelativeInfos异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SaleProductDto loadSaleProductBasicInfoById(Integer id, String enabledFlag) throws ProductServiceException {
        logger.debug("loadSaleProductById -> " + id);
        SaleProductDto saleProductBasicInfo = null;
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductService.loadSaleProductById => 查询的商品Id参数为空");
                throw new ProductServiceException("查询的商品Id参数为空");
            }
            SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoById(id, enabledFlag);
            if (!ObjectUtils.isNullOrEmpty(saleProduct)) {
                saleProductBasicInfo = new SaleProductDto();
                ObjectUtils.fastCopy(saleProduct, saleProductBasicInfo);
                // 根据品牌id获取name
                ProductBrandDto productBrandDto = productBrandService.getBrandByCode(saleProductBasicInfo.getBrandCode());
                if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
                    saleProductBasicInfo.setBrandName(productBrandDto.getBrandName().trim());
                }
            }
            return saleProductBasicInfo;
        } catch (ProductServiceException e) {
            logger.error("依据ID查询商品基础信息出错");
            throw new ProductServiceException("异常：依据ID查询商品基础信息出错");
        }
    }

    @Override
    public SaleProductDto loadSaleProductByIdAndChannelCode(Integer id, String enabledFlag, String saleStatus,
            String channelCode) throws ProductServiceException {
        logger.debug("id -> " + id + "channelCode -> " + channelCode);
        try {
            // 检查商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductService.loadSaleProductByIdAndChannelCode.id => 商品Id参数为空");
                throw new ProductServiceException("商品id参数为空");
            }
            // 检查商品channelCode参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductDto saleProductDto = this.loadSaleProductBasicInfoById(id, enabledFlag);
            // 封装图片列表信息
            List<SaleProductImageDto> saleProductImageDtoList = saleProductImageService
                    .listSaleProductImagesBySaleProductIdAndChannelCode(id, channelCode);
            if (!ObjectUtils.isNullOrEmpty(saleProductImageDtoList)) {
                saleProductDto.setSaleProductImageDtos(saleProductImageDtoList);
            }
            // 封装价格信息
            SaleProductPriceDto saleProductPriceDto = saleProductPriceService
                    .loadSaleProductPriceBySaleProductIdAndChannelCode(id, channelCode);
            if (!ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
            }
            // 封装附加属性信息
            SaleProductProfileDto saleProductProfileDto = saleProductProfileService
                    .loadSaleProductProfileBySaleProductIdAndChannelCode(id, enabledFlag, channelCode);
            if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
            }
            return saleProductDto;
        } catch (ProductServiceException e) {
            logger.error("查询单个商品信息出错");
            throw new ProductServiceException("异常：查询单个商品信息出错");
        }
    }

    @Deprecated
    @Override
    public Page<SaleProductDto> findSaleProductByBasicInfo(SaleProductQuery querySaleProduct)
            throws ProductServiceException {
        logger.debug("querySaleProduct -> " + querySaleProduct);
        try {
            if (ObjectUtils.isNullOrEmpty(querySaleProduct)) {
                logger.error("查询实体为null");
                throw new ProductServiceException("异常：查询实体为空");
            }
            if (ObjectUtils.isNullOrEmpty(querySaleProduct.getChannelCode())) {
                logger.error("查询实体的渠道编码为null");
                throw new ProductServiceException("异常：查询实体的渠道编码为空");
            }
            if (null == querySaleProduct.getStart() || querySaleProduct.getStart() <= 0) {
                querySaleProduct.setStart(1);
            }
            if (null == querySaleProduct.getPageSize() || querySaleProduct.getPageSize() <= 0) {
                querySaleProduct.setPageSize(CommonConstants.PAGE_SIZE);
            }

            PageHelper.startPage(querySaleProduct.getStart(), querySaleProduct.getPageSize());
            Page<SaleProduct> page = saleProductMapper.findSaleProductsByBasicInfo(querySaleProduct);
            Page<SaleProductDto> pageDto = new Page<SaleProductDto>(querySaleProduct.getStart(),
                    querySaleProduct.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<SaleProduct> saleProductList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                for (SaleProduct saleProduct : saleProductList) {
                    SaleProductDto saleProductDto = new SaleProductDto();
                    ObjectUtils.fastCopy(saleProduct, saleProductDto);
                    // 封装图片列表信息
                    List<SaleProductImageDto> saleProductImageDtoList = saleProductImageService
                            .listSaleProductImagesBySaleProductIdAndChannelCode(saleProduct.getId(),
                                    querySaleProduct.getChannelCode());
                    if (!ObjectUtils.isNullOrEmpty(saleProductImageDtoList)) {
                        saleProductDto.setSaleProductImageDtos(saleProductImageDtoList);
                    }
                    // 封装价格信息
                    SaleProductPriceDto saleProductPriceDto = saleProductPriceService
                            .loadSaleProductPriceBySaleProductIdAndChannelCode(saleProduct.getId(),
                                    querySaleProduct.getChannelCode());
                    if (!ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                        saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
                    }
                    // 封装附加属性信息
                    SaleProductProfileDto saleProductProfileDto = saleProductProfileService
                            .loadSaleProductProfileBySaleProductIdAndChannelCode(saleProduct.getId(),
                                    querySaleProduct.getSaleStatus(), querySaleProduct.getChannelCode());
                    if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                        saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
                    }
                    pageDto.add(saleProductDto);
                }
            }
            return pageDto;
        } catch (ProductServiceException e) {
            logger.error("查询商品信息出错");
            throw new ProductServiceException("异常：查询商品信息出错");
        }
    }

    @Override
    public void updateSaleProduct(SaleProductDto updateSaleProductDto, String channelCode) throws ProductServiceException {
        logger.debug("updateSaleProductDto -> " + updateSaleProductDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductDto)) {
                logger.error("ProductService.updateSaleProductDto => 更新商品参数为空");
                throw new ProductServiceException("需要更新的商品参数为空");
            }
            // 检查商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductDto.getId())) {
                logger.error("ProductService.updateSaleProductDto.id => 商品ID为空");
                throw new ProductServiceException("需要更新的商品ID为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 需要更新的商品
            SaleProductDto saleProductDto = this.loadSaleProductBasicInfoById(updateSaleProductDto.getId(), null);
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                // 更新商品基础信息
                this.updateSaleProductBasicInfo(updateSaleProductDto);
                // 更新商品附属信息
                // 检查商品附属信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(updateSaleProductDto.getSaleProductProfileDto())) {
                    SaleProductProfileDto saleProductProfileDto = updateSaleProductDto.getSaleProductProfileDto();
                    saleProductProfileDto.setSaleProductId(updateSaleProductDto.getId());
                    saleProductProfileDto.setContent(updateSaleProductDto.getContentString());
                    saleProductProfileDto.setModifyUserId(updateSaleProductDto.getModifyUserId());
                    saleProductProfileDto.setModifyTime(updateSaleProductDto.getModifyTime());
                    saleProductProfileDto.setChannelCode(channelCode);
                    saleProductProfileService.updateSaleProductProfile(saleProductProfileDto);
                    this.operateContentImage(updateSaleProductDto.getLoadContentImageUrls(),
                            updateSaleProductDto.getAddContentImageUrls());
                }
                // 更新商品价格信息
                // 检查商品价格信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(updateSaleProductDto.getSaleProductPriceDto())) {
                    SaleProductPriceDto saleProductPriceDto = updateSaleProductDto.getSaleProductPriceDto();
                    saleProductPriceDto.setSaleProductId(updateSaleProductDto.getId());
                    saleProductPriceDto.setModifyUserId(updateSaleProductDto.getModifyUserId());
                    saleProductPriceDto.setModifyTime(updateSaleProductDto.getModifyTime());
                    saleProductPriceDto.setChannelCode(channelCode);
                    saleProductPriceService.updateSaleProductPrice(saleProductPriceDto);
                }
                // 更新商品图片信息
                // 封装前台传过来的图片信息列表
                List<SaleProductImageDto> listSaleProductImageDto = null;
                if (!ObjectUtils.isNullOrEmpty(updateSaleProductDto.getAppIsMainPic())) {
                    listSaleProductImageDto = listSaleProductImageDto(updateSaleProductDto);
                } else {
                    listSaleProductImageDto = updateSaleProductDto.getSaleProductImageDtos();
                }
                // 检查商品图片信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDto)) {
                    for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                        saleProductImageDto.setSaleProductId(updateSaleProductDto.getId());
                        saleProductImageDto.setModifyUserId(updateSaleProductDto.getModifyUserId());
                        saleProductImageDto.setModifyTime(updateSaleProductDto.getModifyTime());
                        saleProductImageDto.setChannelCode(channelCode);
                    }
                    saleProductImageService.updateSaleProductImages(listSaleProductImageDto);
                }

                // 更新正式服务器上的图片
                this.operateSaleProductImage(listSaleProductImageDto, updateSaleProductDto.getDeleteImageUrls());
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品出错");
            throw new ProductServiceException("异常：更新商品出错");
        }

    }

    // 增加商品图片到正式服务器
    private void operateSaleProductImage(List<SaleProductImageDto> listSaleProductImageDto, String delImageUrls)
            throws ProductServiceException {
        try {
            // 商品类别保存成功之后，处理商品类别临时图片
            // 商品类别图片标示不为空并且其为增加，将图片更新到正式的环境
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDto)) {
                for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                    if (!ObjectUtils.isNullOrEmpty(saleProductImageDto.getAppImageFlag())
                            && IMAGEFLAG_YES.equals(saleProductImageDto.getAppImageFlag())) {
                        fileUploadUtils.uploadPublishFile(saleProductImageDto.getImageUrl());
                    }
                }
            }
            // 商品类别图片需要删除的，将正式的环境图片删除
            if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
                String[] arrParam = delImageUrls.split(",");
                for (String imageUrl : arrParam) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                        fileUploadUtils.deletePublishFile(imageUrl);
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("增加商品图片到正式服务器出错！");
            throw new ProductServiceException("异常：增加商品图片到正式服务器出错！");
        }
    }

    // 封装前台传过来的图片列表数据
    private List<SaleProductImageDto> listSaleProductImageDto(SaleProductDto saleProductDto) {

        List<SaleProductImageDto> listSaleProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                // 保存图片
                // 封装商品图片
                listSaleProductImageDto = new ArrayList<SaleProductImageDto>();
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getFirstAppImageProfileDto())) {
                    ProductImageProfileDto profileDto1 = saleProductDto.getFirstAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto1);
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSecondAppImageProfileDto())) {
                    ProductImageProfileDto profileDto2 = saleProductDto.getSecondAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto2);
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getThirdAppImageProfileDto())) {
                    ProductImageProfileDto profileDto3 = saleProductDto.getThirdAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto3);
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getFouthAppImageProfileDto())) {
                    ProductImageProfileDto profileDto4 = saleProductDto.getFouthAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto4);
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getFiveAppImageProfileDto())) {
                    ProductImageProfileDto profileDto5 = saleProductDto.getFiveAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto5);
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSixAppImageProfileDto())) {
                    ProductImageProfileDto profileDto6 = saleProductDto.getSixAppImageProfileDto();
                    addSaleProductImageDto(listSaleProductImageDto, saleProductDto, profileDto6);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传输的图片列表信息出错");
            throw new ProductServiceException("异常：封装前台传输的图片列表信息出错");
        }

        return listSaleProductImageDto;
    }

    // 封装前台传过来的图片Dto
    private void addSaleProductImageDto(List<SaleProductImageDto> listSaleProductImageDto, SaleProductDto saleProductDto,
            ProductImageProfileDto profileDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                SaleProductImageDto saleProductImageDto = this.pakageSaleProductImageDto(saleProductDto, profileDto);
                if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
                    listSaleProductImageDto.add(saleProductImageDto);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传过来的图片Dto");
            throw new ProductServiceException("封装前台传过来的图片Dto");
        }
    }

    // 封装前台传过来的图片列表数据
    private SaleProductImageDto pakageSaleProductImageDto(SaleProductDto saleProductDto, ProductImageProfileDto profileDto) {

        SaleProductImageDto saleProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicPath())) {
                // 保存图片
                // 封装商品单张图片
                saleProductImageDto = new SaleProductImageDto();
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicId())) {
                    saleProductImageDto.setId(profileDto.getAppPicId());
                }
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicOrder())) {
                    saleProductImageDto.setImageOrder(profileDto.getAppPicOrder());
                }
                saleProductImageDto.setImageUrl(profileDto.getAppPicPath());
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppImageFlag())) {
                    saleProductImageDto.setAppImageFlag(profileDto.getAppImageFlag());
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getAppIsMainPic())
                        && profileDto.getAppPicSort().intValue() == saleProductDto.getAppIsMainPic().intValue()) {
                    saleProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES);
                } else {
                    saleProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_NO);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传输单张图片信息出错");
            throw new ProductServiceException("异常：封装前台传输单张图片信息出错");
        }

        return saleProductImageDto;
    }

    @Override
    public void updateSaleProductBasicInfo(SaleProductDto updateSaleProductDto) throws ProductServiceException {
        // 更新商品描述表开始
        logger.debug("updateSaleProductDto -> " + updateSaleProductDto);
        // 更新商品基础信息
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductDto)) {
                logger.error("SaleProductService.updateSaleProductDto => 需要更新的商品参数为空");
                throw new ProductServiceException("SaleProductService的updateSaleProductDto方法参数为空");
            }
            // 检查商品基础信息修改人是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductDto.getModifyUserId())) {
                logger.error("ProductService.updateSaleProductDto.modifyUserId=> 商品基础信息修改人为空");
                throw new ProductServiceException("ProductService的updateSaleProductDto.modifyUserId方法参数modifyUserId为空");
            }
            // 检查商品基础信息修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateSaleProductDto.getModifyTime())) {
                logger.error("ProductService.updateSaleProductDto.modifyTime => 商品基础信息修改时间为空");
                throw new ProductServiceException("ProductService的updateSaleProductDto方法参数modifyTime为空");
            }

            SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoById(updateSaleProductDto.getId(), null);

            // 更新商品基础信息
            if (!ObjectUtils.isNullOrEmpty(saleProduct)) {
                // 以下基础相关信息有任何一个有修改就需要更新并且创建商品历史基础信息，其他基础信息不允许修改
                if (ObjectUtils.whetherModified(saleProduct.getSaleProductName(), updateSaleProductDto.getSaleProductName())
                        || ObjectUtils.whetherModified(saleProduct.getProductClassCode(),
                                updateSaleProductDto.getProductClassCode())
                        || ObjectUtils.whetherModified(saleProduct.getBrandCode(), updateSaleProductDto.getBrandCode())
                        || (null != updateSaleProductDto.getPerOperCount() && ObjectUtils
                                .whetherModified(saleProduct.getPerOperCount(), updateSaleProductDto.getPerOperCount()))) {
                    saleProduct.setSaleProductName(updateSaleProductDto.getSaleProductName());
                    saleProduct.setProductClassCode(updateSaleProductDto.getProductClassCode());
                    saleProduct.setBrandCode(updateSaleProductDto.getBrandCode());
                    saleProduct.setPerOperCount(
                            null == updateSaleProductDto.getPerOperCount() ? 1 : updateSaleProductDto.getPerOperCount());
                    saleProduct.setModifyTime(updateSaleProductDto.getModifyTime());
                    saleProduct.setModifyUserId(updateSaleProductDto.getModifyUserId());
                    saleProductMapper.updateSaleProductBasicInfoById(saleProduct);
                    // 更新商品基础信息时创建商品基础信息历史记录
                    SaleProductHistoryDto saleProductHistoryDto = new SaleProductHistoryDto();
                    saleProductHistoryDto.setSaleProductId(saleProduct.getId());
                    saleProductHistoryDto.setStoreId(saleProduct.getStoreId());
                    saleProductHistoryDto.setProductId(saleProduct.getProductId());
                    saleProductHistoryDto.setProductClassCode(saleProduct.getProductClassCode());
                    saleProductHistoryDto.setBrandCode(saleProduct.getBrandCode());
                    saleProductHistoryDto.setBarCode(saleProduct.getBarCode());
                    saleProductHistoryDto.setSaleProductName(updateSaleProductDto.getSaleProductName());
                    saleProductHistoryDto.setProductClassCode(updateSaleProductDto.getProductClassCode());
                    saleProductHistoryDto.setAuditNote(saleProduct.getAuditNote());
                    saleProductHistoryDto.setAuditStatusCode(saleProduct.getAuditStatusCode());
                    saleProductHistoryDto.setAuditTime(saleProduct.getAuditTime());
                    saleProductHistoryDto.setEnabledFlag(saleProduct.getEnabledFlag());
                    saleProductHistoryDto.setOperateTime(updateSaleProductDto.getModifyTime());
                    saleProductHistoryDto.setOperateUserId(updateSaleProductDto.getModifyUserId());
                    saleProductHistoryDto.setPerOperCount(
                            null == updateSaleProductDto.getPerOperCount() ? 1 : updateSaleProductDto.getPerOperCount());
                    saleProductHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTOPERTYPE_MODIFY);
                    saleProductHistoryService.saveSaleProductHistoryBasicInfo(saleProductHistoryDto);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("更新商品基础出错");
            throw new ProductServiceException("异常：更新商品基础出错");
        }

    }

    @Override
    public boolean updateProductClass(Integer id, String productClassCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException {
        logger.debug("id -> " + id + "productClassCode -> " + productClassCode);
        boolean updateFlag = false;
        try {
            // 检查商品参数productId是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("SaleProductService.updateProductClass => 参数商品id为空");
                throw new ProductServiceException("参数商品Id为空");
            }
            // 检查商品参数productClassCode是否为空
            if (ObjectUtils.isNullOrEmpty(productClassCode)) {
                logger.error("SaleProductService.updateProductClass => 参数商品productClassCode为空");
                throw new ProductServiceException("参数商品类别为空");
            }
            // 检查商品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("SaleProductService.updateProductClass.modifyUserId=> 商品类别修改人为空");
                throw new ProductServiceException("商品类别修改人为空");
            }
            // 检查商品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("SaleProductService.updateProductClass.modifyTime => 商品类别修改时间为空");
                throw new ProductServiceException("商品类别修改时间为空");
            }
            SaleProductDto saleProductDto = this.loadSaleProductBasicInfoById(id, null);
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)
                    && ObjectUtils.whetherModified(saleProductDto.getProductClassCode(), productClassCode)) {
                saleProductMapper.updateProductClassById(id, productClassCode, modifyTime, modifyUserId);
                // 更新商品类别时创建商品基础信息历史记录
                SaleProductHistoryDto saleProductHistoryDto = new SaleProductHistoryDto();
                saleProductHistoryDto.setSaleProductId(id);
                saleProductHistoryDto.setStoreId(saleProductDto.getStoreId());
                saleProductHistoryDto.setProductId(saleProductDto.getProductId());
                saleProductHistoryDto.setProductClassCode(productClassCode);
                saleProductHistoryDto.setBrandCode(saleProductDto.getBrandCode());
                saleProductHistoryDto.setBarCode(saleProductDto.getBarCode());
                saleProductHistoryDto.setSaleProductName(saleProductDto.getSaleProductName());
                saleProductHistoryDto.setAuditNote(saleProductDto.getAuditNote());
                saleProductHistoryDto.setAuditStatusCode(saleProductDto.getAuditStatusCode());
                saleProductHistoryDto.setAuditTime(saleProductDto.getAuditTime());
                saleProductHistoryDto.setEnabledFlag(saleProductDto.getEnabledFlag());
                saleProductHistoryDto.setOperateTime(modifyTime);
                saleProductHistoryDto.setOperateUserId(modifyUserId);
                saleProductHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTOPERTYPE_MODIFY);
                saleProductHistoryService.saveSaleProductHistoryBasicInfo(saleProductHistoryDto);
                updateFlag = true;
            }
        } catch (ProductServiceException e) {
            logger.error("根据商品ID更改商品状态出错");
            throw new ProductServiceException("异常：根据商品ID更改商品状态出错");
        }

        return updateFlag;
    }

    @Override
    public List<SaleProductDto> listDataForExportSaleProduct(SaleProductQuery saleProductQuery, Long startLineNum,
            Integer pageSize) throws ProductServiceException {
        try {
            // modified by chenb for warehouse share inventory at 2016/12/10
            // 5:14
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductQuery) && !ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductQuery.getStoreId());
                if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                    return Collections.emptyList();
                }
                if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                        && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStoreType())) {
                    // 店铺共享库存查询微仓商品信息
                    Integer wareHouseId = storeWarehouseProxyService
                            .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                    saleProductQuery.setStoreId(wareHouseId);
                    saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
                }
            }
            // modified over
            List<SaleProductRelatedInfo> saleProducts = saleProductMapper.listDataForExportSaleProduct(saleProductQuery,
                    startLineNum, pageSize);
            List<SaleProductDto> spDtos = new ArrayList<SaleProductDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProducts)) {
                for (SaleProductRelatedInfo sp : saleProducts) {
                    SaleProductDto spDto = new SaleProductDto();
                    ObjectUtils.fastCopy(sp, spDto);
                    if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                        spDto.setStoreId(storeProfileProxyDto.getStoreId());
                        spDto.setStoreType(storeProfileProxyDto.getStoreType());
                    }
                    // 商品上下架状态转换为上下架状态描述，供前台显示
                    spDto.setSaleStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTSALESTATUS.getValue(), sp.getSaleStatus()));
                    // 热卖状态编码转换为热卖状态描述
                    spDto.setHotSaleFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), sp.getHotSaleFlag()));
                    // 商品来源转换为来源描述，供前台显示
                    spDto.setSaleProductSourceName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTSOURCE.getValue(), sp.getSaleProductSource()));
                    // 商品状态转换为商品状态描述，供前台显示
                    spDto.setEnabledFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.SALEPRODUCTENABLEDFLAG.getValue(), sp.getEnabledFlag()));
                    spDtos.add(spDto);
                }
            }
            return spDtos;
        } catch (Exception e) {
            logger.error("listDataForExportSaleProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportSaleProduct(SaleProductQuery saleProductQuery) throws ProductServiceException {
        try {
            // modified by chenb for warehouse share inventory at 2016/12/10
            // 5:14
            if (!ObjectUtils.isNullOrEmpty(saleProductQuery) && !ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService
                        .loadByStoreId(saleProductQuery.getStoreId());
                if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                    return 0L;
                }
                if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                        && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStoreType())) {
                    // 店铺共享库存查询微仓商品信息
                    Integer wareHouseId = storeWarehouseProxyService
                            .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                    saleProductQuery.setStoreId(wareHouseId);
                }
            }
            // modified over
            Long counts = saleProductMapper.getCountsForExportSaleProduct(saleProductQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportSaleProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public boolean updateEnabledFlag(Integer id, String enabledFlag, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException {
        logger.debug("id -> " + id + "enabledFlag -> " + enabledFlag + "modifyUserId -> " + modifyUserId + "modifyTime -> "
                + modifyTime);
        boolean updateFlag = false;
        try {
            // 检查商品参数productId是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("SaleProductService.updateEnabledFlag => 参数商品id为空");
                throw new ProductServiceException("参数商品Id为空");
            }
            // 检查商品参数enabledFlag是否为空
            if (ObjectUtils.isNullOrEmpty(enabledFlag)) {
                logger.error("SaleProductService.updateEnabledFlag => 参数商品enabledFlag为空");
                throw new ProductServiceException("参数商品有效性为空");
            }
            // 检查商品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("SaleProductService.updateEnabledFlag.modifyUserId=> 商品类别修改人为空");
                throw new ProductServiceException("商品类别修改人为空");
            }
            // 检查商品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("SaleProductService.updateEnabledFlag.modifyTime => 商品类别修改时间为空");
                throw new ProductServiceException("商品类别修改时间为空");
            }
            SaleProductDto saleProductDto = this.loadSaleProductBasicInfoById(id, null);
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)
                    && ObjectUtils.whetherModified(saleProductDto.getEnabledFlag(), enabledFlag)) {
                saleProductMapper.updateEnabledFlagById(id, enabledFlag, modifyTime, modifyUserId);
                // 更新商品有效性时创建商品基础信息历史记录
                SaleProductHistoryDto saleProductHistoryDto = new SaleProductHistoryDto();
                saleProductHistoryDto.setSaleProductId(id);
                saleProductHistoryDto.setStoreId(saleProductDto.getStoreId());
                saleProductHistoryDto.setProductId(saleProductDto.getProductId());
                saleProductHistoryDto.setProductClassCode(saleProductDto.getProductClassCode());
                saleProductHistoryDto.setBrandCode(saleProductDto.getBrandCode());
                saleProductHistoryDto.setBarCode(saleProductDto.getBarCode());
                saleProductHistoryDto.setSaleProductName(saleProductDto.getSaleProductName());
                saleProductHistoryDto.setAuditNote(saleProductDto.getAuditNote());
                saleProductHistoryDto.setAuditStatusCode(saleProductDto.getAuditStatusCode());
                saleProductHistoryDto.setAuditTime(saleProductDto.getAuditTime());
                saleProductHistoryDto.setEnabledFlag(enabledFlag);
                saleProductHistoryDto.setOperateTime(modifyTime);
                saleProductHistoryDto.setOperateUserId(modifyUserId);
                saleProductHistoryDto.setOperateType(SystemContext.ProductDomain.SALEPRODUCTOPERTYPE_MODIFY);
                saleProductHistoryService.saveSaleProductHistoryBasicInfo(saleProductHistoryDto);
                updateFlag = true;
            }
        } catch (ProductServiceException e) {
            logger.error("根据商品ID更改商品状态出错", e);
            throw new ProductServiceException("异常：根据商品ID删除商品出错");
        }

        return updateFlag;
    }

    @Override
    public String addToStandard(SaleProductDto saleProductDto, String channelCode, Integer loginId, Date createDate)
            throws ProductServiceException {
        logger.debug("SaleProductDto -> " + saleProductDto + "channelCode -> " + channelCode + "loginId -> " + loginId
                + "createDate -> " + createDate);
        try {
            // 检查商品参数channelCode是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(loginId)) {
                logger.error("SaleProductService.addToStandard.loginId=> 商品修改人为空");
                throw new ProductServiceException("商品修改人为空");
            }
            // 检查商品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(createDate)) {
                logger.error("SaleProductService.addToStandard.createDate => 商品类别createDate时间为空");
                throw new ProductServiceException("商品修改时间为空");
            }
            // 检查商品参数对象是否为空
            String errorString = "";
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                ProductDto productDto = pakageToProductDto(saleProductDto, loginId, createDate);
                if (!ObjectUtils.isNullOrEmpty(productDto)) {
                    errorString = productService.saveProduct(productDto, channelCode);
                }
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("商品添加到标准库出错");
            throw new ProductServiceException("异常：商品添加到标准库出错");
        }
    }

    /**
     * 将商品Dto封装成产品Dto
     * 
     * @param saleProductDto
     *            商品Dto
     * @param loginId
     *            用户Id
     * @param createDate
     *            用户createDate
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private ProductDto pakageToProductDto(SaleProductDto saleProductDto, Integer loginId, Date createDate) {
        ProductDto productDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                productDto = new ProductDto();
                productDto.setProductClassCode(saleProductDto.getProductClassCode());
                productDto.setBrandCode(saleProductDto.getBrandCode());
                productDto.setProductName(saleProductDto.getSaleProductName());
                productDto.setBarCode(saleProductDto.getBarCode());
                // 默认为有效状态
                productDto.setStatusCode(SystemContext.ProductDomain.PRODUCTSTATUS_ON);
                productDto.setCreateTime(createDate);
                productDto.setCreateUserId(loginId);
                // 封装产品的价格信息
                ProductPriceDto productPriceDto = null;
                SaleProductPriceDto saleProductPriceDto = saleProductDto.getSaleProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductPriceDto)) {
                    productPriceDto = new ProductPriceDto();
                    productPriceDto.setCostPrice(saleProductPriceDto.getCostPrice());
                    productPriceDto.setRetailPrice(saleProductPriceDto.getRetailPrice());
                    productPriceDto.setPromotionalPrice(saleProductPriceDto.getPromotionalPrice());
                    productPriceDto.setCommissionPrice(saleProductPriceDto.getCommissionPrice());
                    productPriceDto.setVipCommissionPrice(saleProductPriceDto.getVipCommissionPrice());
                    productDto.setProductPriceDto(productPriceDto);
                }
                // 封装产品的附属信息
                ProductProfileDto productProfileDto = null;
                SaleProductProfileDto saleProductProfileDto = saleProductDto.getSaleProductProfileDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductProfileDto)) {
                    productProfileDto = new ProductProfileDto();
                    productProfileDto.setContent(saleProductProfileDto.getContent());
                    productProfileDto.setDisplayOrder(saleProductProfileDto.getDisplayOrder());
                    productProfileDto.setHotSaleFlag(saleProductProfileDto.getHotSaleFlag());
                    productProfileDto.setProductOwner(saleProductProfileDto.getProductOwner());
                    if (saleProductProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_INIT)) {
                        productProfileDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_INIT);
                    } else if (saleProductProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE)) {
                        productProfileDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE);
                    } else if (saleProductProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE)) {
                        productProfileDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE);
                    }
                    productProfileDto.setProductSpec(saleProductProfileDto.getSaleProductSpec());
                    productProfileDto.setSellPoint(saleProductProfileDto.getSellPoint());
                    productDto.setProductProfileDto(productProfileDto);
                }
                // 封装产品的图片信息
                List<SaleProductImageDto> saleProductImageDtoList = saleProductDto.getSaleProductImageDtos();
                List<ProductImageDto> productImageDtoList = null;
                if (!ObjectUtils.isNullOrEmpty(saleProductImageDtoList)) {
                    productImageDtoList = new ArrayList<ProductImageDto>();
                    for (SaleProductImageDto saleProductImageDto : saleProductImageDtoList) {
                        ProductImageDto productImageDto = null;
                        if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
                            productImageDto = new ProductImageDto();
                            productImageDto.setImageUrl(saleProductImageDto.getImageUrl());
                            productImageDto.setMasterFlag(saleProductImageDto.getMasterFlag());
                            productImageDto.setImageOrder(saleProductImageDto.getImageOrder());
                            productImageDtoList.add(productImageDto);
                        }
                    }
                    productDto.setProductImageDtos(productImageDtoList);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将商品Dto封装成产品Dto失败" + e.getMessage());
            throw new ProductServiceException("异常：将商品Dto封装成产品Dto出错");
        }
        return productDto;
    }

    @Override
    public void saveSaleProductBatch(List<ProductDto> productDtoList, SaleProductBatchSaveDto objs)
            throws ProductServiceException {
        logger.debug("productDtoList -> " + productDtoList);
        try {
            // 检查商品参数店铺id是否为空(objs[0]为店铺id)
            if (ObjectUtils.isNullOrEmpty(objs.getStoreId())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品店铺Id参数为空");
                throw new ProductServiceException("查询的商品店铺Id参数为空");
            }
            // 检查商品参数创建人是否为空(objs[1]为店铺创建人)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateUserId())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品创建人参数为空");
                throw new ProductServiceException("查询的商品barCode参数为空");
            }
            // 检查商品参数创建时间是否为空(objs[2]为店铺商品创建时间)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateTime())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品创建时间参数为空");
                throw new ProductServiceException("查询的商品创建时间参数为空");
            }
            // 检查商品参数渠道编码是否为空(objs[3]为渠道编码)
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品渠道编码参数为空");
                throw new ProductServiceException("查询的商品渠道编码参数为空");
            }
            List<SaleProductDto> saleProductDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(productDtoList)) {
                saleProductDtoList = new ArrayList<>();
                for (ProductDto productDto : productDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(productDto)) {
                        SaleProductDto saleProductDto = this.pakageToSaleProductDto(productDto, objs.getStoreId(),
                                objs.getOperateUserId(), objs.getOperateTime());
                        saleProductDtoList.add(saleProductDto);
                    }
                }
                this.saveSaleProducts(saleProductDtoList, objs.getStoreType(), objs.getChannelCode());
            }
        } catch (ProductServiceException e) {
            logger.error("将标准库产品批量导入店铺出错");
            throw new ProductServiceException("异常：将标准库产品批量导入店铺出错");
        }
    }

    @Override
    public void saveSaleProductBatchSync(List<ProductDto> productDtoList, SaleProductBatchSaveDto objs)
            throws ProductServiceException {
        logger.debug("productDtoList -> " + productDtoList);
        try {
            // 检查商品参数店铺id是否为空(objs[0]为店铺id)
            if (ObjectUtils.isNullOrEmpty(objs.getStoreId())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品店铺Id参数为空");
                throw new ProductServiceException("查询的商品店铺Id参数为空");
            }
            // 检查商品参数创建人是否为空(objs[1]为店铺创建人)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateUserId())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品创建人参数为空");
                throw new ProductServiceException("查询的商品barCode参数为空");
            }
            // 检查商品参数创建时间是否为空(objs[2]为店铺商品创建时间)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateTime())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品创建时间参数为空");
                throw new ProductServiceException("查询的商品创建时间参数为空");
            }
            // 检查商品参数渠道编码是否为空(objs[3]为渠道编码)
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                logger.error("ProductService.saveSaleProductBatch => 查询的商品渠道编码参数为空");
                throw new ProductServiceException("查询的商品渠道编码参数为空");
            }
            List<SaleProductDto> saleProductDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(productDtoList)) {
                saleProductDtoList = new ArrayList<>();
                for (ProductDto productDto : productDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(productDto)) {
                        SaleProductDto saleProductDto = this.pakageToSaleProductDto(productDto, objs.getStoreId(),
                                objs.getOperateUserId(), objs.getOperateTime());
                        saleProductDtoList.add(saleProductDto);
                    }
                }
                List<String> errorStrings = this.saveSaleProducts(saleProductDtoList, objs.getStoreType(),
                        objs.getChannelCode());
                if (!ObjectUtils.isNullOrEmpty(errorStrings)) {
                    throw new ProductServiceException(JSONUtils.toJSONString(errorStrings));
                }
            }
        } catch (ProductServiceException e) {
            String msg = null == e.getMessage() ? "批量保存商品出现系统异常" : e.getMessage();
            logger.error(msg);
            throw new ProductServiceException(msg);
        }
    }

    /**
     * 将产品Dto封装成商品Dto（批量添加）
     * 
     * @param productDto
     *            产品品Dto
     * @param storeId
     *            商店Id
     * @param loginId
     *            用户loginId
     * @param createTime
     *            商品createTime
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageToSaleProductDto(ProductDto productDto, Integer storeId, Integer loginId, Date createTime) {
        SaleProductDto saleProductDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                saleProductDto = new SaleProductDto();
                saleProductDto.setStoreId(storeId);
                saleProductDto.setProductId(productDto.getId());
                saleProductDto.setProductClassCode(productDto.getProductClassCode());
                saleProductDto.setBrandCode(productDto.getBrandCode());
                saleProductDto.setSaleProductName(productDto.getProductName());
                saleProductDto.setBarCode(productDto.getBarCode());
                saleProductDto.setPerOperCount(productDto.getPerOperCount());
                // 默认为审核通过状态
                saleProductDto.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
                // 默认为启用状态
                saleProductDto.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
                saleProductDto.setAuditTime(createTime);
                saleProductDto.setAuditUserId(loginId);
                saleProductDto.setCreateTime(createTime);
                saleProductDto.setCreateUserId(loginId);
                saleProductDto.setModifyTime(createTime);
                saleProductDto.setModifyUserId(loginId);
                // 封装商品的价格信息
                SaleProductPriceDto saleProductPriceDto = null;
                ProductPriceDto productPriceDto = productDto.getProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                    saleProductPriceDto = new SaleProductPriceDto();
                    saleProductPriceDto.setPromotionalPrice(productPriceDto.getPromotionalPrice());
                    saleProductPriceDto.setRetailPrice(productPriceDto.getRetailPrice());
                    saleProductPriceDto.setCommissionPrice(productPriceDto.getCommissionPrice());
                    saleProductPriceDto.setCostPrice(productPriceDto.getCostPrice());
                    saleProductPriceDto.setVipCommissionPrice(productPriceDto.getVipCommissionPrice());
                    saleProductPriceDto.setCreateTime(createTime);
                    saleProductPriceDto.setCreateUserId(loginId);
                    saleProductPriceDto.setModifyTime(createTime);
                    saleProductPriceDto.setModifyUserId(loginId);
                    saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
                }
                // 封装商品的附属信息
                SaleProductProfileDto saleProductProfileDto = null;
                ProductProfileDto productProfileDto = productDto.getProductProfileDto();
                if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                    saleProductProfileDto = new SaleProductProfileDto();
                    saleProductProfileDto.setContent(productProfileDto.getContent());
                    saleProductProfileDto.setDisplayOrder(productProfileDto.getDisplayOrder());
                    saleProductProfileDto.setHotSaleFlag(productProfileDto.getHotSaleFlag());
                    saleProductProfileDto.setProductOwner(productProfileDto.getProductOwner());
                    if (productProfileDto.getSaleStatus().equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_INIT)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_INIT);
                    } else if (productProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE);
                    } else if (productProfileDto.getSaleStatus()
                            .equals(SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE)) {
                        saleProductProfileDto.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
                    }
                    saleProductProfileDto.setSaleProductSpec(productProfileDto.getProductSpec());
                    saleProductProfileDto.setSellPoint(productProfileDto.getSellPoint());
                    // 此处来源是从标准库导入的
                    saleProductProfileDto.setSaleProductSource(SystemContext.ProductDomain.SALEPRODUCTSOURCE_STANDARD);
                    saleProductProfileDto.setCreateTime(createTime);
                    saleProductProfileDto.setCreateUserId(loginId);
                    saleProductProfileDto.setModifyTime(createTime);
                    saleProductProfileDto.setModifyUserId(loginId);
                    saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
                }
                // 封装商品的图片信息
                List<ProductImageDto> productImageDtoList = productDto.getProductImageDtos();
                List<SaleProductImageDto> saleProductImageDtoList = null;
                if (!ObjectUtils.isNullOrEmpty(productImageDtoList)) {
                    saleProductImageDtoList = new ArrayList<SaleProductImageDto>();
                    for (ProductImageDto productImageDto : productImageDtoList) {
                        SaleProductImageDto saleProductImageDto = null;
                        if (!ObjectUtils.isNullOrEmpty(productImageDto)) {
                            saleProductImageDto = new SaleProductImageDto();
                            saleProductImageDto.setImageUrl(productImageDto.getImageUrl());
                            saleProductImageDto.setMasterFlag(productImageDto.getMasterFlag());
                            saleProductImageDto.setImageOrder(productImageDto.getImageOrder());
                            saleProductImageDto.setCreateTime(createTime);
                            saleProductImageDto.setCreateUserId(loginId);
                            saleProductImageDto.setModifyTime(createTime);
                            saleProductImageDto.setModifyUserId(loginId);
                            saleProductImageDtoList.add(saleProductImageDto);
                        }
                    }
                    saleProductDto.setSaleProductImageDtos(saleProductImageDtoList);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将产品Dto封装成商品Dto" + e.getMessage());
            throw new ProductServiceException("异常：将产品Dto封装成商品Dto");
        }
        return saleProductDto;
    }

    @Override
    public boolean updateSaleProductDisplayOrderBatch(List<HashMap<String, Object>> displayOrderList,
            SaleProductSortBatchSaveDto objs) throws ProductServiceException {
        logger.debug("displayOrderList -> " + displayOrderList);
        boolean updateFlag = false;
        try {
            // 检查商品参数店铺id是否为空(objs[0]为店铺id)
            if (ObjectUtils.isNullOrEmpty(objs.getStoreId())) {
                logger.error("ProductService.updateSaleProductDisplayOrderBatch => 更新店铺商品的店铺Id参数为空");
                throw new ProductServiceException(" 更新店铺商品的店铺Id参数为空");
            }
            // 检查商品参数创建人是否为空(objs[1]为店铺创建人)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateUserId())) {
                logger.error("ProductService.updateSaleProductDisplayOrderBatch => 更新店铺商品修改人参数为空");
                throw new ProductServiceException("更新店铺商品修改人参数为空");
            }
            // 检查商品参数创建时间是否为空(objs[2]为店铺商品创建时间)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateTime())) {
                logger.error("ProductService.updateSaleProductDisplayOrderBatch => 更新店铺商品修改时间参数为空");
                throw new ProductServiceException("查询的商品创建时间参数为空");
            }
            // 检查商品参数渠道编码是否为空(objs[3]为渠道编码)
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                logger.error("ProductService.updateSaleProductDisplayOrderBatch => 更新店铺商品渠道编码参数为空");
                throw new ProductServiceException("更新店铺商品渠道编码参数为空");
            }
            if (!ObjectUtils.isNullOrEmpty(displayOrderList)) {
                for (HashMap<String, Object> map : displayOrderList) {
                    if (!ObjectUtils.isNullOrEmpty(map)) {
                        saleProductProfileService.updateDisplayOrderByBarCodeAndChannelCode((String) map.get("barCode"),
                                (Integer) map.get("displayOrder"), objs.getStoreId(), objs.getOperateUserId(),
                                objs.getOperateTime(), objs.getChannelCode());
                    }
                }
            }
            updateFlag = true;
        } catch (ProductServiceException e) {
            logger.error("批量更新店铺商品顺序出错");
            throw new ProductServiceException("异常：批量更新店铺商品顺序出错");
        }
        return updateFlag;
    }

    @Override
    public void saveOtherSaleProductBatch(List<SaleProductDto> saleProductDtoOtherList, SaleProductOtherBatchSaveDto objs)
            throws ProductServiceException {
        logger.debug("saleProductDtoOtherList -> " + saleProductDtoOtherList);
        try {
            // 检查商品列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductDtoOtherList)) {
                logger.error("ProductService.saveOtherSaleProductBatch => 需要保存的商品列表为空");
                throw new ProductServiceException("需要保存的商品列表为空");
            }
            // 检查商品参数店铺id是否为空(objs[0]为店铺id)
            if (ObjectUtils.isNullOrEmpty(objs.getStoreId())) {
                logger.error("ProductService.saveOtherSaleProductBatch => 需要保存的商品店铺Id参数为空");
                throw new ProductServiceException("需要保存的商品店铺Id参数为空");
            }
            // 检查商品参数创建人是否为空(objs[1]为店铺创建人)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateUserId())) {
                logger.error("ProductService.saveOtherSaleProductBatch => 查询的商品创建人参数为空");
                throw new ProductServiceException("需要保存的商品商品创建人参数为空");
            }
            // 检查商品参数创建时间是否为空(objs[2]为店铺商品创建时间)
            if (ObjectUtils.isNullOrEmpty(objs.getOperateTime())) {
                logger.error("ProductService.saveOtherSaleProductBatch => 查询的商品创建时间参数为空");
                throw new ProductServiceException("需要保存的商品创建时间参数为空");
            }
            // 检查商品参数渠道编码是否为空(objs[3]为渠道编码)
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                logger.error("ProductService.saveOtherSaleProductBatch => 查询的商品渠道编码参数为空");
                throw new ProductServiceException("需要保存的商品渠道编码参数为空");
            }
            List<SaleProductDto> saleProductDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductDtoOtherList)) {
                saleProductDtoList = new ArrayList<>();
                for (SaleProductDto saleProductDtoOther : saleProductDtoOtherList) {
                    if (!ObjectUtils.isNullOrEmpty(saleProductDtoOther)) {
                        SaleProductDto saleProductDto = this.pakageOtherToSaleProductDto(saleProductDtoOther,
                                objs.getStoreId(), objs.getOperateUserId(), objs.getOperateTime());
                        saleProductDtoList.add(saleProductDto);
                    }
                }
                this.saveSaleProducts(saleProductDtoList, objs.getStoreType(), objs.getChannelCode());
            }
        } catch (ProductServiceException e) {
            logger.error("将非标准库产品批量保存到店铺出错");
            throw new ProductServiceException("异常：将非标准库产品批量保存到店铺出错");
        }
    }

    /**
     * 将非标准库的商品Dto封装成标准商品Dto（批量添加）
     * 
     * @param saleProductDtoOther
     *            非标准库的商品Dto(前台传过来的)
     * @param storeId
     *            商店Id
     * @param loginId
     *            用户loginId
     * @param createTime
     *            商品createTime
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageOtherToSaleProductDto(SaleProductDto saleProductDtoOther, Integer storeId, Integer loginId,
            Date createTime) {
        SaleProductDto saleProductDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDtoOther)) {
                saleProductDto = new SaleProductDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductDtoOther.getProductId())) {
                    saleProductDto.setProductId(saleProductDtoOther.getProductId());
                }
                saleProductDto.setStoreId(storeId);
                saleProductDto.setProductClassCode(saleProductDtoOther.getProductClassCode());
                saleProductDto.setSaleProductName(saleProductDtoOther.getSaleProductName());
                saleProductDto.setBarCode(saleProductDtoOther.getBarCode());
                // 默认为审核通过状态
                saleProductDto.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
                // 默认为启用状态
                saleProductDto.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
                saleProductDto.setAuditTime(createTime);
                saleProductDto.setAuditUserId(loginId);
                saleProductDto.setCreateTime(createTime);
                saleProductDto.setCreateUserId(loginId);
                // 封装商品的价格信息
                SaleProductPriceDto saleProductPriceDto = new SaleProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductDtoOther.getPromotionalPrice())) {
                    saleProductPriceDto.setPromotionalPrice(saleProductDtoOther.getPromotionalPrice());
                }
                saleProductPriceDto.setRetailPrice(saleProductDtoOther.getRetailPrice());
                saleProductPriceDto.setCommissionPrice(saleProductDtoOther.getCommissionPrice());
                saleProductPriceDto.setVipCommissionPrice(saleProductDtoOther.getVipCommissionPrice());
                saleProductPriceDto.setCostPrice(saleProductDtoOther.getCostPrice());
                saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
                // 封装商品的附属信息
                SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
                saleProductProfileDto.setDisplayOrder(saleProductDtoOther.getDisplayOrder());
                saleProductProfileDto.setHotSaleFlag(saleProductDtoOther.getHotSaleFlag());
                saleProductProfileDto.setSaleStatus(saleProductDtoOther.getSaleStatus());
                saleProductProfileDto.setSaleProductSpec(saleProductDtoOther.getSaleProductSpec());
                // 此处来源是从标准库导入的
                saleProductProfileDto.setSaleProductSource(SystemContext.ProductDomain.SALEPRODUCTSOURCE_SYSTEM);
                saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
                // 封装商品的图片信息(导入的时候是没有图片信息的，不做封装)
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将非标准库的商品Dto封装成商品Dto出错" + e.getMessage());
            throw new ProductServiceException("异常：将非标准库的商品Dto封装成商品Dto出错");
        }
        return saleProductDto;
    }

    @Override
    public void updateSaleProductAuditStatusCodeById(Integer saleProductId, String auditStatusCode, String auditNote,
            Integer auditUserId, Date auditTime) throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId);
        try {
            // 检查商品参数店铺商品id是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("ProductService.updateSaleProductAuditStatusCodeById => 更新店铺商品审核状态的店铺商品Id参数为空");
                throw new ProductServiceException(" 更新店铺商品的店铺商品Id参数为空");
            }
            // 检查商品参数店铺商品审核状态是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatusCode)) {
                logger.error("ProductService.updateSaleProductAuditStatusCodeById => 更新店铺商品审核状态为空");
                throw new ProductServiceException(" 更新店铺商品审核状态为空");
            }
            // 检查商品审核人是否为空
            if (ObjectUtils.isNullOrEmpty(auditUserId)) {
                logger.error("ProductService.updateSaleProductAuditStatusCodeById => 更新店铺商品审核状态审核人参数为空");
                throw new ProductServiceException("更新店铺商品审核状态审核人参数为空");
            }
            // 检查商品参数审核时间是否为空
            if (ObjectUtils.isNullOrEmpty(auditTime)) {
                logger.error("ProductService.updateSaleProductAuditStatusCodeById => 更新店铺商品审核状态审核时间参数为空");
                throw new ProductServiceException("商品参数审核时间参数为空");
            }
            saleProductMapper.updateSaleProductAuditStatusCodeById(saleProductId, auditStatusCode, auditNote, auditUserId,
                    auditTime);
        } catch (ProductServiceException e) {
            logger.error("更新店铺商品审核状态出错", e);
            throw new ProductServiceException("异常：更新店铺商品审核状态出错");
        }
    }

    @Override
    public List<SaleProductDto> listSaleProductBasicInfoByStoreId(Integer storeId, String enableFlag)
            throws ProductServiceException {
        logger.debug("storeId -> " + storeId + "enableFlag -> " + enableFlag);
        List<SaleProductDto> saleProductBasicInfoList = null;
        try {
            // 检查商品店铺id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("ProductService.listSaleProductBasicInfoByStoreIdAndChannelCode => 查询的店铺Id参数为空");
                throw new ProductServiceException("查询的店铺Id参数为空");
            }
            Integer usedStoreId = storeId;
            // modified by chenb for warehouse share inventory at 2016/12/10
            // 5:14
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(usedStoreId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                throw new ProductServiceException("该店铺不存在");
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStoreType())) {
                // 店铺共享库存查询微仓商品信息
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            // modified over
            List<SaleProduct> saleProductList = saleProductMapper.listSaleProductBasicInfoByStoreId(usedStoreId, enableFlag);
            if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                saleProductBasicInfoList = new ArrayList<SaleProductDto>();
                for (SaleProduct saleProduct : saleProductList) {
                    SaleProductDto saleProductDto = null;
                    if (!ObjectUtils.isNullOrEmpty(saleProduct)) {
                        saleProductDto = new SaleProductDto();
                        ObjectUtils.fastCopy(saleProduct, saleProductDto);
                        if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                            saleProductDto.setStoreId(storeProfileProxyDto.getStoreId());
                            saleProductDto.setStoreType(storeProfileProxyDto.getStoreType());
                        }
                        saleProductBasicInfoList.add(saleProductDto);
                    }

                }
            }
            return saleProductBasicInfoList;
        } catch (ProductServiceException e) {
            logger.error("依据ID查询商品基础信息出错");
            throw new ProductServiceException("异常：依据ID查询商品基础信息出错");
        }
    }

    @Override
    public Set<String> getSaleProductBarCode(Integer storeId) throws ProductServiceException {
        try {
            // 检查商品店铺id参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("ProductService.getSaleProductBarCode => 查询的店铺Id参数为空");
                throw new ProductServiceException("查询的店铺Id参数为空");
            }
            Set<String> saleProductBarCodeSet = saleProductMapper.getSaleProductBarCode(storeId);
            return saleProductBarCodeSet;
        } catch (Exception e) {
            logger.error("getSaleProductBarCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductDto> listSaleProductBasicInfosByClassCode(String classCode, String enabledFlag)
            throws ProductServiceException {
        try {
            List<String> classCodeList = null;
            ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(classCode, null);
            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                classCodeList = new ArrayList<String>();
                // if
                // (productClassDto.getClassLevel().equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST))
                // {
                // List<ProductClassMappingDto> productClassMappingDtoList =
                // productClassMappingService
                // .listProductClassMapping(productClassDto.getClassCode(),
                // null);
                // if (!ObjectUtils.isNullOrEmpty(productClassMappingDtoList)) {
                // for (ProductClassMappingDto productClassMappingDto :
                // productClassMappingDtoList) {
                // classCodeList.add(productClassMappingDto.getChildClassCode());
                // }
                // }
                // } else if
                // (productClassDto.getClassLevel().equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_BASIC))
                // {
                classCodeList.add(productClassDto.getClassCode());
                // }
            }
            List<SaleProduct> saleProducts = saleProductMapper.listSaleProductBasicInfosByClassCode(classCodeList,
                    enabledFlag);
            List<SaleProductDto> pDtos = new ArrayList<SaleProductDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProducts)) {
                SaleProductDto pDto = null;
                for (SaleProduct p : saleProducts) {
                    if (!ObjectUtils.isNullOrEmpty(p)) {
                        pDto = new SaleProductDto();
                        ObjectUtils.fastCopy(p, pDto);
                        pDtos.add(pDto);
                    }
                }
            }
            return pDtos;
        } catch (Exception e) {
            logger.error("listProductBasicInfosByClassCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SaleProductAppDto> findSaleProducts(SaleProductQuery saleProductQuery) throws ProductServiceException {
        try {
            if (null == saleProductQuery) {
                throw new ProductServiceException("查询参数不能为 空");
            }
            if (null == saleProductQuery.getStart() || saleProductQuery.getStart() <= 0) {
                saleProductQuery.setStart(1);
            }
            if (null == saleProductQuery.getPageSize() || saleProductQuery.getPageSize() <= 0) {
                saleProductQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }

            if (!StringUtils.isEmpty(saleProductQuery.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(saleProductQuery.getProductClassCode());
                if (!ObjectUtils.isNullOrEmpty(classCodes)) {
                    saleProductQuery.setClassCodes(classCodes);
                }
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService
                    .loadByStoreId(saleProductQuery.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                throw new ProductServiceException("该店铺不存在");
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                // 店铺共享库存查询微仓商品信息
                Integer wareHouseId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                saleProductQuery.setStoreId(wareHouseId);
                saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
            }
            PageHelper.startPage(saleProductQuery.getStart(), saleProductQuery.getPageSize());
            Page<SaleProductAppDto> pageDto = new Page<SaleProductAppDto>(saleProductQuery.getStart(),
                    saleProductQuery.getPageSize());
            Page<SaleProductRelatedInfo> page = saleProductMapper.findSaleProductsForSeller(saleProductQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleProductRelatedInfo> saleProductRelatedInfoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(saleProductRelatedInfoList)) {
                for (SaleProductRelatedInfo spri : saleProductRelatedInfoList) {
                    SaleProductAppDto spDto = new SaleProductAppDto();
                    ObjectUtils.fastCopy(spri, spDto);
                    if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                        spDto.setStoreId(storeProfileProxyDto.getStoreId());
                        spDto.setStoreName(storeProfileProxyDto.getStoreName());
                        spDto.setStoreType(storeProfileProxyDto.getStoreType());
                        String storeTypeName = super.getSystemDictName(
                                SystemContext.UserDomain.DictType.STORETYPE.getValue(), spDto.getStoreType());
                        spDto.setStoreTypeName(storeTypeName);
                    }
                    // 设置附属属性
                    setSaleProductProfileInfo(spDto, spri.getId(), saleProductQuery.getSaleStatus(),
                            saleProductQuery.getChannelCode());

                    // 设置品牌
                    setSaleProductBrandInfo(spDto, spri.getBrandCode());

                    // 设置图片地址
                    setSaleProductImageInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                    // 设置价格
                    setSaleProductPriceInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());
                    // 设置商品分类
                    setSaleProductClassInfo(spDto, spri.getProductClassCode());
                    pageDto.add(spDto);
                }
                // 设置商品库存
                setSaleProductInventoryInfos(pageDto.getResult());
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (

        Exception e) {
            logger.error("searchSaleProducts异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> findSaleProductsBySaleZoneType(SaleProductQuery saleProductQuery)
            throws ProductServiceException {
        try {
            // 简单处理小区ID和店铺ID请求参数,当两个都有值时,不校验小区ID和店铺ID的对应关系是否合法,直接以店铺ID为值
            // 店铺关闭营业依然返回商品列表
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(saleProductQuery.getCommunityId(), null);
            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductQuery.getStoreId());
            }
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("找不到店铺信息");
                return Collections.emptyList();
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                Integer wareHouseId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                saleProductQuery.setStoreId(wareHouseId);
            }
            List<SaleZone> saleZoneList = saleZoneMapper.listByTypeCode(saleProductQuery.getTypeCode());

            if (ObjectUtils.isNullOrEmpty(saleZoneList)) {
                return Collections.emptyList();
            }

            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (SaleZone saleZone : saleZoneList) {
                SaleProduct saleProduct = saleProductMapper.loadByProductIdAndStoreIdEnabledFlag(saleZone.getProductId(),
                        storeProfileProxyDto.getStoreId(), saleProductQuery.getEnabledFlag(),
                        saleProductQuery.getSaleStatus());
                if (ObjectUtils.isNullOrEmpty(saleProduct)
                        || saleProduct.getStoreId().intValue() != storeProfileProxyDto.getStoreId().intValue()) {
                    continue;

                }
                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(
                        saleProduct.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                if (ObjectUtils.isNullOrEmpty(productClassDto)
                        || SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_NO.equals(productClassDto.getDisplay())) {
                    continue;
                }
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtos = new ArrayList<SaleProductAppDto>();
            for (SaleProduct spri : saleProductList) {
                SaleProductAppDto spDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(spri, spDto);
                if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                    spDto.setStoreId(storeProfileProxyDto.getStoreId());
                    spDto.setStoreName(storeProfileProxyDto.getStoreName());
                    spDto.setStoreType(storeProfileProxyDto.getStoreType());
                    String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            spDto.getStoreType());
                    spDto.setStoreTypeName(typeName);
                }
                // 设置附属属性
                setSaleProductProfileInfo(spDto, spri.getId(), saleProductQuery.getSaleStatus(),
                        saleProductQuery.getChannelCode());

                // 设置品牌
                setSaleProductBrandInfo(spDto, spri.getBrandCode());

                // 设置图片地址
                setSaleProductImageInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                // 设置价格
                setSaleProductPriceInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                saleProductAppDtos.add(spDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtos);
            return saleProductAppDtos;
        } catch (Exception e) {
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SaleProductAppDto loadSaleProductById(Integer saleProductId, String enabledFlag, String saleStatus,
            String channelCode) throws ProductServiceException {
        try {
            if (null == saleProductId || saleProductId <= 0) {
                throw new ProductServiceException("商品ID不合法");
            }
            SaleProduct saleProduct = saleProductMapper.loadByIdAndEnabledFlag(saleProductId, enabledFlag);
            if (null == saleProduct) {
                logger.error("商品[" + saleProductId + "]不存在");
                return null;
            }
            SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
            ObjectUtils.fastCopy(saleProduct, saleProductAppDto);

            // 设置商品附属信息
            setSaleProductProfileInfo(saleProductAppDto, saleProductId, saleStatus, channelCode);
            if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleStatus)
                    || SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(saleStatus)) {
                if (ObjectUtils.isNullOrEmpty(saleProductAppDto.getSaleProductProfileDto())) {
                    return null;
                }
            }
            // 设置商品价格信息
            setSaleProductPriceInfo(saleProductAppDto, saleProductId, channelCode);

            // 设置商品库存
            setSaleProductInventoryInfo(saleProductAppDto, saleProductId);

            // 设置商品品牌
            setSaleProductBrandInfo(saleProductAppDto, saleProduct.getBrandCode());

            // 商品图片
            setSaleProductImageInfo(saleProductAppDto, saleProductId, channelCode);
            return saleProductAppDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductByIdsAndChannelCode(List<Integer> saleProductIds, String enabledFlag,
            String saleStatus, String channelCode) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIds)) {
                throw new ProductServiceException("没有要查找的商品");
            }
            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (Integer saleProductId : saleProductIds) {
                SaleProduct saleProduct = saleProductMapper.loadByIdAndEnabledFlag(saleProductId, enabledFlag);
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
            for (SaleProduct saleProduct : saleProductList) {
                SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProduct, saleProductAppDto);
                // 查询商品附属信息
                setSaleProductProfileInfo(saleProductAppDto, saleProduct.getId(), saleStatus, channelCode);
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleStatus)
                        || SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(saleStatus)) {
                    if (ObjectUtils.isNullOrEmpty(saleProductAppDto.getSaleProductProfileDto())) {
                        continue;
                    }
                }
                // 设置商品价格信息
                setSaleProductPriceInfo(saleProductAppDto, saleProduct.getId(), channelCode);

                // 设置商品品牌
                setSaleProductBrandInfo(saleProductAppDto, saleProduct.getBrandCode());

                // 设置商品图片
                setSaleProductImageInfo(saleProductAppDto, saleProduct.getId(), channelCode);
                // 设置商品分类
                setSaleProductClassInfo(saleProductAppDto, saleProduct.getProductClassCode());
                saleProductAppDtoList.add(saleProductAppDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtoList);
            return saleProductAppDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    // 设置商品附属属性
    private void setSaleProductProfileInfo(SaleProductAppDto saleProductAppDto, Integer saleProductId, String saleStatus,
            String channelCode) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
            return;
        }
        SaleProductProfile saleProductProfile = saleProductProfileMapper
                .loadSaleProductProfileBySaleProductIdAndSaleStatusAndChannelCode(saleProductId, saleStatus, channelCode);
        if (null == saleProductProfile) {
            logger.error("商品[" + saleProductId + "]不存在");
            return;
        }
        SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
        ObjectUtils.fastCopy(saleProductProfile, saleProductProfileDto);
        String saleStatusName = SystemBasicDataUtils.getSystemDictName(
                SystemContext.ProductDomain.DictType.SALEPRODUCTSALESTATUS.getValue(), saleProductProfile.getSaleStatus());
        saleProductProfileDto.setSaleStatusName(saleStatusName);
        saleProductAppDto.setSaleProductProfileDto(saleProductProfileDto);
    }

    // 设置商品价格信息
    private void setSaleProductPriceInfo(SaleProductAppDto saleProductAppDto, Integer saleProductId, String channelCode) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
            return;
        }
        SaleProductPrice saleProductPrice = saleProductPriceMapper
                .loadSaleProductPriceBySaleProductIdAndChannelCode(saleProductId, channelCode);
        if (!ObjectUtils.isNullOrEmpty(saleProductPrice)) {
            saleProductAppDto.setPromotionalPrice(saleProductPrice.getPromotionalPrice());
            saleProductAppDto.setRetailPrice(saleProductPrice.getRetailPrice());
            saleProductAppDto.setCommissionPrice(saleProductPrice.getCommissionPrice());
            saleProductAppDto.setCostPrice(saleProductPrice.getCostPrice());
            saleProductAppDto.setVipCommissionPrice(saleProductPrice.getVipCommissionPrice());
        }
    }

    // 单个设置商品库存
    private void setSaleProductInventoryInfo(SaleProductAppDto saleProductAppDto, Integer saleProductId) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
            return;
        }
        SaleProductInventoryProxyDto saleProductInventoryProxyDto = saleProductInventoryProxyService
                .loadByStoreIdAndSaleProductId(null, saleProductId);
        if (!ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDto)) {
            saleProductAppDto.setStockNum(
                    saleProductInventoryProxyDto.getRemainCount() - saleProductInventoryProxyDto.getOrderedCount());
            saleProductAppDto.setRemainCount(saleProductInventoryProxyDto.getRemainCount());
        }
    }

    // 设置多个商品库存
    private void setSaleProductInventoryInfos(List<SaleProductAppDto> saleProductAppDtoList) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDtoList)) {
            return;
        }
        List<Integer> saleProductIds = new ArrayList<Integer>();
        for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
            saleProductIds.add(saleProductAppDto.getId());
        }
        List<SaleProductInventoryProxyDto> saleProductInventoryProxyDtoList = saleProductInventoryProxyService
                .listByStoreIdAndSaleProductIds(null, saleProductIds);
        if (ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDtoList)) {
            return;
        }
        Map<Integer, SaleProductInventoryProxyDto> inventoryMap = new HashMap<Integer, SaleProductInventoryProxyDto>();
        for (SaleProductInventoryProxyDto saleProductInventoryProxyDto : saleProductInventoryProxyDtoList) {
            inventoryMap.put(saleProductInventoryProxyDto.getSaleProductId(), saleProductInventoryProxyDto);
        }
        for (SaleProductAppDto saleProductAppDto : saleProductAppDtoList) {
            SaleProductInventoryProxyDto saleProductInventoryProxyDto = inventoryMap.get(saleProductAppDto.getId());
            if (!ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDto)) {
                Integer remainCount = saleProductInventoryProxyDto.getRemainCount();
                Integer orderCount = saleProductInventoryProxyDto.getOrderedCount();
                if (null == remainCount) {
                    remainCount = 0;
                }
                if (null == orderCount) {
                    orderCount = 0;
                }
                saleProductAppDto.setStockNum(remainCount - orderCount);
                saleProductAppDto.setOrderCount(orderCount);
                saleProductAppDto.setRemainCount(remainCount);
            }
        }
    }

    // 设设置商品品牌
    private void setSaleProductBrandInfo(SaleProductAppDto saleProductAppDto, String brandCode) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto) || ObjectUtils.isNullOrEmpty(brandCode)) {
            return;
        }
        ProductBrand productBrand = productBrandMapper.loadProductBrandByBrandCode(brandCode);
        if (!ObjectUtils.isNullOrEmpty(productBrand)) {
            saleProductAppDto.setBrandName(productBrand.getBrandName());
            saleProductAppDto.setBrandCode(productBrand.getBrandCode());
        }
    }

    // 设设置商品图片
    private void setSaleProductImageInfo(SaleProductAppDto saleProductAppDto, Integer saleProductId, String channelCode) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
            return;
        }
        List<SaleProductImageDto> saleProducctImageDtos = saleProductImageService
                .listSaleProductImagesBySaleProductIdAndChannelCode(saleProductId, channelCode);
        List<String> saleProductImages = new ArrayList<String>();
        String masterSaleProductImage = null;
        if (!ObjectUtils.isNullOrEmpty(saleProducctImageDtos)) {
            for (SaleProductImageDto saleProductImageDto : saleProducctImageDtos) {
                if (SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES.equals(saleProductImageDto.getMasterFlag())) {
                    masterSaleProductImage = saleProductImageDto.getImageUrl();
                }
                if (!ObjectUtils.isNullOrEmpty(saleProductImageDto.getImageUrl())) {
                    saleProductImages.add(saleProductImageDto.getImageUrl());
                }
            }
            saleProductAppDto.setSaleProductImageUrl(masterSaleProductImage);
            saleProductAppDto.setSaleProductImageUrlList(saleProductImages);
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductByProductIdsAndStoreIdAndChannelCode(List<Integer> productIds,
            String enabledFlag, String saleStatus, Integer storeId, String channelCode) throws ProductServiceException {
        try {
            Integer usedStoreId = storeId;
            if (ObjectUtils.isNullOrEmpty(productIds)) {
                logger.info("产品ID为空");
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.info("店铺ID为空");
                return Collections.emptyList();
            }
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
            if (null == storeProfileProxyDto) {
                logger.info("根据店铺ID[" + storeId + "]没有找到店铺信息");
                return Collections.emptyList();
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (Integer productId : productIds) {
                SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndProductId(usedStoreId,
                        productId, enabledFlag);
                if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                    continue;
                }
                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(
                        saleProduct.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                if (ObjectUtils.isNullOrEmpty(productClassDto)
                        || SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_NO.equals(productClassDto.getDisplay())) {
                    continue;
                }
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
            for (SaleProduct saleProduct : saleProductList) {
                SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProduct, saleProductAppDto);
                saleProductAppDto.setStoreId(storeProfileProxyDto.getStoreId());
                saleProductAppDto.setStoreName(storeProfileProxyDto.getStoreName());
                saleProductAppDto.setStoreType(storeProfileProxyDto.getStoreType());
                String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                        saleProductAppDto.getStoreType());
                saleProductAppDto.setStoreTypeName(typeName);
                // 查询商品附属信息
                setSaleProductProfileInfo(saleProductAppDto, saleProduct.getId(), saleStatus, channelCode);
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleStatus)
                        || SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(saleStatus)) {
                    if (ObjectUtils.isNullOrEmpty(saleProductAppDto.getSaleProductProfileDto())) {
                        continue;
                    }
                }

                // 设置商品价格信息
                setSaleProductPriceInfo(saleProductAppDto, saleProduct.getId(), channelCode);

                // 设置商品品牌
                setSaleProductBrandInfo(saleProductAppDto, saleProduct.getBrandCode());

                // 商品图片
                setSaleProductImageInfo(saleProductAppDto, saleProduct.getId(), channelCode);
                saleProductAppDtoList.add(saleProductAppDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtoList);
            return saleProductAppDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductByIdsAndStoreIdAndChannelCode(List<Integer> saleProductIds,
            Integer storeId, String enabledFlag, String saleStatus, String channelCode) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIds)) {
                throw new ProductServiceException("产品ID列表不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                throw new ProductServiceException("店铺ID不能为空");
            }
            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (Integer saleProductId : saleProductIds) {
                SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndId(storeId, saleProductId,
                        enabledFlag);
                if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                    continue;
                }
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
            for (SaleProduct saleProduct : saleProductList) {
                SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProduct, saleProductAppDto);

                // 查询商品附属信息
                setSaleProductProfileInfo(saleProductAppDto, saleProduct.getId(), saleStatus, channelCode);
                if (SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE.equals(saleStatus)
                        || SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_OFFSALE.equals(saleStatus)) {
                    if (ObjectUtils.isNullOrEmpty(saleProductAppDto.getSaleProductProfileDto())) {
                        continue;
                    }
                }
                // 设置商品价格信息
                setSaleProductPriceInfo(saleProductAppDto, saleProduct.getId(), channelCode);

                // 设置商品品牌
                setSaleProductBrandInfo(saleProductAppDto, saleProduct.getBrandCode());

                // 商品图片
                setSaleProductImageInfo(saleProductAppDto, saleProduct.getId(), channelCode);
                saleProductAppDtoList.add(saleProductAppDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtoList);
            return saleProductAppDtoList;
        } catch (Exception e) {
            logger.error("listSaleProductByProductIdsAndStoreIdAndChannelCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    // 设置商品分类
    private void setSaleProductClassInfo(SaleProductAppDto saleProductAppDto, String productClassCode) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto) || ObjectUtils.isNullOrEmpty(productClassCode)) {
            return;
        }
        ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(productClassCode, null);
        if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
            saleProductAppDto.setProductClassName(productClassDto.getClassName());
            saleProductAppDto.setProductClassCode(productClassDto.getClassCode());
        }
    }

    @Override
    public List<SaleProductDto> listSaleProductsByStoreIdAndBarCodes(Integer storeId, List<String> barCodes)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                return Collections.emptyList();
            }
            Integer usedStoreId = storeId;
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(usedStoreId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                return Collections.emptyList();
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            List<SaleProductDto> saleProductDtoList = null;
            List<SaleProduct> saleProductList = saleProductMapper.listSaleProductsByStoreIdAndBarCodes(usedStoreId,
                    barCodes);
            if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                saleProductDtoList = new ArrayList<SaleProductDto>();
                for (SaleProduct saleProduct : saleProductList) {
                    SaleProductDto saleProductDto = new SaleProductDto();
                    ObjectUtils.fastCopy(saleProduct, saleProductDto);
                    saleProductDto.setStoreId(storeProfileProxyDto.getStoreId());
                    saleProductDto.setStoreType(storeProfileProxyDto.getStoreType());
                    saleProductDtoList.add(saleProductDto);
                }
            }
            return saleProductDtoList;
        } catch (Exception e) {
            String msg = "根据店铺ID和若干条形码获取商品List出现系统异常";
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<SaleProductAppDto> findSaleProductInventorys(SaleProductQuery saleProductQuery)
            throws ProductServiceException {
        try {
            if (null == saleProductQuery.getStart() || saleProductQuery.getStart() <= 0) {
                saleProductQuery.setStart(1);
            }
            if (null == saleProductQuery.getPageSize() || saleProductQuery.getPageSize() <= 0) {
                saleProductQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<SaleProductAppDto> pageDto = new Page<SaleProductAppDto>(saleProductQuery.getStart(),
                    saleProductQuery.getPageSize());
            List<StoreProfileProxyDto> storeProfileProxyDtoList = null;
            if (!StringUtils.isEmpty(saleProductQuery.getStoreCode())
                    || !StringUtils.isEmpty(saleProductQuery.getStoreName())) {
                storeProfileProxyDtoList = storeProfileProxyService
                        .listByStoreCodeAndStoreName(saleProductQuery.getStoreCode(), saleProductQuery.getStoreName());
                if (ObjectUtils.isNullOrEmpty(storeProfileProxyDtoList)) {
                    return YiLiDiPageUtils.encapsulatePageResult(pageDto);
                }
            }
            List<Integer> storeIds = null;
            Map<Integer, StoreProfileProxyDto> storeProfileDtoMap = new HashMap<Integer, StoreProfileProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDtoList)) {
                storeIds = new ArrayList<Integer>();
                for (StoreProfileProxyDto storeProfileProxyDto : storeProfileProxyDtoList) {
                    if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                            && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                        Integer wareHouseId = storeWarehouseProxyService
                                .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                        storeIds.add(wareHouseId);
                        storeProfileDtoMap.put(wareHouseId, storeProfileProxyDto);
                    } else {
                        storeIds.add(storeProfileProxyDto.getStoreId());
                        storeProfileDtoMap.put(storeProfileProxyDto.getStoreId(), storeProfileProxyDto);
                    }
                }
                if (!ObjectUtils.isNullOrEmpty(storeIds)) {
                    saleProductQuery.setStoreIds(storeIds);
                }
            }
            PageHelper.startPage(saleProductQuery.getStart(), saleProductQuery.getPageSize());
            Page<SaleProductRelatedInfo> page = saleProductMapper.findSaleProducts(saleProductQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<SaleProductRelatedInfo> saleProductRelatedInfos = page.getResult();
            if (ObjectUtils.isNullOrEmpty(saleProductRelatedInfos)) {
                return YiLiDiPageUtils.encapsulatePageResult(pageDto);
            }
            List<Integer> saleProductIdList = new ArrayList<Integer>();
            for (SaleProductRelatedInfo saleProductRelatedInfo : saleProductRelatedInfos) {
                saleProductIdList.add(saleProductRelatedInfo.getId());
            }
            for (SaleProductRelatedInfo saleProductRelatedInfo : saleProductRelatedInfos) {
                SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProductRelatedInfo, saleProductAppDto);
                if (storeProfileDtoMap.containsKey(saleProductRelatedInfo.getStoreId())) {
                    StoreProfileProxyDto tempStoreProfile = storeProfileDtoMap.get(saleProductRelatedInfo.getStoreId());
                    saleProductAppDto.setStoreId(tempStoreProfile.getStoreId());
                    saleProductAppDto.setStoreName(tempStoreProfile.getStoreName());
                    saleProductAppDto.setStoreType(tempStoreProfile.getStoreType());
                }
                String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                        saleProductAppDto.getStoreType());
                saleProductAppDto.setStoreTypeName(typeName);
                // 设置品牌
                setSaleProductBrandInfo(saleProductAppDto, saleProductRelatedInfo.getBrandCode());
                // 设置商品附加属性
                setSaleProductProfileInfo(saleProductAppDto, saleProductRelatedInfo.getId(),
                        saleProductQuery.getSaleStatus(), null);
                // 设置店铺信息
                setStoreProfileInfo(saleProductAppDto);
                pageDto.add(saleProductAppDto);
            }
            // 商品库存
            setSaleProductInventoryInfos(pageDto.getResult());
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private void setStoreProfileInfo(SaleProductAppDto saleProductAppDto) {
        if (ObjectUtils.isNullOrEmpty(saleProductAppDto) || ObjectUtils.isNullOrEmpty(saleProductAppDto.getStoreId())) {
            return;
        }
        StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductAppDto.getStoreId());
        if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
            saleProductAppDto.setStoreName(storeProfileProxyDto.getStoreName());
            saleProductAppDto.setStoreCode(storeProfileProxyDto.getStoreCode());
        }
    }

    @Override
    public List<SaleProductAppDto> listDataForExportSaleProductInventory(SaleProductQuery saleProductQuery,
            Long startLineNum, Integer pageSize) throws ProductServiceException {
        try {
            if (null == startLineNum || startLineNum <= 0) {
                saleProductQuery.setStart(1);
            } else {
                saleProductQuery.setStart(startLineNum.intValue());
            }
            if (null == pageSize || pageSize <= 0) {
                saleProductQuery.setPageSize(CommonConstants.PAGE_SIZE);
            } else {
                saleProductQuery.setPageSize(pageSize);
            }
            List<StoreProfileProxyDto> storeProfileProxyDtoList = null;
            if (!StringUtils.isEmpty(saleProductQuery.getStoreCode())
                    || !StringUtils.isEmpty(saleProductQuery.getStoreName())) {
                storeProfileProxyDtoList = storeProfileProxyService
                        .listByStoreCodeAndStoreName(saleProductQuery.getStoreCode(), saleProductQuery.getStoreName());
            }
            List<Integer> storeIds = null;
            Map<Integer, StoreProfileProxyDto> storeProfileDtoMap = new HashMap<Integer, StoreProfileProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDtoList)) {
                storeIds = new ArrayList<Integer>();
                for (StoreProfileProxyDto storeProfileProxyDto : storeProfileProxyDtoList) {
                    if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                            && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                        Integer wareHouseId = storeWarehouseProxyService
                                .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                        storeIds.add(wareHouseId);
                        storeProfileDtoMap.put(wareHouseId, storeProfileProxyDto);
                    } else {
                        storeIds.add(storeProfileProxyDto.getStoreId());
                        storeProfileDtoMap.put(storeProfileProxyDto.getStoreId(), storeProfileProxyDto);
                    }
                }
                if (!ObjectUtils.isNullOrEmpty(storeIds)) {
                    saleProductQuery.setStoreIds(storeIds);
                }
            }
            PageHelper.startPage(saleProductQuery.getStart(), saleProductQuery.getPageSize());
            Page<SaleProductRelatedInfo> page = saleProductMapper.findSaleProducts(saleProductQuery);

            List<SaleProductRelatedInfo> saleProductRelatedInfos = page.getResult();
            if (ObjectUtils.isNullOrEmpty(saleProductRelatedInfos)) {
                return null;
            }
            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
            List<Integer> saleProductIdList = new ArrayList<Integer>();
            for (SaleProductRelatedInfo saleProductRelatedInfo : saleProductRelatedInfos) {
                saleProductIdList.add(saleProductRelatedInfo.getId());
            }
            for (SaleProductRelatedInfo saleProductRelatedInfo : saleProductRelatedInfos) {
                SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProductRelatedInfo, saleProductAppDto);
                if (storeProfileDtoMap.containsKey(saleProductRelatedInfo.getStoreId())) {
                    StoreProfileProxyDto tempStoreProfile = storeProfileDtoMap.get(saleProductRelatedInfo.getStoreId());
                    saleProductAppDto.setStoreId(tempStoreProfile.getStoreId());
                    saleProductAppDto.setStoreName(tempStoreProfile.getStoreName());
                    saleProductAppDto.setStoreType(tempStoreProfile.getStoreType());
                    String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            saleProductAppDto.getStoreType());
                    saleProductAppDto.setStoreTypeName(typeName);
                }
                // 设置品牌
                setSaleProductBrandInfo(saleProductAppDto, saleProductRelatedInfo.getBrandCode());
                // 设置商品附加属性
                setSaleProductProfileInfo(saleProductAppDto, saleProductRelatedInfo.getId(),
                        saleProductQuery.getSaleStatus(), null);
                // 设置店铺信息
                setStoreProfileInfo(saleProductAppDto);
                // 设置产品分类
                setSaleProductClassInfo(saleProductAppDto, saleProductRelatedInfo.getProductClassCode());
                saleProductAppDtoList.add(saleProductAppDto);
            }
            // 商品库存
            setSaleProductInventoryInfos(saleProductAppDtoList);
            return saleProductAppDtoList;
        } catch (Exception e) {
            logger.error("listDataForExportSaleProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportSaleProductInventory(SaleProductQuery saleProductQuery) throws ProductServiceException {
        try {
            List<StoreProfileProxyDto> storeProfileProxyDtoList = null;
            if (null != saleProductQuery && (!StringUtils.isEmpty(saleProductQuery.getStoreCode())
                    || !StringUtils.isEmpty(saleProductQuery.getStoreName()))) {
                storeProfileProxyDtoList = storeProfileProxyService
                        .listByStoreCodeAndStoreName(saleProductQuery.getStoreCode(), saleProductQuery.getStoreName());
            }
            List<Integer> storeIds = null;
            if (!ObjectUtils.isNullOrEmpty(storeProfileProxyDtoList)) {
                storeIds = new ArrayList<Integer>();
                for (StoreProfileProxyDto storeProfileProxyDto : storeProfileProxyDtoList) {
                    if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                            && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                        Integer wareHouseId = storeWarehouseProxyService
                                .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                        storeIds.add(wareHouseId);
                    } else {
                        storeIds.add(storeProfileProxyDto.getStoreId());
                    }
                }
                if (!ObjectUtils.isNullOrEmpty(storeIds)) {
                    saleProductQuery.setStoreIds(storeIds);
                }
            }
            Long counts = saleProductMapper.getCountsForExportSaleProductInventory(saleProductQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportSaleProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductsForSellerFlitting(SaleProductDto saleProductDto)
            throws ProductServiceException {
        try {
            if (StringUtils.isEmpty(saleProductDto.getProductClassCode())) {
                if (StringUtils.isNotEmpty(saleProductDto.getParentCode())) {
                    List<ProductClassMapping> productClassMappingList = productClassMappingMapper
                            .listByClassCode(saleProductDto.getParentCode());
                    List<String> classdCodes = null;
                    if (!ObjectUtils.isNullOrEmpty(productClassMappingList)) {
                        classdCodes = new ArrayList<String>();
                        for (ProductClassMapping productClassMapping : productClassMappingList) {
                            classdCodes.add(productClassMapping.getChildClassCode());
                        }
                    }
                    saleProductDto.setProductClassCodes(classdCodes);
                }
            }
            SaleProductQuery saleProductQuery = new SaleProductQuery();
            ObjectUtils.fastCopy(saleProductDto, saleProductQuery);
            List<SaleProductRelatedInfo> saleProductRelatedInfoList = saleProductMapper
                    .listSaleProductsForSellerFlitting(saleProductQuery);
            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();
            if (!ObjectUtils.isNullOrEmpty(saleProductRelatedInfoList)) {
                for (SaleProductRelatedInfo spri : saleProductRelatedInfoList) {
                    SaleProductAppDto spDto = new SaleProductAppDto();
                    ObjectUtils.fastCopy(spri, spDto);
                    // 设置附属属性
                    setSaleProductProfileInfo(spDto, spri.getId(), saleProductDto.getSaleStatus(),
                            saleProductDto.getChannelCode());
                    // 设置品牌
                    setSaleProductBrandInfo(spDto, spri.getBrandCode());
                    // 设置图片地址
                    setSaleProductImageInfo(spDto, spri.getId(), saleProductDto.getChannelCode());
                    // 设置价格
                    setSaleProductPriceInfo(spDto, spri.getId(), saleProductDto.getChannelCode());
                    // 设置商品分类
                    setSaleProductClassInfo(spDto, spri.getProductClassCode());
                    saleProductAppDtoList.add(spDto);
                }
                // 设置商品库存
                setSaleProductInventoryInfos(saleProductAppDtoList);
            }
            return saleProductAppDtoList;
        } catch (Exception e) {
            String msg = "获取卖家调拨微仓的商品列表出现系统异常";
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProducts(SaleProductQuery saleProductQuery) throws ProductServiceException {
        try {
            if (null == saleProductQuery) {
                return Collections.emptyList();
            }
            if (!StringUtils.isEmpty(saleProductQuery.getBrandCode())) {
                ProductBrandDto productBrandDto = productBrandService
                        .loadProductBrandByBrandCode(saleProductQuery.getBrandCode());
                if (ObjectUtils.isNullOrEmpty(productBrandDto)
                        || !productBrandDto.getStatusCode().equals(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON)) {
                    return Collections.emptyList();
                }
            }

            List<SaleProductAppDto> saleProductAppDtoList = new ArrayList<SaleProductAppDto>();

            if (ObjectUtils.isNullOrEmpty(saleProductQuery.getCommunityId())
                    && ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                return saleProductAppDtoList;
            }
            // 简单处理小区ID和店铺ID请求参数,当两个都有值时,不校验小区ID和店铺ID的对应关系是否合法,直接以店铺ID为值
            // 店铺关闭营业依然返回商品列表
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(saleProductQuery.getCommunityId(), null);
            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductQuery.getStoreId());
            }
            List<String> brandCodeList = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductQuery.getKeywords())) {
                ProductBrandQuery productBrandQuery = new ProductBrandQuery();
                productBrandQuery.setBrandName(saleProductQuery.getKeywords());
                productBrandQuery.setStatusCode(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON);
                List<ProductBrand> productBrandList = productBrandMapper.getProductBrands(productBrandQuery);
                if (!ObjectUtils.isNullOrEmpty(productBrandList)) {
                    brandCodeList = new ArrayList<String>();
                    for (ProductBrand productBrand : productBrandList) {
                        brandCodeList.add(productBrand.getBrandCode());
                    }
                    saleProductQuery.setBrandCodes(brandCodeList);
                }
            }
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("找不到店铺信息");
                return saleProductAppDtoList;
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                Integer wareHouseId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
                saleProductQuery.setStoreId(wareHouseId);
                saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
            } else {
                saleProductQuery.setStoreId(storeProfileProxyDto.getStoreId());
            }
            if (!StringUtils.isEmpty(saleProductQuery.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(saleProductQuery.getProductClassCode());
                if (!ObjectUtils.isNullOrEmpty(classCodes)) {
                    saleProductQuery.setClassCodes(classCodes);
                }
            }
            List<SaleProductRelatedInfo> saleProductRelatedInfoList = saleProductMapper.listSaleProducts(saleProductQuery);
            if (!ObjectUtils.isNullOrEmpty(saleProductRelatedInfoList)) {
                for (SaleProductRelatedInfo spri : saleProductRelatedInfoList) {
                    SaleProductAppDto spDto = new SaleProductAppDto();
                    ObjectUtils.fastCopy(spri, spDto);
                    spDto.setStoreId(storeProfileProxyDto.getStoreId());
                    spDto.setStoreName(storeProfileProxyDto.getStoreName());
                    spDto.setStoreType(storeProfileProxyDto.getStoreType());
                    String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            spDto.getStoreType());
                    spDto.setStoreTypeName(typeName);
                    // 设置附属属性
                    setSaleProductProfileInfo(spDto, spri.getId(), saleProductQuery.getSaleStatus(),
                            saleProductQuery.getChannelCode());

                    // 设置品牌
                    setSaleProductBrandInfo(spDto, spri.getBrandCode());

                    // 设置图片地址
                    setSaleProductImageInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                    // 设置价格
                    setSaleProductPriceInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());
                    // 设置商品分类
                    setSaleProductClassInfo(spDto, spri.getProductClassCode());
                    saleProductAppDtoList.add(spDto);
                }
                // 设置商品库存
                setSaleProductInventoryInfos(saleProductAppDtoList);
            }
            return saleProductAppDtoList;
        } catch (Exception e) {
            logger.error("listSaleProducts异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SaleProductAppDto loadSaleProductByStoreIdAndBarCode(Integer storeId, String barCode, String channelCode)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId) || ObjectUtils.isNullOrEmpty(barCode)) {
                return null;
            }
            Integer usedStoreId = storeId;
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(usedStoreId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                return null;
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndBarCode(usedStoreId, barCode);
            if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                return null;
            }
            SaleProductAppDto saleProductAppDto = new SaleProductAppDto();
            ObjectUtils.fastCopy(saleProduct, saleProductAppDto);
            saleProductAppDto.setStoreId(storeProfileProxyDto.getStoreId());
            saleProductAppDto.setStoreName(storeProfileProxyDto.getStoreName());
            saleProductAppDto.setStoreType(storeProfileProxyDto.getStoreType());
            String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                    saleProductAppDto.getStoreType());
            saleProductAppDto.setStoreTypeName(typeName);
            // 设置附属属性
            setSaleProductProfileInfo(saleProductAppDto, saleProductAppDto.getId(), null, channelCode);

            // 设置品牌
            setSaleProductBrandInfo(saleProductAppDto, saleProductAppDto.getBrandCode());

            // 设置图片地址
            setSaleProductImageInfo(saleProductAppDto, saleProductAppDto.getId(), channelCode);

            // 设置价格
            setSaleProductPriceInfo(saleProductAppDto, saleProductAppDto.getId(), channelCode);
            // 设置商品库存
            setSaleProductInventoryInfo(saleProductAppDto, saleProductAppDto.getId());
            return saleProductAppDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductsByFloorId(SaleProductQuery saleProductQuery)
            throws ProductServiceException {
        try {
            // 简单处理小区ID和店铺ID请求参数,当两个都有值时,不校验小区ID和店铺ID的对应关系是否合法,直接以店铺ID为值
            // 店铺关闭营业依然返回商品列表
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(saleProductQuery.getStoreId())) {
                storeProfileProxyDto = storeProfileProxyService.loadByCommunityId(saleProductQuery.getCommunityId(), null);
            } else {
                storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductQuery.getStoreId());
            }
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("找不到店铺信息");
                return Collections.emptyList();
            }
            List<FloorProductDto> floorProductDtoList = floorProductService.listByFloorId(saleProductQuery.getFloorId());
            if (ObjectUtils.isNullOrEmpty(floorProductDtoList)) {
                return Collections.emptyList();
            }
            Integer storeId = storeProfileProxyDto.getStoreId();
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                storeId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (FloorProductDto floorProductDto : floorProductDtoList) {
                SaleProduct saleProduct = saleProductMapper.loadByProductIdAndStoreIdEnabledFlag(
                        floorProductDto.getProductId(), storeId, saleProductQuery.getEnabledFlag(),
                        saleProductQuery.getSaleStatus());
                if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                    continue;

                }
                ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(
                        saleProduct.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                if (ObjectUtils.isNullOrEmpty(productClassDto)
                        || SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_NO.equals(productClassDto.getDisplay())) {
                    continue;
                }
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtos = new ArrayList<SaleProductAppDto>();
            for (SaleProduct spri : saleProductList) {
                SaleProductAppDto spDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(spri, spDto);
                spDto.setStoreId(storeProfileProxyDto.getStoreId());
                spDto.setStoreName(storeProfileProxyDto.getStoreName());
                spDto.setStoreType(storeProfileProxyDto.getStoreType());
                String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                        spDto.getStoreType());
                spDto.setStoreTypeName(typeName);
                // 设置附属属性
                setSaleProductProfileInfo(spDto, spri.getId(), saleProductQuery.getSaleStatus(),
                        saleProductQuery.getChannelCode());

                // 设置品牌
                setSaleProductBrandInfo(spDto, spri.getBrandCode());

                // 设置图片地址
                setSaleProductImageInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                // 设置价格
                setSaleProductPriceInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                saleProductAppDtos.add(spDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtos);
            return saleProductAppDtos;
        } catch (Exception e) {
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SaleProductAppDto> listSaleProductsByTypeCode(SaleProductQuery saleProductQuery)
            throws ProductServiceException {
        try {
            // 店铺关闭营业依然返回商品列表
            StoreProfileProxyDto storeProfileProxyDto = null;
            storeProfileProxyDto = storeProfileProxyService.loadByStoreId(saleProductQuery.getStoreId());
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                logger.info("找不到店铺信息");
                return Collections.emptyList();
            }
            List<SaleZoneDto> saleZoneDtoList = saleZoneService.listByTypeCode(saleProductQuery.getTypeCode());
            if (ObjectUtils.isNullOrEmpty(saleZoneDtoList)) {
                return Collections.emptyList();
            }
            Integer storeId = storeProfileProxyDto.getStoreId();
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                storeId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            List<SaleProduct> saleProductList = new ArrayList<SaleProduct>();
            for (SaleZoneDto saleZoneDto : saleZoneDtoList) {
                SaleProduct saleProduct = saleProductMapper.loadByProductIdAndStoreIdEnabledFlag(saleZoneDto.getProductId(),
                        storeId, saleProductQuery.getEnabledFlag(), saleProductQuery.getSaleStatus());
                if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                    continue;
                }
                saleProductList.add(saleProduct);
            }
            List<SaleProductAppDto> saleProductAppDtos = new ArrayList<SaleProductAppDto>();
            for (SaleProduct spri : saleProductList) {
                SaleProductAppDto spDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(spri, spDto);
                spDto.setStoreId(storeProfileProxyDto.getStoreId());
                spDto.setStoreName(storeProfileProxyDto.getStoreName());
                spDto.setStoreType(storeProfileProxyDto.getStoreType());
                String typeName = super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                        spDto.getStoreType());
                spDto.setStoreTypeName(typeName);
                // 设置附属属性
                setSaleProductProfileInfo(spDto, spri.getId(), saleProductQuery.getSaleStatus(),
                        saleProductQuery.getChannelCode());

                // 设置品牌
                setSaleProductBrandInfo(spDto, spri.getBrandCode());

                // 设置图片地址
                setSaleProductImageInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                // 设置价格
                setSaleProductPriceInfo(spDto, spri.getId(), saleProductQuery.getChannelCode());

                saleProductAppDtos.add(spDto);
            }
            // 设置商品库存
            setSaleProductInventoryInfos(saleProductAppDtos);
            return saleProductAppDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<String> listSaleProductBrandCodesByStoreId(SaleProductQuery saleProductQuery)
            throws ProductServiceException {
        if (null == saleProductQuery) {
            return Collections.emptyList();
        }
        List<String> codes = saleProductMapper.listSaleProductBrandCodesByStoreId(saleProductQuery);
        ArrayList<String> saleProductBrands = null;
        // 过滤品牌codes
        if (!ObjectUtils.isNullOrEmpty(codes)) {
            HashSet<String> set = new HashSet<String>(codes);
            saleProductBrands = new ArrayList<String>(set);
        }
        return saleProductBrands;
    }

    @Override
    public List<Integer> listStoreIdsByProductId(SaleProductQuery saleProductQuery) throws ProductServiceException {
        // TODO Auto-generated method stub
        if (null == saleProductQuery) {
            return Collections.emptyList();
        }
        List<Integer> storeIds = saleProductMapper.listStoreIdsByProductId(saleProductQuery);
        return storeIds;
    }

    @Override
    public SaleProductDto loadSaleProductInfoByStoreIdAndBarCode(Integer storeId, String storeName, String barCode,
            String saleProductName) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId) || StringUtils.isEmpty(barCode) || StringUtils.isEmpty(storeName)
                    || StringUtils.isEmpty(saleProductName)) {
                return null;
            }
            Integer usedStoreId = storeId;
            StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(usedStoreId);
            if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
                return null;
            } else if (!storeName.equals(storeProfileProxyDto.getStoreName())) {
                return null;
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
                usedStoreId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            }
            SaleProduct saleProduct = saleProductMapper.loadSaleProductBasicInfoByStoreIdAndBarCode(usedStoreId, barCode);
            if (ObjectUtils.isNullOrEmpty(saleProduct)) {
                return null;
            } else if (!saleProductName.equals(saleProduct.getSaleProductName())) {
                return null;
            }
            SaleProductDto saleProductDto = new SaleProductDto();
            ObjectUtils.fastCopy(saleProduct, saleProductDto);
            return saleProductDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateBatchRemainCountById(List<KeyValuePair<Integer, Integer>> saleProductRemainCountKeys, Integer userId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductRemainCountKeys)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new ProductServiceException("操作用户ID不能为空");
            }
            Map<Integer, Integer> sortedMap = new TreeMap<Integer, Integer>();
            for (KeyValuePair<Integer, Integer> saleProductIdAndRemainCountDeltaKey : saleProductRemainCountKeys) {
                if (ObjectUtils.isNullOrEmpty(saleProductIdAndRemainCountDeltaKey.getKey())
                        || ArithUtils.converIntegerToInt(saleProductIdAndRemainCountDeltaKey.getValue()) == 0) {
                    throw new ProductServiceException("商品库存参数不合法");
                }
                sortedMap.put(saleProductIdAndRemainCountDeltaKey.getKey(), saleProductIdAndRemainCountDeltaKey.getValue());
            }
            Date nowTime = new Date();
            for (Integer saleProductId : sortedMap.keySet()) {
                Integer effectCount = saleProductMapper.updateRemainCountById(saleProductId, sortedMap.get(saleProductId),
                        nowTime, userId);
                if (ArithUtils.converIntegerToInt(effectCount) != 1) {
                    throw new ProductServiceException("修改商品冗余库存字段异常");
                }
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public SaleProductAppDto loadByStoreIdAndProductId(Integer storeId, Integer productId) throws ProductServiceException {
        try {
            SaleProduct saleProduct = saleProductMapper.loadByStoreIdAndProductId(storeId, productId);
            SaleProductAppDto saleProductAppDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
                saleProductAppDto = new SaleProductAppDto();
                ObjectUtils.fastCopy(saleProduct, saleProductAppDto);
            }
            return saleProductAppDto;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new ProductServiceException(e.getMessage());
        }
    }
}
