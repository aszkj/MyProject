package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.FloorMapper;
import com.yilidi.o2o.product.model.Floor;
import com.yilidi.o2o.product.service.IFloorAdvertisementTypeService;
import com.yilidi.o2o.product.service.IFloorService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.FloorDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 楼层Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午4:17:08
 */
@Service("floorService")
public class FloorServiceImpl extends BasicDataService implements IFloorService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";

    @Autowired
    private FloorMapper floorMapper;

    @Autowired
    private IProductClassService productClassServicer;

    @Autowired
    private IFloorAdvertisementTypeService floorAdvertisementTypeService;

    @Override
    public void save(FloorDto floorDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(floorDto)) {
                throw new ProductServiceException("参数floorDto不能为空");
            }
            Floor floor = new Floor();
            ObjectUtils.fastCopy(floorDto, floor);
            if (SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT.equals(floorDto.getLinkType())) {
                floor.setLinkData("floorId=" + floor.getId());
            }else if(SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT_CLASS.equals(floorDto.getLinkType())){
                if(!ObjectUtils.isNullOrEmpty(floorDto.getProductClassCode())){
                    if(!ObjectUtils.isNullOrEmpty(productClassServicer.getAllNextProductClassByUpCode(new ProductClassQuery(floorDto.getProductClassCode())))){
                        throw new ProductServiceException("分类不是最后一级的");
                    }else{
                        floor.setLinkData(floorDto.getProductClassCode());
                    }
                }
            }
            floorMapper.save(floor);
            operateImage(floorDto.getImageFlag(), floorDto.getDelImageUrl(), floorDto.getFloorImageUrl());
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateById(FloorDto floorDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(floorDto)) {
                throw new ProductServiceException("参数floorDto不能为空");
            }
            Floor floor = new Floor();
            ObjectUtils.fastCopy(floorDto, floor);
            if (SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT.equals(floorDto.getLinkType())) {
                floor.setLinkData("floorId=" + floor.getId());
            }else if(SystemContext.ProductDomain.FLOORLINKTYPE_PRODUCT_CLASS.equals(floorDto.getLinkType())){
                if(!ObjectUtils.isNullOrEmpty(floorDto.getProductClassCode())){
                    if(!ObjectUtils.isNullOrEmpty(productClassServicer.getAllNextProductClassByUpCode(new ProductClassQuery(floorDto.getProductClassCode())))){
                        throw new ProductServiceException("分类不是最后一级的");
                    }else{
                        floor.setLinkData(floorDto.getProductClassCode());
                    }
                }
            }
            floorMapper.updateByIdSelective(floor);
            operateImage(floorDto.getImageFlag(), floorDto.getDelImageUrl(), floorDto.getFloorImageUrl());
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
    public FloorDto loadById(Integer id) throws ProductServiceException {
        FloorDto floorDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            Floor floor = floorMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(floor)) {
                floorDto = new FloorDto();
                ObjectUtils.fastCopy(floor, floorDto);
                floorDto.setStatusCodeName(super.getSystemDictName(
                        SystemContext.ProductDomain.DictType.FLOORSTATUS.getValue(), floorDto.getStatusCode()));
                floorDto.setFloorImageFullUrl(StringUtils.toFullImageUrl(floorDto.getFloorImageUrl()));
            }
            return floorDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<FloorDto> listFloors() throws ProductServiceException {
        try {
            List<FloorDto> floorDtos = null;
            List<Floor> floors = floorMapper.listFloors();
            if (!ObjectUtils.isNullOrEmpty(floors)) {
                floorDtos = new ArrayList<FloorDto>();
                for (Floor floor : floors) {
                    FloorDto floorDto = new FloorDto();
                    ObjectUtils.fastCopy(floor, floorDto);
                    floorDto.setStatusCodeName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.FLOORSTATUS.getValue(), floorDto.getStatusCode()));
                    floorDto.setFloorImageFullUrl(StringUtils.toFullImageUrl(floorDto.getFloorImageUrl()));
                    String advertisementTypeCode = floorAdvertisementTypeService.loadAdvertisementTypeCodeByFloorId(floor
                            .getId());
                    floorDto.setAdvertisementTypeCode(advertisementTypeCode);
                    floorDtos.add(floorDto);
                }
            }
            return floorDtos;
        } catch (Exception e) {
            logger.error("listFloors异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
