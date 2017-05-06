/**
 * 文件名称：MessageProxyService.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.proxy;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.EmailTypeModelClassMapping;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.transaction.model.RollbackMessageModel;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;
import com.yilidi.o2o.system.proxy.dto.SystemMessageProxyDto;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserShareAwardProxyDto;

/**
 * 功能描述：消息服务代理接口定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IMessageProxyService {

    /**
     * @Description TODO(发送邮件)
     * @param mapping
     * @param fromUserNameAndEmailInfo
     * @param toUserNameAndEmailInfoList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendEmail(EmailTypeModelClassMapping mapping, KeyValuePair<String, String> fromUserNameAndEmailInfo,
            List<KeyValuePair<String, String>> toUserNameAndEmailInfoList, String... variables)
            throws SystemServiceException;

    /**
     * @Description TODO(用户发送短信)
     * @param mapping
     * @param remoteIpAddr
     * @param toUserMobileList
     * @param variables
     * @throws SystemServiceException
     */
    public void userSendSms(SmsTypeModelClassMapping mapping, String remoteIpAddr, List<String> toUserMobileList,
            String... variables) throws SystemServiceException;

    /**
     * @Description TODO(系统发送短信)
     * @param mapping
     * @param toUserMobileList
     * @param variables
     * @throws SystemServiceException
     */
    public void systemSendSms(SmsTypeModelClassMapping mapping, List<String> toUserMobileList, String... variables)
            throws SystemServiceException;

    /**
     * 发送推送通知
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendPush(PushTypeModelClassMapping mapping, List<Integer> toUserIdList, String... variables)
            throws SystemServiceException;

    /**
     * 发送回滚事务消息
     * 
     * @param rollbackMessageModelListMap
     * @throws SystemServiceException
     */
    public void sendRollbackTransactionMessage(Map<String, List<RollbackMessageModel>> rollbackMessageModelListMap)
            throws SystemServiceException;

    /**
     * 登录日志消息
     * 
     * @param loginLogProxyDto
     *            登录日志代理对象
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendLoginLogMessage(LoginLogProxyDto loginLogProxyDto) throws SystemServiceException;

    /**
     * 发送保存同步用户信息消息
     * 
     * @param smallTableUserInfoProxyDto
     *            用户信息小表实体类代理DTO
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendSaveSynUserInfoMessage(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto)
            throws SystemServiceException;

    /**
     * 发送更新同步用户信息消息
     * 
     * @param smallTableUserInfoProxyDto
     *            用户信息小表实体类代理DTO
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendUpdateSynUserInfoMessage(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto)
            throws SystemServiceException;

    /**
     * 用户奖励消息
     * 
     * @param userShareAwardProxyDto
     *            用户奖励实体代理类
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendUserShareAwardMessage(UserShareAwardProxyDto userShareAwardProxyDto) throws SystemServiceException;

    /**
     * 发送修改用户头像地址消息
     * 
     * @param userId
     *            用户ID
     * @param userAvatarUrl
     *            用户头像地址url
     * @throws UserServiceException
     *             系统域服务异常
     */
    public void sendUpdatUserAvatarMessage(Integer userId, String userAvatarUrl) throws SystemServiceException;

    /**
     * 同步购物车商品消息
     * 
     * @param userId
     *            用户ID
     * @param shopCartProxyDtoList
     *            购物车代理DTO类
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendAsycnShopCartMessage(Integer userId, List<ShopCartProxyDto> shopCartProxyDtoList)
            throws SystemServiceException;

    /**
     * 修改商品冗余字段库存消息
     * 
     * @param saleProductIdAndRemainCountDeltaKeys
     *            商品库存变化键值对列表
     * @param userId
     *            操作用户ID
     * @throws SystemServiceException
     *             系统域服务异常
     */
    public void sendSaleProductRemainChangeMessage(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws SystemServiceException;

    /**
     *	发送注册送消息
     * 
     * @param userId
     *            的奖用户ID
     * @throws nowTime
     *             当前时间
     */
	public void sendUserRegistAwardMessage(Integer userId, Date nowTime);
	
	/**
     * 发送推送通知(卖家系统消息)
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendSellerPushMystemMessage(int pushWay, List<Integer> toUserIdList,SystemMessageProxyDto systemMessageProxyDto);

    /**
     * 发送推送通知(买家家系统消息)
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendBuyerPushMystemMessage(int pushWay, List<Integer> toUserIdList,SystemMessageProxyDto systemMessageProxyDto);

    /**
     * 
     * 
     * @param orderNo
     *           
     * @param operationUserId
     *            
     * @param operationTime
     *           
     */
    public void sendBuyActivityCouponMessage(String orderNo, Integer operationUserId, Date operationTime);
    
    /**
     * 发送退款消息
     * @param userId
     * @param saleOrderNo
     * @param refundAmount
     */
	public void sendRefundMessage(Integer userId, String saleOrderNo, long refundAmount);

	/**
	 * 发送优惠消息
	 * @param systemUserId
	 * @param userIdList
	 * @param messageTitle
	 * @param messageIntro
	 * @param messagepublishobjectBuyerSpecial
	 */
	public void sendPreferenceMessage(int user, List<Integer> userIdList, String messageTitle,
			String messageIntro, String publishObject);
	
}
