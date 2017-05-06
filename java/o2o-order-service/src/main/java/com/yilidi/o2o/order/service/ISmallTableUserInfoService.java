package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.SmallTableUserInfoDto;

/**
 * 用户信息小表Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午10:58:03
 */
public interface ISmallTableUserInfoService {

    /**
     * 保存用户信息小表
     * 
     * @param smallTableUserInfoDto
     *            用户信息小表
     * @throws OrderServiceException
     *             服务异常
     */
    public void save(SmallTableUserInfoDto smallTableUserInfoDto) throws OrderServiceException;

    /**
     * 根据用户ID更新用户信息小表
     * 
     * @param smallTableUserInfoDto
     *            用户信息小表
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateByUserId(SmallTableUserInfoDto smallTableUserInfoDto) throws OrderServiceException;

    /**
     * 根据用户ID获取用户信息小表
     * 
     * @param userId
     *            用户ID
     * @return SmallTableUserInfoDto 用户信息小表DTO
     * @throws OrderServiceException
     *             服务异常
     */
    public SmallTableUserInfoDto loadByUserId(Integer userId) throws OrderServiceException;

    /**
     * 根据用户ID获取用户信息小表列表（当存在一个客户对应多个用户时就会返回列表）
     * 
     * @param customerId
     *            客户ID
     * @return List<SmallTableUserInfoDto> 用户信息小表DTO列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<SmallTableUserInfoDto> listByCustomerId(Integer customerId) throws OrderServiceException;

}
