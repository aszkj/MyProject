package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.FloorProductDto;
import com.yilidi.o2o.product.service.dto.FloorProductInfoDto;
import com.yilidi.o2o.product.service.dto.ProductDto;

/**
 * 楼层与产品关联关系Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午6:05:47
 */
public interface IFloorProductService {

    /**
     * 新增楼层与产品关联关系
     * 
     * @param floorId
     *            楼层ID
     * @param productIdAndSorts
     *            产品ID与组内排序连接字符串
     * @param userId
     *            用户ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(Integer floorId, String productIdAndSorts, Integer userId) throws ProductServiceException;

    /**
     * 根据ID删除楼层与产品关联关系
     * 
     * @param id
     *            关联关系ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteById(Integer id) throws ProductServiceException;

    /**
     * 根据楼层ID删除楼层与产品关联关系
     * 
     * @param floorId
     *            楼层ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteByFloorId(Integer floorId) throws ProductServiceException;

    /**
     * 根据关联关系ID获取楼层与产品关联关系
     * 
     * @param id
     *            关联关系ID
     * @return FloorProductDto 楼层与产品关联关系DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public FloorProductDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据楼层ID获取楼层与产品关联关系列表
     * 
     * @param floorId
     *            楼层ID
     * @return List<FloorProductDto> 楼层与产品关联关系列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<FloorProductDto> listByFloorId(Integer floorId) throws ProductServiceException;

    /**
     * 根据楼层查询信息获取其所关联的产品相关信息列表
     * 
     * @param floorProductInfoDto
     *            楼层与产品关联关系查询信息DTO
     * @return List<ProductDto> 楼层所关联的产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<ProductDto> listProductInfosByFloorId(FloorProductInfoDto floorProductInfoDto)
            throws ProductServiceException;

}
