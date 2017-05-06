package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;

/**
 * 邀请排行榜修改历史Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IInviterUserShareWeekTopService {

    /**
     * 新增邀请排行榜数据
     * 
     * @param inviterUserShareWeekTopDto
     *            邀请排行榜DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(InviterUserShareWeekTopDto inviterUserShareWeekTopDto) throws UserServiceException;

    /**
     * 批量新增邀请排行榜数据
     * 
     * @param inviterUserShareWeekTopDtos
     *            邀请排行榜DTO列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveBatch(List<InviterUserShareWeekTopDto> inviterUserShareWeekTopDtos) throws UserServiceException;

    /**
     * 分页查询
     * 
     * @param year
     *            年份
     * @param month
     *            月
     * @param weekNumber
     *            周次
     * @param pageNo
     *            当前页
     * @param pageSize
     *            每页大小
     * @return YiLiDiPage<InviterUserShareWeekTopDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<InviterUserShareWeekTopDto> findInviterUserShareWeekTops(Integer year, Integer month,
            Integer weekNumber, Integer pageNo, Integer pageSize) throws UserServiceException;

    /**
     * 查询记录总数
     * 
     * @param year
     *            年份
     * @param month
     *            月
     * @param weekNumber
     *            周次
     * @return 总数
     * @throws UserServiceException
     *             用户域服务异常
     */
    public Integer getInviterUserShareWeekTopsCount(Integer year, Integer month, Integer weekNumber)
            throws UserServiceException;

    /**
     * 人工干预修改邀请排行榜列表
     * 
     * @param inviterUserShareWeekTopDto
     *            修改参数
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateWeekTopByIntervention(InviterUserShareWeekTopDto inviterUserShareWeekTopDto)
            throws UserServiceException;

}
