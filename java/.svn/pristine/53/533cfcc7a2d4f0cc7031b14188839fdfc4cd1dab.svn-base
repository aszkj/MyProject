package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.FloorDto;

/**
 * 楼层Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午2:40:01
 */
public interface IFloorService {

    /**
     * 保存楼层信息
     * 
     * @param floorDto
     *            楼层信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(FloorDto floorDto) throws ProductServiceException;

    /**
     * 更新楼层信息
     * 
     * @param floorDto
     *            楼层信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateById(FloorDto floorDto) throws ProductServiceException;

    /**
     * 根据ID获取楼层信息
     * 
     * @param id
     *            楼层信息ID
     * @return 楼层信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public FloorDto loadById(Integer id) throws ProductServiceException;

    /**
     * 获取楼层信息列表
     * 
     * @return 楼层信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<FloorDto> listFloors() throws ProductServiceException;

}
