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

import java.util.Date;

import com.yilidi.o2o.core.exception.UserServiceException;

/**
 * 功能描述：用户分享代理服务接口定义 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IUserShareProxyService {

    /**
     * 登录保存分享奖励信息
     * 
     * @param userId
     *            用户ID
     * @param nowTime
     *            当前时间
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveUserShareAwardForLoginContidion(Integer userId, Date nowTime) throws UserServiceException;

    /**
     * 下单指定商品保存分享奖励信息
     * 
     * @param userId
     *            用户ID
     * @param nowTime
     *            当前时间
     * @param orderNo
     *            订单编号
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveUserShareAwardForProductOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException;

    /**
     * 下单指定商品保存分享奖励信息
     * 
     * @param userId
     *            用户ID
     * @param nowTime
     *            当前时间
     * @param orderNo
     *            订单编号
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveUserShareAwardForAnyOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException;

    /**
     * 用户注册保存分享奖励信息
     * 
     * @param userId
     *            用户ID
     * @param nowTime
     *            当前时间
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveUserShareAwardForRegisterContidion(Integer userId, Date nowTime) throws UserServiceException;
}
