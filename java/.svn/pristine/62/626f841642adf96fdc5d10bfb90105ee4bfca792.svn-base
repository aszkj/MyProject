package com.yilidi.o2o.schedule.user;

import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopHistoryService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 用户分享每周邀请排行榜定时任务(每隔7天)
 * 
 * @author chenb
 * 
 */
public class InviterUserShareWeekTopWeeklyJob {

    private Logger logger = Logger.getLogger(InviterUserShareWeekTopWeeklyJob.class);

    private IInvitedUserShareAwardService invitedUserShareAwardService;

    private IInviterUserShareWeekTopService inviterUserShareWeekTopService;

    private IInviterUserShareWeekTopHistoryService inviterUserShareWeekTopHistoryService;

    private IUserService userService;

    protected synchronized void performance() {
        try {
            logger.info("===============用户分享每周邀请排行榜定时任务(每隔7天)定时任务开始===============");
            Calendar calendar = Calendar.getInstance();
            Integer year = calendar.get(Calendar.YEAR);
            Integer month = calendar.get(Calendar.MONTH) + 1;
            Date nowTime = calendar.getTime();
            Integer weekNum = getWeekNumbByTime(nowTime);
            for (int i = 1; i <= weekNum; i++) {
                Date startTime = getWeeklyStartTime(i, 0);
                Date endTime = getWeeklyEndTime(i, 0);
                List<InviterUserStatisticInfoDto> inviterUserStatisticInfoDtos = invitedUserShareAwardService
                        .listInviterStatisticsCountsByTime(startTime, endTime);
                if (!ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtos)) {
                    for (InviterUserStatisticInfoDto inviterUserStatisticInfoDto : inviterUserStatisticInfoDtos) {
                        try {
                            UserDto userDto = userService.loadUserById(inviterUserStatisticInfoDto.getShareUserId());
                            if (ObjectUtils.isNullOrEmpty(userDto)) {
                                continue;
                            }
                            Integer revisionCount = inviterUserShareWeekTopHistoryService.getRevisionCount(year, month, i,
                                    userDto.getUserName());
                            if (ArithUtils.converIntegerToInt(revisionCount) > 0) {
                                // 修改过不跑数据
                                continue;
                            }
                            InviterUserShareWeekTopDto inviterUserShareWeekTopDto = new InviterUserShareWeekTopDto();
                            inviterUserShareWeekTopDto.setYear(year);
                            inviterUserShareWeekTopDto.setMonth(month);
                            inviterUserShareWeekTopDto.setWeekNumber(i);
                            inviterUserShareWeekTopDto.setInviterCount(
                                    ArithUtils.converIntegerToInt(inviterUserStatisticInfoDto.getInviterCount()));
                            inviterUserShareWeekTopDto
                                    .setRevisionInviterCount(inviterUserStatisticInfoDto.getInviterCount());
                            inviterUserShareWeekTopDto.setCreateTime(nowTime);
                            inviterUserShareWeekTopDto.setCreateUserId(CommonConstants.SYSTEM_USER_ID);
                            inviterUserShareWeekTopDto.setModifyTime(nowTime);
                            inviterUserShareWeekTopDto.setModifyUserId(CommonConstants.SYSTEM_USER_ID);
                            inviterUserShareWeekTopDto.setUserName(userDto.getUserName());
                            inviterUserShareWeekTopService.save(inviterUserShareWeekTopDto);
                        } catch (Exception e) {
                            logger.error(e, e);
                        }
                    }
                }
            }
            logger.info("===============用户分享每周邀请排行榜定时任务(每隔7天)定时任务结束===============");
        } catch (Exception e) {
            logger.error("更新分享规则状态定时任务失败！", e);
            throw new IllegalStateException(e.getMessage());
        }
    }

    private Integer getWeekNumbByTime(Date time) throws ParseException {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(time);
        Calendar nowCalendar = Calendar.getInstance();
        Integer prevMonth = calendar.get(Calendar.MONTH) - nowCalendar.get(Calendar.MONTH);
        if (prevMonth < 0) {
            nowCalendar.set(Calendar.DAY_OF_MONTH, nowCalendar.getActualMaximum(Calendar.DAY_OF_MONTH));
            nowCalendar.set(Calendar.HOUR_OF_DAY, 0);
            nowCalendar.set(Calendar.MINUTE, 0);
            nowCalendar.set(Calendar.SECOND, 0);
            nowCalendar.set(Calendar.MILLISECOND, 0);
        }
        // 当月第一周的开始时间
        Date startFirsWeekDate = DateUtils.getSpecificStartDate(DateUtils.getFirstDateByPutOffMonths(prevMonth));
        // 当月第一周的结束时间
        Date endFirstWeekDate = DateUtils.getSpecificEndDate(DateUtils.addDays(startFirsWeekDate, 6));
        if (startFirsWeekDate.before(time) && !time.after(endFirstWeekDate)) {
            return 1;
        }
        // 当月第二周开始时间
        Date startSndWeekDate = DateUtils.getSpecificStartDate(DateUtils.addDays(endFirstWeekDate, 1));
        // 当月第二周结束时间
        Date endSndWeekDate = DateUtils.getSpecificEndDate(DateUtils.addDays(startSndWeekDate, 6));
        if (startSndWeekDate.before(time) && !time.after(endSndWeekDate)) {
            return 2;
        }
        // 当月第三周开始时间
        Date startThirdWeekDate = DateUtils.getSpecificStartDate(DateUtils.addDays(endSndWeekDate, 1));
        // 当月第三周结束时间
        Date endThirdWeekDate = DateUtils.getSpecificEndDate(DateUtils.addDays(startThirdWeekDate, 6));
        if (startThirdWeekDate.before(time) && !time.after(endThirdWeekDate)) {
            return 3;
        }
        // 当月第四周开始时间
        Date startFouthWeekDate = DateUtils.getSpecificStartDate(DateUtils.addDays(endThirdWeekDate, 1));
        // 当月第四周结束时间
        Date endFourthWeekDate = DateUtils.getSpecificEndDate(DateUtils.getLastDateByPutOffMonths(prevMonth));
        if (startFouthWeekDate.before(time) && !time.after(endFourthWeekDate)) {
            return 4;
        }
        return null;
    }

    /**
     * 获取第几周的开始时间
     * 
     * @param weekNum
     *            周次
     * @return 第几周的开始时间
     * @throws ParseException
     *             转换异常
     */
    private Date getWeeklyStartTime(Integer weekNum, Integer prevMonth) throws ParseException {
        if (null == weekNum) {
            weekNum = 1;
        }
        Date startFirsWeekDate = DateUtils.getSpecificStartDate(DateUtils.getFirstDateByPutOffMonths(prevMonth));
        switch (weekNum) {
        case 1:
            return startFirsWeekDate;
        case 2:
            return DateUtils.getSpecificStartDate(DateUtils.addDays(startFirsWeekDate, 7));
        case 3:
            return DateUtils.getSpecificStartDate(DateUtils.addDays(startFirsWeekDate, 14));
        case 4:
            return DateUtils.getSpecificStartDate(DateUtils.addDays(startFirsWeekDate, 21));
        }
        return null;
    }

    /**
     * 获取第几周的结束时间
     * 
     * @param weekNum
     *            周次
     * @return 第几周的结束时间
     * @throws ParseException
     *             转换异常
     */
    private Date getWeeklyEndTime(Integer weekNum, Integer prevMonth) throws ParseException {
        if (null == weekNum) {
            weekNum = 1;
        }
        Date startFirsWeekDate = DateUtils.getSpecificStartDate(DateUtils.getFirstDateByPutOffMonths(prevMonth));
        Date endFirstWeekDate = DateUtils.getSpecificEndDate(DateUtils.addDays(startFirsWeekDate, 6));
        switch (weekNum) {
        case 1:
            return endFirstWeekDate;
        case 2:
            return DateUtils.getSpecificEndDate(DateUtils.addDays(endFirstWeekDate, 7));
        case 3:
            return DateUtils.getSpecificEndDate(DateUtils.addDays(endFirstWeekDate, 14));
        case 4:
            return DateUtils.getSpecificEndDate(DateUtils.getLastDateByPutOffMonths(prevMonth));
        }
        return null;
    }

    public IInvitedUserShareAwardService getInvitedUserShareAwardService() {
        return invitedUserShareAwardService;
    }

    public void setInvitedUserShareAwardService(IInvitedUserShareAwardService invitedUserShareAwardService) {
        this.invitedUserShareAwardService = invitedUserShareAwardService;
    }

    public IInviterUserShareWeekTopService getInviterUserShareWeekTopService() {
        return inviterUserShareWeekTopService;
    }

    public void setInviterUserShareWeekTopService(IInviterUserShareWeekTopService inviterUserShareWeekTopService) {
        this.inviterUserShareWeekTopService = inviterUserShareWeekTopService;
    }

    public IInviterUserShareWeekTopHistoryService getInviterUserShareWeekTopHistoryService() {
        return inviterUserShareWeekTopHistoryService;
    }

    public void setInviterUserShareWeekTopHistoryService(
            IInviterUserShareWeekTopHistoryService inviterUserShareWeekTopHistoryService) {
        this.inviterUserShareWeekTopHistoryService = inviterUserShareWeekTopHistoryService;
    }

    public IUserService getUserService() {
        return userService;
    }

    public void setUserService(IUserService userService) {
        this.userService = userService;
    }

}
