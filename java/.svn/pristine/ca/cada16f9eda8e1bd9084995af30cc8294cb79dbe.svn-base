package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityFormDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityInfoDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeRewardDto;
import com.yilidi.o2o.product.service.dto.UserRedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.query.RedEnvelopeActivityQueryDto;

/**
 * 红包Service接口
 * 
 * @author: chenlian
 * @date: 2016年11月3日 上午10:21:20
 */
public interface IRedEnvelopeService {

    /**
     * 新增抢红包活动
     * 
     * @param redEnvelopeActivityDto
     *            抢红包活动信息DTO
     * @return 抢红包活动ID
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Integer saveRedEnvelopeActivity(RedEnvelopeActivityDto redEnvelopeActivityDto) throws ProductServiceException;

    /**
     * 根据id更新抢红包活动
     * 
     * @param redEnvelopeActivityDto
     *            抢红包活动信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateRedEnvelopeActivityById(RedEnvelopeActivityDto redEnvelopeActivityDto) throws ProductServiceException;

    /**
     * 根据ID获取抢红包活动信息
     * 
     * @param id
     *            抢红包活动信息ID
     * @return 抢红包活动信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public RedEnvelopeActivityDto loadRedEnvelopeActivityById(Integer id) throws ProductServiceException;

    /**
     * 根据当前时间获取抢红包活动信息
     * 
     * @param currentDateTime
     *            当前时间
     * @return 抢红包活动信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public RedEnvelopeActivityDto loadRedEnvelopeActivityByCurrentDateTime(Date currentDateTime)
            throws ProductServiceException;

    /**
     * 根据全局活动ID获取抢红包活动信息
     * 
     * @param globalActivityId
     *            全局活动ID
     * @return 抢红包活动信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public RedEnvelopeActivityDto loadRedEnvelopeActivityByGlobalActivityId(Integer globalActivityId)
            throws ProductServiceException;

    /**
     * 分页获取抢红包活动列表
     * 
     * @param redEnvelopeActivityQueryDto
     *            抢红包活动查询dto
     * @return 抢红包活动列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public YiLiDiPage<RedEnvelopeActivityInfoDto> findRedEnvelopeActivities(
            RedEnvelopeActivityQueryDto redEnvelopeActivityQueryDto) throws ProductServiceException;

    /**
     * 获取抢红包活动列表
     * 
     * @return 红包活动列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<RedEnvelopeActivityDto> listRedEnvelopeActivities() throws ProductServiceException;

    /**
     * 新增红包奖励
     * 
     * @param redEnvelopeRewardDto
     *            红包奖励信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void saveRedEnvelopeReward(RedEnvelopeRewardDto redEnvelopeRewardDto) throws ProductServiceException;

    /**
     * 根据id更新红包奖励
     * 
     * @param redEnvelopeRewardDto
     *            红包奖励信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateRedEnvelopeRewardById(RedEnvelopeRewardDto redEnvelopeRewardDto) throws ProductServiceException;

    /**
     * 根据ID获取红包奖励信息
     * 
     * @param id
     *            红包奖励信息ID
     * @return 红包奖励信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public RedEnvelopeRewardDto loadRedEnvelopeRewardById(Integer id) throws ProductServiceException;

    /**
     * 获取红包奖励信息列表
     * 
     * @param redEnvelopeActivityId
     *            抢红包活动ID
     * @param rewardStatus
     *            奖励状态
     * @return 红包奖励信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<RedEnvelopeRewardDto> listRedEnvelopeRewards(Integer redEnvelopeActivityId, String rewardStatus)
            throws ProductServiceException;

    /**
     * 新增整体抢红包游戏
     * 
     * @param redEnvelopeActivityFormDto
     *            抢红包活动信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void saveWholeRedEnvelopeActivity(RedEnvelopeActivityFormDto redEnvelopeActivityFormDto)
            throws ProductServiceException;

    /**
     * 修改整体抢红包游戏
     * 
     * @param redEnvelopeActivityFormDto
     *            抢红包活动信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateWholeRedEnvelopeActivity(RedEnvelopeActivityFormDto redEnvelopeActivityFormDto)
            throws ProductServiceException;

    /**
     * 新增用户抢红包活动
     * 
     * @param userRedEnvelopeActivityDto
     *            用户抢红包活动信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void saveUserActivity(UserRedEnvelopeActivityDto userRedEnvelopeActivityDto) throws ProductServiceException;

    /**
     * 根据id更新用户抢红包活动
     * 
     * @param userRedEnvelopeActivityDto
     *            用户抢红包活动信息DTO
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public void updateUserActivityById(UserRedEnvelopeActivityDto userRedEnvelopeActivityDto) throws ProductServiceException;

    /**
     * 根据id更新用户抢红包次数
     * 
     * @param record
     *            记录
     * @param playCountLimit
     *            限参与抢红包活动次数
     * @return 更新记录条数
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Integer updateUserActivityByIdWithCountLimit(UserRedEnvelopeActivityDto record, Integer playCountLimit)
            throws ProductServiceException;

    /**
     * 根据id更新用户抢到红包的数量
     * 
     * @param id
     *            用户抢红包活动信息ID
     * @return 更新记录条数
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Integer updateUserActivityByIdWithRedEnvelopeCount(Integer id) throws ProductServiceException;

    /**
     * 根据ID获取用户抢红包活动信息
     * 
     * @param id
     *            用户抢红包活动信息ID
     * @return 用户抢红包活动信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public UserRedEnvelopeActivityDto loadUserActivityById(Integer id) throws ProductServiceException;

    /**
     * 根据红包活动id和用户id以及活动参与日期加载用户抢红包信息
     * 
     * @param redEnvelopeActivityId
     *            抢红包活动id
     * @param userId
     *            用户id
     * @param playDate
     *            抢红包日期
     * @return 用户抢红包信息记录
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public UserRedEnvelopeActivityDto loadUserActivityByAIdAndUIdAndPDate(Integer redEnvelopeActivityId, Integer userId,
            Date playDate) throws ProductServiceException;

}
