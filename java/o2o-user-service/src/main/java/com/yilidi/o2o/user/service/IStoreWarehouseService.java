package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.StoreWarehouseDto;
import com.yilidi.o2o.user.service.dto.WarehouseAssociatePartnerDto;
import com.yilidi.o2o.user.service.dto.query.WarehousePartnersQueryDto;

/**
 * 店铺与微仓关联关系Service
 * 
 * @author: chenlian
 * @date: 2016年6月23日 下午4:35:36
 */
public interface IStoreWarehouseService {

    /**
     * 新增店铺与微仓关联关系
     * 
     * @param storeWarehouseDto
     *            店铺与微仓关联关系DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(StoreWarehouseDto storeWarehouseDto) throws UserServiceException;

    /**
     * 根据店铺ID删除店铺与微仓关联关系
     * 
     * @param storeId
     *            店铺ID
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void deleteByStoreId(Integer storeId) throws UserServiceException;

    /**
     * 根据微仓ID获取该微仓所关联的所有店铺ID列表
     * 
     * @param warehouseId
     *            微仓ID
     * @return List<Integer> 店铺ID列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<Integer> listStoreIdsByWarehouseId(Integer warehouseId) throws UserServiceException;

    /**
     * 根据店铺ID获取该店铺所关联的微仓ID
     * 
     * @param storeId
     *            店铺ID
     * @return Integer 微仓ID
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer loadWarehouseIdByStoreId(Integer storeId) throws UserServiceException;

    /**
     * 分页获取微仓所关联的门店信息
     * 
     * @param warehousePartnersQueryDto
     *            微仓关联合伙人信息查询DTO
     * @return YiLiDiPage<WarehouseAssociatePartnerDto> 微仓关联合伙人信息
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<WarehouseAssociatePartnerDto> findWarehouseAssociatePartners(
            WarehousePartnersQueryDto warehousePartnersQueryDto) throws UserServiceException;

}
