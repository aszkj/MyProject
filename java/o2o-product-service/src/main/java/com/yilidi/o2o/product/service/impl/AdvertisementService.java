package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.List;

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
import com.yilidi.o2o.product.dao.AdvertisementMapper;
import com.yilidi.o2o.product.model.Advertisement;
import com.yilidi.o2o.product.service.IAdvertisementService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 广告Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月22日 下午5:23:10
 */
@Service("advertisementService")
public class AdvertisementService extends BasicDataService implements IAdvertisementService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";

    @Autowired
    private AdvertisementMapper advertisementMapper;
    
    @Autowired
    private IProductClassService productClassService;

    @Override
    public void save(AdvertisementDto advertisementDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(advertisementDto)) {
                throw new ProductServiceException("参数advertisementDto不能为空");
            }
            Advertisement advertisement = new Advertisement();
            ObjectUtils.fastCopy(advertisementDto, advertisement);
            // 检查产品类别是否是最低一级的
            if(!ObjectUtils.isNullOrEmpty(advertisementDto.getProductClassCode())){
                if (!ObjectUtils.isNullOrEmpty(productClassService.getAllNextProductClassByUpCode(new ProductClassQuery(
                        advertisementDto.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)))) {
                    logger.error("ProductService.saveProductDto.getProductClassCode => 产品没有挂载最低级的类别上");
                    throw new ProductServiceException("产品类别就不是最低一级的类别");
                }
            }
            advertisementMapper.save(advertisement);
            operateImage(advertisementDto.getImageFlag(), advertisementDto.getDelImageUrl(), advertisementDto.getImageUrl());
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateById(AdvertisementDto advertisementDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(advertisementDto)) {
                throw new ProductServiceException("参数advertisementDto不能为空");
            }
            Advertisement advertisement = new Advertisement();
            ObjectUtils.fastCopy(advertisementDto, advertisement);
            // 检查产品类别是否是最低一级的
            if(!ObjectUtils.isNullOrEmpty(advertisementDto.getProductClassCode())){
                if (!ObjectUtils.isNullOrEmpty(productClassService.getAllNextProductClassByUpCode(new ProductClassQuery(
                        advertisementDto.getProductClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON)))) {
                    logger.error("ProductService.saveProductDto.getProductClassCode => 产品没有挂载最低级的类别上");
                    throw new ProductServiceException("产品类别就不是最低一级的类别");
                }
            }
            advertisementMapper.updateByIdSelective(advertisement);
            operateImage(advertisementDto.getImageFlag(), advertisementDto.getDelImageUrl(), advertisementDto.getImageUrl());
        } catch (Exception e) {
            logger.error("updateById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private void operateImage(String imageFlag, String delImageUrl, String classImageUrl) throws ProductServiceException {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
                fileUploadUtils.uploadPublishFile(classImageUrl);
            }
            if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
                fileUploadUtils.deletePublishFile(delImageUrl);
            }
        } catch (ProductServiceException e) {
            logger.error("operateImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public AdvertisementDto loadById(Integer id) throws ProductServiceException {
        AdvertisementDto advertisementDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            Advertisement advertisement = advertisementMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(advertisement)) {
                advertisementDto = new AdvertisementDto();
                ObjectUtils.fastCopy(advertisement, advertisementDto);
                advertisementDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.ADVERTISEMENTTYPE.getValue(), advertisementDto.getTypeCode()));
                advertisementDto.setStatusCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.ADVERTISEMENTSTATUS.getValue(),
                        advertisementDto.getStatusCode()));
                advertisementDto.setImageFullUrl(StringUtils.toFullImageUrl(advertisementDto.getImageUrl()));
            }
            return advertisementDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<AdvertisementDto> listByTypeCode(String typeCode) throws ProductServiceException {
        List<AdvertisementDto> advertisementDtos = null;
        try {
            if (ObjectUtils.isNullOrEmpty(typeCode)) {
                throw new ProductServiceException("参数typeCode不能为空");
            }
            List<Advertisement> advertisements = advertisementMapper.listByTypeCode(typeCode);
            if (!ObjectUtils.isNullOrEmpty(advertisements)) {
                advertisementDtos = new ArrayList<AdvertisementDto>();
                for (Advertisement advertisement : advertisements) {
                    AdvertisementDto advertisementDto = new AdvertisementDto();
                    ObjectUtils.fastCopy(advertisement, advertisementDto);
                    advertisementDto.setTypeCodeName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.ADVERTISEMENTTYPE.getValue(),
                            advertisementDto.getTypeCode()));
                    advertisementDto.setStatusCodeName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.ADVERTISEMENTSTATUS.getValue(),
                            advertisementDto.getStatusCode()));
                    advertisementDto.setImageFullUrl(StringUtils.toFullImageUrl(advertisementDto.getImageUrl()));
                    advertisementDtos.add(advertisementDto);
                }
            }
            return advertisementDtos;
        } catch (Exception e) {
            logger.error("listByTypeCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<AdvertisementDto> findAdvertisements(AdvertisementQuery advertisementQuery)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(advertisementQuery)) {
                throw new ProductServiceException("参数advertisementQuery不能为空");
            }
            if (null == advertisementQuery.getStart() || advertisementQuery.getStart() <= 0) {
                advertisementQuery.setStart(1);
            }
            if (null == advertisementQuery.getPageSize() || advertisementQuery.getPageSize() <= 0) {
                advertisementQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<AdvertisementDto> pageDto = new Page<AdvertisementDto>(advertisementQuery.getStart(),
                    advertisementQuery.getPageSize());
            PageHelper.startPage(advertisementQuery.getStart(), advertisementQuery.getPageSize());
            Page<Advertisement> page = advertisementMapper.findAdvertisements(advertisementQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<Advertisement> advertisements = page.getResult();
            for (Advertisement advertisement : advertisements) {
                AdvertisementDto advertisementDto = new AdvertisementDto();
                ObjectUtils.fastCopy(advertisement, advertisementDto);
                advertisementDto.setTypeCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.ADVERTISEMENTTYPE.getValue(), advertisementDto.getTypeCode()));
                advertisementDto.setStatusCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.ADVERTISEMENTSTATUS.getValue(),
                        advertisementDto.getStatusCode()));
                advertisementDto.setImageFullUrl(StringUtils.toFullImageUrl(advertisementDto.getImageUrl()));
                pageDto.add(advertisementDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findAdvertisements异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<AdvertisementDto> list(AdvertisementQuery query) throws ProductServiceException {
        try {
            List<Advertisement> adLists = advertisementMapper.list(query);
            List<AdvertisementDto> desLists = new ArrayList<AdvertisementDto>();
            if (!ObjectUtils.isNullOrEmpty(adLists)) {
                for (Advertisement ad : adLists) {
                    AdvertisementDto destAd = new AdvertisementDto();
                    ObjectUtils.fastCopy(ad, destAd);
                    desLists.add(destAd);
                }
            }
            return desLists;
        } catch (Exception e) {
            logger.error("list异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
