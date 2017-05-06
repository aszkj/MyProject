package com.yilidi.o2o.user.service;

import java.util.Date;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;

/**
 * 用户分享Service服务
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IUserShareService {

    /**
     * 分享到微信好友
     * 
     * @param shareUserId
     *            分享用户ID
     * @param currentTime
     *            系统当前时间
     * @return 分享规则信息
     * @throws UserServiceException
     *             用户域服务异常
     */
    public ShareRuleDto updateShareToWechatFriends(Integer shareUserId, Date currentTime) throws UserServiceException;

    /**
     * 分享到微信朋友圈
     * 
     * @param shareUserId
     *            分享用户ID
     * @param currentTime
     *            系统当前时间
     * @return 朋友圈图片
     * @throws UserServiceException
     *             用户域服务异常
     */
    public String updateShareToWechatFriendsCircle(Integer shareUserId, Date currentTime) throws UserServiceException;

    /**
     * 用户领取分享活动
     * 
     * @param code
     *            微信唯一标识码
     * @param shareCode
     *            用户分享码
     * @param mobile
     *            领取用户手机号码
     * @param channel
     *            渠道类型
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateAcceptInvite(String code, String shareCode, String mobile, String channel) throws UserServiceException;

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

    /**
     * 发送用户分享奖励配送信息
     * 
     * @param userId
     *            用户ID
     * @param nowTime
     *            当前时间
     * @param orderNo
     *            订单编号
     * @param awardConditionType
     *            奖励条件类型
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void sendUserShareAwardMessage(Integer userId, Date nowTime, String orderNo, String awardConditionType)
            throws UserServiceException;
}
