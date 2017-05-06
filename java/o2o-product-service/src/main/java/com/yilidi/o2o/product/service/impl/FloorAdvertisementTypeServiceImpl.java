package com.yilidi.o2o.product.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.FloorAdvertisementTypeMapper;
import com.yilidi.o2o.product.model.FloorAdvertisementType;
import com.yilidi.o2o.product.service.IFloorAdvertisementTypeService;
import com.yilidi.o2o.product.service.dto.FloorAdvertisementTypeDto;
import com.yilidi.o2o.service.BasicDataService;

@Service("floorAdvertisementTypeService")
public class FloorAdvertisementTypeServiceImpl extends BasicDataService implements IFloorAdvertisementTypeService {

    @Autowired
    private FloorAdvertisementTypeMapper floorAdvertisementTypeMapper;

    @Override
    public void save(FloorAdvertisementTypeDto floorAdvertisementTypeDto) throws ProductServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(floorAdvertisementTypeDto)) {
                msg = "floorAdvertisementTypeDto为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            String advertisementTypeCode = loadAdvertisementTypeCodeByFloorId(floorAdvertisementTypeDto.getFloorId());
            if (null != advertisementTypeCode) {
                deleteByFloorId(floorAdvertisementTypeDto.getFloorId());
            }
            if (!StringUtils.isEmpty(floorAdvertisementTypeDto.getAdvertisementTypeCode())) {
                FloorAdvertisementType floorAdvertisementType = new FloorAdvertisementType();
                ObjectUtils.fastCopy(floorAdvertisementTypeDto, floorAdvertisementType);
                floorAdvertisementTypeMapper.save(floorAdvertisementType);
            }
        } catch (Exception e) {
            msg = null == msg ? "新增楼层与店铺关联关系出现系统异常" : msg;
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
            floorAdvertisementTypeMapper.deleteByFloorId(floorId);
        } catch (Exception e) {
            msg = null == msg ? "根据楼层ID删除楼层与店铺关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public List<Integer> listFloorIdsByAdvertisementTypeCode(String advertisementTypeCode) throws ProductServiceException {
        String msg = null;
        List<Integer> floorIds = null;
        try {
            if (StringUtils.isEmpty(advertisementTypeCode)) {
                msg = "advertisementTypeCode为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            floorIds = floorAdvertisementTypeMapper.listFloorIdsByAdvertisementTypeCode(advertisementTypeCode);
            return floorIds;
        } catch (Exception e) {
            msg = null == msg ? "根据广告类型编码获取该店铺所关联的所有楼层ID列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

    @Override
    public String loadAdvertisementTypeCodeByFloorId(Integer floorId) throws ProductServiceException {
        String msg = null;
        String advertisementTypeCode = null;
        try {
            if (ObjectUtils.isNullOrEmpty(floorId)) {
                msg = "floorId为空";
                logger.error(msg);
                throw new ProductServiceException(msg);
            }
            advertisementTypeCode = floorAdvertisementTypeMapper.loadAdvertisementTypeCodeByFloorId(floorId);
            return advertisementTypeCode;
        } catch (Exception e) {
            msg = null == msg ? "根据楼层ID获取该楼层所关联的广告类型编码出现系统异常" : msg;
            logger.error(msg, e);
            throw new ProductServiceException(msg);
        }
    }

}
