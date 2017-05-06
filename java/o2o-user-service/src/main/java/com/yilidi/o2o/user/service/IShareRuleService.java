package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.query.ShareRuleQueryDto;

/**
 * 分享规则Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IShareRuleService {

    /**
     * 新增分享规则
     * 
     * @param shareRuleDto
     *            分享规则DTO
     * @throws UserServiceException
     *             销售域服务异常
     */
    public void saveShareRule(ShareRuleDto shareRuleDto) throws UserServiceException;

    /**
     * 修改分享规则
     * 
     * @param shareRuleDto
     *            分享规则DTO
     * @throws UserServiceException
     *             销售域服务异常
     */
    public void updateShareRule(ShareRuleDto shareRuleDto) throws UserServiceException;

    /**
     * 根据ID查找分享规则基础信息
     * 
     * @param ruleId
     *            分享规则ID
     * @return ShareRuleDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public ShareRuleDto loadById(Integer ruleId) throws UserServiceException;

    /**
     * 根据ID查找分享规则详细信息
     * 
     * @param ruleId
     *            分享规则ID
     * @return ShareRuleDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public ShareRuleDto loadDetailById(Integer ruleId) throws UserServiceException;

    /**
     * 获取当前正在进行的分享规则活动
     * 
     * @param updateStockShareByStoreId
     *            当前时间
     * @return ShareRuleDto
     * @throws UserServiceException
     *             销售域服务异常
     */
    public ShareRuleDto loadProgressing(Date nowTime) throws UserServiceException;

    /**
     * 分页分享规则列表
     * 
     * @param shareRuleQueryDto
     *            分享规则查询条件
     * @return YiLiDiPage<ShareRuleDto>
     * @throws UserServiceException
     *             销售域服务异常
     */
    public YiLiDiPage<ShareRuleDto> findShareRules(ShareRuleQueryDto shareRuleQueryDto) throws UserServiceException;

    /**
     * 分享规则列表
     * 
     * @param shareRuleQueryDto
     *            分享规则查询条件
     * @return List<ShareRuleDto>
     * @throws UserServiceException
     *             销售域服务异常
     */
    public List<ShareRuleDto> listShareRules(ShareRuleQueryDto shareRuleQueryDto) throws UserServiceException;

    /**
     * 根据状态查找分享规则列表
     * 
     * @param status
     *            分享状态
     * @return 分享规则列表
     * @throws UserServiceException
     *             销售服务异常
     */
    public List<ShareRuleDto> listShareRulesByStatus(String status) throws UserServiceException;

    /**
     * 修改分享规则状态
     * 
     * @param shareRuleId
     *            分享规则ID
     * @param updateStatus
     *            修改后规则状态
     * @param updateUserId
     *            用户操作ID
     * @param updateTime
     *            操作时间
     * @throws UserServiceException
     *             销售服务异常
     */
    public void updateStatusById(Integer shareRuleId, String updateStatus, Integer updateUserId, Date updateTime)
            throws UserServiceException;

}
