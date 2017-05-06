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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.ProductMapper;
import com.yilidi.o2o.product.model.Product;
import com.yilidi.o2o.product.model.combination.ProductRelatedInfo;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductImageService;
import com.yilidi.o2o.product.service.IProductPriceService;
import com.yilidi.o2o.product.service.IProductProfileService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.IProductTempService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductImageProfileDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.ProductTempDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:产品服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productService")
public class ProductServiceImpl extends BasicDataService implements IProductService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private IProductProfileService productProfileService;
    @Autowired
    private IProductClassService productClassService;
    @Autowired
    private IProductPriceService productPriceService;
    @Autowired
    private IProductImageService productImageService;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private IProductBrandService productBrandService;
    @Autowired
    private IProductTempService productTempService;

    @Override
    public String saveProduct(ProductDto saveProductDto, String channelCode) throws ProductServiceException {
        logger.debug("saveProductDto -> " + saveProductDto + "channelCode -> " + channelCode);
        try {
            // 检查产品信息参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto)) {
                logger.error("ProductService.saveProductDto => 保存产品信息参数为空");
                throw new ProductServiceException("保存产品信息参数为空");
            }
            // 检查产品渠道编码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 产品条形码参数是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto.getBarCode())) {
                logger.error("saveProductDto.barCode => 产品条形码参数barCode为空");
                throw new ProductServiceException("产品条形码参数barCode为空");
            }
            // 检查产品创建的用户ID是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto.getCreateUserId())) {
                logger.error("ProductService.saveProductDto.createUserId => 产品创建的用户ID为空");
                throw new ProductServiceException("产品创建的用户ID为空");
            }
            // 检查产品创建时间是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto.getCreateTime())) {
                logger.error("ProductService.saveProductDto.createTime => 产品创建时间为空");
                throw new ProductServiceException("产品创建时间为空");
            }
            // 检查产品分类是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto.getProductClassCode())) {
                logger.error("ProductService.saveProductDto.createTime => 产品分类为空");
                throw new ProductServiceException("请选择产品分类");
            }
            // 检查产品类别是否是最低一级的
            if (!ObjectUtils.isNullOrEmpty(productClassService.getAllNextProductClassByUpCode(new ProductClassQuery(
                    saveProductDto.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)))) {
                logger.error("ProductService.saveProductDto.getProductClassCode => 产品没有挂载最低级的类别上");
                throw new ProductServiceException("产品类别就不是最低一级的类别");
            }
            // 保存产品基础信息
            String errorString = this.saveProductBasicInfo(saveProductDto);
            // 保存产品附加信息
            // 错误信息为空才保存产品其他信息
            if (ObjectUtils.isNullOrEmpty(errorString)) {
                ProductProfileDto productProfileDto = saveProductDto.getProductProfileDto();
                productProfileDto.setProductId(saveProductDto.getId());
                productProfileDto.setChannelCode(channelCode);
                productProfileDto.setContent(saveProductDto.getContentString());
                productProfileDto.setCreateUserId(saveProductDto.getCreateUserId());
                productProfileDto.setCreateTime(saveProductDto.getCreateTime());
                productProfileService.saveProductProfile(productProfileDto);
                
                // 保存产品价格信息
                ProductPriceDto productPriceDto = saveProductDto.getProductPriceDto();
                productPriceDto.setProductId(saveProductDto.getId());
                productPriceDto.setChannelCode(channelCode);
                productPriceDto.setCreateUserId(saveProductDto.getCreateUserId());
                productPriceDto.setCreateTime(saveProductDto.getCreateTime());
                productPriceService.saveProductPrice(productPriceDto);
                // 保存产品图片信息
                // 封装前台传过来的图片信息列表
                // 如果是手动发布的则进一步封装图片Dto信息，如果是从其他渠道添加到标准库的，前台已经封装好的不需要二次封装
                List<ProductImageDto> listProductImageDto = null;
                if (!ObjectUtils.isNullOrEmpty(saveProductDto.getAppIsMainPic())) {
                    listProductImageDto = listProductImageDto(saveProductDto);
                } else {
                    listProductImageDto = saveProductDto.getProductImageDtos();
                }
                if (!ObjectUtils.isNullOrEmpty(listProductImageDto)) {
                    for (ProductImageDto productImageDto : listProductImageDto) {
                        productImageDto.setProductId(saveProductDto.getId());
                        productImageDto.setChannelCode(channelCode);
                        productImageDto.setCreateUserId(saveProductDto.getCreateUserId());
                        productImageDto.setCreateTime(saveProductDto.getCreateTime());
                    }
                    productImageService.saveProductImages(listProductImageDto);

                    // 保存图片之后将图片上传到正式服务器
                    operateProductImage(listProductImageDto, saveProductDto.getDeleteImageUrls());
                    this.operateContentImage(saveProductDto.getLoadContentImageUrls(), saveProductDto.getAddContentImageUrls());
                }
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("保存产品出错");
            throw new ProductServiceException("异常：保存产品出错");
        }
    }

    // 增加产品图片到正式服务器
    private void operateProductImage(List<ProductImageDto> listProductImageDto, String delImageUrls)
            throws ProductServiceException {
        try {
            // 产品类别保存成功之后，处理产品类别临时图片
            // 产品类别图片标示不为空并且其为增加，将图片更新到正式的环境
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(listProductImageDto)) {
                for (ProductImageDto productImageDto : listProductImageDto) {
                    if (!ObjectUtils.isNullOrEmpty(productImageDto.getAppImageFlag())
                            && IMAGEFLAG_YES.equals(productImageDto.getAppImageFlag())) {
                        fileUploadUtils.uploadPublishFile(productImageDto.getImageUrl());
                    }
                }
            }

            if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
                if (!delImageUrls.contains(",")) {
                    fileUploadUtils.deletePublishFile(delImageUrls);
                } else {
                    String[] arrParam = delImageUrls.split(",");
                    for (String imageUrl : arrParam) {
                        if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                            fileUploadUtils.deletePublishFile(imageUrl);
                        }
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("增加产品图片到正式服务器出错！");
            throw new ProductServiceException("异常：增加产品图片到正式服务器出错！");
        }
    }

    // 增加详情图片到正式服务器
    private void operateContentImage(String loadContentImageUrls, String addContentImageUrls)
            throws ProductServiceException {
        try {
            List<String> delImageUrls = this.getDelImageUrls(loadContentImageUrls, addContentImageUrls);
            List<String> addImageUrls = this.getAddImageUrls(loadContentImageUrls, addContentImageUrls);
            // 产品保存成功之后，处理产品临时图片
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
            logger.error("增加和删除产品图片到正式服务器出错！");
            throw new ProductServiceException("异常：增加和删除产品图片到正式服务器出错！");
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

    @Override
    public void updateProduct(ProductDto updateProductDto, String channelCode) {
        logger.debug("updateProductDto -> " + updateProductDto);
        // 检查产品参数对象是否为空
        try {
            if (ObjectUtils.isNullOrEmpty(updateProductDto)) {
                logger.error("ProductService.updateProductDto => 产品参数为空");
                throw new ProductServiceException("需要更新的产品参数实体为空");
            }
            // 检查产品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto.getId())) {
                logger.error("ProductService.updateProductDto.id => 产品ID为空");
                throw new ProductServiceException("产品ID为空");
            }
            // 检查产品更新的用户ID是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto.getModifyUserId())) {
                logger.error("ProductService.updateProductDto.modifyUserId => 产品更新的用户ID为空");
                throw new ProductServiceException("产品更新的用户ID为空");
            }
            // 检查产品更新modifyTime是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto.getModifyTime())) {
                logger.error("ProductService.updateProductDto.modifyTime => 产品更新时间为空");
                throw new ProductServiceException("产品更新时间为空");
            }
            // 检查产品类别是否是最低一级的
            if (!ObjectUtils.isNullOrEmpty(updateProductDto.getProductClassCode())) {
                if (!ObjectUtils.isNullOrEmpty(productClassService.getAllNextProductClassByUpCode(new ProductClassQuery(
                        updateProductDto.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)))) {
                    logger.error("ProductService.saveProductDto.getProductClassCode => 产品没有挂载最低级的类别上");
                    throw new ProductServiceException("产品类别不是最低一级的类别");
                }
            }
            // 产品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 需要更新的产品
            if (!ObjectUtils.isNullOrEmpty(updateProductDto.getId())) {
                // 更新产品基础信息
                this.updateProductBasicInfo(updateProductDto);
                // 更新产品图片信息
                List<ProductImageDto> listProductImageDto = updateProductDto.getProductImageDtos();//从终审带来的list参数
                //List<ProductImageDto> listProductImageDto =listProductImageDto(updateProductDto);
                // 检查产品图片信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(listProductImageDto)) {
                    for (ProductImageDto productImageDto : listProductImageDto) {
                        productImageDto.setProductId(updateProductDto.getId());
                        productImageDto.setModifyUserId(updateProductDto.getModifyUserId());
                        productImageDto.setModifyTime(updateProductDto.getModifyTime());
                        productImageDto.setChannelCode(channelCode);
                    }
                    productImageService.updateProductImages(listProductImageDto);
                }
                // 删除数据库里图片信息
                if (!ObjectUtils.isNullOrEmpty(updateProductDto.getDeleteImageUrls())) {
                    if (!updateProductDto.getDeleteImageUrls().contains(",")) {
                        String ext = this.getExtensionName(updateProductDto.getDeleteImageUrls()).replace(".", "");
                        String imageUrl1 = updateProductDto.getDeleteImageUrls().replaceAll("\\." + ext, "\\_1." + ext);
                        productImageService.deleteProductImageByImageUrl1(imageUrl1);
                    } else {
                        String[] arrParam = updateProductDto.getDeleteImageUrls().split(",");
                        for (String imageUrl : arrParam) {
                            if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                                String ext = this.getExtensionName(imageUrl).replace(".", "");
                                String imageUrl1 = imageUrl.replaceAll("\\." + ext, "\\_1." + ext);
                                productImageService.deleteProductImageByImageUrl1(imageUrl1);
                            }
                        }
                    }
                }
                // 更新产品附属信息
                // 检查产品附属信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(updateProductDto.getProductProfileDto())) {
                    ProductProfileDto productProfileDto = updateProductDto.getProductProfileDto();
                    productProfileDto.setProductId(updateProductDto.getId());
                    productProfileDto.setContent(updateProductDto.getContentString());
                    productProfileDto.setModifyUserId(updateProductDto.getModifyUserId());
                    productProfileDto.setModifyTime(updateProductDto.getModifyTime());
                    productProfileDto.setChannelCode(channelCode);
                    productProfileService.updateProductProfile(updateProductDto.getProductProfileDto());
                    this.operateContentImage(updateProductDto.getLoadContentImageUrls(),
                            updateProductDto.getAddContentImageUrls());
                }
                // 更新产品价格
                // 检查产品价格信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(updateProductDto.getProductPriceDto())) {
                    ProductPriceDto productPriceDto = updateProductDto.getProductPriceDto();
                    productPriceDto.setProductId(updateProductDto.getId());
                    productPriceDto.setModifyUserId(updateProductDto.getModifyUserId());
                    productPriceDto.setModifyTime(updateProductDto.getModifyTime());
                    productPriceDto.setChannelCode(channelCode);
                    productPriceService.updateProductPrice(productPriceDto);
                }
                // 更新正式服务器上的图片
                this.operateProductImage(listProductImageDto, updateProductDto.getDeleteImageUrls());
            }
        } catch (ProductServiceException e) {
            logger.error("更新产品出错", e);
            throw new ProductServiceException("异常：更新产品出错");
        }
    }

    /**
     * 
     * @Description TODO(获取文件的后缀名)
     * @param filename
     * @return String
     */
    private String getExtensionName(String filename) {
        String ext = "";
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot >= 0) && (dot < (filename.length() - 1))) {
                ext = filename.substring(dot);
            }
        }
        return ext;
    }

    // 封装前台传过来的图片列表数据
    private List<ProductImageDto> listProductImageDto(ProductDto productDto) {
        List<ProductImageDto> listProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                // 保存图片
                // 封装产品图片
                listProductImageDto = new ArrayList<ProductImageDto>();
                if (!ObjectUtils.isNullOrEmpty(productDto.getFirstAppImageProfileDto())) {
                    ProductImageProfileDto profileDto1 = productDto.getFirstAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto1);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getSecondAppImageProfileDto())) {
                    ProductImageProfileDto profileDto2 = productDto.getSecondAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto2);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getThirdAppImageProfileDto())) {
                    ProductImageProfileDto profileDto3 = productDto.getThirdAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto3);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getFouthAppImageProfileDto())) {
                    ProductImageProfileDto profileDto4 = productDto.getFouthAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto4);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getFiveAppImageProfileDto())) {
                    ProductImageProfileDto profileDto5 = productDto.getFiveAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto5);
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getSixAppImageProfileDto())) {
                    ProductImageProfileDto profileDto6 = productDto.getSixAppImageProfileDto();
                    addProductImageDto(listProductImageDto, productDto, profileDto6);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传输的图片列表信息出错");
            throw new ProductServiceException("异常：封装前台传输的图片列表信息出错");
        }

        return listProductImageDto;
    }

    // 封装前台传过来的图片Dto
    private void addProductImageDto(List<ProductImageDto> listProductImageDto, ProductDto productDto,
            ProductImageProfileDto profileDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                ProductImageDto productImageDto = pakageProductImageDto(productDto, profileDto);
                if (!ObjectUtils.isNullOrEmpty(productImageDto)) {
                    listProductImageDto.add(productImageDto);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传过来的图片Dto");
            throw new ProductServiceException("封装前台传过来的图片Dto");
        }
    }

    // 封装前台传过来的图片列表数据
    private ProductImageDto pakageProductImageDto(ProductDto productDto, ProductImageProfileDto profileDto) {
        ProductImageDto productImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicPath())) {
                // 保存图片
                // 封装产品单张图片
                productImageDto = new ProductImageDto();
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicId())) {
                    productImageDto.setId(profileDto.getAppPicId());
                }
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicOrder())) {
                    productImageDto.setImageOrder(profileDto.getAppPicOrder());
                }
                productImageDto.setImageUrl(profileDto.getAppPicPath());
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppImageFlag())) {
                    productImageDto.setAppImageFlag(profileDto.getAppImageFlag());
                }
                if (!ObjectUtils.isNullOrEmpty(productDto.getAppIsMainPic())
                        && profileDto.getAppPicSort().intValue() == productDto.getAppIsMainPic().intValue()) {
                    productImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES);
                } else {
                    productImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_NO);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传输单张图片信息出错");
            throw new ProductServiceException("异常：封装前台传输单张图片信息出错");
        }

        return productImageDto;
    }

    // 更新产品基础信息
    private void updateProductBasicInfo(ProductDto updateProductDto) {
        logger.debug("updateProductBasicInfo -> " + updateProductDto);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto)) {
                logger.error("updateProductBasicInfo.updateProductDto => 产品参数为空");
                throw new ProductServiceException("更新产品参数为空");
            }
            // 判断产品修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto.getModifyTime())) {
                logger.error("updateProductDto.modifyTime => 产品修改时间参数为空");
                throw new ProductServiceException("异常：产品修改时间参数为空");
            }
            // 判断产品modifyUserId是否为空
            if (ObjectUtils.isNullOrEmpty(updateProductDto.getModifyUserId())) {
                logger.error("updateProductDto.modifyUserId => 产品modifyUserId参数为空");
                throw new ProductServiceException("异常：产品modifyUserId参数为空");
            }
            // 判断产品ID是否为空
            if (!ObjectUtils.isNullOrEmpty(updateProductDto.getId())) {
                // 更新产品基础信息开始
                Product product = null;
                ProductDto productDto = this.loadProductBasicInfoByProductId(updateProductDto.getId());
                if (ObjectUtils.whetherModified(productDto.getProductName(), updateProductDto.getProductName())
                        || ObjectUtils.whetherModified(productDto.getProductClassCode(),
                                updateProductDto.getProductClassCode())
                        || ObjectUtils.whetherModified(productDto.getBrandName(), updateProductDto.getBrandName())) {
                    product = new Product();
                    ObjectUtils.fastCopy(productDto, product);
                    product.setProductClassCode(updateProductDto.getProductClassCode());
                    // 检查产品品牌
                    // 检查产品品牌
                    if (!ObjectUtils.isNullOrEmpty(updateProductDto.getBrandName())) {
                        ProductBrandDto productBrandDto = productBrandService
                                .getBrandByName(updateProductDto.getBrandName().trim());
                        if (!ObjectUtils.isNullOrEmpty(productBrandDto) && productBrandDto.getStatusCode().equals(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON)) {
                            product.setBrandCode(productBrandDto.getBrandCode());
                        } else {
                            logger.error("updateProductDto.modifyTime => 无此品牌");
                            throw new ProductServiceException("异常：无此品牌");
                        }
                    } else {
                        product.setBrandCode(updateProductDto.getBrandCode());
                    }
                    product.setBarCode(product.getBarCode());
                    product.setProductName(updateProductDto.getProductName());
                    product.setStatusCode(product.getStatusCode());
                    product.setModifyUserId(updateProductDto.getModifyUserId());
                    product.setModifyTime(updateProductDto.getModifyTime());
                    productMapper.updateProductBasicInfoById(product);
                    updateProductDto.setId(product.getId());
                }
            }
        } catch (ProductServiceException e) {
            logger.error("更新产品基础信息出错");
            throw new ProductServiceException("异常：更新产品基础信息出错");
        }
    }

    // 保存产品基础信息
    private String saveProductBasicInfo(ProductDto saveProductDto) {
        logger.debug("saveProductBasicInfo -> " + saveProductDto);
        // 保存产品基础信息开始
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto)) {
                logger.error("ProductService.saveProductDto => 产品参数为空");
                throw new ProductServiceException("产品参数为空");
            }
            // 产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(saveProductDto.getBarCode())) {
                logger.error("saveProductDto.barCode => 产品条形码参数为空");
                throw new ProductServiceException("产品条形码参数为空");
            }
            // 判断产品是否是重复添加
            ProductDto productDtoLoad = this.loadProductBasicInfoByBarCode(saveProductDto.getBarCode());
            String errorString = "";
            if (!ObjectUtils.isNullOrEmpty(productDtoLoad)) {
                errorString = "产品'" + productDtoLoad.getProductName() + "'已经存在，产品条形码为：" + productDtoLoad.getBarCode();
            } else {
                // 判断产品类别参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductDto.getProductClassCode())) {
                    logger.error("saveProductDto.productClassCode => 产品类别参数为空");
                    throw new ProductServiceException("产品类别参数为空");
                }
                // 产品品牌编码参数是否为空
                // if (ObjectUtils.isNullOrEmpty(saveProductDto.getBrandCode())) {
                // logger.error("saveProductDto.brandCode => 产品品牌编码参数为空");
                // throw new ProductServiceException("产品品牌编码参数为空");
                // }
                // 产品名称是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductDto.getProductName())) {
                    logger.error("saveProductDto.productName => 产品名称参数为空");
                    throw new ProductServiceException("产品名称参数为空");
                }
                // 产品createUserId是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductDto.getCreateUserId())) {
                    logger.error("saveProductDto.createUserId => 产品createUserId参数为空");
                    throw new ProductServiceException("产品createUserId参数为空");
                }
                // 产品createTime是否为空
                if (ObjectUtils.isNullOrEmpty(saveProductDto.getCreateTime())) {
                    logger.error("saveProductDto.createTime => 产品createTime参数为空");
                    throw new ProductServiceException("产品createTime参数为空");
                }
                Product product = new Product();
                // 检查产品品牌
                if (!ObjectUtils.isNullOrEmpty(saveProductDto.getBrandName())) {
                    ProductBrandDto productBrandDto = productBrandService
                            .getBrandByName(saveProductDto.getBrandName().trim());
                    if (!ObjectUtils.isNullOrEmpty(productBrandDto) && productBrandDto.getStatusCode().equals(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON)) {
                        product.setBrandCode(productBrandDto.getBrandCode());
                    } else {
                        logger.error("updateProductDto.modifyTime => 无此品牌");
                        throw new ProductServiceException("异常：无此品牌");
                    }
                } else {
                    product.setBrandCode(saveProductDto.getBrandCode());
                }
                product.setProductClassCode(saveProductDto.getProductClassCode());
                product.setProductName(saveProductDto.getProductName());
                product.setBarCode(saveProductDto.getBarCode());
                product.setStatusCode(saveProductDto.getStatusCode());
                product.setCreateUserId(saveProductDto.getCreateUserId());
                product.setCreateTime(saveProductDto.getCreateTime());
                productMapper.saveProductBasicInfo(product);
                saveProductDto.setId(product.getId());
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("保存产品基础信息出错");
            throw new ProductServiceException("异常：保存产品基础信息出错");
        }
    }

    private ProductDto loadProductBasicInfoByBarCode(String barCode) throws ProductServiceException {
        ProductDto productDto = null;
        logger.debug("loadProductByBarCode -> " + barCode);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.loadProductByProductId => 产品Id参数为空");
                throw new ProductServiceException("产品Id参数为空");
            }
            Product product = productMapper.loadProductBasicInfoByBarCode(barCode);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(product)) {
                productDto = new ProductDto();
                ObjectUtils.fastCopy(product, productDto);

            }
        } catch (ProductServiceException e) {
            logger.error("查询产品基础信息出错");
            throw new ProductServiceException("异常：查询产品基础信息出错");
        }
        return productDto;
    }

    @Override
    public ProductDto loadProductByProductIdAndChannelCode(Integer productId, String channelCode)
            throws ProductServiceException {
        ProductDto productDto = null;
        try {
            // 查询产品的基础信息
            productDto = this.loadProductBasicInfoByProductId(productId);
            // 查询产品的附加信息
            ProductProfileDto productProfileDto = productProfileService
                    .loadProductProfileByProductIdAndChannelCode(productId, channelCode);
            // 产品附加信息是否为空
            if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                productDto.setProductProfileDto(productProfileDto);
            }
            // 查询产品价格信息
            ProductPriceDto productPriceDto = productPriceService.loadProductPriceByProductIdAndChannelCode(productId,
                    channelCode);
            // 产品价格信息是否为空
            if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                productDto.setProductPriceDto(productPriceDto);
            }
            // 查询产品图片信息
            List<ProductImageDto> productImageDtos = productImageService
                    .listProductImagesByProductIdAndChannelCode(productId, channelCode);
            // 产品图片信息是否为空
            if (!ObjectUtils.isNullOrEmpty(productImageDtos)) {
                productDto.setProductImageDtos(productImageDtos);
            }
        } catch (ProductServiceException e) {
            logger.error("按照产品Id和渠道编码查询产品信息出错");
            throw new ProductServiceException("异常：按照产品Id和渠道编码查询产品信息出错");
        }
        return productDto;
    }

    @Override
    public ProductDto loadProductByBarCodeAndChannelCode(String barCode, String channelCode) throws ProductServiceException {
        ProductDto productDto = null;
        logger.debug("loadProductByBarCode -> " + barCode);
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.loadProductByBarCodeAndChannelCode => 产品Id参数为空");
                throw new ProductServiceException("产品Id参数为空");
            }
            Product product = productMapper.loadProductBasicInfoByBarCode(barCode);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(product)) {
                productDto = new ProductDto();
                ObjectUtils.fastCopy(product, productDto);

                // 查询产品的附加信息
                ProductProfileDto productProfileDto = productProfileService
                        .loadProductProfileByProductIdAndChannelCode(product.getId(), channelCode);
                // 产品附加信息是否为空
                if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                    productDto.setProductProfileDto(productProfileDto);
                }
                // 查询产品价格信息
                ProductPriceDto productPriceDto = productPriceService
                        .loadProductPriceByProductIdAndChannelCode(product.getId(), channelCode);
                // 产品价格信息是否为空
                if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                    productDto.setProductPriceDto(productPriceDto);
                }
                // 查询产品图片信息
                List<ProductImageDto> productImageDtos = productImageService
                        .listProductImagesByProductIdAndChannelCode(product.getId(), channelCode);
                // 产品图片信息是否为空
                if (!ObjectUtils.isNullOrEmpty(productImageDtos)) {
                    productDto.setProductImageDtos(productImageDtos);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("查询产品基础信息出错");
            throw new ProductServiceException("异常：查询产品基础信息出错");
        }
        return productDto;
    }

    // 根据产品Id查询产品基本信息
    private ProductDto loadProductBasicInfoByProductId(Integer id) throws ProductServiceException {
        logger.debug("loadProductByProductId -> " + id);
        // 检查产品参数对象是否为空
        ProductDto productBasicInfo = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductService.loadProductByProductId => 产品Id参数为空");
                throw new ProductServiceException("产品Id参数为空");
            }
            Product product = productMapper.loadProductBasicInfoById(id);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(product)) {
                productBasicInfo = new ProductDto();
                ObjectUtils.fastCopy(product, productBasicInfo);
                // 根据品牌id获取name
                ProductBrandDto productBrandDto = productBrandService.getBrandByCode(productBasicInfo.getBrandCode());
                if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
                    productBasicInfo.setBrandName(productBrandDto.getBrandName().trim());
                }
            }
        } catch (ProductServiceException e) {
            logger.error("查询产品基础信息出错");
            throw new ProductServiceException("异常：查询产品基础信息出错");
        }
        return productBasicInfo;
    }

    @Override
    public void batchSaveProduct(List<ProductDto> saveProductDtos, String channelCode) throws ProductServiceException {
        logger.debug("saveProductDtos -> " + saveProductDtos);
        // 检查产品渠道编码参数对象是否为空
        if (ObjectUtils.isNullOrEmpty(channelCode)) {
            channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
        }
        // 检查产品参数对象是否为空
        if (ObjectUtils.isNullOrEmpty(saveProductDtos)) {
            logger.error("ProductService.batchSaveProduct => 产品列表参数为空");
            throw new ProductServiceException("产品列表参数为空");
        }
        try {
            for (ProductDto productDto : saveProductDtos) {
                if (ObjectUtils.isNullOrEmpty(productDto)) {
                    logger.error("ProductService.batchSaveProduct => 产品参数productDto为空");
                    throw new ProductServiceException("产品参数productDto为空");
                }
                saveProduct(productDto, channelCode);
            }
        } catch (ProductServiceException e) {
            logger.error("批量保存产品出错");
            throw new ProductServiceException("异常：批量保存产品出错");
        }
    }

    @Override
    public boolean updateProductStatusById(Integer productId, String statusCode, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException {

        logger.debug("productId -> " + productId + "statusCode -> " + statusCode);
        boolean updateFlag = false;
        try {
            // 检查产品参数productId是否为空
            if (ObjectUtils.isNullOrEmpty(productId)) {
                logger.error("ProductService.updateProductStatusById => 产品参数产品productId为空");
                throw new ProductServiceException("产品参数产品productId为空");
            }
            // 检查产品参数statusCode是否为空
            if (ObjectUtils.isNullOrEmpty(statusCode)) {
                logger.error("ProductService.updateProductStatusById => 参数产品statusCode为空");
                throw new ProductServiceException("参数产品statusCode为空");
            }
            // 检查产品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateProductClassDto.modifyUserId=> 产品类别修改人为空");
                throw new ProductServiceException("ProductService的updateProductClass.modifyUserId方法参数modifyUserId为空");
            }
            // 检查产品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateProductClassDto.modifyTime => 产品类别修改时间为空");
                throw new ProductServiceException("ProductService的updateProductClass方法参数modifyTime为空");
            }
            productMapper.updateStatusCodeById(productId, statusCode, modifyTime, modifyUserId);
            updateFlag = true;
        } catch (ProductServiceException e) {
            logger.error("根据产品ID更改产品状态出错");
            throw new ProductServiceException("异常：根据产品ID更改产品状态出错");
        }

        return updateFlag;
    }

    @Override
    public YiLiDiPage<ProductDto> findProductsByBasicInfo(ProductQuery queryProduct) throws ProductServiceException {
        logger.debug("queryProduct -> " + queryProduct);
        try {
            if (ObjectUtils.isNullOrEmpty(queryProduct)) {
                logger.error("productMapper.listProductsByBasicInfo.queryProduct => 按条件查询的产品queryProduct为空");
                throw new ProductServiceException("按条件查询的产品queryProduct为空");
            }
            if (ObjectUtils.isNullOrEmpty(queryProduct.getChannelCode())) {
                logger.error("productMapper.listProductsByBasicInfo.channelCode => 按条件查询的产品channelCode为空");
                throw new ProductServiceException("按条件查询的产品channelCode为空");
            }
            if (null == queryProduct.getStart() || queryProduct.getStart() <= 0) {
                queryProduct.setStart(1);
            }
            if (null == queryProduct.getPageSize() || queryProduct.getPageSize() <= 0) {
                queryProduct.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(queryProduct.getStart(), queryProduct.getPageSize());
            Page<Product> page = productMapper.findProductsByBasicInfo(queryProduct);
            Page<ProductDto> pageDto = new Page<ProductDto>(queryProduct.getStart(), queryProduct.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<Product> listProductBasicInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(listProductBasicInfos)) {

                for (Product product : listProductBasicInfos) {
                    if (!ObjectUtils.isNullOrEmpty(product)) {
                        ProductDto productDto = new ProductDto();
                        ObjectUtils.fastCopy(product, productDto);
                        // 封装该产品的价格信息
                        ProductPriceDto productPriceDto = productPriceService
                                .loadProductPriceByProductIdAndChannelCode(product.getId(), queryProduct.getChannelCode());
                        if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
                            productDto.setProductPriceDto(productPriceDto);
                        }
                        // 封装该产品的附加信息
                        ProductProfileDto productProfileDto = productProfileService
                                .loadProductProfileByProductIdAndChannelCode(product.getId(), queryProduct.getChannelCode());
                        if (!ObjectUtils.isNullOrEmpty(productProfileDto)) {
                            productDto.setProductProfileDto(productProfileDto);
                        }
                        // 封装该产品的图片列表信息
                        List<ProductImageDto> productImageDtoList = productImageService
                                .listProductImagesByProductIdAndChannelCode(product.getId(), queryProduct.getChannelCode());
                        if (!ObjectUtils.isNullOrEmpty(productImageDtoList)) {
                            productDto.setProductImageDtos(productImageDtoList);
                        }
                        pageDto.add(productDto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);

        } catch (ProductServiceException e) {
            logger.error("查询产品列表出错");
            throw new ProductServiceException("异常：查询产品列表出错");
        }
    }

    @Override
    public List<ProductDto> getProductBasicInfos() throws ProductServiceException {
        try {
            List<Product> listProductBasicInfos = productMapper.getProductBasicInfos();
            List<ProductDto> listProductDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listProductBasicInfos)) {
                listProductDtos = new ArrayList<ProductDto>();
                for (Product product : listProductBasicInfos) {
                    ProductDto productDto = new ProductDto();
                    ObjectUtils.fastCopy(product, productDto);
                    listProductDtos.add(productDto);
                }
            }
            return listProductDtos;
        } catch (ProductServiceException e) {
            logger.error("查询产品列表出错");
            throw new ProductServiceException("异常：查询产品列表出错");
        }
    }

    @Override
    public YiLiDiPage<ProductDto> findProductRelativeInfos(ProductQuery queryProduct) throws ProductServiceException {
        try {
            if (null == queryProduct.getStart() || queryProduct.getStart() <= 0) {
                queryProduct.setStart(1);
            }
            if (null == queryProduct.getPageSize() || queryProduct.getPageSize() <= 0) {
                queryProduct.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(queryProduct.getStart(), queryProduct.getPageSize());
            if (!StringUtils.isEmpty(queryProduct.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(queryProduct.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	queryProduct.setClassCodes(classCodes);
                }
            }
            Page<ProductRelatedInfo> page = productMapper.findProductRelativeInfos(queryProduct);
            Page<ProductDto> pageDto = new Page<ProductDto>(queryProduct.getStart(), queryProduct.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);

            List<ProductRelatedInfo> productRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(productRelatedInfos)) {
                for (ProductRelatedInfo pri : productRelatedInfos) {
                    ProductDto pDto = new ProductDto();
                    ObjectUtils.fastCopy(pri, pDto);
                    // 上下架状态编码转换为上下架状态描述
                    pDto.setSaleStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(), pri.getSaleStatus()));
                    // 热卖状态编码转换为热卖状态描述
                    pDto.setHotSaleFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), pri.getHotSaleFlag()));
                    pageDto.add(pDto);
                }
            }

            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findProductRelativeInfos异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public boolean updateProductClass(Integer id, String productClassCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException {
        logger.debug("id -> " + id + "productClassCode -> " + productClassCode);
        boolean updateFlag = false;
        try {
            // 检查产品参数productId是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("ProductService.updateProductClass => 参数产品id为空");
                throw new ProductServiceException("参数产品Id为空");
            }
            // 检查产品参数productClassCode是否为空
            if (ObjectUtils.isNullOrEmpty(productClassCode)) {
                logger.error("ProductService.updateProductClass => 参数产品productClassCode为空");
                throw new ProductServiceException("参数产品类别为空");
            }
            // 检查产品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateProductClass.modifyUserId=> 产品类别修改人为空");
                throw new ProductServiceException("产品类别修改人为空");
            }
            // 检查产品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.updateProductClass.modifyTime => 产品类别修改时间为空");
                throw new ProductServiceException("产品类别修改时间为空");
            }
            productMapper.updateProductClassById(id, productClassCode, modifyTime, modifyUserId);
            updateFlag = true;
        } catch (ProductServiceException e) {
            logger.error("根据产品ID更改产品状态出错");
            throw new ProductServiceException("异常：根据产品ID更改产品状态出错");
        }

        return updateFlag;
    }

    @Override
    public List<ProductDto> listDataForExportProduct(ProductQuery productQuery, Long startLineNum, Integer pageSize)
            throws ProductServiceException {
        try {
            if (!StringUtils.isEmpty(productQuery.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(productQuery.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	productQuery.setClassCodes(classCodes);
                }
            }
            List<ProductRelatedInfo> products = productMapper.listDataForExportProduct(productQuery, startLineNum, pageSize);
            List<ProductDto> pDtos = new ArrayList<ProductDto>();
            if (!ObjectUtils.isNullOrEmpty(products)) {
                for (ProductRelatedInfo p : products) {
                    ProductDto pDto = new ProductDto();
                    ObjectUtils.fastCopy(p, pDto);
                    // 上下架状态编码转换为上下架状态描述
                    pDto.setSaleStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(), p.getSaleStatus()));
                    // 热卖状态编码转换为热卖状态描述
                    pDto.setHotSaleFlagName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), p.getHotSaleFlag()));
                    pDtos.add(pDto);
                }
            }
            return pDtos;
        } catch (Exception e) {
            logger.error("listDataForExportProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportProduct(ProductQuery productQuery) throws ProductServiceException {
        try {
            if (!StringUtils.isEmpty(productQuery.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(productQuery.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	productQuery.setClassCodes(classCodes);
                }
            }
            Long counts = this.productMapper.getCountsForExportProduct(productQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public boolean checkBarCodeIsExistInStandard(String barCode) throws ProductServiceException {
        try {
            // 检查产品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                logger.error("ProductService.checkBarCodeIsExistInStandard => 产品条形码参数为空");
                throw new ProductServiceException("产品条形码参数为空");
            }
            ProductDto productDto = this.loadProductBasicInfoByBarCode(barCode);
            return productDto != null;
        } catch (Exception e) {
            logger.error("checkBarCodeIsExistInStandard异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<String> saveProductTempToStandard(ProductDto productDto, Integer tempId, String channelCode,
            Integer createUserId, Date createTime) throws ProductServiceException {
        logger.debug("productDto -> " + productDto + "tempId -> " + tempId + "channelCode -> " + channelCode
                + "createUserId -> " + createUserId + "createTime -> " + createTime);
        try {
            // 检查产品图片信息是否为空
            if (ObjectUtils.isNullOrEmpty(productDto)) {
                logger.error("SaleProductService.productDto => 参数产品图片信息为空");
                throw new ProductServiceException("参数产品图片为空");
            }
            // 检查产品参数tempId是否为空
            if (ObjectUtils.isNullOrEmpty(tempId)) {
                logger.error("SaleProductService.tempId => 临时表产品Id为空");
                throw new ProductServiceException("临时表产品Id为空");
            }
            // 检查产品参数channelCode是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查产品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(createUserId)) {
                logger.error("SaleProductService.addToStandard.createUserId=> 产品创建人为空");
                throw new ProductServiceException("产品创建人为空");
            }
            // 检查产品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(createTime)) {
                logger.error("SaleProductService.addToStandard.createTime => 产品创建时间为空");
                throw new ProductServiceException("产品创建时间为空");
            }
            // 检查产品参数对象是否为空
            List<String> errorString = null;
            if (!ObjectUtils.isNullOrEmpty(productDto)) {
                errorString = new ArrayList<String>();
                ProductDto productDtoStandard = this.pakageProductTempToProductDto(productDto, tempId, createUserId,
                        createTime);
                if (!ObjectUtils.isNullOrEmpty(productDtoStandard)) {
                    String errorInfoString = this.saveProduct(productDtoStandard, channelCode);
                    if (!ObjectUtils.isNullOrEmpty(errorInfoString)) {
                        errorString.add(errorInfoString);
                    }
                }
                if (ObjectUtils.isNullOrEmpty(errorString)) {
                    productTempService.deleteProductTemp(tempId);
                }
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("产品添加到标准库出错");
            throw new ProductServiceException("异常：产品添加到标准库出错");
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
    private ProductDto pakageProductTempToProductDto(ProductDto productDto, Integer tempId, Integer createUserId,
            Date createTime) {
        ProductDto productDtoStandard = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(tempId)) {
                ProductTempDto productTempDto = productTempService.loadProductTempById(tempId);
                if (!ObjectUtils.isNullOrEmpty(productTempDto) && !ObjectUtils.isNullOrEmpty(productDto)) {
                    productDtoStandard = new ProductDto();
                    productDtoStandard.setProductClassCode(productTempDto.getProductClassCode());
                    productDtoStandard.setProductName(productTempDto.getProductName());
                    productDtoStandard.setBarCode(productTempDto.getBarCode());
                    // 默认为有效状态
                    productDtoStandard.setStatusCode(SystemContext.ProductDomain.PRODUCTSTATUS_ON);
                    productDtoStandard.setCreateTime(createTime);
                    productDtoStandard.setCreateUserId(createUserId);
                    // 详情内容相关带入到dto里，保存产品的时候service层再做处理
                    productDtoStandard.setAddContentImageUrls(productDto.getAddContentImageUrls());
                    productDtoStandard.setDeleteImageUrls(productDto.getDeleteImageUrls());
                    productDtoStandard.setContentString(productDto.getContentString());
                    // 封装产品的价格信息
                    ProductPriceDto productPriceDto = new ProductPriceDto();
                    if (!ObjectUtils.isNullOrEmpty(productTempDto.getCostPrice())) {
                        productPriceDto.setCostPrice(productTempDto.getCostPrice());
                    }
                    if (!ObjectUtils.isNullOrEmpty(productTempDto.getRetailPrice())) {
                        productPriceDto.setRetailPrice(productTempDto.getRetailPrice());
                    }
                    if (!ObjectUtils.isNullOrEmpty(productTempDto.getPromotionalPrice())) {
                        productPriceDto.setPromotionalPrice(productTempDto.getPromotionalPrice());
                    }
                    if (!ObjectUtils.isNullOrEmpty(productTempDto.getCommissionPrice())) {
                        productPriceDto.setCommissionPrice(productTempDto.getCommissionPrice());
                    }
                    if (!ObjectUtils.isNullOrEmpty(productTempDto.getVipCommissionPrice())) {
                        productPriceDto.setVipCommissionPrice(productTempDto.getVipCommissionPrice());
                    }
                    productDtoStandard.setProductPriceDto(productPriceDto);
                    // 封装产品的附属信息
                    ProductProfileDto productProfileDto = new ProductProfileDto();
                    productProfileDto.setDisplayOrder(productTempDto.getDisplayOrder());
                    productProfileDto.setHotSaleFlag(productTempDto.getHotSaleFlag());
                    productProfileDto.setSaleStatus(productTempDto.getSaleStatus());
                    productProfileDto.setProductSpec(productTempDto.getProductSpec());
                    productDtoStandard.setProductProfileDto(productProfileDto);
                    // 封装产品的图片信息
                    List<ProductImageDto> listProductImageDto = this.listProductImageDto(productDto);
                    productDtoStandard.setProductImageDtos(listProductImageDto);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("将临时产品Dto封装成产品Dto失败" + e.getMessage());
            throw new ProductServiceException("异常：将临时产品Dto封装成产品Dto出错");
        }
        return productDtoStandard;
    }

    @Override
    public List<String> saveProductToStores(List<HashMap<String, Object>> storeInfo, List<String> barCodeList,
            String channelCode, Integer createUserId, Date createTime) throws ProductServiceException {
        long startSyncTime = System.currentTimeMillis();
        logger.debug("storeInfo -> " + storeInfo + "barCodeList -> " + barCodeList + "channelCode -> " + channelCode
                + "createUserId -> " + createUserId + "createTime -> " + createTime);
        try {
            // 检查店铺id组是否为空
            if (ObjectUtils.isNullOrEmpty(storeInfo)) {
                logger.error("SaleProductService.storeIds => 参数店铺id组信息为空");
                throw new ProductServiceException("店铺id组信息为空");
            }
            // 检查产品条形码组是否为空
            if (ObjectUtils.isNullOrEmpty(barCodeList)) {
                logger.error("SaleProductService.barCodeList => 产品条形码组为空");
                throw new ProductServiceException("产品条形码组为空");
            }
            // 检查产品参数channelCode是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查产品类别修改人是否为空
            if (ObjectUtils.isNullOrEmpty(createUserId)) {
                logger.error("SaleProductService.addToStandard.createUserId=> 商品创建人为空");
                throw new ProductServiceException("商品创建人为空");
            }
            // 检查产品类别修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(createTime)) {
                logger.error("SaleProductService.addToStandard.createTime => 商品创建时间为空");
                throw new ProductServiceException("商品创建时间为空");
            }
            List<String> errorListStrng = null;
            if (!ObjectUtils.isNullOrEmpty(storeInfo)) {
                errorListStrng = new ArrayList<String>();
                for (HashMap<String, Object> storeMap : storeInfo) {
                    if (!ObjectUtils.isNullOrEmpty(storeMap)) {
                        List<SaleProductDto> listSaleProductDto = null;
                        // 查找店铺中所有的商品,并且封装其条形码list
                        List<SaleProductDto> saleProductDtoList = saleProductService
                                .listSaleProductBasicInfoByStoreId((Integer) storeMap.get("storeId"), null);
                        List<HashMap<String, Object>> saleProductbarCodeList = null;
                        if (!ObjectUtils.isNullOrEmpty(saleProductDtoList)) {
                            saleProductbarCodeList = new ArrayList<HashMap<String, Object>>();
                            HashMap<String, Object> saleProductInfoHashMap = null;
                            for (SaleProductDto saleProductDto : saleProductDtoList) {
                                if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                                    saleProductInfoHashMap = new HashMap<String, Object>();
                                    saleProductInfoHashMap.put("barCode", saleProductDto.getBarCode());
                                    saleProductInfoHashMap.put("saleProductName", saleProductDto.getSaleProductName());
                                }
                                saleProductbarCodeList.add(saleProductInfoHashMap);
                            }
                        }
                        // 封装该店铺可以存在的所有的产品基本类型
                        List<HashMap<String, String>> storeProductClassList = productClassService
                                .listProductClassByStoreType((String) storeMap.get("storeType"),
                                        SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                        // 根据产品id和渠道编码获取到产品
                        if (!ObjectUtils.isNullOrEmpty(barCodeList)) {
                            listSaleProductDto = new ArrayList<SaleProductDto>();
                            String isExitErrorClassCodeString = "";
                            for (String barCode : barCodeList) {
                                if (!ObjectUtils.isNullOrEmpty(barCode)) {
                                    boolean isExitClassCode = false;
                                    // 判断该产品是否满足该店铺可以存在的基本产品类型
                                    if (!ObjectUtils.isNullOrEmpty(storeProductClassList)) {
                                        ProductDto productDto = this.loadProductBasicInfoByBarCode(barCode);
                                        for (Map<String, String> productClassHashMap : storeProductClassList) {
                                            if (productDto.getProductClassCode()
                                                    .equals(productClassHashMap.get("classCode"))) {
                                                isExitClassCode = true;
                                                break;
                                            }
                                        }
                                        if (!isExitClassCode) {
                                            ProductClassDto productClassDto = productClassService
                                                    .loadProductClassByClassCode(productDto.getProductClassCode(),
                                                            SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
                                            String exitClassCodeString = "产品类型为：" + productClassDto.getClassName()
                                                    + "&nbsp&nbsp的产品：" + productDto.getProductName() + "&nbsp&nbsp不能添加到店铺:"
                                                    + (String) storeMap.get("storeName") + "&nbsp&nbsp因为该店铺所能添加的产品不包括此类别的产品";
                                            if (!ObjectUtils.isNullOrEmpty(exitClassCodeString)) {
                                                isExitErrorClassCodeString += "&nbsp&nbsp&nbsp&nbsp" + exitClassCodeString
                                                        + "<br>";
                                            }

                                        }
                                    }
                                    // 该产品的类型符合该店铺类型的产品类别，则可以添加到店铺中
                                    if (isExitClassCode) {
                                        ProductDto productDto = this.loadProductByBarCodeAndChannelCode(barCode,
                                                channelCode);
                                        // 将产品封装到商品列表当中
                                        SaleProductDto saleProductDto = pakageToSaleProductDto(productDto,
                                                (Integer) storeMap.get("storeId"), createUserId, createTime);
                                        listSaleProductDto.add(saleProductDto);
                                    }
                                }
                            }
                            if (!ObjectUtils.isNullOrEmpty(listSaleProductDto)) {
                                saleProductService.saveSaleProducts(listSaleProductDto, (String) storeMap.get("storeType"),
                                        channelCode);
                            }
                            if (ObjectUtils.isNullOrEmpty(storeProductClassList)) {
                                String errorStoreString = "您店铺编码为:" + (String) storeMap.get("storeCode") + "，店铺名为:"
                                        + (String) storeMap.get("storeName") + "&nbsp&nbsp的店铺未关联产品基础分类<br>";
                                errorListStrng.add(errorStoreString);
                            }
                            if (!ObjectUtils.isNullOrEmpty(isExitErrorClassCodeString)) {
                                String errorStoreString = "您在店铺编码为:" + (String) storeMap.get("storeCode") + "，店铺名为:"
                                        + (String) storeMap.get("storeName") + "&nbsp&nbsp中所要添加的商品，其中<br>"
                                        + isExitErrorClassCodeString;
                                errorListStrng.add(errorStoreString);
                            }
                        }
                    }
                }
            }
            long endSyncTime = System.currentTimeMillis();
            logger.info("同步过程耗时：" + (endSyncTime - startSyncTime) + "毫秒。");
            return errorListStrng;
        } catch (ProductServiceException e) {
            logger.error("产品同步出现系统异常");
            throw new ProductServiceException(e.getMessage());
        }
    }

    /**
     * 将产品Dto封装成商品Dto（批量添加）
     * 
     * @param productDto
     *            商品Dto
     * @param storeId
     *            商店Id
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageToSaleProductDto(ProductDto productDto, Integer storeId, Integer createUserId,
            Date createTime) {
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
                saleProductDto.setAuditUserId(createUserId);
                saleProductDto.setCreateTime(createTime);
                saleProductDto.setCreateUserId(createUserId);
                saleProductDto.setModifyTime(createTime);
                saleProductDto.setModifyUserId(createUserId);
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
                    saleProductPriceDto.setCreateUserId(createUserId);
                    saleProductPriceDto.setModifyTime(createTime);
                    saleProductPriceDto.setModifyUserId(createUserId);
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
                    saleProductProfileDto.setCreateUserId(createUserId);
                    saleProductProfileDto.setModifyTime(createTime);
                    saleProductProfileDto.setModifyUserId(createUserId);
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
                            saleProductImageDto.setCreateUserId(createUserId);
                            saleProductImageDto.setModifyTime(createTime);
                            saleProductImageDto.setModifyUserId(createUserId);
                            saleProductImageDtoList.add(saleProductImageDto);
                        }
                    }
                    saleProductDto.setSaleProductImageDtos(saleProductImageDtoList);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("封装商品参数失败" + e.getMessage());
        }
        return saleProductDto;
    }

    @Override
    public List<ProductDto> listProductBasicInfosByClassCode(String productClassCode, String statusCode) {
        try {
            List<String> classCodeList = null;
            ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(productClassCode,
                    null);
            if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                classCodeList = new ArrayList<String>();
                // if (productClassDto.getClassLevel().equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST)) {
                // List<ProductClassMappingDto> productClassMappingDtoList = productClassMappingService
                // .listProductClassMapping(productClassDto.getClassCode(), null);
                // if (!ObjectUtils.isNullOrEmpty(productClassMappingDtoList)) {
                // for (ProductClassMappingDto productClassMappingDto : productClassMappingDtoList) {
                // classCodeList.add(productClassMappingDto.getChildClassCode());
                // }
                // }
                // } else if (productClassDto.getClassLevel().equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_BASIC)) {
                classCodeList.add(productClassDto.getClassCode());
                // }
            }
            List<Product> products = productMapper.listProductBasicInfosByClassCode(classCodeList, statusCode);
            List<ProductDto> pDtos = new ArrayList<ProductDto>();
            if (!ObjectUtils.isNullOrEmpty(products)) {
                ProductDto pDto = null;
                for (Product p : products) {
                    if (!ObjectUtils.isNullOrEmpty(p)) {
                        pDto = new ProductDto();
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
    public Set<String> getProductBarCode() throws ProductServiceException {
        try {
            Set<String> productBarCodeSet = productMapper.getProductBarCode();
            return productBarCodeSet;
        } catch (Exception e) {
            logger.error("getProductBarCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Set<String> getProductBarCodeByStoreType(String storeType) throws ProductServiceException {
        try {
            // 检查店铺类型为空
            if (ObjectUtils.isNullOrEmpty(storeType)) {
                logger.error("SaleProductService.getProductBarCode.storeType => 参数店铺类型为空");
                throw new ProductServiceException("参数店铺类型为空");
            }
            List<HashMap<String, String>> storeProductClasslist = productClassService.listProductClassByStoreType(storeType,
                    SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            List<String> classCodeList = null;
            Set<String> productBarCodeSet = null;
            if (!ObjectUtils.isNullOrEmpty(storeProductClasslist)) {
                classCodeList = new ArrayList<String>();
                for (HashMap<String, String> hashMap : storeProductClasslist) {
                    if (!ObjectUtils.isNullOrEmpty(hashMap)) {
                        classCodeList.add(hashMap.get("classCode"));
                    }
                }
            }
            if (!ObjectUtils.isNullOrEmpty(classCodeList)) {
                productBarCodeSet = productMapper.getProductBarCodeByClassCode(classCodeList);
            }
            return productBarCodeSet;
        } catch (Exception e) {
            logger.error("getProductBarCodeByStoreType异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<ProductDto> findProductRelativeInfosByStoreType(Integer storeId, String storeType,
            ProductQuery queryProduct) throws ProductServiceException {
        try {
            // 检查店铺类型为空
            if (ObjectUtils.isNullOrEmpty(storeType)) {
                logger.error("SaleProductService.findProductRelativeInfosByStoreType.storeType => 参数店铺类型为空");
                throw new ProductServiceException("参数店铺类型为空");
            }
            if (null == queryProduct.getStart() || queryProduct.getStart() <= 0) {
                queryProduct.setStart(1);
            }
            if (null == queryProduct.getPageSize() || queryProduct.getPageSize() <= 0) {
                queryProduct.setPageSize(CommonConstants.PAGE_SIZE);
            }
            List<HashMap<String, String>> storeProductClasslist = productClassService.listProductClassByStoreType(storeType,
                    SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
            // 封装产品类别(店铺关联的)
            List<String> classCodeList = null;
            // 封装产品类别(搜索条件)
            if (!ObjectUtils.isNullOrEmpty(queryProduct.getProductClassCode())) {
               List<Object> classCodes = productClassService.getSubClassCodes(queryProduct.getProductClassCode());
                if (!ObjectUtils.isNullOrEmpty(classCodes)) {
                    if (!ObjectUtils.isNullOrEmpty(storeProductClasslist)) {
                        classCodeList = new ArrayList<String>();
                        for (HashMap<String, String> hashMap : storeProductClasslist) {
                            if (!ObjectUtils.isNullOrEmpty(hashMap)) {
                                for (Object classCode : classCodes) {
                                    if (hashMap.get("classCode").equals(classCode.toString())) {
                                        classCodeList.add(classCode.toString());
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                if (!ObjectUtils.isNullOrEmpty(storeProductClasslist)) {
                    classCodeList = new ArrayList<String>();
                    for (HashMap<String, String> hashMap : storeProductClasslist) {
                        if (!ObjectUtils.isNullOrEmpty(hashMap)) {
                            classCodeList.add(hashMap.get("classCode"));
                        }
                    }
                }
            }

            Page<ProductDto> pageDto = new Page<ProductDto>(queryProduct.getStart(), queryProduct.getPageSize());
            if (!ObjectUtils.isNullOrEmpty(classCodeList)) {
                PageHelper.startPage(queryProduct.getStart(), queryProduct.getPageSize());
                Page<ProductRelatedInfo> page = productMapper.findProductRelativeInfosByStoreType(storeId, classCodeList,
                        queryProduct);
                ObjectUtils.fastCopy(page, pageDto);
                List<ProductRelatedInfo> productRelatedInfos = page.getResult();
                if (!ObjectUtils.isNullOrEmpty(productRelatedInfos)) {
                    for (ProductRelatedInfo pri : productRelatedInfos) {
                        ProductDto pDto = new ProductDto();
                        ObjectUtils.fastCopy(pri, pDto);
                        // 上下架状态编码转换为上下架状态描述
                        pDto.setSaleStatusName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.PRODUCTSALESTATUS.getValue(), pri.getSaleStatus()));
                        // 热卖状态编码转换为热卖状态描述
                        pDto.setHotSaleFlagName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.HOTSALEFLAG.getValue(), pri.getHotSaleFlag()));
                        pageDto.add(pDto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findProductRelativeInfos异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<ProductDto> listProductByIdsAndStatusCode(List<Integer> productIds, String statusCode)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(productIds)) {
                throw new ProductServiceException("产品不能为空");
            }
            List<ProductDto> productDtoList = new ArrayList<ProductDto>();
            for (Integer productId : productIds) {
                Product product = productMapper.loadProductBasicInfoByIdAndStatusCode(productId, statusCode);
                if (ObjectUtils.isNullOrEmpty(product)) {
                    continue;
                }
                ProductDto productDto = new ProductDto();
                ObjectUtils.fastCopy(product, productDto);
                // 设置产品附加属性
                setProductProfileInfo(productDto, productId, null);
                // 设置品牌
                setProductBrandInfo(productDto, product.getBrandCode());
                // 设置产品分类
                setProductClassInfo(productDto, product.getProductClassCode());
                // 设置产品价格
                setProductPriceInfo(productDto, productId, null);
                // 设置图片
                setProductImageInfo(productDto, productId, null);
                productDtoList.add(productDto);
            }
            return productDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    // 设置产品附属属性
    private void setProductProfileInfo(ProductDto productDto, Integer productId, String channelCode) {
        if (ObjectUtils.isNullOrEmpty(productDto)) {
            return;
        }
        ProductProfileDto productProfileDto = productProfileService.loadProductProfileByProductIdAndChannelCode(productId,
                channelCode);
        if (null == productProfileDto) {
            logger.error("商品[" + productId + "]不存在");
            throw new ProductServiceException("商品不存在");
        }
        productDto.setProductProfileDto(productProfileDto);
    }

    // 设置产品价格信息
    private void setProductPriceInfo(ProductDto productDto, Integer productId, String channelCode) {
        if (ObjectUtils.isNullOrEmpty(productDto)) {
            return;
        }
        ProductPriceDto productPriceDto = productPriceService.loadProductPriceByProductIdAndChannelCode(productId,
                channelCode);
        if (!ObjectUtils.isNullOrEmpty(productPriceDto)) {
            productDto.setProductPriceDto(productPriceDto);
        }
    }

    // 设置产品品牌
    private void setProductBrandInfo(ProductDto productDto, String brandCode) {
        if (ObjectUtils.isNullOrEmpty(productDto) || ObjectUtils.isNullOrEmpty(brandCode)) {
            return;
        }
        ProductBrandDto productBrandDto = productBrandService.loadProductBrandByBrandCode(brandCode);
        if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
            productDto.setBrandName(productBrandDto.getBrandName());
        }
    }

    // 设置产品图片
    private void setProductImageInfo(ProductDto productDto, Integer productId, String channelCode) {
        if (ObjectUtils.isNullOrEmpty(productDto)) {
            return;
        }
        List<ProductImageDto> productImageDtoList = productImageService.listProductImagesByProductIdAndChannelCode(productId,
                channelCode);
        if (!ObjectUtils.isNullOrEmpty(productImageDtoList)) {
            productDto.setProductImageDtos(productImageDtoList);
        }
    }

    // 设置产品分类
    private void setProductClassInfo(ProductDto productDto, String productClassCode) {
        if (ObjectUtils.isNullOrEmpty(productDto) || ObjectUtils.isNullOrEmpty(productClassCode)) {
            return;
        }
        ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(productClassCode, null);
        if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
            productDto.setClassName(productClassDto.getClassName());
        }
    }
}
