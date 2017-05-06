package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
import com.yilidi.o2o.product.dao.AuditProductMapper;
import com.yilidi.o2o.product.model.AuditProduct;
import com.yilidi.o2o.product.model.query.AuditProductQuery;
import com.yilidi.o2o.product.service.IAuditProductBatchInfoService;
import com.yilidi.o2o.product.service.IAuditProductImageService;
import com.yilidi.o2o.product.service.IAuditProductService;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductProfileService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.AuditProductBatchInfoDto;
import com.yilidi.o2o.product.service.dto.AuditProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.AuditProductDto;
import com.yilidi.o2o.product.service.dto.AuditProductImageDto;
import com.yilidi.o2o.product.service.dto.AuditProductImageProfileDto;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductImageDto;
import com.yilidi.o2o.product.service.dto.ProductPriceDto;
import com.yilidi.o2o.product.service.dto.ProductProfileDto;
import com.yilidi.o2o.product.service.dto.query.AuditProductQueryDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 数据包产品Service实现类
 * 
 * @author: chenlian
 * @date: 2016年12月10日 下午6:19:58
 */
@Service("auditProductService")
public class AuditProductServiceImpl extends BasicDataService implements IAuditProductService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
    private static final String IMAGEFLAG_NO = "IMAGEFLAG_NO";

    @Autowired
    private AuditProductMapper auditProductMapper;
    @Autowired
    private IProductClassService productClassService;
    @Autowired
    private IProductService productService;
    @Autowired
    private IAuditProductBatchInfoService auditProductBatchInfoService;
    @Autowired
    private IAuditProductImageService auditProductImageService;
    @Autowired
    private IProductBrandService productBrandService;
    @Autowired
    private IProductProfileService productProfileService;

    @Override
    public AuditProductDto loadAuditProductByBarCodeAndChannelCode(String barCode, String channelCode)
            throws ProductServiceException {
        AuditProductDto auditProductDto = null;
        try {
            // 检查产品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                throw new ProductServiceException("数据包产品条形码参数为空");
            }
            // 数据包产品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            AuditProduct auditProduct = auditProductMapper.loadByBarCodeAndChannelCode(barCode, channelCode);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(auditProduct)) {
                auditProductDto = new AuditProductDto();
                ObjectUtils.fastCopy(auditProduct, auditProductDto);
            }
            return auditProductDto;
        } catch (ProductServiceException e) {
            logger.error("loadAuditProductByBarCodeAndChannelCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveAuditProduct(String batchNo, AuditProductDto saveAuditProductDto, String channelCode,
            Date createTime, Integer createUserId) throws ProductServiceException {
        // 保存产品基础信息开始
        try {
            // 保存数据包产品信息
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductDto)) {
                throw new ProductServiceException("产品参数为空");
            }
            // 产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getBarCode())) {
                throw new ProductServiceException("产品条形码参数为空");
            }
            // 数据包产品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 判断产品是否是重复添加
            AuditProductDto auditProductDtoLoad = this.loadAuditProductByBarCodeAndChannelCode(
                    saveAuditProductDto.getBarCode(), channelCode);
            if (ObjectUtils.isNullOrEmpty(auditProductDtoLoad)) {
                // 产品名称参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductName())) {
                    throw new ProductServiceException("产品名称参数为空");
                }
                // 产品规格参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductSpec())) {
                    throw new ProductServiceException("产品规格参数为空");
                }
                // 判断产品分类参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductClassCode())) {
                    throw new ProductServiceException("产品分类参数为空");
                }
                // 产品品牌参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getBrandCode())) {
                    throw new ProductServiceException("产品品牌参数为空");
                }
                // 产品采购价是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getCostPrice())) {
                    throw new ProductServiceException("产品采购价参数为空");
                }
                // 产品普通会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getRetailPrice())) {
                    throw new ProductServiceException("产品普通会员售价参数为空");
                }
                // 产品VIP会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getPromotionalPrice())) {
                    throw new ProductServiceException("产品VIP会员售价参数为空");
                }
                // 产品显示顺序是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getDisplayOrder())) {
                    throw new ProductServiceException("产品显示顺序参数为空");
                }
                AuditProduct auditProduct = new AuditProduct();
                auditProduct.setBatchNo(batchNo);
                auditProduct.setProductName(saveAuditProductDto.getProductName());
                auditProduct.setBarCode(saveAuditProductDto.getBarCode());
                auditProduct.setProductSpec(saveAuditProductDto.getProductSpec());
                auditProduct.setProductClassCode(saveAuditProductDto.getProductClassCode());
                auditProduct.setBrandCode(saveAuditProductDto.getBrandCode());
                auditProduct.setCostPrice(saveAuditProductDto.getCostPrice());
                auditProduct.setRetailPrice(saveAuditProductDto.getRetailPrice());
                auditProduct.setPromotionalPrice(saveAuditProductDto.getPromotionalPrice());
                auditProduct.setDisplayOrder(saveAuditProductDto.getDisplayOrder());
                auditProduct.setChannelCode(channelCode);
                auditProduct.setContent(saveAuditProductDto.getContent());
                auditProduct.setAuditStatus(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_AUDIT);
                auditProduct.setCreateTime(createTime);
                auditProduct.setCreateUserId(createUserId);
                auditProduct.setDataResource(saveAuditProductDto.getDataResource());
                auditProductMapper.save(auditProduct);
                // 保存数据包产品图片
                List<String> productImageUrls = saveAuditProductDto.getProductImageUrls();
                if (!ObjectUtils.isNullOrEmpty(productImageUrls)) {
                    List<AuditProductImageDto> auditProductImageDtoList = new ArrayList<AuditProductImageDto>();
                    int i = 1;
                    for (String imageUrl : productImageUrls) {
                        AuditProductImageDto auditProductImageDto = new AuditProductImageDto();
                        auditProductImageDto.setBatchNo(batchNo);
                        auditProductImageDto.setAuditProductId(auditProduct.getId());
                        auditProductImageDto.setChannelCode(channelCode);
                        auditProductImageDto.setImageUrl(imageUrl);
                        auditProductImageDto.setImageOrder(i);
                        if (i == 1) {
                            auditProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES);
                        } else {
                            auditProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_NO);
                        }
                        auditProductImageDto.setCreateTime(createTime);
                        auditProductImageDto.setCreateUserId(createUserId);
                        auditProductImageDto.setDataResource(saveAuditProductDto.getDataResource());
                        auditProductImageDtoList.add(auditProductImageDto);
                        i++;
                    }
                    auditProductImageService.saveAuditProductImages(auditProductImageDtoList);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("saveAuditProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveAuditProduct(AuditProductDto saveAuditProductDto, String channelCode) throws ProductServiceException {
        // 保存产品基础信息开始
        try {
            // 保存数据包产品信息
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductDto)) {
                throw new ProductServiceException("产品参数为空");
            }
            // 产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getBarCode())) {
                throw new ProductServiceException("产品条形码参数为空");
            }
            // 数据包产品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(saveAuditProductDto.getBarCode(), channelCode);
            boolean flag = false;//新增产品需校验barCode,正式产品修改则无需校验barCode.
            if(saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){
            	flag = true ;
				productProfileService.updateSaleStatusByProductIdAndChannelCode(productDto.getId(),
						SystemContext.ProductDomain.PRODUCTSALESTATUS_OFFSALE, channelCode,
						saveAuditProductDto.getCreateUserId(), saveAuditProductDto.getCreateTime());
            }else{// 判断产品是否是重复添加
            	AuditProductDto auditProductDtoLoad = this.loadAuditProductByBarCodeAndChannelCode(
                        saveAuditProductDto.getBarCode(), channelCode);
            	if(ObjectUtils.isNullOrEmpty(productDto) && ObjectUtils.isNullOrEmpty(auditProductDtoLoad)){
            		flag = true ;
            	}
            }
            if (flag) {
                // 产品名称参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductName())) {
                    throw new ProductServiceException("产品名称参数为空");
                }
                // 产品规格参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductSpec())) {
                    throw new ProductServiceException("产品规格参数为空");
                }
                // 判断产品分类参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getProductClassCode())) {
                    throw new ProductServiceException("产品分类参数为空");
                }
                // 产品品牌参数是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getBrandName())) {
                    throw new ProductServiceException("产品品牌参数为空");
                }
                ProductBrandDto productBrandDto = productBrandService.getBrandByName(saveAuditProductDto.getBrandName());
                // 产品品牌编码是否为空
                if (ObjectUtils.isNullOrEmpty(productBrandDto)) {
                    throw new ProductServiceException("产品品牌编码为空");
                }else{
                	saveAuditProductDto.setBrandCode(productBrandDto.getBrandCode());
                }
                	
                // 产品普通会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getRetailPrice())) {
                    throw new ProductServiceException("产品普通会员售价参数为空");
                }
                // 产品VIP会员售价是否为空
                if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getPromotionalPrice())) {
                    throw new ProductServiceException("产品VIP会员售价参数为空");
                }
                // 产品显示顺序是否为空（非必填）
                /*if (ObjectUtils.isNullOrEmpty(saveAuditProductDto.getDisplayOrder())) {
                    throw new ProductServiceException("产品显示顺序参数为空");
                }*/
                AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                        .loadAuditProductBatchInfoByBatchNo(saveAuditProductDto.getBatchNo());
                if(ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)){
                	auditProductBatchInfoDto = new AuditProductBatchInfoDto();
                    auditProductBatchInfoDto.setBatchNo(saveAuditProductDto.getBatchNo());
                    auditProductBatchInfoDto.setUploadCount(1);
                    auditProductBatchInfoDto.setSubmitStatus(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                    auditProductBatchInfoDto.setSubmitCount(0);
                    auditProductBatchInfoDto.setCreateTime(saveAuditProductDto.getCreateTime());
                    auditProductBatchInfoDto.setCreateUserId(saveAuditProductDto.getCreateUserId());
                    auditProductBatchInfoDto.setDataResource(saveAuditProductDto.getDataResource());
                    auditProductBatchInfoService.saveAuditProductBatchInfo(auditProductBatchInfoDto);
                }else{
                	auditProductBatchInfoService.updateUploadCount(auditProductBatchInfoDto.getBatchNo(),1,auditProductBatchInfoDto.getCreateTime(),auditProductBatchInfoDto.getCreateUserId());
                }
                
                AuditProduct auditProduct = new AuditProduct();
                auditProduct.setBatchNo(saveAuditProductDto.getBatchNo());
                auditProduct.setProductName(saveAuditProductDto.getProductName());
                auditProduct.setBarCode(saveAuditProductDto.getBarCode());
                auditProduct.setProductSpec(saveAuditProductDto.getProductSpec());
                auditProduct.setProductClassCode(saveAuditProductDto.getProductClassCode());
                auditProduct.setBrandCode(saveAuditProductDto.getBrandCode());
                auditProduct.setRetailPrice(saveAuditProductDto.getRetailPrice());
                auditProduct.setPromotionalPrice(saveAuditProductDto.getPromotionalPrice());
                auditProduct.setCostPrice(saveAuditProductDto.getCostPrice());
                auditProduct.setCommissionPrice(saveAuditProductDto.getCommissionPrice());
                auditProduct.setVipCommissionPrice(saveAuditProductDto.getVipCommissionPrice());
                auditProduct.setDisplayOrder(saveAuditProductDto.getDisplayOrder());
                auditProduct.setChannelCode(channelCode);
                if(!StringUtils.isEmpty(saveAuditProductDto.getContent())){
                	String uploadFileTempUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
                    String uploadFileUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL);
                    String content = saveAuditProductDto.getContent().replaceAll(uploadFileTempUrl, uploadFileUrl);
                    auditProduct.setContent(content);
                }
                auditProduct.setAuditStatus(SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_AUDIT);
                auditProduct.setCreateTime(saveAuditProductDto.getCreateTime());
                auditProduct.setCreateUserId(saveAuditProductDto.getCreateUserId());
                auditProduct.setDataResource(saveAuditProductDto.getDataResource());
                auditProductMapper.save(auditProduct);
                // 保存产品图片
                List<AuditProductImageDto> listProductImageDto = null;
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getAppIsMainPic())) {
                    listProductImageDto = listProductImageDto(saveAuditProductDto);
                } else {
                    listProductImageDto = saveAuditProductDto.getProductImageDtos();
                }
                if (!ObjectUtils.isNullOrEmpty(listProductImageDto)) {
                	List<AuditProductImageDto> auditProductImageDtoList = new ArrayList<AuditProductImageDto>();
                    int i = 1;
                    for (AuditProductImageDto productImageDto : listProductImageDto) {
                    	 AuditProductImageDto auditProductImageDto = new AuditProductImageDto();
                         auditProductImageDto.setBatchNo(saveAuditProductDto.getBatchNo());
                         auditProductImageDto.setAuditProductId(auditProduct.getId());
                         auditProductImageDto.setChannelCode(channelCode);
                         auditProductImageDto.setImageUrl(productImageDto.getImageUrl());
                         auditProductImageDto.setImageOrder(i);
                         auditProductImageDto.setMasterFlag(productImageDto.getMasterFlag());
                         auditProductImageDto.setCreateTime(saveAuditProductDto.getCreateTime());
                         auditProductImageDto.setCreateUserId(saveAuditProductDto.getCreateUserId());
                         auditProductImageDto.setDataResource(saveAuditProductDto.getDataResource());
                         auditProductImageDtoList.add(auditProductImageDto);
                         i++;
                    }
                    auditProductImageService.saveAuditProductImages(auditProductImageDtoList);
                }
                //throw new ProductServiceException("产品条形码已被使用！");
                operateContentImage(saveAuditProductDto,saveAuditProductDto.getLoadContentImageUrls(), saveAuditProductDto.getAddContentImageUrls());
                operateAuditProductImage(saveAuditProductDto,listProductImageDto, saveAuditProductDto.getDeleteImageUrls());
            }else{
            	throw new ProductServiceException("产品条形码已被使用！");
            }
        } catch (ProductServiceException e) {
            logger.error("saveAuditProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }
    
 // 封装前台传过来的图片列表数据
    private List<AuditProductImageDto> listProductImageDto(AuditProductDto saveAuditProductDto) {
        List<AuditProductImageDto> listProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto)) {
                // 保存图片
                // 封装产品图片
                listProductImageDto = new ArrayList<AuditProductImageDto>();
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getFirstAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto1 = saveAuditProductDto.getFirstAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto1);
                }
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getSecondAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto2 = saveAuditProductDto.getSecondAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto2);
                }
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getThirdAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto3 = saveAuditProductDto.getThirdAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto3);
                }
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getFouthAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto4 = saveAuditProductDto.getFouthAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto4);
                }
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getFiveAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto5 = saveAuditProductDto.getFiveAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto5);
                }
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getSixAppImageProfileDto())) {
                	AuditProductImageProfileDto profileDto6 = saveAuditProductDto.getSixAppImageProfileDto();
                    addProductImageDto(listProductImageDto, saveAuditProductDto, profileDto6);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传输的图片列表信息出错");
            throw new ProductServiceException("异常：封装前台传输的图片列表信息出错");
        }

        return listProductImageDto;
    }
 // 封装前台传过来的图片Dto
    private void addProductImageDto(List<AuditProductImageDto> listProductImageDto, AuditProductDto saveAuditProductDto,
    		AuditProductImageProfileDto profileDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto)) {
            	AuditProductImageDto auditProductImageDto = pakageProductImageDto(saveAuditProductDto, profileDto);
                if (!ObjectUtils.isNullOrEmpty(auditProductImageDto)) {
                    listProductImageDto.add(auditProductImageDto);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("封装前台传过来的图片Dto");
            throw new ProductServiceException("封装前台传过来的图片Dto");
        }
    }
 // 封装前台传过来的图片列表数据
    private AuditProductImageDto pakageProductImageDto(AuditProductDto saveAuditProductDto, AuditProductImageProfileDto profileDto) {
    	AuditProductImageDto productImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicPath())) {
                // 保存图片
                // 封装产品单张图片
                productImageDto = new AuditProductImageDto();
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
                if (!ObjectUtils.isNullOrEmpty(saveAuditProductDto.getAppIsMainPic())
                        && profileDto.getAppPicSort().intValue() == saveAuditProductDto.getAppIsMainPic().intValue()) {
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

    @Override
    public void saveAuditProductBatch(List<AuditProductDto> auditProductDtoList, AuditProductBatchSaveDto objs)
            throws ProductServiceException {
        try {
            // 检查产品列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductDtoList)) {
                throw new ProductServiceException("需要保存的产品列表为空");
            }
            // 检查产品参数渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(objs.getChannelCode())) {
                throw new ProductServiceException("需要保存的产品渠道编码参数为空");
            }
            // 检查产品参数创建时间是否为空
            if (ObjectUtils.isNullOrEmpty(objs.getCreateTime())) {
                throw new ProductServiceException("需要保存的创建时间参数为空");
            }
            // 检查产品参数创建人是否为空
            if (ObjectUtils.isNullOrEmpty(objs.getCreateUserId())) {
                throw new ProductServiceException("需要保存的创建人参数为空");
            }
            if (!ObjectUtils.isNullOrEmpty(auditProductDtoList)) {
                // 保存数据包产品批次信息
                AuditProductBatchInfoDto auditProductBatchInfoDto = new AuditProductBatchInfoDto();
                String batchNo = StringUtils.generatePacketProductBatchNo();
                auditProductBatchInfoDto.setBatchNo(batchNo);
                auditProductBatchInfoDto.setUploadCount(auditProductDtoList.size());
                auditProductBatchInfoDto.setSubmitStatus(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                auditProductBatchInfoDto.setSubmitCount(0);
                auditProductBatchInfoDto.setCreateTime(objs.getCreateTime());
                auditProductBatchInfoDto.setCreateUserId(objs.getCreateUserId());
                auditProductBatchInfoDto.setDataResource(SystemContext.ProductDomain.AUDITPRODUCTDATARESOURCE_PACKET);
                auditProductBatchInfoService.saveAuditProductBatchInfo(auditProductBatchInfoDto);
                for (AuditProductDto auditProductDtoSave : auditProductDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(auditProductDtoSave)) {
                        this.saveAuditProduct(batchNo, auditProductDtoSave, objs.getChannelCode(), objs.getCreateTime(),
                                objs.getCreateUserId());
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("saveAuditProductBatch异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditProductBasicInfoById(AuditProductDto auditProductDto, String channelCode)
            throws ProductServiceException {
        try {
            // 检查产品分类是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductDto.getProductClassCode())) {
                logger.error("ProductService.saveProductDto.createTime => 产品分类为空");
                throw new ProductServiceException("请选择产品分类");
            }
            // 检查产品类别是否是最低一级的
            if (!ObjectUtils.isNullOrEmpty(productClassService.getAllNextProductClassByUpCode(new ProductClassQuery(
                    auditProductDto.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)))) {
                logger.error("ProductService.saveProductDto.getProductClassCode => 产品没有挂载最低级的类别上");
                throw new ProductServiceException("产品类别就不是最低一级的类别");
            }
            // 检查数据包产品参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                throw new ProductServiceException("数据包产品参数为空");
            }
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditProductDto.getId())) {
                throw new ProductServiceException("数据包产品ID参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            AuditProduct auditProduct = new AuditProduct();
            auditProduct.setId(auditProductDto.getId());
            auditProduct.setProductName(auditProductDto.getProductName());
            auditProduct.setBarCode(auditProductDto.getBarCode());
            auditProduct.setProductClassCode(auditProductDto.getProductClassCode());
            auditProduct.setDataResource(auditProductDto.getDataResource());
            if (!ObjectUtils.isNullOrEmpty(auditProductDto.getBrandCode())) {
                auditProduct.setBrandCode(auditProductDto.getBrandCode());
            }
            if (!ObjectUtils.isNullOrEmpty(auditProductDto.getBrandName())) {
                ProductBrandDto productBrandDto = productBrandService.getBrandByName(auditProductDto.getBrandName());
                if (ObjectUtils.isNullOrEmpty(productBrandDto)) {
                    throw new ProductServiceException("产品品牌不存在");
                }
                auditProduct.setBrandCode(productBrandDto.getBrandCode());
            }
            auditProduct.setRetailPrice(auditProductDto.getRetailPrice());
            auditProduct.setCostPrice(auditProductDto.getCostPrice());
            auditProduct.setCommissionPrice(auditProductDto.getCommissionPrice());
            auditProduct.setVipCommissionPrice(auditProductDto.getVipCommissionPrice());
            auditProduct.setPromotionalPrice(auditProductDto.getPromotionalPrice());
            auditProduct.setDisplayOrder(auditProductDto.getDisplayOrder());
            auditProduct.setProductSpec(auditProductDto.getProductSpec());
            if(!StringUtils.isEmpty(auditProductDto.getContent())){
            	if(!auditProductDto.getBatchNo().equals("BATCHNO_UPDATE") && !auditProductDto.getBatchNo().equals("BATCHNO_NEW")){
            		auditProduct.setContent(auditProductDto.getContent());
            	}else{
            		String uploadFileTempUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
                    String uploadFileUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL);
                    String content = auditProductDto.getContent().replaceAll(uploadFileTempUrl, uploadFileUrl);
                    auditProduct.setContent(content);
            	}
            }
            auditProduct.setModifyUserId(auditProductDto.getModifyUserId());
            auditProduct.setModifyTime(auditProductDto.getModifyTime());
            auditProductMapper.updateAuditProductBasicInfoById(auditProduct);
            List<AuditProductImageDto> listAuditProductImageDto = listAuditProductImageDto(auditProductDto);
            if (!ObjectUtils.isNullOrEmpty(listAuditProductImageDto)) {
                for (AuditProductImageDto auditProductImageDto : listAuditProductImageDto) {
                    auditProductImageDto.setAuditProductId(auditProductDto.getId());
                    auditProductImageDto.setModifyUserId(auditProductDto.getModifyUserId());
                    auditProductImageDto.setModifyTime(auditProductDto.getModifyTime());
                    auditProductImageDto.setChannelCode(channelCode);
                    auditProductImageDto.setBatchNo(auditProductDto.getBatchNo());
                    auditProductImageDto.setDataResource(auditProductDto.getDataResource());
                }
                auditProductImageService.updateAuditProductImages(listAuditProductImageDto);
            }
            if (!ObjectUtils.isNullOrEmpty(auditProductDto.getDeleteImageUrls())) {
                if (!auditProductDto.getDeleteImageUrls().contains(",")) {
                    String ext = this.getExtensionName(auditProductDto.getDeleteImageUrls()).replace(".", "");
                    String imageUrl1 = auditProductDto.getDeleteImageUrls().replaceAll("\\." + ext, "\\_1." + ext);
                    auditProductImageService.deleteAuditProductImageByImageUrl1(imageUrl1);
                } else {
                    String[] arrParam = auditProductDto.getDeleteImageUrls().split(",");
                    for (String imageUrl : arrParam) {
                        if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                            String ext = this.getExtensionName(imageUrl).replace(".", "");
                            String imageUrl1 = imageUrl.replaceAll("\\." + ext, "\\_1." + ext);
                            auditProductImageService.deleteAuditProductImageByImageUrl1(imageUrl1);
                        }
                    }
                }
            }
            operateContentImage(auditProductDto,auditProductDto.getLoadContentImageUrls(), auditProductDto.getAddContentImageUrls());
            operateAuditProductImage(auditProductDto,listAuditProductImageDto, auditProductDto.getDeleteImageUrls());
        } catch (ProductServiceException e) {
            logger.error("updateAuditProductBasicInfoById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private List<AuditProductImageDto> listAuditProductImageDto(AuditProductDto auditProductDto) {
        List<AuditProductImageDto> listAuditProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(auditProductDto)) {
                listAuditProductImageDto = new ArrayList<AuditProductImageDto>();
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getFirstAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto1 = auditProductDto.getFirstAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto1);
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getSecondAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto2 = auditProductDto.getSecondAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto2);
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getThirdAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto3 = auditProductDto.getThirdAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto3);
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getFouthAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto4 = auditProductDto.getFouthAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto4);
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getFiveAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto5 = auditProductDto.getFiveAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto5);
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getSixAppImageProfileDto())) {
                    AuditProductImageProfileDto profileDto6 = auditProductDto.getSixAppImageProfileDto();
                    addAuditProductImageDto(listAuditProductImageDto, auditProductDto, profileDto6);
                }
            }
            return listAuditProductImageDto;
        } catch (ProductServiceException e) {
            logger.error("listAuditProductImageDto异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private void addAuditProductImageDto(List<AuditProductImageDto> listAuditProductImageDto,
            AuditProductDto auditProductDto, AuditProductImageProfileDto profileDto) {
        try {
            if (!ObjectUtils.isNullOrEmpty(auditProductDto)) {
                AuditProductImageDto auditProductImageDto = pakageAuditProductImageDto(auditProductDto, profileDto);
                if (!ObjectUtils.isNullOrEmpty(auditProductImageDto)) {
                    listAuditProductImageDto.add(auditProductImageDto);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("addAuditProductImageDto异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private AuditProductImageDto pakageAuditProductImageDto(AuditProductDto auditProductDto,
            AuditProductImageProfileDto profileDto) {
        AuditProductImageDto auditProductImageDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicPath())) {
                auditProductImageDto = new AuditProductImageDto();
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicId())) {
                    auditProductImageDto.setId(profileDto.getAppPicId());
                }
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppPicOrder())) {
                    auditProductImageDto.setImageOrder(profileDto.getAppPicOrder());
                }
                auditProductImageDto.setImageUrl(profileDto.getAppPicPath());
                if (!ObjectUtils.isNullOrEmpty(profileDto.getAppImageFlag())) {
                    auditProductImageDto.setAppImageFlag(profileDto.getAppImageFlag());
                }
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getAppIsMainPic())
                        && profileDto.getAppPicSort().intValue() == auditProductDto.getAppIsMainPic().intValue()) {
                    auditProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES);
                } else {
                    auditProductImageDto.setMasterFlag(SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_NO);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("pakageAuditProductImageDto异常", e);
            throw new ProductServiceException(e.getMessage());
        }
        return auditProductImageDto;
    }

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

    private void operateContentImage(AuditProductDto saveAuditProductDto,String loadContentImageUrls, String addContentImageUrls) throws ProductServiceException {
        try {
            List<String> delImageUrls = this.getDelImageUrls(loadContentImageUrls, addContentImageUrls);
            List<String> addImageUrls = this.getAddImageUrls(loadContentImageUrls, addContentImageUrls);
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
            	if(!saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){//删除正式库详情图
            		for (String imageUrl : delImageUrls) {
                        if (!ObjectUtils.isNullOrEmpty(imageUrl)) {//test
                        	fileUploadUtils.deletePublishFile(imageUrl);
                            fileUploadUtils.deleteTempFile(imageUrl);
                        }
                    }
            	}else if(saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){//是否是原有的详情图
            		ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(saveAuditProductDto.getBarCode(), saveAuditProductDto.getChannelCode());
            		for (String imageUrl : delImageUrls) {
            				if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
            					if(-1!=productDto.getProductProfileDto().getContent().indexOf(imageUrl)){
                					continue;
                				}
            					fileUploadUtils.deletePublishFile(imageUrl);
                				fileUploadUtils.deleteTempFile(imageUrl);
                            }
                        
                    }
            	}
                
            }
            if(saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE") || saveAuditProductDto.getBatchNo().equals("BATCHNO_NEW")){
            	if (!ObjectUtils.isNullOrEmpty(addContentImageUrls)) {
                    for (String imageUrl : addImageUrls) {
                        if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                            fileUploadUtils.uploadPublishFile(imageUrl);
                        }
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("operateContentImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

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
            logger.error("getDelImageUrls异常", e);
            throw new ProductServiceException(e.getMessage());
        }
        return delImageUrls;
    }
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


    private void operateAuditProductImage(AuditProductDto saveAuditProductDto,List<AuditProductImageDto> listAuditProductImageDto, String delImageUrls)
            throws ProductServiceException {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if(saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE") || saveAuditProductDto.getBatchNo().equals("BATCHNO_NEW")){
            	if (!ObjectUtils.isNullOrEmpty(listAuditProductImageDto)) {
                    for (AuditProductImageDto productImageDto : listAuditProductImageDto) {
                        if (!ObjectUtils.isNullOrEmpty(productImageDto.getAppImageFlag())
                                && IMAGEFLAG_YES.equals(productImageDto.getAppImageFlag())) {
                            fileUploadUtils.uploadPublishFile(productImageDto.getImageUrl());
                        }
                    }
                }
            }
            //根据来源类型决定是否删除正式库相应图片
            if(!saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){//删除正式库详情图
            	if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
                    if (!delImageUrls.contains(",")) {
                        fileUploadUtils.deletePublishFile(delImageUrls);
                    } else {
                        String[] arrParam = delImageUrls.split(",");
                        for (String imageUrl : arrParam) {
                            if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                            	fileUploadUtils.deletePublishFile(imageUrl);
                                fileUploadUtils.deleteTempFile(imageUrl);
                            }
                        }
                    }
                }
            }
            if(saveAuditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){//删除正式库详情图
            	if (!ObjectUtils.isNullOrEmpty(delImageUrls)) {
            		ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(saveAuditProductDto.getBarCode(), saveAuditProductDto.getChannelCode());
                    List<ProductImageDto> list = productDto.getProductImageDtos();
                    if(ObjectUtils.isNullOrEmpty(list)){
                    	if (!delImageUrls.contains(",")) {
                            fileUploadUtils.deletePublishFile(delImageUrls);
                        } else {
                            String[] arrParam = delImageUrls.split(",");
                            for (String imageUrl : arrParam) {
                                if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                                	fileUploadUtils.deletePublishFile(imageUrl);
                                    fileUploadUtils.deleteTempFile(imageUrl);
                                }
                            }
                        }
                    }else{
                    	if (!delImageUrls.contains(",")) {
                        	int i=0;
                        	for(ProductImageDto productImageDto : list){
                        		i++;
                        		if(delImageUrls.equals(productImageDto.getImageUrl())){
                        			break;
                        		}
                        		if(!delImageUrls.equals(productImageDto.getImageUrl()) && i==list.size()){
                        			fileUploadUtils.deletePublishFile(delImageUrls);
                        		}
                        	}
                        } else {
                            String[] arrParam = delImageUrls.split(",");
                            for (String imageUrl : arrParam) {
                            	int i=0;
                            	for(ProductImageDto productImageDto : list){
                            		i++;
                            		if(imageUrl.equals(productImageDto.getImageUrl())){
                            			break;
                            		}
                            		if(!imageUrl.equals(productImageDto.getImageUrl()) && i==list.size()){
                            			fileUploadUtils.deletePublishFile(imageUrl);
                            		}
                            	}
                            }
                        }
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("operateAuditProductImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusBySubmit(Integer id, List<String> preAuditStatusList, Date submitTime, String auditStatus,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("数据包产品ID参数为空");
            }
            // 检查提交审批之前的审核状态列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatusList)) {
                throw new ProductServiceException("提交审批之前的审核状态列表参数为空");
            }
            // 检查提交审批时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(submitTime)) {
                throw new ProductServiceException("提交审批时间参数为空");
            }
            // 检查提交审批之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("提交审批之后的审核状态参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            Integer effectedCount = auditProductMapper.updateAuditStatusBySubmit(id, preAuditStatusList, submitTime,
                    auditStatus, modifyUserId, modifyTime);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("提交审批之前的审核状态只能为待审核");
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusBySubmit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusBySubmitBatch(String batchNo, List<Integer> ids, List<String> preAuditStatusList,
            Date submitTime, String auditStatus, Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(ids)) {
                throw new ProductServiceException("数据包产品ID列表参数为空");
            }
            // 检查提交审批之前的审核状态列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatusList)) {
                throw new ProductServiceException("提交审批之前的审核状态列表参数为空");
            }
            // 检查提交审批时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(submitTime)) {
                throw new ProductServiceException("提交审批时间参数为空");
            }
            // 检查提交审批之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("提交审批之后的审核状态参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            for (Integer id : ids) {
                Integer effectedCount = auditProductMapper.updateAuditStatusBySubmit(id, preAuditStatusList, submitTime,
                        auditStatus, modifyUserId, modifyTime);
                if (effectedCount.intValue() != 1) {
                    AuditProductDto auditProductDto = this.loadAuditProductById(id);
                    if (!ObjectUtils.isNullOrEmpty(auditProductDto)) {
                        throw new ProductServiceException("产品：" + auditProductDto.getProductName()
                                + " 提交审批之前的审核状态只能为待审核、初审驳回，终审驳回");
                    } else {
                        throw new ProductServiceException("提交审批之前的审核状态只能为待审核、初审驳回，终审驳回");
                    }
                }
            }
            auditProductBatchInfoService.updateSubmitTime(batchNo, submitTime, modifyTime, modifyUserId);
            auditProductBatchInfoService.updateSubmitCount(batchNo, ids.size(), modifyTime, modifyUserId);
            AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                    .loadAuditProductBatchInfoByBatchNo(batchNo);
            if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)) {
                Integer submitCount = auditProductBatchInfoDto.getSubmitCount();
                if (!ObjectUtils.isNullOrEmpty(submitCount)
                        && submitCount.intValue() == auditProductBatchInfoDto.getUploadCount().intValue()
                        && !SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL.equals(auditProductBatchInfoDto
                                .getSubmitStatus())) {
                    List<String> preSubmitStatusList = new ArrayList<String>();
                    preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                    preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART);
                    auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                            SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL, modifyTime, modifyUserId);
                }
                if (!ObjectUtils.isNullOrEmpty(submitCount)
                        && submitCount.intValue() != auditProductBatchInfoDto.getUploadCount().intValue()
                        && SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE.equals(auditProductBatchInfoDto
                                .getSubmitStatus())) {
                    List<String> preSubmitStatusList = new ArrayList<String>();
                    preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                    auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                            SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART, modifyTime, modifyUserId);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusBySubmit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusByInitAudit(String batchNo, Integer id, String preAuditStatus, String auditStatus,
            Integer initAuditUserId, Date initAuditTime, String initAuditRejectReason, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException {
        try {
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("数据包产品ID参数为空");
            }
            // 检查初审之前的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatus)) {
                throw new ProductServiceException("初审之前的审核状态参数为空");
            }
            // 检查初审之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("初审之后的审核状态参数为空");
            }
            // 检查初审用户ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(initAuditUserId)) {
                throw new ProductServiceException("初审用户ID参数为空");
            }
            // 检查初审时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(initAuditTime)) {
                throw new ProductServiceException("初审时间参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            Integer effectedCount = auditProductMapper.updateAuditStatusByInitAudit(id, preAuditStatus, auditStatus,
                    initAuditUserId, initAuditTime, initAuditRejectReason, modifyUserId, modifyTime);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("初审之前的审核状态只能为待初审");
            }
            if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_INIT_AUDIT_REJECTED.equals(auditStatus)) {
                auditProductBatchInfoService.updateSubmitCount(batchNo, -1, modifyTime, modifyUserId);
                AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                        .loadAuditProductBatchInfoByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)) {
                    Integer submitCount = auditProductBatchInfoDto.getSubmitCount();
                    if (!ObjectUtils.isNullOrEmpty(submitCount) && submitCount.intValue() == 0) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE, modifyTime, modifyUserId);
                    }
                    if (!ObjectUtils.isNullOrEmpty(submitCount)
                            && submitCount.intValue() != 0
                            && SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL.equals(auditProductBatchInfoDto
                                    .getSubmitStatus())) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART, modifyTime, modifyUserId);
                    }
                }
            }
            if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FOR_FINAL_AUDIT.equals(auditStatus)) {
                AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                        .loadAuditProductBatchInfoByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)) {
                    Integer submitCount = auditProductBatchInfoDto.getSubmitCount();
                    if (!ObjectUtils.isNullOrEmpty(submitCount)
                            && submitCount.intValue() == auditProductBatchInfoDto.getUploadCount().intValue()
                            && !SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL.equals(auditProductBatchInfoDto
                                    .getSubmitStatus())) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL, modifyTime, modifyUserId);
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusByInitAudit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusByFinalAudit(String batchNo, Integer id, String preAuditStatus, String auditStatus,
            Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId,
            Date modifyTime) throws ProductServiceException {
        try {
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("数据包产品ID参数为空");
            }
            // 检查终审之前的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatus)) {
                throw new ProductServiceException("终审之前的审核状态参数为空");
            }
            // 检查终审之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("终审之后的审核状态参数为空");
            }
            // 检查终审用户ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(finalAuditUserId)) {
                throw new ProductServiceException("终审用户ID参数为空");
            }
            // 检查终审时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(finalAuditTime)) {
                throw new ProductServiceException("终审时间参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            Integer effectedCount = auditProductMapper.updateAuditStatusByFinalAudit(id, preAuditStatus, auditStatus,
                    finalAuditUserId, finalAuditTime, finalAuditRejectReason, modifyUserId, modifyTime);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("终审之前的审核状态只能为待终审");
            }
            if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINAL_AUDIT_REJECTED.equals(auditStatus)) {
                auditProductBatchInfoService.updateSubmitCount(batchNo, -1, modifyTime, modifyUserId);
                AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                        .loadAuditProductBatchInfoByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)) {
                    Integer submitCount = auditProductBatchInfoDto.getSubmitCount();
                    if (!ObjectUtils.isNullOrEmpty(submitCount) && submitCount.intValue() == 0) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE);
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_NONE, modifyTime, modifyUserId);
                    }
                    if (!ObjectUtils.isNullOrEmpty(submitCount)
                            && submitCount.intValue() != 0
                            && SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL.equals(auditProductBatchInfoDto
                                    .getSubmitStatus())) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART, modifyTime, modifyUserId);
                    }
                }
            }
            if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINISHED.equals(auditStatus)) {
                AuditProductBatchInfoDto auditProductBatchInfoDto = auditProductBatchInfoService
                        .loadAuditProductBatchInfoByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductBatchInfoDto)) {
                    Integer submitCount = auditProductBatchInfoDto.getSubmitCount();
                    if (!ObjectUtils.isNullOrEmpty(submitCount)
                            && submitCount.intValue() == auditProductBatchInfoDto.getUploadCount().intValue()
                            && !SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL.equals(auditProductBatchInfoDto
                                    .getSubmitStatus())) {
                        List<String> preSubmitStatusList = new ArrayList<String>();
                        preSubmitStatusList.add(SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_PART);
                        auditProductBatchInfoService.updateSubmitStatus(batchNo, preSubmitStatusList,
                                SystemContext.ProductDomain.AUDITPRODUCTSUBMITSTATUS_ALL, modifyTime, modifyUserId);
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusByFinalAudit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveStandardProFromPacketProByFinalAuditPass(String batchNo, Integer id, String preAuditStatus,
            String auditStatus, Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            this.updateAuditStatusByFinalAudit(batchNo, id, preAuditStatus, auditStatus, finalAuditUserId, finalAuditTime,
                    finalAuditRejectReason, modifyUserId, modifyTime);
            AuditProductDto auditProductDto = this.loadAuditProductById(id);
            List<ProductImageDto> newImgList = null;
            if (ObjectUtils.isNullOrEmpty(auditProductDto)) {
                throw new ProductServiceException("数据包产品不存在");
            }
            ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(auditProductDto.getBarCode(), SystemContext.UserDomain.CHANNELTYPE_ALL);
            ProductDto productDtoStandard = encapsulateStandardProductInfos(id, modifyUserId, modifyTime, auditProductDto,productDto);
            if(batchNo.equals("BATCHNO_UPDATE")){
            	StringBuffer deleteImageUrls = new StringBuffer("");//去除删掉的图片
            	if(!ObjectUtils.isNullOrEmpty(productDto) && !ObjectUtils.isNullOrEmpty(productDto.getProductImageDtos()) ){
            		List<ProductImageDto> oldimgList = productDto.getProductImageDtos();
            		for(ProductImageDto productImageDto: oldimgList){
            			if(ObjectUtils.isNullOrEmpty(productDtoStandard.getProductImageDtos())){
            				deleteImageUrls.append(productImageDto.getImageUrl()+",");
            			}else{
            				newImgList = productDtoStandard.getProductImageDtos();
            				for(int i=0;i<newImgList.size();i++){
                				ProductImageDto auditProductImageDto = newImgList.get(i);
                				if(productImageDto.getImageUrl().equals(auditProductImageDto.getImageUrl())){
                					break;
                				}
                				if(!productImageDto.getImageUrl().equals(auditProductImageDto.getImageUrl()) && i==(newImgList.size()-1)){
                					deleteImageUrls.append(productImageDto.getImageUrl()+",");
                				}
                			}
            			}
            		}
            		if(deleteImageUrls.toString().length()>0){
            			productDtoStandard.setDeleteImageUrls(deleteImageUrls.toString().substring(0,deleteImageUrls.toString().length()-1));
            		}
            	}
            	if(ObjectUtils.isNullOrEmpty(productDto.getProductImageDtos()) && !ObjectUtils.isNullOrEmpty(newImgList)){
            		for(ProductImageDto auditProductImageDto:newImgList ){
            			auditProductImageDto.setAppImageFlag(IMAGEFLAG_YES);
            		}
            	}else if(!ObjectUtils.isNullOrEmpty(productDto.getProductImageDtos()) && !ObjectUtils.isNullOrEmpty(newImgList)){
            		for(int i=0;i<newImgList.size();i++){
            			ProductImageDto auditProductImageDto = newImgList.get(i);
        				for(int j =0;j<productDto.getProductImageDtos().size();j++){
            				ProductImageDto productImageDto = productDto.getProductImageDtos().get(j);
            				if(productImageDto.getImageUrl().equals(auditProductImageDto.getImageUrl())){
            					auditProductImageDto.setAppImageFlag(IMAGEFLAG_NO);
            					auditProductImageDto.setId(productImageDto.getId());
            					break;
            				}
            				if(!productImageDto.getImageUrl().equals(auditProductImageDto.getImageUrl()) && j==(productDto.getProductImageDtos().size()-1)){
            					auditProductImageDto.setAppImageFlag(IMAGEFLAG_YES);
            				}
            			}
            		}
            	}
            	productDtoStandard.setId(productDto.getId());
            	productDtoStandard.getProductPriceDto().setId(productDto.getProductPriceDto().getId());
            	productDtoStandard.getProductProfileDto().setId(productDto.getProductProfileDto().getId());
            	productDtoStandard.setModifyUserId(modifyUserId);
            	productDtoStandard.setModifyTime(modifyTime);
            	productService.updateProduct(productDtoStandard, auditProductDto.getChannelCode());
            }else{
            	productService.saveProduct(productDtoStandard, auditProductDto.getChannelCode());
            }
        } catch (ProductServiceException e) {
            logger.error("saveStandardProFromPacketProByFinalAuditPass异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }
    
    private ProductDto encapsulateStandardProductInfos(Integer id, Integer modifyUserId, Date modifyTime,
            AuditProductDto auditProductDto,ProductDto productDto) {
        // 封装产品的基本信息
        ProductDto productDtoStandard = new ProductDto();
        productDtoStandard.setProductClassCode(auditProductDto.getProductClassCode());
        productDtoStandard.setBrandCode(auditProductDto.getBrandCode());
        productDtoStandard.setProductName(auditProductDto.getProductName());
        productDtoStandard.setBarCode(auditProductDto.getBarCode());
        productDtoStandard.setStatusCode(SystemContext.ProductDomain.PRODUCTSTATUS_ON);
        productDtoStandard.setChannelCode(auditProductDto.getChannelCode());
        productDtoStandard.setCreateTime(modifyTime);
        productDtoStandard.setCreateUserId(modifyUserId);
        // 封装产品的价格信息
        ProductPriceDto productPriceDto = null;
        productPriceDto = new ProductPriceDto();
        productPriceDto.setCostPrice(auditProductDto.getCostPrice()==null?0:auditProductDto.getCostPrice());
        productPriceDto.setCommissionPrice(auditProductDto.getCommissionPrice()==null?0:auditProductDto.getCommissionPrice());
        productPriceDto.setVipCommissionPrice(auditProductDto.getVipCommissionPrice()==null?0:auditProductDto.getVipCommissionPrice());
        productPriceDto.setRetailPrice(auditProductDto.getRetailPrice());
        productPriceDto.setPromotionalPrice(auditProductDto.getPromotionalPrice());
        productDtoStandard.setProductPriceDto(productPriceDto);
        // 封装产品的附属信息
        ProductProfileDto productProfileDto = new ProductProfileDto();
        productProfileDto.setDisplayOrder(auditProductDto.getDisplayOrder());
        productProfileDto.setSaleStatus(SystemContext.ProductDomain.PRODUCTSALESTATUS_ONSALE);
        productProfileDto.setMaintainStoreFlag("MAINTAINSTOREFLAG_YES");
        productProfileDto.setProductSpec(auditProductDto.getProductSpec());
        if (!ObjectUtils.isNullOrEmpty(auditProductDto.getContent())) {
            String uploadFileTempUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
            String uploadFileUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL);
            String content = auditProductDto.getContent().replaceAll(uploadFileTempUrl, uploadFileUrl);
            productProfileDto.setContent(content);
            productDtoStandard.setContentString(content);
            String regex = "";
            if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINISHED.equals(auditProductDto.getAuditStatus())) {
                regex = "(.*?)" + uploadFileUrl + "(.*?)\"";
            } else {
                regex = "(.*?)" + uploadFileTempUrl + "(.*?)\"";
            }
            Pattern ptag = Pattern.compile(regex);
            Matcher mtag = ptag.matcher(auditProductDto.getContent());
            String addContentImageUrls = "";
            String loadContentImageUrls = "";
            while (mtag.find()) {
                addContentImageUrls += mtag.group(2) + ",";
            }
            if(addContentImageUrls.length()>0)
            productDtoStandard.setAddContentImageUrls(addContentImageUrls.substring(0, addContentImageUrls.length() - 1));
            if(!ObjectUtils.isNullOrEmpty(productDto)){
            	mtag = ptag.matcher(productDto.getProductProfileDto().getContent());
            	while (mtag.find()) {
            		loadContentImageUrls += mtag.group(2) + ",";
                }
            	if(loadContentImageUrls.length()>0)
                    productDtoStandard.setLoadContentImageUrls(loadContentImageUrls.substring(0, loadContentImageUrls.length() - 1));
            }
        }
        productDtoStandard.setProductProfileDto(productProfileDto);
        // 封装产品的图片信息
        List<AuditProductImageDto> auditProductImageDtoList = auditProductImageService
                .listImagesByAuditProductIdAndChannelCode(id, auditProductDto.getChannelCode());
        if (!ObjectUtils.isNullOrEmpty(auditProductImageDtoList)) {
            List<ProductImageDto> productImageDtoList = new ArrayList<ProductImageDto>();
            for (AuditProductImageDto auditProductImageDto : auditProductImageDtoList) {
                ProductImageDto productImageDto = new ProductImageDto();
                productImageDto.setProductId(auditProductImageDto.getAuditProductId());
                productImageDto.setChannelCode(auditProductImageDto.getChannelCode());
                productImageDto.setImageUrl(auditProductImageDto.getImageUrl());
                productImageDto.setImageOrder(auditProductImageDto.getImageOrder());
                productImageDto.setMasterFlag(auditProductImageDto.getMasterFlag());
                productImageDto.setCreateTime(modifyTime);
                productImageDto.setCreateUserId(modifyUserId);
                productImageDto.setAppImageFlag(IMAGEFLAG_YES);
                productImageDtoList.add(productImageDto);
            }
            productDtoStandard.setProductImageDtos(productImageDtoList);
        }
        return productDtoStandard;
    }

    @Override
    public AuditProductDto loadAuditProductById(Integer id) throws ProductServiceException {
        AuditProductDto auditProductDto = null;
        try {
            // 检查产品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("数据包产品id参数为空");
            }
            AuditProduct auditProduct = auditProductMapper.loadById(id);
            // 检查产品对象是否为空
            if (!ObjectUtils.isNullOrEmpty(auditProduct)) {
                auditProductDto = new AuditProductDto();
                ObjectUtils.fastCopy(auditProduct, auditProductDto);
                if (!ObjectUtils.isNullOrEmpty(auditProductDto.getBrandCode())) {
                    ProductBrandDto productBrandDto = productBrandService.loadProductBrandByBrandCode(auditProductDto
                            .getBrandCode());
                    if (!ObjectUtils.isNullOrEmpty(productBrandDto)) {
                        auditProductDto.setBrandName(productBrandDto.getBrandName());
                    }
                }
                if (SystemContext.ProductDomain.AUDITPRODUCTAUDITSTATUS_FINISHED.equals(auditProductDto.getAuditStatus())) {
                    if (!ObjectUtils.isNullOrEmpty(auditProductDto.getContent())) {
                        String uploadFileTempUrl = super
                                .getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
                        String uploadFileUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL);
                        String content = auditProductDto.getContent().replaceAll(uploadFileTempUrl, uploadFileUrl);
                        auditProductDto.setContent(content);
                    }
                }
                List<AuditProductImageDto> productImageDtos = auditProductImageService
                        .listImagesByAuditProductIdAndChannelCode(auditProductDto.getId(), null);
                if (!ObjectUtils.isNullOrEmpty(productImageDtos)) {
                    auditProductDto.setProductImageDtos(productImageDtos);
                }
            }
            return auditProductDto;
        } catch (ProductServiceException e) {
            logger.error("loadAuditProductById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AuditProductDto> findAuditProducts(AuditProductQueryDto auditProductQueryDto)
            throws ProductServiceException {
        try {
            if (null == auditProductQueryDto.getStart() || auditProductQueryDto.getStart() <= 0) {
                auditProductQueryDto.setStart(1);
            }
            if (null == auditProductQueryDto.getPageSize() || auditProductQueryDto.getPageSize() <= 0) {
                auditProductQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<AuditProductDto> pageDto = new Page<AuditProductDto>(auditProductQueryDto.getStart(),
                    auditProductQueryDto.getPageSize());
            AuditProductQuery auditProductQuery = new AuditProductQuery();
            ObjectUtils.fastCopy(auditProductQueryDto, auditProductQuery);
            PageHelper.startPage(auditProductQuery.getStart(), auditProductQuery.getPageSize());
            if (!StringUtils.isEmpty(auditProductQuery.getProductClassCode())) {
                List<Object> classCodes = productClassService.getSubClassCodes(auditProductQuery.getProductClassCode());
                if(!ObjectUtils.isNullOrEmpty(classCodes)){
                	auditProductQuery.setClassCodes(classCodes);
                }
            }
            Page<AuditProduct> page = auditProductMapper.findAuditProducts(auditProductQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<AuditProduct> auditProducts = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(auditProducts)) {
                for (AuditProduct pp : auditProducts) {
                    AuditProductDto pDto = null;
                    if (!ObjectUtils.isNullOrEmpty(pp)) {
                        pDto = new AuditProductDto();
                        ObjectUtils.fastCopy(pp, pDto);
                        pDto.setAuditStatusName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.AUDITPRODUCTAUDITSTATUS.getValue(),
                                pDto.getAuditStatus()));
                        ProductClassDto productClassDto = productClassService.loadProductClassByClassCode(
                                pDto.getProductClassCode(), null);
                        if (!ObjectUtils.isNullOrEmpty(productClassDto)) {
                            pDto.setProductClassName(productClassDto.getClassName());
                        }
                        pageDto.add(pDto);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAuditProducts异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public boolean checkBarCodeIsExistInAuditProduct(String barCode, String channelCode) throws ProductServiceException {
        try {
            // 检查产品条形码参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(barCode)) {
                throw new ProductServiceException("数据包产品条形码参数为空");
            }
            // 数据包产品条形码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            AuditProductDto auditProductDto = this.loadAuditProductByBarCodeAndChannelCode(barCode, channelCode);
            return auditProductDto != null;
        } catch (Exception e) {
            logger.error("checkBarCodeIsExistInAuditProduct异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductById(Integer id, List<String> auditStatusList) throws ProductServiceException {
        try {
            // 检查数据包产品的Id是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("数据包产品的Id参数为空");
            }
            // 审核状态列表是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatusList)) {
                throw new ProductServiceException("审核状态列表参数为空");
            }
            AuditProductDto auditProductDto = this.loadAuditProductById(id);
            String productName = null;
            if (!ObjectUtils.isNullOrEmpty(auditProductDto)) {
                productName = auditProductDto.getProductName();
            }
            Integer effectedCount = auditProductMapper.deleteById(id, auditStatusList);
            if (effectedCount.intValue() != 1) {
                if (!ObjectUtils.isNullOrEmpty(productName)) {
                    throw new ProductServiceException("待删除的产品：" + productName + " 的审核状态只能为待审核、初审驳回，终审驳回");
                } else {
                    throw new ProductServiceException("待删除的产品的审核状态只能为待审核、初审驳回，终审驳回");
                }
            }
        } catch (Exception e) {
            logger.error("deleteAuditProductById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductByIdBatch(String batchNo, List<Integer> ids, List<String> auditStatusList,
            Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            // 检查数据包产品导入批次号是否为空
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("数据包产品导入批次号参数为空");
            }
            // 检查数据包产品的Id是否为空
            if (ObjectUtils.isNullOrEmpty(ids)) {
                throw new ProductServiceException("数据包产品的Id列表参数为空");
            }
            // 检查审核状态列表是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatusList)) {
                throw new ProductServiceException("审核状态列表参数为空");
            }
            // 检查更新人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            //String uploadFileTempUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
            String uploadFileUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_URL);
            
            List<String> imageUrlList = new ArrayList<String>();
            for (Integer id : ids) {
                AuditProductDto auditProductDto = this.loadAuditProductById(id);
                if (!ObjectUtils.isNullOrEmpty(auditProductDto)) {
                	if(!auditProductDto.getBatchNo().equals("BATCHNO_UPDATE")){
                		String content = auditProductDto.getContent();
                        if (!ObjectUtils.isNullOrEmpty(content)) {
                            String	regex="(.*?)" + uploadFileUrl + "(.*?)\"";
                            Pattern ptag = Pattern.compile(regex);
                            Matcher mtag = ptag.matcher(content);
                            while (mtag.find()) {
                                imageUrlList.add(mtag.group(2));
                            }
                        }
                        List<AuditProductImageDto> auditProductImageDtoList = auditProductImageService
                                .listImagesByAuditProductIdAndChannelCode(id, auditProductDto.getChannelCode());
                        if (!ObjectUtils.isNullOrEmpty(auditProductImageDtoList)) {
                            for (AuditProductImageDto auditProductImageDto : auditProductImageDtoList) {
                                imageUrlList.add(auditProductImageDto.getImageUrl());
                            }
                        }
                        this.deleteAuditProductById(id, auditStatusList);
                        auditProductImageService.deleteImageByAuditProductIdAndChannelCode(id,
                                auditProductDto.getChannelCode());
                    }else{	
						ProductDto productDto = productService.loadProductByBarCodeAndChannelCode(
								auditProductDto.getBarCode(), SystemContext.UserDomain.CHANNELTYPE_ALL);
						String content = auditProductDto.getContent();
						String productDtoContent = productDto.getProductProfileDto().getContent();
						if (!ObjectUtils.isNullOrEmpty(content)) {
							String regex = "(.*?)" + uploadFileUrl + "(.*?)\"";
							Pattern ptag = Pattern.compile(regex);
							Matcher mtag = ptag.matcher(content);
							while (mtag.find()) {
								imageUrlList.add(mtag.group(2));
							}
							List<String> imageList = new ArrayList<String>();//原产品带有的详情图
							if(!ObjectUtils.isNullOrEmpty(productDtoContent)){
								mtag = ptag.matcher(productDtoContent);
								while (mtag.find()) {
									imageList.add(mtag.group(2));
								}
								if(!ObjectUtils.isNullOrEmpty(imageList)&&!ObjectUtils.isNullOrEmpty(imageUrlList)){
									for(Iterator<String> it = imageUrlList.iterator();it.hasNext();){
										for(String oldImg:imageList){
											if(oldImg.equals(it.next())){
												it.remove();//将原产品中的详情图保留
											}
										}
									}
								}
							}
						}
						List<AuditProductImageDto> auditProductImageDtoList = auditProductImageService
								.listImagesByAuditProductIdAndChannelCode(id, auditProductDto.getChannelCode());
						List<ProductImageDto> oldimgList = productDto.getProductImageDtos();
						if (!ObjectUtils.isNullOrEmpty(auditProductImageDtoList)) {
							if(!ObjectUtils.isNullOrEmpty(oldimgList)){//原产品图片非空
								for(Iterator<AuditProductImageDto> it = auditProductImageDtoList.iterator();it.hasNext();){
		            				for(int i=0;i<oldimgList.size();i++){
		            					if(oldimgList.get(i).getImageUrl().equals(it.next().getImageUrl())){
		            						it.remove();//将原产品中的产品图片保留
		            					}
		                			}
		            			}
							}
							for (AuditProductImageDto auditProductImageDto : auditProductImageDtoList) {
								imageUrlList.add(auditProductImageDto.getImageUrl());
							}
						}
						this.deleteAuditProductById(id, auditStatusList);
						auditProductImageService.deleteImageByAuditProductIdAndChannelCode(id,
								auditProductDto.getChannelCode());
                    }
                }
            }
            auditProductBatchInfoService.updateUploadCount(batchNo, -ids.size(), modifyTime, modifyUserId);
            if (!ObjectUtils.isNullOrEmpty(imageUrlList)) {
                FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
                for (String imageUrl : imageUrlList) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                    	fileUploadUtils.deletePublishFile(imageUrl);
                        fileUploadUtils.deleteTempFile(imageUrl);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("deleteAuditProductByIdBatch异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductByBatchNo(String batchNo) throws ProductServiceException {
        try {
            // 检查数据包产品的Id是否为空
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("数据包产品的批次号参数为空");
            }
            auditProductMapper.deleteByBatchNo(batchNo);
        } catch (Exception e) {
            logger.error("deleteAuditProductByBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteAuditProductByBatchNoBatch(List<String> batchNos, List<String> submitStatusList)
            throws ProductServiceException {
        try {
            // 检查数据包产品导入批次列表是否为空
            if (ObjectUtils.isNullOrEmpty(batchNos)) {
                throw new ProductServiceException("数据包产品导入批次列表参数为空");
            }
            // 检查提交状态列表是否为空
            if (ObjectUtils.isNullOrEmpty(submitStatusList)) {
                throw new ProductServiceException("提交状态列表参数为空");
            }
            String uploadFileTempUrl = super.getSystemParamValue(SystemContext.SystemParams.UPLOAD_FILE_TEMP_URL);
            List<String> imageUrlList = new ArrayList<String>();
            for (String batchNo : batchNos) {
                List<AuditProductDto> auditProductDtos = this.listAuditProductsByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductDtos)) {
                    for (AuditProductDto auditProductDto : auditProductDtos) {
                        String content = auditProductDto.getContent();
                        if (!ObjectUtils.isNullOrEmpty(content)) {
                            String regex = "(.*?)" + uploadFileTempUrl + "(.*?)\"";
                            Pattern ptag = Pattern.compile(regex);
                            Matcher mtag = ptag.matcher(content);
                            while (mtag.find()) {
                                imageUrlList.add(mtag.group(2));
                            }
                        }
                    }
                }
                List<AuditProductImageDto> auditProductImageDtoList = auditProductImageService
                        .listImagesByBatchNo(batchNo);
                if (!ObjectUtils.isNullOrEmpty(auditProductImageDtoList)) {
                    for (AuditProductImageDto auditProductImageDto : auditProductImageDtoList) {
                        imageUrlList.add(auditProductImageDto.getImageUrl());
                    }
                }
                auditProductImageService.deleteAuditProductImageByBatchNo(batchNo);
                this.deleteAuditProductByBatchNo(batchNo);
                auditProductBatchInfoService.deleteAuditProductBatchInfoByBatchNo(batchNo, submitStatusList);
            }
            if (!ObjectUtils.isNullOrEmpty(imageUrlList)) {
                FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
                for (String imageUrl : imageUrlList) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                    	fileUploadUtils.deletePublishFile(imageUrl);
                        fileUploadUtils.deleteTempFile(imageUrl);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("deleteAuditProductByIdBatch异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<AuditProductDto> listAuditProductsByBatchNo(String batchNo) throws ProductServiceException {
        try {
            // 检查数据包产品导入批次号是否为空
            if (ObjectUtils.isNullOrEmpty(batchNo)) {
                throw new ProductServiceException("数据包产品导入批次号参数为空");
            }
            List<AuditProduct> listAuditProduct = auditProductMapper.listByBatchNo(batchNo);
            List<AuditProductDto> auditProductDtos = null;
            if (!ObjectUtils.isNullOrEmpty(listAuditProduct)) {
                auditProductDtos = new ArrayList<AuditProductDto>();
                for (AuditProduct auditProduct : listAuditProduct) {
                    AuditProductDto auditProductDto = null;
                    if (!ObjectUtils.isNullOrEmpty(auditProduct)) {
                        auditProductDto = new AuditProductDto();
                        ObjectUtils.fastCopy(auditProduct, auditProductDto);
                        auditProductDtos.add(auditProductDto);
                    }
                }
            }
            return auditProductDtos;
        } catch (ProductServiceException e) {
            logger.error("listAuditProductsByBatchNo异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Set<String> getAuditProductBarCode() throws ProductServiceException {
        try {
            List<String> auditProductBarCodeList = auditProductMapper.getAuditProductBarCode();
            Set<String> auditProductBarCodeSet = null;
            if (!ObjectUtils.isNullOrEmpty(auditProductBarCodeList)) {
                auditProductBarCodeSet = new HashSet<String>();
                for (String barCode : auditProductBarCodeList) {
                    if (!ObjectUtils.isNullOrEmpty(barCode)) {
                        auditProductBarCodeSet.add(barCode);
                    }
                }
            }
            return auditProductBarCodeSet;
        } catch (Exception e) {
            logger.error("getAuditProductBarCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
