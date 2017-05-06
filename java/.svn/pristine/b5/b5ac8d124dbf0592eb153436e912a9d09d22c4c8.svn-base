package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.UserShareCodeDto;

/**
 * 用户分享码Service服务类
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IUserShareCodeService {

    /**
     * 新增用户分享码
     * 
     * @param userShareCodeDto
     *            用户分享码DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(UserShareCodeDto userShareCodeDto) throws UserServiceException;

    /**
     * 根据ID查找用户分享码基础信息
     * 
     * @param id
     *            用户分享码ID
     * @return UserShareCodeDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public UserShareCodeDto loadById(Integer id) throws UserServiceException;

    /**
     * 根据用户ID查找基础信息
     * 
     * @param userId
     *            分享用户ID
     * @return UserShareCodeDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public UserShareCodeDto loadByShareUserId(Integer userId) throws UserServiceException;

    /**
     * 根据用户分享码查找基础信息
     * 
     * @param shareCode
     *            用户分享唯码
     * @return UserShareCodeDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public UserShareCodeDto loadByShareCode(String shareCode) throws UserServiceException;

    /**
     * 根据用户分享码和分享用户ID查找基础信息
     * 
     * @param shareCode
     *            用户分享唯码
     * @param userId
     *            分享用户ID
     * @return UserShareCodeDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public UserShareCodeDto loadByShareCodeAndUserId(String shareCode, Integer userId) throws UserServiceException;
}
