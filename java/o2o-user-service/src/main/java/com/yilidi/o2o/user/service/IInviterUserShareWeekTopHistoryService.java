package com.yilidi.o2o.user.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopHistoryDto;

/**
 * 邀请排行榜修改历史Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IInviterUserShareWeekTopHistoryService {

    /**
     * 新增邀请排行榜修改历史数据
     * 
     * @param inviterUserShareWeekTopHistoryDto
     *            邀请排行榜历史DTO
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void save(InviterUserShareWeekTopHistoryDto inviterUserShareWeekTopHistoryDto) throws UserServiceException;

    /**
     * 批量新增邀请排行榜历史数据
     * 
     * @param inviterUserShareWeekTopHistoryDtos
     *            邀请排行榜历史DTO列表
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void saveBatch(List<InviterUserShareWeekTopHistoryDto> inviterUserShareWeekTopHistoryDtos)
            throws UserServiceException;

    /**
     * 分页查询
     * 
     * @param year
     *            年份
     * @param month
     *            月
     * @param weekNumber
     *            周次
     * @param revisionBatchCode
     *            修改批次号
     * @param pageNo
     *            当前页
     * @param pageSize
     *            每页大小
     * @return YiLiDiPage<InviterUserShareWeekTopHistoryDto>
     * @throws UserServiceException
     *             用户域服务异常
     */
    public YiLiDiPage<InviterUserShareWeekTopHistoryDto> findInviterUserShareWeekTopHistorys(Integer year, Integer month,
            Integer weekNumber, String revisionBatchCode, Integer pageNo, Integer pageSize) throws UserServiceException;

    /**
     * 获取邀请排行榜修改次数
     * 
     * @param year
     *            年份
     * @param month
     *            月份
     * @param weekNumber
     *            周次
     * @param userName
     *            用户手机号码
     * @return 修改次数
     * @throws UserServiceException
     *             用户域 服务异常
     */
    public Integer getRevisionCount(Integer year, Integer month, Integer weekNumber, String userName)
            throws UserServiceException;
}
