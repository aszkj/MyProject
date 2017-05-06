package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ThemeColumnDto;

/**
 * 专题栏目Service接口
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午3:22:45
 */
public interface IThemeColumnService {

    /**
     * 新增专题栏目
     * 
     * @param themeId
     *            专题ID
     * @param themeColumnInfos
     *            专题栏目相关信息连接字符串
     * @param userId
     *            用户ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(Integer themeId, String themeColumnInfos, Integer userId) throws ProductServiceException;

    /**
     * 根据ID删除专题栏目
     * 
     * @param id
     *            专题栏目ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteById(Integer id) throws ProductServiceException;

    /**
     * 根据专题ID删除其所关联的专题栏目
     * 
     * @param themeId
     *            专题ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void deleteByThemeId(Integer themeId) throws ProductServiceException;

    /**
     * 根据专题栏目ID获取专题栏目
     * 
     * @param id
     *            专题栏目ID
     * @return ThemeColumnDto 专题栏目DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public ThemeColumnDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据专题ID获取其所关联的专题栏目列表
     * 
     * @param themeId
     *            专题ID
     * @return List<ThemeColumnDto> 专题栏目列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<ThemeColumnDto> listByThemeId(Integer themeId) throws ProductServiceException;

}
