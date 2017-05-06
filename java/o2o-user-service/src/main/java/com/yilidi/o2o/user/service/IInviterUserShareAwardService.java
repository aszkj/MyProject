package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.InviterUserShareAwardDto;

/**
 * 邀请人用户奖励记录Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IInviterUserShareAwardService {

    /**
     * 新增奖励
     * 
     * @param inviterUserShareAwardDto
     *            邀请人奖励DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(InviterUserShareAwardDto inviterUserShareAwardDto) throws UserServiceException;

    /**
     * 根据ID查找分享结果基础信息
     * 
     * @param id
     *            分享记录ID
     * @return InviterUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InviterUserShareAwardDto loadById(Integer id) throws UserServiceException;

    /**
     * 根据用户分享码和分享规则加载奖励基础信息
     * 
     * @param shareCode
     *            用户分享码
     * @param shareRuleId
     *            分享规则ID
     * @return InviterUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InviterUserShareAwardDto loadByShareCodeAndShareRuleId(String shareCode, Integer shareRuleId)
            throws UserServiceException;

    /**
     * 根据被邀请用户ID和分享规则加载分享奖励基础信息
     * 
     * @param inviterUserId
     *            邀请人用户ID
     * @param shareRuleId
     *            分享规则ID
     * @param invitedUserId
     *            被邀请用户ID
     * @return InviterUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InviterUserShareAwardDto loadByUserIdAndShareRuleIdAndInvitedUserId(Integer inviterUserId, Integer shareRuleId,
            Integer invitedUserId) throws UserServiceException;

    /**
     * 统计分享用户指定时间内奖励累计
     * 
     * @param userId
     *            用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return InviterUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InviterUserShareAwardDto getAwardStatisticsInfo(Integer userId, Date startTime, Date endTime)
            throws UserServiceException;

    /**
     * 获取指定时间内分享用户累计奖励优惠券金额
     * 
     * @param shareUserId
     *            分享用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 分享用户累计奖励优惠券金额
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Long getInviterAmountCountByShareUserIdAndTime(Integer shareUserId, Date startTime, Date endTime)
            throws UserServiceException;

    /**
     * 新增奖励
     * 
     * @param inviterUserShareAwardDto
     *            邀请人奖励DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
	public void save(List<InviterUserShareAwardDto> saveInviterUserShareAwardDtoList);
}
