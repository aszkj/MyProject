package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.EmailTypeModelClassMapping;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;

/**
 * @Description: TODO(发送消息服务类)
 * @author: chenlian
 * @date: 2016年5月30日 下午3:42:50
 */
public interface IMessageService {
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
     * 发送推送通知(订单消息)
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendPushOrderMessage(PushTypeModelClassMapping mapping, List<Integer> toUserIdList, String... variables)
            throws SystemServiceException;
    
    /**
     * 发送推送通知(卖家系统消息)
     * @param pushWay 
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendSellerPushMystemMessage(int pushWay, List<Integer> toUserIdList,SystemMessageDto systemMessageDto);

    /**
     * 发送推送通知(买家家系统消息)
     * @param pushWay 
     * 
     * @param mapping
     * @param toUserIdList
     * @param variables
     * @throws SystemServiceException
     */
    public void sendBuyerPushMystemMessage(int pushWay, List<Integer> toUserIdList,SystemMessageDto systemMessageDto);
    
    /**
     * 推送退款消息
     * 
     * @param userId 推送的对象
     * @param saleOrderNo
     * @param refundAmount
     */
	public void sendRefundMessage(Integer userId, String saleOrderNo, long refundAmount);

	/**
	 * 推送优惠消息
	 * @param user2 
	 * 
	 * @param userId 操作的用户
	 * @param userIdList 推送的对象
	 * @param couponNum
	 * @param couponPrice
	 * @param grantRange
	 */
	public void sendPreferenceMessage(Integer user, List<Integer> userIdList, String messageTitle, String messageIntro,String publishObject);
}
