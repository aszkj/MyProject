package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.UserClientTokenDto;

/**
 * 用户与APP客户端Token关联关系Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月5日 下午7:40:05
 */
public interface IUserClientTokenService {

    /**
     * 新增用户与APP客户端Token关联关系
     * 
     * @param userClientTokenDto
     * @throws UserServiceException
     */
    public void save(UserClientTokenDto userClientTokenDto) throws UserServiceException;

    /**
     * 更新用户与APP客户端Token关联关系
     * 
     * @param id
     * @param clientToken
     * @param deviceToken
     * @param platform
     * @throws UserServiceException
     */
    public void update(Integer id, String clientToken, String deviceToken, String platform) throws UserServiceException;

    /**
     * 根据用户ID获取用户与APP客户端Token关联关系
     * 
     * @param userId
     * @return UserClientTokenDto
     */
    public UserClientTokenDto loadByUserId(Integer userId);

    /**
     * 根据APP客户端clientToken查询当前存在的关联关系数据信息
     * 
     * @param clientToken
     * @return UserClientTokenDto
     * @throws UserServiceException
     */
    public UserClientTokenDto loadByClientToken(String clientToken) throws UserServiceException;
    
    /**
     * 根据APP客户端deviceToken查询当前存在的关联关系数据信息
     * 
     * @param deviceToken
     * @return UserClientTokenDto
     * @throws UserServiceException
     */
    public UserClientTokenDto loadByDeviceToken(String deviceToken) throws UserServiceException;
    

    /**
     * 删除用户与APP客户端Token关联关系
     * 
     * @param userClientTokenId
     * @throws UserServiceException
     */
    public void delete(Integer userClientTokenId) throws UserServiceException;
}
