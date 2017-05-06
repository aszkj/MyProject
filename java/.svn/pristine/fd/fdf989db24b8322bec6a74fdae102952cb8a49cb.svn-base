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
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.SaleProductTempMapper;
import com.yilidi.o2o.product.model.SaleProductTemp;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductImageService;
import com.yilidi.o2o.product.service.ISaleProductImageTempService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.ISaleProductTempService;
import com.yilidi.o2o.product.service.dto.ProductImageProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;
import com.yilidi.o2o.product.service.dto.SaleProductImageTempDto;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;
import com.yilidi.o2o.product.service.dto.SaleProductProfileDto;
import com.yilidi.o2o.product.service.dto.SaleProductTempDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:临时商品服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleProductTempService")
public class SaleProductTempServiceImpl extends BasicDataService implements ISaleProductTempService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
    @Autowired
    private SaleProductTempMapper saleProductTempMapper;
    @Autowired
    private ISaleProductService saleProductService;
    @Autowired
    private ISaleProductImageService saleProductImageService;
    @Autowired
    private ISaleProductImageTempService saleProductImageTempService;
    @Autowired
    private IProductClassService productClassService;
    @Autowired
    private IProductService productService;

    @Override
    public String saveSaleProductTemp(SaleProductDto saveSaleProductDto, String channelCode, Integer modifyUserId,
            Date modifyTime) throws ProductServiceException {
        logger.debug("saveSaleProductDto -> " + saveSaleProductDto);
        try {
            // 检查商品参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto)) {
                logger.error("ProductService.saveSaleProductTemp => 保存商品参数为空");
                throw new ProductServiceException("需要保存的商品参数为空");
            }
            // 检查商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saveSaleProductDto.getId())) {
                logger.error("ProductService.saveSaleProductTemp.id => 商品ID为空");
                throw new ProductServiceException("需要保存新的商品ID为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品基础信息修改人是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                logger.error("ProductService.saveSaleProductTemp.modifyUserId=> 商品信息修改人为空");
                throw new ProductServiceException("ProductService的saveSaleProductTemp.modifyUserId方法参数modifyUserId为空");
            }
            // 检查商品基础信息修改时间是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                logger.error("ProductService.saveSaleProductTemp.modifyTime => 商品基础信息修改时间为空");
                throw new ProductServiceException("ProductService的saveSaleProductTemp方法参数modifyTime为空");
            }

            // 获取是否有删除的图片
            String delImageUrls = saveSaleProductDto.getDeleteImageUrls();
            // 将前台传过来的不标准的商品Dto图片封装成标准的图片dto列表，然后做成标准的商品dto
            List<SaleProductImageDto> listSaleProductImageDto = listSaleProductImageDto(saveSaleProductDto);
            saveSaleProductDto.setSaleProductImageDtos(listSaleProductImageDto);
            // 需要更新的商品
            SaleProductDto saleProductDto = saleProductService.loadSaleProductByIdAndChannelCode(saveSaleProductDto.getId(),
                    null, null, channelCode);
            // 检查商品临时表中是否存在相同商品信息，不存在则保存到商品临时表
            SaleProductTempDto saleProductTempDto = this
                    .loadSaleProductTempBasicInfoByIdAndChannelCode(saveSaleProductDto.getId(), channelCode);
            String errorString = "";
            if (!ObjectUtils.isNullOrEmpty(saleProductTempDto)) {
                errorString = "商品'" + saleProductTempDto.getSaleProductName() + "'已经修改，，正在等待审核，请不要重复修改，商品条形码为："
                        + saleProductTempDto.getBarCode();
            } else {
                if (!ObjectUtils.isNullOrEmpty(saleProductDto)) {
                    SaleProductTemp saleProductTemp = null;
                    // 以下基础相关信息有任何一个有修改就需要保存到临时商品表，其他基础信息不允许修改
                    if (ObjectUtils.whetherModified(saleProductDto.getSaleProductName(),
                            saveSaleProductDto.getSaleProductName())
                            || ObjectUtils.whetherModified(saleProductDto.getProductClassCode(),
                                    saveSaleProductDto.getProductClassCode())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductPriceDto().getPromotionalPrice(),
                                    saveSaleProductDto.getSaleProductPriceDto().getPromotionalPrice())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductPriceDto().getRetailPrice(),
                                    saveSaleProductDto.getSaleProductPriceDto().getRetailPrice())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductProfileDto().getHotSaleFlag(),
                                    saveSaleProductDto.getSaleProductProfileDto().getHotSaleFlag())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductProfileDto().getSaleProductSpec(),
                                    saveSaleProductDto.getSaleProductProfileDto().getSaleProductSpec())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductProfileDto().getSaleStatus(),
                                    saveSaleProductDto.getSaleProductProfileDto().getSaleStatus())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductProfileDto().getContent(),
                                    saveSaleProductDto.getSaleProductProfileDto().getContent())
                            || ObjectUtils.whetherModified(saleProductDto.getSaleProductProfileDto().getDisplayOrder(),
                                    saveSaleProductDto.getSaleProductProfileDto().getDisplayOrder())
                            || checkSaleProductImageIsModify(saleProductDto.getSaleProductImageDtos(),
                                    listSaleProductImageDto, delImageUrls)) {
                        saleProductTemp = new SaleProductTemp();
                        saleProductTemp.setProductClassCode(saveSaleProductDto.getProductClassCode());
                        saleProductTemp.setSaleProductId(saveSaleProductDto.getId());
                        saleProductTemp.setProductId(saleProductDto.getProductId());
                        saleProductTemp.setBarCode(saleProductDto.getBarCode());
                        saleProductTemp.setStoreId(saleProductDto.getStoreId());
                        saleProductTemp.setSaleProductName(saveSaleProductDto.getSaleProductName());
                        saleProductTemp
                                .setPromotionalPrice(saveSaleProductDto.getSaleProductPriceDto().getPromotionalPrice());
                        saleProductTemp.setRetailPrice(saveSaleProductDto.getSaleProductPriceDto().getRetailPrice());
                        saleProductTemp.setHotSaleFlag(saveSaleProductDto.getSaleProductProfileDto().getHotSaleFlag());
                        saleProductTemp
                                .setSaleProductSpec(saveSaleProductDto.getSaleProductProfileDto().getSaleProductSpec());
                        saleProductTemp.setSaleStatus(saveSaleProductDto.getSaleProductProfileDto().getSaleStatus());
                        saleProductTemp.setContent(saveSaleProductDto.getSaleProductProfileDto().getContent());
                        saleProductTemp.setDisplayOrder(saveSaleProductDto.getSaleProductProfileDto().getDisplayOrder());
                        saleProductTemp.setChannelCode(channelCode);
                        saleProductTemp.setModifyTime(modifyTime);
                        saleProductTemp.setModifyUserId(modifyUserId);
                        saleProductTemp.setCommissionPrice(saveSaleProductDto.getCommissionPrice());
                        saleProductTemp.setCostPrice(saveSaleProductDto.getCostPrice());
                        saleProductTemp.setVipCommissionPrice(saveSaleProductDto.getVipCommissionPrice());
                        // 未审核
                        saleProductTemp.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_NOT_YET);
                        // 信息保存到临时商品表
                        saleProductTempMapper.saveSaleProductTemp(saleProductTemp);

                        // 保存临时商品图片信息
                        List<SaleProductImageTempDto> saleProductImageTempDtos = null;
                        if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDto)) {
                            saleProductImageTempDtos = new ArrayList<SaleProductImageTempDto>();
                            for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                                SaleProductImageTempDto saleProductImageTempDto = null;
                                if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
                                    saleProductImageTempDto = new SaleProductImageTempDto();
                                    ObjectUtils.fastCopy(saleProductImageDto, saleProductImageTempDto);
                                    saleProductImageTempDto.setTempId(saleProductTemp.getTempId());
                                    saleProductImageTempDto.setSaleProductId(saleProductTemp.getSaleProductId());
                                    saleProductImageTempDto.setCreateUserId(modifyUserId);
                                    saleProductImageTempDto.setCreateTime(modifyTime);
                                    saleProductImageTempDto.setChannelCode(channelCode);
                                    saleProductImageTempDtos.add(saleProductImageTempDto);
                                }
                            }
                            saleProductImageTempService.saveSaleProductImageTemps(saleProductImageTempDtos);
                        }
                        // 更改原商品审核状态为未审核状态
                        saleProductService.updateSaleProductAuditStatusCodeById(saveSaleProductDto.getId(),
                                SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_NOT_YET,
                                saveSaleProductDto.getAuditNote(), modifyUserId, modifyTime);

                        // 更新正式服务器上的图片
                        this.operateSaleProductImage(listSaleProductImageDto, null);
                    }
                }
            }
            return errorString;
        } catch (ProductServiceException e) {
            logger.error("保存商品出错");
            throw new ProductServiceException("异常：保存商品出错");
        }
    }

    // 增加商品图片到正式服务器
    private void operateSaleProductImage(List<SaleProductImageDto> listSaleProductImageDto,
            List<HashMap<String, Object>> delImageUrls) throws ProductServiceException {
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

                for (HashMap<String, Object> imageUrl : delImageUrls) {
                    if (!ObjectUtils.isNullOrEmpty(imageUrl)) {
                        fileUploadUtils.deletePublishFile((String) imageUrl.get("delImageUrl"));
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("增加商品图片到正式服务器出错！");
            throw new ProductServiceException("异常：增加商品图片到正式服务器出错！");
        }
    }

    // 判断所修改的商品的图片信息是否已经修改
    private boolean checkSaleProductImageIsModify(List<SaleProductImageDto> listSaleProductImageDto,
            List<SaleProductImageDto> listSaleProductImageChangeDto, String delImageUrls) {
        boolean isAdd = false;
        boolean isdel = false;
        boolean isMod = false;
        try {
            // 循环图片
            if (!ObjectUtils.isNullOrEmpty(listSaleProductImageChangeDto)) {
                for (SaleProductImageDto saleProductImageChangeDto : listSaleProductImageChangeDto) {
                    // 判断图片是否有增加
                    if (!ObjectUtils.isNullOrEmpty(saleProductImageChangeDto)
                            && (ObjectUtils.isNullOrEmpty(saleProductImageChangeDto.getId()))) {
                        isAdd = true;
                        break;
                    }
                }
                for (SaleProductImageDto saleProductImageChangeDto : listSaleProductImageChangeDto) {
                    // 判断主图标示是否有更改 循环原始的的图片列表找到主图，与修改后的商品图片列表的主图对比，如果id变了或者id为空，则表示修改了
                    if (!ObjectUtils.isNullOrEmpty(saleProductImageChangeDto)
                            && !ObjectUtils.isNullOrEmpty(saleProductImageChangeDto.getMasterFlag())
                            && SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES
                                    .equals(saleProductImageChangeDto.getMasterFlag())) {
                        for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                            if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)
                                    && !ObjectUtils.isNullOrEmpty(saleProductImageDto.getMasterFlag())
                                    && SystemContext.ProductDomain.PRODUCTIMAGEMASTERFLAG_YES
                                            .equals(saleProductImageChangeDto.getMasterFlag())
                                    && (ObjectUtils.isNullOrEmpty(saleProductImageChangeDto.getId()) || (saleProductImageDto
                                            .getId().intValue() != saleProductImageChangeDto.getId().intValue()))) {
                                isMod = true;
                                break;
                            }
                        }
                    }
                }
                // 判断图片是否减少
                if (ObjectUtils.isNullOrEmpty(delImageUrls)) {
                    isdel = false;
                }
            }
        } catch (ProductServiceException e) {
            logger.error("判断所修改的商品的图片信息是否已经修改出错", e);
            throw new ProductServiceException("异常：判断所修改的商品的图片信息是否已经修改出错");
        }
        return isMod || isAdd || isdel;
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
    public SaleProductTempDto loadSaleProductTempBasicInfoById(Integer tempId) throws ProductServiceException {
        logger.debug("tempId -> " + tempId);
        try {
            // 检查临时商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(tempId)) {
                logger.error("ProductService.loadSaleProductByIdAndChannelCode.tempId => 临时商品Id参数为空");
                throw new ProductServiceException("临时商品tempId参数为空");
            }
            SaleProductTemp saleProductTemp = saleProductTempMapper.loadSaleProductTempById(tempId);
            SaleProductTempDto saleProductTempDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductTemp)) {
                saleProductTempDto = new SaleProductTempDto();
                ObjectUtils.fastCopy(saleProductTemp, saleProductTempDto);
            }
            return saleProductTempDto;
        } catch (ProductServiceException e) {
            logger.error("查询单个临时商品基础信息出错", e);
            throw new ProductServiceException("异常：查询单个临时商品基础信息出错");
        }
    }

    @Override
    public SaleProductTempDto loadSaleProductTempBasicInfoByIdAndChannelCode(Integer saleProductId, String channelCode)
            throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
        try {
            // 检查临时商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("ProductService.loadSaleProductByIdAndChannelCode.saleProductId => 商品Id参数为空");
                throw new ProductServiceException("商品saleProductId参数为空");
            }
            // 检查临时商品channelCode参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductTemp saleProductTemp = saleProductTempMapper
                    .loadSaleProductTempBasicInfoByIdAndChannelCode(saleProductId, channelCode);
            SaleProductTempDto saleProductTempDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductTemp)) {
                saleProductTempDto = new SaleProductTempDto();
                ObjectUtils.fastCopy(saleProductTemp, saleProductTempDto);
            }
            return saleProductTempDto;
        } catch (ProductServiceException e) {
            logger.error("查询单个临时商品基础信息出错", e);
            throw new ProductServiceException("异常：查询单个临时商品基础信息出错");
        }
    }

    @Override
    public SaleProductDto loadSaleProductTempByIdAndChannelCode(Integer saleProductId, String channelCode)
            throws ProductServiceException {
        logger.debug("saleProductId -> " + saleProductId + "channelCode -> " + channelCode);
        try {
            // 检查临时商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(saleProductId)) {
                logger.error("ProductService.loadSaleProductByIdAndChannelCode.saleProductId => 临时商品Id参数为空");
                throw new ProductServiceException("临时商品saleProductId参数为空");
            }
            // 检查临时商品channelCode参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            SaleProductTempDto saleProductTempDto = this.loadSaleProductTempBasicInfoByIdAndChannelCode(saleProductId,
                    channelCode);
            SaleProductDto saleProductDto = null;
            if (!ObjectUtils.isNullOrEmpty(saleProductTempDto)) {
                // 封装图片列表信息
                List<SaleProductImageTempDto> saleProductImageTempDtoList = saleProductImageTempService
                        .listSaleProductImageTempsBySaleProductIdAndChannelCode(saleProductId, channelCode);
                if (!ObjectUtils.isNullOrEmpty(saleProductImageTempDtoList)) {
                    saleProductTempDto.setSaleProductImageTempDtos(saleProductImageTempDtoList);
                }
                // 封装成正式商品给前台显示
                saleProductDto = this.pakageToSaleProductDto(saleProductTempDto);
            }
            return saleProductDto;
        } catch (ProductServiceException e) {
            logger.error("查询单个临时商品基础信息出错", e);
            throw new ProductServiceException("异常：查询单个临时商品基础信息出错");
        }
    }

    /**
     * 将临时商品Dto封装成商品Dto（前台显示用）
     * 
     * @param productDto
     *            商品Dto
     * @param storeId
     *            商店Id
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageToSaleProductDto(SaleProductTempDto saleProductTempDto) {
        SaleProductDto saleProductDto = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductTempDto)) {
                saleProductDto = new SaleProductDto();
                saleProductDto.setStoreId(saleProductTempDto.getStoreId());
                saleProductDto.setProductId(saleProductTempDto.getProductId());
                saleProductDto.setProductClassCode(saleProductTempDto.getProductClassCode());
                saleProductDto.setParentCode(saleProductTempDto.getParentCode());
                saleProductDto.setSaleProductName(saleProductTempDto.getSaleProductName());
                saleProductDto.setBarCode(saleProductTempDto.getBarCode());
                // 审核状态
                saleProductDto.setAuditStatusCode(saleProductTempDto.getAuditStatusCode());
                // 封装商品的价格信息
                SaleProductPriceDto saleProductPriceDto = new SaleProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductTempDto.getPromotionalPrice())) {
                    saleProductPriceDto.setPromotionalPrice(saleProductTempDto.getPromotionalPrice());
                }
                saleProductPriceDto.setRetailPrice(saleProductTempDto.getRetailPrice());
                saleProductDto.setSaleProductPriceDto(saleProductPriceDto);
                // 封装商品的附属信息
                SaleProductProfileDto saleProductProfileDto = new SaleProductProfileDto();
                saleProductProfileDto.setContent(saleProductTempDto.getContent());
                saleProductProfileDto.setDisplayOrder(saleProductTempDto.getDisplayOrder());
                saleProductProfileDto.setHotSaleFlag(saleProductTempDto.getHotSaleFlag());
                saleProductProfileDto.setSaleStatus(saleProductTempDto.getSaleStatus());
                saleProductProfileDto.setSaleProductSpec(saleProductTempDto.getSaleProductSpec());
                saleProductProfileDto.setChannelCode(saleProductTempDto.getChannelCode());
                saleProductDto.setSaleProductProfileDto(saleProductProfileDto);
                // 封装商品的图片信息
                List<SaleProductImageTempDto> productImageTempDtoList = saleProductTempDto.getSaleProductImageTempDtos();
                List<SaleProductImageDto> saleProductImageDtoList = null;
                if (!ObjectUtils.isNullOrEmpty(productImageTempDtoList)) {
                    saleProductImageDtoList = new ArrayList<SaleProductImageDto>();
                    for (SaleProductImageTempDto saleProductImageTempDto : productImageTempDtoList) {
                        SaleProductImageDto saleProductImageDto = null;
                        if (!ObjectUtils.isNullOrEmpty(saleProductImageTempDto)) {
                            saleProductImageDto = new SaleProductImageDto();
                            saleProductImageDto.setImageUrl(saleProductImageTempDto.getImageUrl());
                            saleProductImageDto.setMasterFlag(saleProductImageTempDto.getMasterFlag());
                            saleProductImageDto.setImageOrder(saleProductImageTempDto.getImageOrder());
                            saleProductImageDto.setChannelCode(saleProductImageTempDto.getChannelCode());
                            saleProductImageDto.setSaleProductId(saleProductImageTempDto.getSaleProductId());
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
    public String auditSaleProductTemp(SaleProductDto auditSaleProductDto, String channelCode, Integer auditUserId,
            Date auditTime) throws ProductServiceException {
        try {
            // 检查更新商品id参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditSaleProductDto)) {
                logger.error("ProductService.auditSaleProductTemp => 审核商品为空");
                throw new ProductServiceException("需要审核的商品为空");
            }
            // 检查更新商品id参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditSaleProductDto.getId())) {
                logger.error("ProductService.auditSaleProductTemp => 审核商品id参数为空");
                throw new ProductServiceException("需要审核的商品id参数为空");
            }
            // 检查商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(auditSaleProductDto.getAuditStatusCode())) {
                logger.error("ProductService.auditSaleProductTemp.auditStatsusCode => 商品auditStatsusCode为空");
                throw new ProductServiceException("需要更新的商品ID为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 检查商品基础信息审核人是否为空
            if (ObjectUtils.isNullOrEmpty(auditUserId)) {
                logger.error("ProductService.auditSaleProductTemp.auditUserId=> 商品信息审核人为空");
                throw new ProductServiceException("ProductService的auditSaleProductTemp.modifyUserId方法参数auditUserId为空");
            }
            // 检查商品基础信息审核时间是否为空
            if (ObjectUtils.isNullOrEmpty(auditTime)) {
                logger.error("ProductService.auditSaleProductTemp.auditTime => 商品基础信息审核时间为空");
                throw new ProductServiceException("ProductService的auditSaleProductTemp方法参数审核时间为空");
            }
            // 如果审核通过，就将临时表中得此商品修改信息保存到商品库中 否则，只更新商品库的商品状态以及删除正式图片服务器上的图片
            // 需要审核的正式库商品
            SaleProductDto saleProductDto = saleProductService.loadSaleProductByIdAndChannelCode(auditSaleProductDto.getId(),
                    null, null, channelCode);
            // 品临时表中相同商品信息
            SaleProductTempDto saleProductTempDto = this
                    .loadSaleProductTempBasicInfoByIdAndChannelCode(auditSaleProductDto.getId(), channelCode);
            // 封装前台传过来的图片信息列表
            List<SaleProductImageDto> listSaleProductImageDtoAudit = listSaleProductImageDto(auditSaleProductDto);
            List<HashMap<String, Object>> delImageUrls = null;
            if (auditSaleProductDto.getAuditStatusCode().equals(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED)) {
                // 删除数据库中原商品的图片记录
                List<Integer> delImageId = null;
                List<SaleProductImageDto> listSaleProductImageDtos = null;
                if (!ObjectUtils.isNullOrEmpty(saleProductDto.getSaleProductImageDtos())) {
                    delImageId = new ArrayList<Integer>();
                    listSaleProductImageDtos = saleProductDto.getSaleProductImageDtos();
                    for (SaleProductImageDto saleProductImageDto : listSaleProductImageDtos) {
                        if (!ObjectUtils.isNullOrEmpty(saleProductImageDto)) {
                            delImageId.add(saleProductImageDto.getId());
                        }
                    }
                }
                // 删除原始商品中得图片信息，通过更新重新添加和更新图片
                if (!ObjectUtils.isNullOrEmpty(delImageId)) {
                    saleProductImageService.deleteSaleProductImagesById(delImageId, auditUserId, auditTime);
                }
                // 封装前获取需要删除的图片Url
                delImageUrls = this.getDelImageUrls(saleProductDto.getSaleProductImageDtos(), listSaleProductImageDtoAudit);
                // 将临时商品的信息封装到正式商品信息里，然后做更新操作
                this.pakageSaleProductDto(saleProductDto, auditSaleProductDto, saleProductTempDto, channelCode, auditUserId,
                        auditTime);
                saleProductService.updateSaleProduct(saleProductDto, channelCode);

            } else if (auditSaleProductDto.getAuditStatusCode()
                    .equals(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_NOT_PASSED)) {

                delImageUrls = this.getDelImageUrls(listSaleProductImageDtoAudit, saleProductDto.getSaleProductImageDtos());
                // 删除图片服务器上正式的图片
                saleProductService.updateSaleProductAuditStatusCodeById(auditSaleProductDto.getId(),
                        auditSaleProductDto.getAuditStatusCode(), auditSaleProductDto.getAuditNote(), auditUserId,
                        auditTime);
            }
            // 无论审核是否通过，都需要删除临时表中的数据
            this.deleteSaleProductTemp(saleProductTempDto.getTempId(), channelCode);
            // 删除图片服务器上正式的图片
            this.operateSaleProductImage(null, delImageUrls);

        } catch (ProductServiceException e) {
            logger.error("审核临时商品出错", e);
            throw new ProductServiceException("异常：审核临时商品出错");
        }
        return null;
    }

    /**
     * 封装前获取需要删除的图片Url
     * 
     * @param listSaleProductImageDtoDelete
     *            有需要上传图片的图片dto列表
     * @param listSaleProductImageDto
     *            需要保留图片的的图片Dto
     * @return String 需要删除的URL字符串和id列表
     * @throws SaleProductServiceException
     */
    private List<HashMap<String, Object>> getDelImageUrls(List<SaleProductImageDto> listSaleProductImageDtoDelete,
            List<SaleProductImageDto> listSaleProductImageDto) {
        List<HashMap<String, Object>> delImageUrls = null;
        try {
            if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDtoDelete)) {
                delImageUrls = new ArrayList<HashMap<String, Object>>();
                for (SaleProductImageDto saleProductImageDtoDelete : listSaleProductImageDtoDelete) {
                    boolean isDel = true;
                    if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDto)) {
                        for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                            if (saleProductImageDtoDelete.getImageUrl().equals(saleProductImageDto.getImageUrl())) {
                                isDel = false;
                            }
                        }
                    }
                    HashMap<String, Object> delImageUrlMap = null;
                    if (isDel && !ObjectUtils.isNullOrEmpty(saleProductImageDtoDelete.getImageUrl())) {
                        delImageUrlMap = new HashMap<String, Object>();
                        delImageUrlMap.put("delImageUrl", saleProductImageDtoDelete.getImageUrl());
                        delImageUrlMap.put("delImageId", saleProductImageDtoDelete.getId());
                        delImageUrls.add(delImageUrlMap);
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("获取需要删除的临时图片url失败" + e.getMessage());
        }
        return delImageUrls;

    }

    /**
     * 将临时商品Dto封装成商品Dto（审核）
     * 
     * @param saleProductDto
     *            原店铺里商品 商品Dto
     * @param auditSaleProductDto
     *            审核页面传过来的商品 商品Dto
     * @param saleProductTempDto
     *            修改后的商品，临时商品表里的商品 商品Dto
     * @param channelCode
     *            渠道编码
     * @param auditUserId
     *            审核人
     * @param auditTime
     *            审核时间
     * @return MsgBean
     * @throws SaleProductServiceException
     */
    private SaleProductDto pakageSaleProductDto(SaleProductDto saleProductDto, SaleProductDto auditSaleProductDto,
            SaleProductTempDto saleProductTempDto, String channelCode, Integer auditUserId, Date auditTime) {
        try {
            if (!ObjectUtils.isNullOrEmpty(saleProductDto) && !ObjectUtils.isNullOrEmpty(saleProductTempDto)) {
                // 封装基本信息
                saleProductDto.setSaleProductName(saleProductTempDto.getSaleProductName());
                saleProductDto.setProductClassCode(saleProductTempDto.getProductClassCode());
                saleProductDto.setParentCode(saleProductTempDto.getParentCode());
                saleProductDto.setAuditStatusCode(auditSaleProductDto.getAuditStatusCode());
                saleProductDto.setAuditNote(auditSaleProductDto.getAuditNote());
                saleProductDto.setAuditUserId(auditUserId);
                saleProductDto.setAuditTime(auditTime);
                saleProductDto.setModifyUserId(saleProductTempDto.getModifyUserId());
                saleProductDto.setModifyTime(saleProductTempDto.getModifyTime());
                // 封装价格信息
                SaleProductPriceDto saleProductPriceDto = saleProductDto.getSaleProductPriceDto();
                if (!ObjectUtils.isNullOrEmpty(saleProductTempDto.getPromotionalPrice())) {
                    saleProductPriceDto.setPromotionalPrice(saleProductTempDto.getPromotionalPrice());
                }
                saleProductPriceDto.setRetailPrice(saleProductTempDto.getRetailPrice());
                // 封装附加属性信息
                SaleProductProfileDto saleProductProfileDto = saleProductDto.getSaleProductProfileDto();
                saleProductProfileDto.setContent(saleProductTempDto.getContent());
                saleProductProfileDto.setSaleProductSpec(saleProductTempDto.getSaleProductSpec());
                saleProductProfileDto.setHotSaleFlag(saleProductTempDto.getHotSaleFlag());
                saleProductProfileDto.setSaleStatus(saleProductTempDto.getSaleStatus());
                if (!ObjectUtils.isNullOrEmpty(saleProductTempDto.getDisplayOrder())) {
                    saleProductProfileDto.setDisplayOrder(saleProductTempDto.getDisplayOrder());
                }
                // 封装图片信息
                // 封装前台传过来的图片信息列表
                List<SaleProductImageDto> listSaleProductImageDto = listSaleProductImageDto(auditSaleProductDto);
                // 检查商品图片信息参数对象是否为空
                if (!ObjectUtils.isNullOrEmpty(listSaleProductImageDto)) {
                    for (SaleProductImageDto saleProductImageDto : listSaleProductImageDto) {
                        saleProductImageDto.setSaleProductId(auditSaleProductDto.getId());
                        saleProductImageDto.setModifyUserId(auditSaleProductDto.getModifyUserId());
                        saleProductImageDto.setModifyTime(auditSaleProductDto.getModifyTime());
                        saleProductImageDto.setChannelCode(channelCode);
                    }
                    saleProductDto.setSaleProductImageDtos(listSaleProductImageDto);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            logger.info("封装商品失败" + e.getMessage());
        }
        return saleProductDto;
    }

    @Override
    public void deleteSaleProductTemp(Integer deleteId, String channelCode) throws ProductServiceException {
        logger.debug("deleteId -> " + deleteId + "channelCode -> " + channelCode);
        try {
            // 检查商品ID参数对象是否为空
            if (ObjectUtils.isNullOrEmpty(deleteId)) {
                logger.error("ProductService.deleteSaleProductTemp.id => 商品ID为空");
                throw new ProductServiceException("需要删除的商品ID为空");
            }
            // 商品渠道编码是否为空
            if (ObjectUtils.isNullOrEmpty(channelCode)) {
                channelCode = SystemContext.UserDomain.CHANNELTYPE_ALL;
            }
            // 删除临时商品表基础信息
            saleProductTempMapper.deleteSaleProductTemp(deleteId);
            // 删除临时图片信息
            saleProductImageTempService.deleteSaleProductImageTemps(deleteId, channelCode);

        } catch (ProductServiceException e) {
            logger.error("删除临时商品出错", e);
            throw new ProductServiceException("异常：删除临时商品出错");
        }

    }
}
