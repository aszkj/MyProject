package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.WarehouseLocationInfoDto;
import com.yilidi.o2o.user.service.dto.query.StoreLocationQueryDto;

/**
 * 
 * 门店service接口
 * 
 * @author: heyong
 * @date: 2015年11月11日 上午11:12:16
 * 
 */
public interface IStoreProfileService {

    /**
     * 新增保存店铺
     * 
     * @param storeProfileDto
     *            实体DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(StoreProfileDto storeProfileDto) throws UserServiceException;

    /**
     * 更新店铺
     * 
     * @param storeProfileDto
     *            实体DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void update(StoreProfileDto storeProfileDto) throws UserServiceException;

    /**
     * 查看店铺
     * 
     * @param id
     *            StoreProfileID
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadById(Integer id) throws UserServiceException;

    /**
     * 关闭或者开启店铺 修改状态
     * 
     * @param id
     *            门店ID
     * @param storeStatus
     *            状态
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateStatusById(Integer id, String storeStatus) throws UserServiceException;
    /**
     *  修改共享库存状态
     * 
     * @param id
     *            门店ID
     * @param stockShare
     *            共享库存状态
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateStockShareByStoreId(Integer id, String stockShare) throws UserServiceException;

    /**
     * 
     * 根据storeCode查找对象
     * 
     * @param storeCode
     *            门店编号
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadByStoreCode(String storeCode) throws UserServiceException;

    /**
     * 
     * 获取全国合伙人
     * 
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadNationalPartner() throws UserServiceException;

    /**
     * 
     * 获取全国体验店
     * 
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadNationalExperienceStore() throws UserServiceException;

    /**
     * 
     * 获取全国微仓
     * 
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadNationalWarehouse() throws UserServiceException;

    /**
     * 
     * 依据状态查询所有店铺信息
     * 
     * @param storeStatus
     *            门店状态
     * @return StoreProfileDto列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<StoreProfileDto> listStoreProfile(String storeStatus) throws UserServiceException;

    /**
     * 根据storeId查看店铺
     * 
     * @param storeId
     *            门店ID对应customerId
     * @param storeStatus
     *            门店状态
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadByStoreId(Integer storeId, String storeStatus) throws UserServiceException;

    /**
     * 根据小区ID查找店铺
     * 
     * @param communityId
     *            小区ID
     * @param storeStatus
     *            门店状态
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadByCommunityId(Integer communityId, String storeStatus) throws UserServiceException;

    /**
     * 根据经纬度查找最近店铺信息
     * 
     * @param longitude
     *            纬度
     * @param latitude
     *            纬度
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadNearestStoreProfileByLngAndLat(String longitude, String latitude) throws UserServiceException;

    /**
     * 获取店铺基本信息
     * 
     * @param storeId
     *            门店ID对应customerId
     * @param storeStatus
     *            门店状态
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadBasicStoreInfo(Integer storeId, String storeStatus) throws UserServiceException;

    /**
     * @Description TODO(卖家修改店铺详细信息)
     * @param storeProfileDto
     * @throws UserServiceException
     */
    public void updateStoreDetailsForSeller(StoreProfileDto storeProfileDto) throws UserServiceException;

    /**
     * 根据经度和纬度定位到指定距离范围内微仓列表
     * 
     * @param distance
     * @param longitude
     * @param latitude
     * @param storeType
     * @return List<WarehouseLocationInfoDto>
     * @throws UserServiceException
     */
    public List<WarehouseLocationInfoDto> listAroundWarehouses(Integer distance, String longitude, String latitude,
            String storeType) throws UserServiceException;

    /**
     * 根据若干店铺类型查询店铺列表
     * 
     * @param storeTypes
     * @return List<StoreProfileDto>
     * @throws UserServiceException
     */
    public List<StoreProfileDto> listByStoreTypes(List<String> storeTypes) throws UserServiceException;

    /**
     * 根据若干店铺ID获取店铺信息列表
     * 
     * @param storeIds
     * @return List<StoreProfileDto>
     * @throws UserServiceException
     */
    public List<StoreProfileDto> listStoreProfileByStoreIds(List<Integer> storeIds) throws UserServiceException;

    /**
     * 查找附近店铺列表
     * 
     * @param storeLocationQueryDto
     *            附近店铺定位查询条件
     * @return 店铺列表
     * @throws UserServiceException
     *             用户服务域异常
     */
    public List<StoreProfileDto> listAroundStores(StoreLocationQueryDto storeLocationQueryDto) throws UserServiceException;
    /**
     * 根据店铺名称获取店铺信息列表
     * @param storeName
     * @return
     * @throws UserServiceException
     */
	public List<StoreProfileDto> listStoreByName(String storeName) throws UserServiceException;
	/**
	 * 根据社区Id获取关联的店铺信息
	 * @param communityCode
	 * @return
	 */
	public List<StoreProfileDto> listStoresByCommunityCode(String communityCode) throws UserServiceException;
	/**
     * 查看店铺
     * 
     * @param id
     *            StoreProfileID
     * @return StoreProfileDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public StoreProfileDto loadByStoreId(Integer storeId) throws UserServiceException;
    /**
     * 更新店铺评价得分(定时任务调用)
     * @param storeId
     * @param storeScore
     */
    public void updateStoreScoreByStoreId(Integer storeId, Float storeScore) throws UserServiceException;
}
