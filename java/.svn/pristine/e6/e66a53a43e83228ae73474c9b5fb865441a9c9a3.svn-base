/**
 * 文件名称：UserProxyService.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.user.proxy;

import java.util.List;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.proxy.dto.ConsigneeAddressProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 功能描述：用户代理服务接口定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IUserProxyService {

    /**
     * 根据用户ID获取用户对象
     * 
     * @param userId
     *            用户Id
     * @return 用户对象
     * @throws UserServiceException
     *             服务层异常
     */
    public UserProxyDto getUserById(Integer userId) throws UserServiceException;

    /**
     * 根据用户的id加载用户名和email地址键值对
     * 
     * @param ids
     *            用户id列表
     * @return List<KeyValuePair<userName, emailAddress>>
     * @throws UserServiceException
     *             服务层异常
     */
    public List<KeyValuePair<String, String>> getUserEmailAndNameByIds(List<Integer> ids) throws UserServiceException;

    /**
     * 根据用户的id加载用户名和email地址键值对
     * 
     * @param ids
     *            用户id列表
     * @return List<KeyValuePair<userName, phoneNo>>
     * @throws UserServiceException
     *             服务层异常
     */
    public List<KeyValuePair<String, String>> getUserPhoneAndNameByIds(List<Integer> ids) throws UserServiceException;

    /**
     * 根据id获取收货地址
     * 
     * @param id
     *            收货地址id
     * @return 收货地址信息
     * @throws UserServiceException
     *             用户服务层异常
     */
    public ConsigneeAddressProxyDto loadConsigneeAddressById(Integer id) throws UserServiceException;

    /**
     * 
     * 根据客户类型查询userId列表
     * 
     * @param customerType
     * @return
     */
    public List<Integer> listUserIdsByCustomerType(String customerType) throws UserServiceException;

    /**
     * 
     * 根据用户账号列表查询userId列表
     * 
     * @param customerType
     * @return
     */
    public List<Integer> listUserIdsByUserNames(List<String> userNames) throws UserServiceException;

    /**
     * 
     * 根据买家用户级别查询userId列表
     * 
     * @param buyerLevel
     * @return
     */
    public List<Integer> listUserIdsByBuyerLevel(String buyerLevel) throws UserServiceException;

    /**
     * 根据用户的id加载用户列表
     * 
     * @param ids
     *            用户id列表
     * @return 用户列表
     * @throws UserServiceException
     *             服务层异常
     */
    public List<UserProxyDto> listUserByIds(List<Integer> ids) throws UserServiceException;

    /**
     * 修改用户头像url
     * 
     * @param userId
     *            用户id
     * @param avatarUrl
     *            用户头像url
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateUserAvatar(Integer userId, String avatarUrl) throws UserServiceException;

    /**
     * 获取推送用户
     * @param customerType
     * @return
     */
	public List<UserProxyDto> getPushUserByCustomerType(String customerType) throws UserServiceException;

	public UserProxyDto getUserByCustomerId(Integer customerId) throws UserServiceException;

}
