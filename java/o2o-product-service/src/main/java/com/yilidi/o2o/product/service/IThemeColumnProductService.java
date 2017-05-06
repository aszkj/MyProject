package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ThemeColumnProductDto;
import com.yilidi.o2o.product.service.dto.ThemeColumnProductInfoDto;

/**
 * 专题栏目与产品关联关系Service接口
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午4:07:02
 */
public interface IThemeColumnProductService {

    /**
     * 新增专题栏目与产品关联关系
     * 
     * @param themeColumnId
     *            专题栏目ID
     * @param productIdAndSorts
     *            产品ID与组内排序连接字符串
     * @param userId
     *            用户ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(Integer themeColumnId, String productIdAndSorts, Integer userId) throws ProductServiceException;

    /**
     * 根据ID删除专题栏目与产品关联关系
     * 
     * @param id
     *            关联关系ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteById(Integer id) throws ProductServiceException;

    /**
     * 根据专题栏目ID删除专题栏目与产品关联关系
     * 
     * @param themeColumnId
     *            专题栏目ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteByThemeColumnId(Integer themeColumnId) throws ProductServiceException;

    /**
     * 根据关联关系ID获取专题栏目与产品关联关系
     * 
     * @param id
     *            关联关系ID
     * @return ThemeColumnProductDto 专题栏目与产品关联关系DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public ThemeColumnProductDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据专题栏目ID获取专题栏目与产品关联关系列表
     * 
     * @param themeColumnId
     *            专题栏目ID
     * @return List<ThemeColumnProductDto> 专题栏目与产品关联关系列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<ThemeColumnProductDto> listByThemeColumnId(Integer themeColumnId) throws ProductServiceException;

    /**
     * 根据专题栏目查询信息获取其所关联的产品相关信息列表
     * 
     * @param themeColumnProductInfoDto
     *            专题栏目与产品关联关系查询信息DTO
     * @return List<ProductDto> 专题栏目所关联的产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<ProductDto> listProductInfosByThemeColumnId(ThemeColumnProductInfoDto themeColumnProductInfoDto)
            throws ProductServiceException;

}
