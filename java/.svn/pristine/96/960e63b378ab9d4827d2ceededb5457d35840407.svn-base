package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.StoreDeliveryDto;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryQuery;

/**
 * 门店接单员service接口
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午2:02:42
 * 
 */
public interface IStoreDeliveryService {

	/**
	 * 新增保存店铺接单员
	 * 
	 * @param storeDeliveryDto
	 *            实体DTO
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public void save(StoreDeliveryDto storeDeliveryDto) throws UserServiceException;

	/**
	 * 更新店铺接单员
	 * 
	 * @param storeDeliveryDto
	 *            实体DTO
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public void update(StoreDeliveryDto storeDeliveryDto) throws UserServiceException;

	/**
	 * 查看店铺接单员
	 * 
	 * @param id
	 *            店铺接单员ID
	 * @return StoreDeliveryDto
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public StoreDeliveryDto loadById(Integer id) throws UserServiceException;

	/**
	 * 修改状态 是否有效
	 * 
	 * @param id
	 *            店铺接单员ID
	 * @param state
	 *            状态
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public void updateStateById(Integer id, String state) throws UserServiceException;

	/**
	 * 
	 * 查询分页列表
	 * 
	 * @param storeDeliveryQuery
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public YiLiDiPage<StoreDeliveryDto> findStoreDelivery(StoreDeliveryQuery storeDeliveryQuery) throws UserServiceException;

	/**
	 * 重置密码
	 * 
	 * @param id
	 *            接单员ID
	 * @throws UserServiceException
	 *             用户域服务异常
	 */
	public void resetStoreDeliveryPassword(Integer id) throws UserServiceException;
}
