package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;

/**
 * 广告Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月22日 下午5:46:12
 */
public interface IAdvertisementService {

    /**
     * 新增广告
     * 
     * @param advertisementDto
     * @throws ProductServiceException
     */
    public void save(AdvertisementDto advertisementDto) throws ProductServiceException;

    /**
     * 修改广告
     * 
     * @param advertisementDto
     * @throws ProductServiceException
     */
    public void updateById(AdvertisementDto advertisementDto) throws ProductServiceException;

    /**
     * 根据ID获取广告信息
     * 
     * @param id
     * @return AdvertisementDto
     * @throws ProductServiceException
     */
    public AdvertisementDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据广告类型编码获取广告列表信息
     * 
     * @param typeCode
     * @return List<AdvertisementDto>
     * @throws ProductServiceException
     */
    public List<AdvertisementDto> listByTypeCode(String typeCode) throws ProductServiceException;

    /**
     * 根据查询条件分页获取广告列表信息
     * 
     * @param advertisementQuery
     * @return YiLiDiPage<AdvertisementDto>
     * @throws ProductServiceException
     */
    public YiLiDiPage<AdvertisementDto> findAdvertisements(AdvertisementQuery advertisementQuery)
            throws ProductServiceException;

    /**
     * 根据查询条件获取广告列表信息
     * 
     * @param query
     * @return List<AdvertisementDto>
     * @throws ProductServiceException
     */
    public List<AdvertisementDto> list(AdvertisementQuery query) throws ProductServiceException;

}