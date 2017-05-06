package com.yilidi.o2o.controller.operation.user;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopHistoryService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopService;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopHistoryDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopResultDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserShareAwardQueryDto;
import com.yilidi.o2o.user.service.dto.query.InviterUserShareWeekTopQueryDto;

/**
 * 分享邀请排行榜管理
 * 
 * @author: chenb
 * @date: 2015年11月17日 上午10:03:22
 * 
 */
@Controller("operationInviterUserShareWeekTopController")
@RequestMapping(value = "/operation")
public class InviterUserShareWeekTopController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IInvitedUserShareAwardService invitedUserShareAwardService;
    @Autowired
    private IInviterUserShareAwardService inviterUserShareAwardService;
    @Autowired
    private IInviterUserShareWeekTopService inviterUserShareWeekTopService;
    @Autowired
    private IInviterUserShareWeekTopHistoryService inviterUserShareWeekTopHistoryService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IShareRuleService shareRuleService;
    @Autowired
    private ICouponService couponService;

    /**
     * 查询分享邀请排行旁
     * 
     * @param inviterUserShareWeekTopQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/usershare/weektoplist")
    @ResponseBody
    public MsgBean search(@RequestBody InviterUserShareWeekTopQueryDto inviterUserShareWeekTopQueryDto) {
        try {
            Calendar nowCalendar = Calendar.getInstance();
            Integer year = inviterUserShareWeekTopQueryDto.getYear();
            Integer month = inviterUserShareWeekTopQueryDto.getMonth();
            Integer pageNo = inviterUserShareWeekTopQueryDto.getStart();
            Integer pageSize = inviterUserShareWeekTopQueryDto.getPageSize();
            if (ObjectUtils.isNullOrEmpty(year)) {
                year = nowCalendar.get(Calendar.YEAR);
            }
            if (ObjectUtils.isNullOrEmpty(month)) {
                month = nowCalendar.get(Calendar.MONTH) + 1;
            }
            if (ObjectUtils.isNullOrEmpty(pageNo)) {
                pageNo = 1;
            }
            if (ObjectUtils.isNullOrEmpty(pageSize)) {
                pageSize = CommonConstants.PAGE_SIZE;
            }
            nowCalendar.set(Calendar.YEAR, year);
            nowCalendar.set(Calendar.MONTH, (month - 1));
            Date nowTime = nowCalendar.getTime();
            InviterUserShareWeekTopResultDto inviterUserShareWeekTopResultDto = new InviterUserShareWeekTopResultDto();
            Integer weekNum = getWeekNumbByTime(nowTime);
            inviterUserShareWeekTopResultDto.setYear(year);
            inviterUserShareWeekTopResultDto.setMonth(month);
            inviterUserShareWeekTopResultDto.setCurWeekNumber(weekNum);
            for (int i = 1; i <= weekNum; i++) {
                Date startTime = getWeeklyStartTime(i, month);
                Date endTime = getWeeklyEndTime(i, month);
                if (i == weekNum && year == nowCalendar.get(Calendar.YEAR) && month == nowCalendar.get(Calendar.MONTH) + 1) {
                    YiLiDiPage<InviterUserShareWeekTopHistoryDto> firsRevisionWeekTopPage = inviterUserShareWeekTopHistoryService
                            .findInviterUserShareWeekTopHistorys(year, month, i,
                                    SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST, pageNo,
                                    pageSize);
                    inviterUserShareWeekTopResultDto.setFirsRevisionWeekTops(firsRevisionWeekTopPage.getResultList());

                    YiLiDiPage<InviterUserShareWeekTopHistoryDto> sndRevisionWeekTopPage = inviterUserShareWeekTopHistoryService
                            .findInviterUserShareWeekTopHistorys(year, month, i,
                                    SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_SECOND, pageNo,
                                    pageSize);
                    inviterUserShareWeekTopResultDto.setSndRevisionWeekTops(sndRevisionWeekTopPage.getResultList());

                    YiLiDiPage<InviterUserShareWeekTopHistoryDto> thirdRevisionWeekTopPage = inviterUserShareWeekTopHistoryService
                            .findInviterUserShareWeekTopHistorys(year, month, i,
                                    SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_THIRD, pageNo,
                                    pageSize);
                    inviterUserShareWeekTopResultDto.setThirdRevisionWeekTops(thirdRevisionWeekTopPage.getResultList());
                    YiLiDiPage<InviterUserShareWeekTopHistoryDto> fourthRevisionWeekTopPage = inviterUserShareWeekTopHistoryService
                            .findInviterUserShareWeekTopHistorys(year, month, i,
                                    SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FOURTH, pageNo,
                                    pageSize);
                    inviterUserShareWeekTopResultDto.setFourthRevisionWeekTops(fourthRevisionWeekTopPage.getResultList());
                    if (!ObjectUtils.isNullOrEmpty(firsRevisionWeekTopPage)
                            && !ObjectUtils.isNullOrEmpty(firsRevisionWeekTopPage.getResultList())) {
                        YiLiDiPage<InviterUserShareWeekTopDto> curWeekTopPage = inviterUserShareWeekTopService
                                .findInviterUserShareWeekTops(year, month, i, pageNo, pageSize);
                        Integer count = inviterUserShareWeekTopService.getInviterUserShareWeekTopsCount(year, month, i);
                        inviterUserShareWeekTopResultDto.setCurWeekTops(curWeekTopPage.getResultList());
                        inviterUserShareWeekTopResultDto.setCureWeekTopsCount(count);
                    } else {
                        InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto = new InvitedUserShareAwardQueryDto();
                        invitedUserShareAwardQueryDto.setStartTime(startTime);
                        invitedUserShareAwardQueryDto.setEndTime(endTime);
                        invitedUserShareAwardQueryDto.setStart(pageNo);
                        invitedUserShareAwardQueryDto.setPageSize(pageSize);
                        YiLiDiPage<InviterUserStatisticInfoDto> pageDto = invitedUserShareAwardService
                                .findInviterStatisticsCounts(invitedUserShareAwardQueryDto);
                        List<InviterUserShareWeekTopDto> curWeekTops = new ArrayList<InviterUserShareWeekTopDto>();
                        if (!ObjectUtils.isNullOrEmpty(pageDto) && !ObjectUtils.isNullOrEmpty(pageDto.getResultList())) {
                            List<InviterUserStatisticInfoDto> inviterUserStatisticInfoDtos = pageDto.getResultList();
                            for (InviterUserStatisticInfoDto inviterUserStatisticInfoDto : inviterUserStatisticInfoDtos) {
                                InviterUserShareWeekTopDto inviterUserShareWeekTopDto = new InviterUserShareWeekTopDto();
                                inviterUserShareWeekTopDto.setYear(year);
                                inviterUserShareWeekTopDto.setMonth(month);
                                inviterUserShareWeekTopDto.setWeekNumber(i);
                                inviterUserShareWeekTopDto.setInviterCount(inviterUserStatisticInfoDto.getInviterCount());
                                inviterUserShareWeekTopDto.setUserName(inviterUserStatisticInfoDto.getShareUserName());
                                curWeekTops.add(inviterUserShareWeekTopDto);
                            }
                        }
                        inviterUserShareWeekTopResultDto.setCurWeekTops(curWeekTops);
                        Integer count = invitedUserShareAwardService
                                .getInviterStatisticsCount(invitedUserShareAwardQueryDto);
                        inviterUserShareWeekTopResultDto.setCureWeekTopsCount(count);
                    }
                } else {
                    YiLiDiPage<InviterUserShareWeekTopDto> weekTopPage = inviterUserShareWeekTopService
                            .findInviterUserShareWeekTops(year, month, i, pageNo, pageSize);
                    Integer count = inviterUserShareWeekTopService.getInviterUserShareWeekTopsCount(year, month, i);
                    if (i == 1) {
                        inviterUserShareWeekTopResultDto.setFirstWeekTops(weekTopPage.getResultList());
                        inviterUserShareWeekTopResultDto.setFirsWeekTopsCount(count);
                    }
                    if (i == 2) {
                        inviterUserShareWeekTopResultDto.setSndWeekTops(weekTopPage.getResultList());
                        inviterUserShareWeekTopResultDto.setSndWeekTopsCount(count);
                    }
                    if (i == 3) {
                        inviterUserShareWeekTopResultDto.setThirdWeekTops(weekTopPage.getResultList());
                        inviterUserShareWeekTopResultDto.setThirdWeekTopsCount(count);
                    }
                    if (i == 4) {
                        inviterUserShareWeekTopResultDto.setFourthWeekTops(weekTopPage.getResultList());
                        inviterUserShareWeekTopResultDto.setFourthWeekTopsCount(count);
                    }
                }
            }
            return super.encapsulateMsgBean(inviterUserShareWeekTopResultDto, MsgBean.MsgCode.SUCCESS, "查询分享邀请排行旁成功");
        } catch (Exception e) {
            logger.error("查询分享邀请排行旁失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 保存修改邀请排行榜数据
     * 
     * @param inviterUserShareWeekTopDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/usershare/modifyweektop")
    @ResponseBody
    public MsgBean modifyWeekTop(@RequestBody InviterUserShareWeekTopDto inviterUserShareWeekTopDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto)
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getWeekTopDataStr())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getYear())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getMonth())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getWeekNumber())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "没有接收到需要修改的参数");
            }
            Date nowTime = new Date();
            inviterUserShareWeekTopDto.setCreateUserId(super.getUserId());
            inviterUserShareWeekTopDto.setCreateTime(nowTime);
            inviterUserShareWeekTopDto.setModifyTime(nowTime);
            inviterUserShareWeekTopDto.setModifyUserId(super.getUserId());
            inviterUserShareWeekTopService.updateWeekTopByIntervention(inviterUserShareWeekTopDto);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.SUCCESS, "保存修改邀请排行榜数据成功");
        } catch (Exception e) {
            logger.error("保存修改邀请排行榜数据失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 邀请排行榜更多
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/usershare/more")
    @ResponseBody
    public MsgBean moreWeekTop(@RequestBody InviterUserShareWeekTopQueryDto inviterUserShareWeekTopQueryDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto)
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto.getYear())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto.getMonth())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto.getWeekNumber())) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "没有接收到需要修改的参数");
            }
            logger.info(inviterUserShareWeekTopQueryDto.getStart());
            Integer pageNo = inviterUserShareWeekTopQueryDto.getStart();
            Integer pageSize = inviterUserShareWeekTopQueryDto.getPageSize();
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto.getStart())) {
                pageNo = 1;
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopQueryDto.getPageSize())) {
                pageSize = CommonConstants.PAGE_SIZE;
            }
            Calendar nowCalendar = Calendar.getInstance();
            Date nowTime = nowCalendar.getTime();
            Integer curWeekNumber = getWeekNumbByTime(nowTime);
            // YiLiDiPage<InviterUserShareWeekTopDto> page = new YiLiDiPage<InviterUserShareWeekTopDto>();
            // page.setCurrentPage(pageNo);
            // page.setPageSize(pageSize);
            // if (inviterUserShareWeekTopQueryDto.getYear().intValue() == nowCalendar.get(Calendar.YEAR)
            // && inviterUserShareWeekTopQueryDto.getMonth().intValue() == nowCalendar.get(Calendar.MONTH) + 1
            // && curWeekNumber.intValue() == inviterUserShareWeekTopQueryDto.getWeekNumber()) {
            // Integer revisionCount = inviterUserShareWeekTopHistoryService.getRevisionCount(
            // inviterUserShareWeekTopQueryDto.getYear(), inviterUserShareWeekTopQueryDto.getMonth(),
            // inviterUserShareWeekTopQueryDto.getWeekNumber());
            // if (ArithUtils.converIntegerToInt(revisionCount) > 0) {
            // page = inviterUserShareWeekTopService.findInviterUserShareWeekTops(
            // inviterUserShareWeekTopQueryDto.getYear(), inviterUserShareWeekTopQueryDto.getMonth(),
            // inviterUserShareWeekTopQueryDto.getWeekNumber(), pageNo, pageSize);
            // } else if (pageNo == 1) {
            // Date startTime = getWeeklyStartTime(inviterUserShareWeekTopQueryDto.getWeekNumber(),
            // inviterUserShareWeekTopQueryDto.getMonth());
            // Date endTime = getWeeklyEndTime(inviterUserShareWeekTopQueryDto.getWeekNumber(),
            // inviterUserShareWeekTopQueryDto.getMonth());
            // InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto = new InvitedUserShareAwardQueryDto();
            // invitedUserShareAwardQueryDto.setStartTime(startTime);
            // invitedUserShareAwardQueryDto.setEndTime(endTime);
            // invitedUserShareAwardQueryDto.setStart(pageNo);
            // invitedUserShareAwardQueryDto.setPageSize(pageSize);
            // YiLiDiPage<InviterUserStatisticInfoDto> pageDto = invitedUserShareAwardService
            // .findInviterStatisticsCounts(invitedUserShareAwardQueryDto);
            // ObjectUtils.fastCopy(pageDto, page);
            // if (!ObjectUtils.isNullOrEmpty(pageDto) && !ObjectUtils.isNullOrEmpty(pageDto.getResultList())) {
            // List<InviterUserShareWeekTopDto> inviterUserShareWeekTopDtos = new ArrayList<InviterUserShareWeekTopDto>();
            // for (InviterUserStatisticInfoDto inviterUserStatisticInfoDto : pageDto.getResultList()) {
            // InviterUserShareWeekTopDto inviterUserShareWeekTopDto = new InviterUserShareWeekTopDto();
            // inviterUserShareWeekTopDto.setInviterCount(inviterUserStatisticInfoDto.getInviterCount());
            // UserDto userDto = userService.loadUserById(inviterUserStatisticInfoDto.getShareUserId());
            // if (ObjectUtils.isNullOrEmpty(userDto)) {
            // continue;
            // }
            // inviterUserShareWeekTopDto.setUserName(userDto.getUserName());
            // inviterUserShareWeekTopDtos.add(inviterUserShareWeekTopDto);
            // }
            // page.setResultList(inviterUserShareWeekTopDtos);
            // }
            // }
            // } else {
            YiLiDiPage<InviterUserShareWeekTopDto> page = inviterUserShareWeekTopService.findInviterUserShareWeekTops(
                    inviterUserShareWeekTopQueryDto.getYear(), inviterUserShareWeekTopQueryDto.getMonth(),
                    inviterUserShareWeekTopQueryDto.getWeekNumber(), pageNo, pageSize);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "保存修改邀请排行榜数据成功");
        } catch (

        Exception e) {
            logger.error("保存修改邀请排行榜数据失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
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
        return 0;
    }

    /**
     * 获取第几周的开始时间
     * 
     * @param weekNum
     *            周次
     * @param month
     *            月份
     * @return 第几周的开始时间
     * @throws ParseException
     *             转换异常
     */
    private Date getWeeklyStartTime(Integer weekNum, Integer month) throws ParseException {
        if (null == weekNum) {
            weekNum = 1;
        }
        Calendar nowTime = Calendar.getInstance();
        Integer prevMonth = month - nowTime.get(Calendar.MONTH) - 1;
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
     * @param 月份
     *            周次
     * @return 第几周的结束时间
     * @throws ParseException
     *             转换异常
     */
    private Date getWeeklyEndTime(Integer weekNum, Integer month) throws ParseException {
        if (null == weekNum) {
            weekNum = 1;
        }
        Calendar nowTime = Calendar.getInstance();
        Integer prevMonth = month - nowTime.get(Calendar.MONTH) - 1;
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
}
