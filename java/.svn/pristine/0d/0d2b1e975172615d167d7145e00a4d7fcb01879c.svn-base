package com.yilidi.o2o.controller.operation.user;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareAwardService;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.InvitedUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserShareAwardQueryDto;

/**
 * 分享记录管理
 * 
 * @author: chenb
 * @date: 2015年11月17日 上午10:03:22
 * 
 */
@Controller("operationInvitedUserShareAwardController")
@RequestMapping(value = "/operation")
public class InvitedUserShareAwardController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IInvitedUserShareAwardService invitedUserShareAwardService;
    @Autowired
    private IInviterUserShareAwardService inviterUserShareAwardService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IShareRuleService shareRuleService;
    @Autowired
    private ICouponService couponService;

    /**
     * 查询分享记录列表
     * 
     * @param invitedUserShareAwardQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/usersharerecord/search")
    @ResponseBody
    public MsgBean search(@RequestBody InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) {
        try {
            Date nowTime = new Date();
            YiLiDiPage<InviterUserStatisticInfoDto> pageDto = invitedUserShareAwardService
                    .findInviterStatisticsCounts(invitedUserShareAwardQueryDto);
            if (!ObjectUtils.isNullOrEmpty(pageDto)) {
                List<InviterUserStatisticInfoDto> inviterUserStatisticInfoDtoList = pageDto.getResultList();
                if (!ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtoList)) {
                    for (InviterUserStatisticInfoDto inviterUserStatisticInfoDto : inviterUserStatisticInfoDtoList) {
                        Date endTime = DateUtils.getSpecificEndDate(
                                DateUtils.getConcreteDateByPutOffWeeks(0, DateUtils.getDayOfWeek(nowTime)));
                        Date startTime = DateUtils
                                .getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(0, Calendar.MONDAY));
                        invitedUserShareAwardQueryDto.setStartTime(startTime);
                        invitedUserShareAwardQueryDto.setEndTime(endTime);
                        InviterUserStatisticInfoDto inviterUserStatisticInfoDtoTmp = invitedUserShareAwardService
                                .loadStatisticsCountByShareUserIdAndTime(inviterUserStatisticInfoDto.getShareUserId(),
                                        startTime, endTime);
                        if (ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtoTmp)) {
                            inviterUserStatisticInfoDto.setCurWeekCount(0);
                        } else {
                            inviterUserStatisticInfoDto.setCurWeekCount(inviterUserStatisticInfoDtoTmp.getInviterCount());
                        }
                        Date prevEndTime = DateUtils
                                .getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.SUNDAY));
                        Date prevStartTime = DateUtils
                                .getSpecificEndDate(DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.MONDAY));
                        invitedUserShareAwardQueryDto.setStartTime(prevStartTime);
                        invitedUserShareAwardQueryDto.setEndTime(prevEndTime);
                        inviterUserStatisticInfoDtoTmp = invitedUserShareAwardService
                                .loadStatisticsCountByShareUserIdAndTime(inviterUserStatisticInfoDto.getShareUserId(),
                                        prevStartTime, prevEndTime);
                        if (ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtoTmp)) {
                            inviterUserStatisticInfoDto.setPrevWeekCount(0);
                        } else {
                            inviterUserStatisticInfoDto.setPrevWeekCount(inviterUserStatisticInfoDtoTmp.getInviterCount());
                        }
                        inviterUserStatisticInfoDtoTmp = invitedUserShareAwardService
                                .loadStatisticsCountByShareUserIdAndTime(inviterUserStatisticInfoDto.getShareUserId(), null,
                                        null);
                        if (ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtoTmp)) {
                            inviterUserStatisticInfoDto.setAccumulativeCount(0);
                        } else {
                            inviterUserStatisticInfoDto
                                    .setAccumulativeCount(inviterUserStatisticInfoDtoTmp.getInviterCount());
                        }
                        InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                                .getAwardStatisticsInfo(inviterUserStatisticInfoDto.getShareUserId(), null, null);
                        if (!ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                            inviterUserStatisticInfoDto.setAccumulativeIncome(inviterUserShareAwardDto.getAwardCash());
                            inviterUserStatisticInfoDto
                                    .setAccumulativeCoupon(inviterUserShareAwardDto.getAwardCouponCount());
                            inviterUserStatisticInfoDto.setAccumulativePoints(inviterUserShareAwardDto.getAwardPoints());
                        }
                    }
                }
            }
            return super.encapsulateMsgBean(pageDto, MsgBean.MsgCode.SUCCESS, "查询分享记录列表成功");
        } catch (Exception e) {
            logger.error("查询分享规则列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分享记录详细信息
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/usersharerecord/{shareUserId}/detail")
    @ResponseBody
    public MsgBean updateStatus(@PathVariable Integer shareUserId) {
        try {
            InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                    .getAwardStatisticsInfo(shareUserId, null, null);
            Date nowTime = new Date();
            Date endTime = DateUtils
                    .getSpecificEndDate(DateUtils.getConcreteDateByPutOffWeeks(0, DateUtils.getDayOfWeek(nowTime)));
            Date startTime = DateUtils.getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(0, Calendar.MONDAY));
            Date prevEndTime = DateUtils.getSpecificStartDate(DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.SUNDAY));
            Date prevStartTime = DateUtils.getSpecificEndDate(DateUtils.getConcreteDateByPutOffWeeks(-1, Calendar.MONDAY));
            InviterUserStatisticInfoDto curInviterUserStaticInfoDto = invitedUserShareAwardService
                    .loadStatisticsCountByShareUserIdAndTime(shareUserId, startTime, endTime);
            InviterUserStatisticInfoDto prevInviterUserStaticInfoDto = invitedUserShareAwardService
                    .loadStatisticsCountByShareUserIdAndTime(shareUserId, prevStartTime, prevEndTime);
            if (ObjectUtils.isNullOrEmpty(prevInviterUserStaticInfoDto)) {
                inviterUserShareAwardDto.setPrevWeekInviterCount(0);
            } else {
                inviterUserShareAwardDto.setPrevWeekInviterCount(prevInviterUserStaticInfoDto.getInviterCount());
            }
            if (ObjectUtils.isNullOrEmpty(curInviterUserStaticInfoDto)) {
                inviterUserShareAwardDto.setCurWeekInviterCount(0);
            } else {
                inviterUserShareAwardDto.setCurWeekInviterCount(curInviterUserStaticInfoDto.getInviterCount());
            }
            InviterUserShareAwardDto inviterCountUserShareAwardDto = inviterUserShareAwardService
                    .getAwardStatisticsInfo(shareUserId, null, null);
            if (!ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                inviterUserShareAwardDto.setAwardCash(inviterCountUserShareAwardDto.getAwardCash());
                inviterUserShareAwardDto.setAwardCouponCount(inviterUserShareAwardDto.getAwardCouponCount());
                inviterUserShareAwardDto.setAwardPoints(inviterCountUserShareAwardDto.getAwardPoints());
            }
            if (!ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                UserDto userDto = userService.loadUserById(inviterUserShareAwardDto.getUserId());
                if (!ObjectUtils.isNullOrEmpty(userDto)) {
                    inviterUserShareAwardDto.setShareUserName(userDto.getUserName());
                }
            }
            return super.encapsulateMsgBean(inviterUserShareAwardDto, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 分享用户邀请详细列表
     * 
     * @return MsgBean
     */
    @RequestMapping(value = "/usersharerecord/inviteduserlist")
    @ResponseBody
    public MsgBean updateStatus(@RequestBody InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) {
        try {
            YiLiDiPage<InvitedUserShareAwardDto> pageDto = invitedUserShareAwardService
                    .findInvitedUserShareAwardsByShareUserId(invitedUserShareAwardQueryDto);
            if (!ObjectUtils.isNullOrEmpty(pageDto) && !ObjectUtils.isNullOrEmpty(pageDto.getResultList())) {
                for (InvitedUserShareAwardDto invitedUserShareAwardDto : pageDto.getResultList()) {
                    UserDto userDto = userService.loadUserById(invitedUserShareAwardDto.getInvitedUserId());
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                        invitedUserShareAwardDto.setInvitedUserName(userDto.getUserName());
                    }
                    ShareRuleDto shareRuleDto = shareRuleService.loadById(invitedUserShareAwardDto.getShareRuleId());
                    if (!ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                        String invitedConditionTypeName = systemBasicDataInfoUtils.getSystemDictName(
                                SystemContext.UserDomain.DictType.SHARERULEINVITEDCONDITIONTYPE.getValue(),
                                shareRuleDto.getInvitedConditionType());
                        invitedUserShareAwardDto.setInvitedConditionTypeName(invitedConditionTypeName);
                        String invitedAwardTypeName = systemBasicDataInfoUtils.getSystemDictName(
                                SystemContext.UserDomain.DictType.SHARERULEAWARDTYPE.getValue(),
                                shareRuleDto.getInvitedAwardType());
                        invitedUserShareAwardDto.setInvitedAwardTypeName(invitedAwardTypeName);
                        String invitedAwardDesc = "";
                        if(!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType()) && !ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType().equals(SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH))){
                        	if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                                invitedAwardDesc = Integer.parseInt(shareRuleDto.getInvitedAward()) / 1000 + "元";
                            }
                        }
                        if(!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType()) && !ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType().equals(SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS))){
                        	if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                        		invitedAwardDesc = shareRuleDto.getInvitedAward() + "积分";
                        	}
                        }
                        if(!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType()) && !ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType().equals(SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON))){
                        	if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                        		String[] invitedAwardArray = shareRuleDto.getInvitedAward().split(";");
                        		if(!ObjectUtils.isNullOrEmpty(invitedAwardArray)){
                        			CouponDto couponDto = null;
                        			for (String invitedAward : invitedAwardArray) {
										String[] awardArray = invitedAward.split(",");
										if(StringUtils.isEmpty(awardArray[0]) || StringUtils.isEmpty(awardArray[1]) || StringUtils.isEmpty(awardArray[2])){
											continue;
										}
										couponDto = couponService.loadCouponById(Integer.parseInt(awardArray[0]));
										if (!ObjectUtils.isNullOrEmpty(couponDto)) {
											if(!StringUtils.isEmpty(invitedAwardDesc)){
												invitedAwardDesc += "+";
		                        			}
											invitedAwardDesc += couponDto.getRule() + " " + awardArray[2] + "张";
										}
									}
                        		}
                            }
                        }
                        
                        invitedUserShareAwardDto.setInvitedAwardDesc(invitedAwardDesc);
                    }
                }
            }
            return super.encapsulateMsgBean(pageDto, MsgBean.MsgCode.SUCCESS, "操作成功");
        } catch (Exception e) {
            logger.error(e, e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
}
