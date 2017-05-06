package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.InvitedUserShareRecordDto;

/**
 * 被邀请用户分享记录Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IInvitedUserShareRecordService {

    /**
     * 新增分享结果
     * 
     * @param invitedUserShareRecordDto
     *            分享记录DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(InvitedUserShareRecordDto invitedUserShareRecordDto) throws UserServiceException;

    /**
     * 根据ID查找分享结果基础信息
     * 
     * @param id
     *            分享记录ID
     * @return InvitedUserShareRecordDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InvitedUserShareRecordDto loadById(Integer id) throws UserServiceException;

    /**
     * 根据用户分享码和分享规则加载分享结果基础信息
     * 
     * @param shareCode
     *            用户分享码
     * @param shareRuleId
     *            分享规则ID
     * @return InvitedUserShareRecordDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InvitedUserShareRecordDto loadByShareCodeAndShareRuleId(String shareCode, Integer shareRuleId)
            throws UserServiceException;

    /**
     * 根据被邀请用户ID和分享规则加载分享结果基础信息
     * 
     * @param invitedUserId
     *            被邀请用户ID
     * @param shareRuleId
     *            分享规则ID
     * @return InvitedUserShareRecordDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public InvitedUserShareRecordDto loadByInvitedUserIdAndShareRuleId(Integer invitedUserId, Integer shareRuleId)
            throws UserServiceException;
}
