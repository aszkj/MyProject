package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.FloorAdvertisementTypeDto;

/**
 * 楼层与广告类型关联关系Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月25日 上午11:45:42
 */
public interface IFloorAdvertisementTypeService {

    /**
     * 新增楼层与广告类型关联关系
     * 
     * @param floorAdvertisementTypeDto
     *            楼层与广告类型关联关系
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(FloorAdvertisementTypeDto floorAdvertisementTypeDto) throws ProductServiceException;

    /**
     * 根据楼层ID删除楼层与广告类型关联关系
     * 
     * @param floorId
     *            楼层ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteByFloorId(Integer floorId) throws ProductServiceException;

    /**
     * 根据广告类型编码获取该广告类型所关联的所有楼层ID列表
     * 
     * @param advertisementTypeCode
     *            广告类型编码
     * @return List<Integer> 楼层ID列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<Integer> listFloorIdsByAdvertisementTypeCode(String advertisementTypeCode) throws ProductServiceException;

    /**
     * 根据楼层ID获取该楼层所关联的广告类型编码
     * 
     * @param floorId
     *            楼层ID
     * @return String 广告类型编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public String loadAdvertisementTypeCodeByFloorId(Integer floorId) throws ProductServiceException;

}
