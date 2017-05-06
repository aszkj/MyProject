package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ThemeDto;
import com.yilidi.o2o.product.service.dto.query.ThemeQueryDto;

/**
 * 专题Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午4:04:53
 */
public interface IThemeService {

    /**
     * 保存专题信息
     * 
     * @param themeDto
     *            专题信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void save(ThemeDto themeDto) throws ProductServiceException;

    /**
     * 更新专题信息
     * 
     * @param themeDto
     *            专题信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateById(ThemeDto themeDto) throws ProductServiceException;

    /**
     * 根据ID获取专题信息
     * 
     * @param id
     *            专题信息ID
     * @return 专题信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public ThemeDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据专题类型编码获取专题信息
     * 
     * @param typeCode
     *            专题类型编码
     * @return 专题信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public ThemeDto loadByTypeCode(String typeCode) throws ProductServiceException;

    /**
     * 分页获取专题信息列表
     * 
     * @param themeQueryDto
     *            专题查询dto
     * @return 专题信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public YiLiDiPage<ThemeDto> findThemes(ThemeQueryDto themeQueryDto) throws ProductServiceException;
    /**
     * 校验专题类型是否已被专题引用
     * @param themeQueryDto
     * @return
     * @throws ProductServiceException
     */
    public List<ThemeDto> listThemes(ThemeQueryDto themeQueryDto) throws ProductServiceException;

}
