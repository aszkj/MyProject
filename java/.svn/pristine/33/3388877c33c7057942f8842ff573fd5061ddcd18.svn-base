package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.RecommendCustomerStoreDto;

/**
 * 推广客户与店铺关联关系Service
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午5:10:11
 */
public interface IRecommendCustomerStoreService {

    /**
     * 新增推广客户与店铺关联关系
     * 
     * @param recommendCustomerStoreDto
     *            推广客户与店铺关联关系
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(RecommendCustomerStoreDto recommendCustomerStoreDto) throws UserServiceException;

    /**
     * 根据推广客户ID删除推广客户与店铺关联关系
     * 
     * @param recommendCustomerId
     *            推广客户ID
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void deleteByRecommendCustomerId(Integer recommendCustomerId) throws UserServiceException;

    /**
     * 根据店铺ID获取该店铺所关联的所有推广客户ID列表
     * 
     * @param storeId
     *            店铺ID
     * @return List<Integer> 推广客户ID列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<Integer> listRecommendCustomerIdsByStoreId(Integer storeId) throws UserServiceException;

    /**
     * 根据推广客户ID获取该推广客户所关联的店铺ID
     * 
     * @param recommendCustomerId
     *            推广客户ID
     * @return Integer 店铺ID
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer loadStoreIdByRecommendCustomerId(Integer recommendCustomerId) throws UserServiceException;

}
