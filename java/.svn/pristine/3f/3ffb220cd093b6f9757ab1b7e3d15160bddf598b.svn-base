package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.InvitedUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserShareAwardQueryDto;

/**
 * 分享用户奖励记录Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IInvitedUserShareAwardService {

    /**
     * 新增分享用户奖励
     * 
     * @param invitedUserShareAwardDto
     *            分享用户奖励DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(InvitedUserShareAwardDto invitedUserShareAwardDto) throws UserServiceException;

    /**
     * 根据ID查找分享奖励基础信息
     * 
     * @param id
     *            分享用户奖励ID
     * @return InvitedUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InvitedUserShareAwardDto loadById(Integer id) throws UserServiceException;

    /**
     * 根据分享规则和被邀请人用户ID查找分享奖励基础信息
     * 
     * @param invitedUserId
     *            被邀请人用户ID
     * @param shareRuleId
     *            分享规则ID
     * @return InvitedUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InvitedUserShareAwardDto loadByInvitedUserIdAndShareRuleId(Integer invitedUserId, Integer shareRuleId)
            throws UserServiceException;

    /**
     * 根据分享规则和被请人用户ID查找分享奖励基础信息
     * 
     * @param shareUserId
     *            邀请人用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return InvitedUserShareAwardDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InviterUserStatisticInfoDto loadStatisticsCountByShareUserIdAndTime(Integer shareUserId, Date startTime,
            Date endTime) throws UserServiceException;

    /**
     * 分页查询某人邀请奖励人数列表
     * 
     * @param invitedUserShareAwardQueryDto
     *            分享记录查询条件
     * @return YiLiDiPage<InvitedUserShareAwardDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<InvitedUserShareAwardDto> findInvitedUserShareAwardsByShareUserId(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException;

    /**
     * 分页查询分享奖励结果列表
     * 
     * @param invitedUserShareAwardQueryDto
     *            查询条件
     * @return YiLiDiPage<InviterUserStatisticInfoDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<InviterUserStatisticInfoDto> findInviterStatisticsCounts(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException;

    /**
     * 查询分享奖励结果列表总数量
     * 
     * @param invitedUserShareAwardQueryDto
     *            查询条件
     * @return YiLiDiPage<InviterUserStatisticInfoDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer getInviterStatisticsCount(InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto)
            throws UserServiceException;

    /**
     * 获取指定时间区间内的邀请冠军用户ID
     * 
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 分享记录信息
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer loadChampionByTime(Date startTime, Date endTime) throws UserServiceException;

    /**
     * 获取指定时间内分享用户邀请人数
     * 
     * @param shareUserId
     *            分享用户ID
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return 分享记录信息
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer getInviterCountByShareUserIdAndTime(Integer shareUserId, Date startTime, Date endTime)
            throws UserServiceException;

    /**
     * 分页查询分享奖励记列表
     * 
     * @param invitedUserShareAwardQueryDto
     *            分享奖励查询条件
     * @return YiLiDiPage<InvitedUserShareAwardDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<InvitedUserShareAwardDto> findInvitedUserShareAwards(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException;

    /**
     * 根据指定时间查询邀请人数汇总列表
     * 
     * @param startTime
     *            开始时间
     * @param endTime
     *            结束时间
     * @return List<InviterUserStatisticInfoDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public List<InviterUserStatisticInfoDto> listInviterStatisticsCountsByTime(Date startTime, Date endTime)
            throws UserServiceException;

    /**
     * 新增分享用户奖励(批量)
     * 
     * @param invitedUserShareAwardDto
     *            分享用户奖励DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
	public void save(List<InvitedUserShareAwardDto> invitedUserShareAwardDtoList);
}
