package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.SaleZoneDto;
import com.yilidi.o2o.product.service.dto.SaleZoneProductInfoDto;

/**
 * 专区（专题与产品关联）Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月22日 上午10:57:46
 */
public interface ISaleZoneService {

    /**
     * 新增专区（专题与产品关联）
     * 
     * @param typeCode
     *            专区类型编码
     * @param productIdAndSorts
     *            产品ID与组内排序连接字符串
     * @param userId
     *            用户ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(String typeCode, String productIdAndSorts, Integer userId) throws ProductServiceException;

    /**
     * 根据ID删除专区（专题与产品关联）
     * 
     * @param id
     *            专区ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteById(Integer id) throws ProductServiceException;

    /**
     * 根据专区类型编码删除专区（专题与产品关联）
     * 
     * @param typeCode
     *            专区类型编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteByTypeCode(String typeCode) throws ProductServiceException;

    /**
     * 根据ID获取专区（专题与产品关联）
     * 
     * @param id
     *            专题与产品关联ID
     * @return SaleZoneDto 专区
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public SaleZoneDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据专区类型编码获取专区（专题与产品关联）列表
     * 
     * @param typeCode
     *            专区类型编码
     * @return List<SaleZoneDto> 专区列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<SaleZoneDto> listByTypeCode(String typeCode) throws ProductServiceException;

    /**
     * 根据专区产品查询信息获取其所关联的产品相关信息列表
     * 
     * @param saleZoneProductInfoDto
     *            专区产品查询信息DTO
     * @return List<ProductDto> 专区类型编码所关联的产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<ProductDto> listProductInfosByThemeTypeCode(SaleZoneProductInfoDto saleZoneProductInfoDto)
            throws ProductServiceException;

}
