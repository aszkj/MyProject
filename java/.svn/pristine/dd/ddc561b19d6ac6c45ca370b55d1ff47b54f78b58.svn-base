package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;

/**
 * 功能描述：userSSL服务层接口 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IConnectUserService {

    /**
     * 根据授权用户唯一标识来获取用户对象
     * 
     * @param openId
     *            授权用户唯一标识
     * @return 用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public ConnectUserDto loadByOpenId(String openId) throws UserServiceException;

    /**
     * 根据授权用户唯一标识来获取用户对象
     * 
     * @param userId
     *            用户ID
     * @param connectType
     *            接入类型
     * @return 用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public ConnectUserDto loadByUserIdAndConnectType(Integer userId, String connectType) throws UserServiceException;

    /**
     * 添加用户
     * 
     * @param connectUserDto
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void save(ConnectUserDto connectUserDto) throws UserServiceException;

    /**
     * 根据openId修改设置绑定用户ID
     * 
     * @param openId
     *            第三方接入用户唯一标识
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateBindUserIdByOpenId(String openId, Integer userId) throws UserServiceException;

    /**
     * 根据unionId修改设置绑定用户ID
     * 
     * @param unionId
     *            微信接入返回多个公共账号统一的unionId
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateBindUserIdByUnionId(String unionId, Integer userId) throws UserServiceException;

    /**
     * 绑定用户信息
     * 
     * @param openId
     *            同一用户唯一
     * @param mobile
     *            手机号码
     * @param password
     *            密码
     * @param channelCode
     *            密码
     * @return Integer
     * @throws UserServiceException
     *             服务端异常
     */
    public Integer saveBindUserInfo(String openId, String mobile, String password, String channelCode)
            throws UserServiceException;

    /**
     * 根据授权用户唯一标识来获取用户对象
     * 
     * @param unionId
     *            unionId
     * @return 接入列表
     * @throws UserServiceException
     *             服务端异常
     */
    public List<ConnectUserDto> listByUnionId(String unionId) throws UserServiceException;

    /**
     * 根据unionId和connectType来获取用户对象
     * 
     * @param unionId
     *            unionId
     * @param connectType
     *            connectType
     * @return 接入用户信息
     * @throws UserServiceException
     *             服务端异常
     */
    public ConnectUserDto loadByUnionIdAndConnectType(String unionId, String connectType) throws UserServiceException;

    /**
     * 绑定微信
     * 
     * @param code
     *            微信第三方登录标识码
     * @param tradeType
     *            APP微信第三方登录类型）： JSAPI：微信公众号第三方登录类型（即H5端微信第三方登录类型
     * @param bindUserId
     *            绑定用户ID
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateBindWX(String code, String tradeType, Integer bindUserId) throws UserServiceException;

    /**
     * 解除微信绑定
     * 
     * @param bindUserId
     *            绑定用户ID
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUnBindWX(Integer bindUserId) throws UserServiceException;

    /**
     * 绑定QQ
     * 
     * @param accessToken
     *            QQ授权的token值
     * @param openId
     *            QQ所得到的唯一标识码
     * @param bindUserId
     *            绑定用户ID
     * @param channel
     *            渠道类型,1:android,2:ios
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateBindQQ(String accessToken, String openId, Integer bindUserId, String channel)
            throws UserServiceException;

    /**
     * 解除QQ绑定
     * 
     * @param bindUserId
     *            绑定用户ID
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUnBindQQ(Integer bindUserId) throws UserServiceException;

    /**
     * 根据用户ID和接入类型列表获取接入用户信息列表
     * 
     * @param userId
     *            用户ID
     * @param connectTypes
     *            接入类型列表
     * @return 用户对象列表
     * @throws UserServiceException
     *             服务端异常
     */
    public List<ConnectUserDto> listByUserIdAndConnectTypes(Integer userId, List<String> connectTypes)
            throws UserServiceException;
}
