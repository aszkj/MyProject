package com.yilidi.o2o.controller.mobile.buyer.user;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.AcceptInviteParam;
import com.yilidi.o2o.appparam.buyer.user.InfoByShareCodeParam;
import com.yilidi.o2o.appparam.buyer.user.ShareInviteTopParam;
import com.yilidi.o2o.appvo.buyer.user.ChampionRewardInfoVO;
import com.yilidi.o2o.appvo.buyer.user.InfoByShareCodeVO;
import com.yilidi.o2o.appvo.buyer.user.InviteTopVO;
import com.yilidi.o2o.appvo.buyer.user.MyInviteRecordVO;
import com.yilidi.o2o.appvo.buyer.user.MyInviteSummaryInfoVO;
import com.yilidi.o2o.appvo.buyer.user.ShareActivityInfoVO;
import com.yilidi.o2o.appvo.buyer.user.ShareContentVO;
import com.yilidi.o2o.appvo.buyer.user.ShareToMomentsVO;
import com.yilidi.o2o.appvo.buyer.user.ShareToSmsVO;
import com.yilidi.o2o.appvo.buyer.user.ShareToWeiXinFriendsVO;
import com.yilidi.o2o.appvo.buyer.user.UserBaseInfoVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.connect.wechat.api.AccessTokenApi;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareAwardService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopHistoryService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopService;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.IUserShareCodeService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.InvitedUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserShareCodeDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserShareAwardQueryDto;

/**
 * 分享活动规则
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerUserShareController")
@RequestMapping(value = "/interfaces/buyer")
public class UserShareController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final String SHARECODE_PARAM_NAME = "shareCode";
    /** 用户默认头像名称 **/
    private static final String USERHEAD_IMAGE_NAME_DEFAULT = "/head_image_default.png";

    @Autowired
    private IShareRuleService shareRuleService;
    @Autowired
    private IUserShareCodeService userShareCodeService;
    @Autowired
    private IUserService userService;
    @Autowired
    private IUserShareService userShareService;
    @Autowired
    private IInvitedUserShareAwardService invitedUserShareAwardService;
    @Autowired
    private IInviterUserShareAwardService inviterUserShareAwardService;
    @Autowired
    private IInviterUserShareWeekTopHistoryService inviterUserShareWeekTopHistoryService;
    @Autowired
    private IInviterUserShareWeekTopService inviterUserShareWeekTopService;
    /**
     * 分享活动冠军奖励
     */
    private static final String USERSHARE_CHAMPION_AWARD_DEFAULT = "100元";

    /**
     * 3.62分享送好礼信息总汇接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     */
    @RequestMapping(value = "/share/shareactivityinfo")
    @ResponseBody
    public ResultParamModel shareActivityInfo(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        Date nowTime = new Date();
        Date prevMonthStartTime = DateUtils.getSpecificStartDate(DateUtils.addMonths(nowTime, -1));
        Date prevMonthEndTime = DateUtils.getSpecificEndDate(DateUtils.addMonths(nowTime, -1));
        Integer shareUserId = invitedUserShareAwardService.loadChampionByTime(prevMonthStartTime, prevMonthEndTime);
        ShareActivityInfoVO shareActivityInfoVO = new ShareActivityInfoVO();
        ChampionRewardInfoVO championRewardInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(shareUserId)) {
            UserDto userDto = userService.loadUserById(shareUserId);
            if (!ObjectUtils.isNullOrEmpty(userDto)) {
                championRewardInfoVO = new ChampionRewardInfoVO();
                championRewardInfoVO.setChampionName(userDto.getUserName());
                championRewardInfoVO.setPeriod(DateUtils.getMonth(prevMonthStartTime) + "月");
                championRewardInfoVO.setRewardName(getUserShareChampionAwardSystemConfig());
            }
        }
        shareActivityInfoVO.setChampionRewardInfo(championRewardInfoVO);
        ChampionRewardInfoVO nextRewardInfoVO = new ChampionRewardInfoVO();
        nextRewardInfoVO.setPeriod(DateUtils.getMonth(nowTime) + "月");
        nextRewardInfoVO.setRewardName(getUserShareChampionAwardSystemConfig());
        shareActivityInfoVO.setNextRewardInfo(nextRewardInfoVO);
        ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
        if (!ObjectUtils.isNullOrEmpty(shareRuleDto)) {
            shareActivityInfoVO.setInfoRuleUrl(StringUtils.toFullMobileUrl(shareRuleDto.getDescriptionUrl()));
        }
        return super.encapsulateParam(shareActivityInfoVO, AppMsgBean.MsgCode.SUCCESS, "获取成功");
    }

    /**
     * 3.63分享送好礼邀请排行榜接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws ParseException
     */
    @RequestMapping(value = "/share/invitetop")
    @ResponseBody
    public ResultParamModel inviteTop(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        ShareInviteTopParam shareInviteTopParam = super.getEntityParam(req, ShareInviteTopParam.class);
        Calendar calendar = Calendar.getInstance();
        Date nowTime = calendar.getTime();
        Integer year = calendar.get(Calendar.YEAR);
        Integer month = calendar.get(Calendar.MONTH) + 1;
        Integer weekNum = getWeekNumbByTime(nowTime); // 当前时间属于第几周
        Date startTime = getWeeklyStartTime(weekNum, month);
        Date endTime = getWeeklyEndTime(weekNum, month);
        InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto = new InvitedUserShareAwardQueryDto();
        invitedUserShareAwardQueryDto.setStartTime(startTime);
        invitedUserShareAwardQueryDto.setEndTime(endTime);
        invitedUserShareAwardQueryDto.setStart(shareInviteTopParam.getPageNum());
        invitedUserShareAwardQueryDto.setPageSize(shareInviteTopParam.getPageSize());
        Integer revisionCount = inviterUserShareWeekTopHistoryService.getRevisionCount(year, month, weekNum, null);
        List<InviteTopVO> inviteTopVOList = null;
        YiLiDiPage<InviterUserShareWeekTopDto> weekTopPage = null;
        if (revisionCount > 0) {
            weekTopPage = inviterUserShareWeekTopService.findInviterUserShareWeekTops(year, month, weekNum,
                    shareInviteTopParam.getPageNum(), shareInviteTopParam.getPageSize());
            inviteTopVOList = getInviteTopVOListByWeekTop(weekTopPage.getResultList());
        }
        if (ObjectUtils.isNullOrEmpty(weekTopPage) || ObjectUtils.isNullOrEmpty(weekTopPage.getResultList())) {
            YiLiDiPage<InviterUserStatisticInfoDto> page = invitedUserShareAwardService
                    .findInviterStatisticsCounts(invitedUserShareAwardQueryDto);
            inviteTopVOList = getInviteTopVOListByAward(page.getResultList());
            return super.encapsulatePageParam(page, inviteTopVOList, AppMsgBean.MsgCode.SUCCESS, "操作成功");
        } else {
            return super.encapsulatePageParam(weekTopPage, inviteTopVOList, AppMsgBean.MsgCode.SUCCESS, "操作成功");
        }
    }

    private List<InviteTopVO> getInviteTopVOListByAward(List<InviterUserStatisticInfoDto> inviterUserStatisticInfoDtos) {
        if (ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoDtos)) {
            return Collections.emptyList();
        }
        List<InviteTopVO> inviteTopVOList = new ArrayList<InviteTopVO>();
        for (InviterUserStatisticInfoDto inviterUserStatisticInfoDto : inviterUserStatisticInfoDtos) {
            InviteTopVO inviteTopVO = new InviteTopVO();
            inviteTopVO.setInviteCount(inviterUserStatisticInfoDto.getInviterCount());
            UserDto userDto = userService.loadUserById(inviterUserStatisticInfoDto.getShareUserId());
            if (ObjectUtils.isNullOrEmpty(userDto)) {
                continue;
            }
            if (!ObjectUtils.isNullOrEmpty(userDto.getUserName())) {
                inviteTopVO.setUserName(userDto.getUserName().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
            }
            String userImageUrl = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH)
                    + USERHEAD_IMAGE_NAME_DEFAULT;
            if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())
                    && !ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto().getUserImageUrl())) {
                userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
            }
            inviteTopVO.setUserImageUrl(StringUtils.toFullImageUrl(userImageUrl));
            inviteTopVOList.add(inviteTopVO);
        }
        return inviteTopVOList;
    }

    private List<InviteTopVO> getInviteTopVOListByWeekTop(List<InviterUserShareWeekTopDto> inviterUserShareWeekTopDtos) {
        if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDtos)) {
            return Collections.emptyList();
        }
        List<InviteTopVO> inviteTopVOList = new ArrayList<InviteTopVO>();
        for (InviterUserShareWeekTopDto inviterUserShareWeekTopDto : inviterUserShareWeekTopDtos) {
            InviteTopVO inviteTopVO = new InviteTopVO();
            inviteTopVO.setInviteCount(inviterUserShareWeekTopDto.getRevisionInviterCount());
            UserDto userDto = userService.loadUserByNameAndType(inviterUserShareWeekTopDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            String userImageUrl = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH)
                    + USERHEAD_IMAGE_NAME_DEFAULT;
            if (!ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getUserName())) {
                inviteTopVO.setUserName(
                        inviterUserShareWeekTopDto.getUserName().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
            }
            if (!ObjectUtils.isNullOrEmpty(userDto) && !ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
                userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
            }
            inviteTopVO.setUserImageUrl(StringUtils.toFullImageUrl(userImageUrl));
            inviteTopVOList.add(inviteTopVO);
        }
        return inviteTopVOList;
    }

    /**
     * 3.64分享送好礼我的邀请记录接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/share/myinvite")
    @ResponseBody
    public ResultParamModel myInvite(HttpServletRequest req, HttpServletResponse resp) {
        ShareInviteTopParam shareInviteTopParam = super.getEntityParam(req, ShareInviteTopParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto = new InvitedUserShareAwardQueryDto();
        invitedUserShareAwardQueryDto.setStart(shareInviteTopParam.getPageNum());
        invitedUserShareAwardQueryDto.setPageSize(shareInviteTopParam.getPageSize());
        invitedUserShareAwardQueryDto.setShareUserId(userSession.getUserId());
        YiLiDiPage<InvitedUserShareAwardDto> page = invitedUserShareAwardService
                .findInvitedUserShareAwardsByShareUserId(invitedUserShareAwardQueryDto);
        List<InvitedUserShareAwardDto> invitedUserShareAwardDtos = page.getResultList();
        List<MyInviteRecordVO> myInviteRecordVOList = new ArrayList<MyInviteRecordVO>();
        if (!ObjectUtils.isNullOrEmpty(invitedUserShareAwardDtos)) {
            for (InvitedUserShareAwardDto invitedUserShareAwardDto : invitedUserShareAwardDtos) {
                MyInviteRecordVO myInviteRecordVO = new MyInviteRecordVO();
                myInviteRecordVO.setInviteTime(invitedUserShareAwardDto.getCreateTime());
                UserDto userDto = userService.loadUserById(invitedUserShareAwardDto.getInvitedUserId());
                if (ObjectUtils.isNullOrEmpty(userDto)) {
                    continue;
                }
                String userImageUrl = null;
                myInviteRecordVO.setUserName(userDto.getUserName().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
                if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
                    userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
                }
                if (ObjectUtils.isNullOrEmpty(userImageUrl)) {
                    userImageUrl = SystemBasicDataUtils.getSystemParamValue(
                            SystemContext.SystemParams.USER_PIC_RELATIVE_PATH) + USERHEAD_IMAGE_NAME_DEFAULT;
                }
                myInviteRecordVO.setUserImageUrl(StringUtils.toFullImageUrl(userImageUrl));
                myInviteRecordVOList.add(myInviteRecordVO);
            }
        }
        return super.encapsulatePageParam(page, myInviteRecordVOList, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    /**
     * 3.65分享送好礼我的邀请总汇接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/share/myinvitesummary")
    @ResponseBody
    public ResultParamModel myInviteSummary(HttpServletRequest req, HttpServletResponse resp) {
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        MyInviteSummaryInfoVO myInviteSummaryInfoVO = new MyInviteSummaryInfoVO();
        Integer totalCount = invitedUserShareAwardService.getInviterCountByShareUserIdAndTime(userSession.getUserId(), null,
                null);
        Long inviterCouponACount = inviterUserShareAwardService
                .getInviterAmountCountByShareUserIdAndTime(userSession.getUserId(), null, null);
        myInviteSummaryInfoVO.setInviteCount(totalCount);
        myInviteSummaryInfoVO.setInviteRewardAmount(inviterCouponACount);
        return super.encapsulateParam(myInviteSummaryInfoVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    /**
     * 3.66获取分享微信好友信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     * @throws UnsupportedEncodingException
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/share/sharetoweixinfriends")
    @ResponseBody
    public ResultParamModel shareToWeiXinFriends(HttpServletRequest req, HttpServletResponse resp)
            throws UnsupportedEncodingException {
        Date nowTime = new Date();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        ShareRuleDto shareRuleDto = userShareService.updateShareToWechatFriends(userSession.getUserId(), nowTime);
        ShareToWeiXinFriendsVO shareToWeiXinFriendsVO = null;
        if (!ObjectUtils.isNullOrEmpty(shareRuleDto)) {
            shareToWeiXinFriendsVO = new ShareToWeiXinFriendsVO();
            shareToWeiXinFriendsVO.setImageUrl(StringUtils.EMPTY);
            shareToWeiXinFriendsVO.setContent(shareRuleDto.getFriendContent());
            shareToWeiXinFriendsVO.setTitle(shareRuleDto.getFriendTitle());
            shareToWeiXinFriendsVO
                    .setRedirectUrl(getRedirectH5DrawUrl(shareRuleDto.getH5DrawUrl(), shareRuleDto.getShareCode()));
        }
        return super.encapsulateParam(shareToWeiXinFriendsVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    private String getRedirectH5DrawUrl(String h5DrawUrl, String shareCode) throws UnsupportedEncodingException {
        if (ObjectUtils.isNullOrEmpty(h5DrawUrl)) {
            return StringUtils.EMPTY;
        }
        StringBuffer resultUrlSb = new StringBuffer();
        resultUrlSb.append(h5DrawUrl);
        if (-1 == h5DrawUrl.indexOf("?"))
            resultUrlSb.append("?").append(SHARECODE_PARAM_NAME).append("=").append(shareCode);
        else {
            resultUrlSb.append("&").append(SHARECODE_PARAM_NAME).append("=").append(shareCode);
        }
        return AccessTokenApi.getAuthorizeURLThroughPublish(WechatConfig.getAppId(true),
                URLEncoder.encode(StringUtils.toFullMobileUrl(resultUrlSb.toString()), CommonConstants.UTF_8), false);
    }

    /**
     * 3.67获取分享微信朋友圈信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/share/sharetomoments")
    @ResponseBody
    public ResultParamModel shareToMoments(HttpServletRequest req, HttpServletResponse resp) {
        Date nowTime = new Date();
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        String url = userShareService.updateShareToWechatFriendsCircle(userSession.getUserId(), nowTime);
        ShareToMomentsVO shareToMomentsVO = new ShareToMomentsVO();
        shareToMomentsVO.setImageUrl(StringUtils.toFullImageUrl(url));
        return super.encapsulateParam(shareToMomentsVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    /**
     * 3.68获取分享短信信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    // @RequestMapping(value = "/share/sharetosms")
    // @ResponseBody
    public ResultParamModel shareToSms(HttpServletRequest req, HttpServletResponse resp) {
        Date nowTime = new Date();
        ShareToSmsVO shareToSmsVO = new ShareToSmsVO();
        shareToSmsVO.setContent("短信分享内容");
        return super.encapsulateParam(shareToSmsVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    /**
     * 3.69根据分享唯一标识获取分享活动信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/share/infobysharecode")
    @ResponseBody
    public ResultParamModel infoBySharCode(HttpServletRequest req, HttpServletResponse resp) {
        InfoByShareCodeParam infoByShareCodeParam = super.getEntityParam(req, InfoByShareCodeParam.class);
        String shareCode = infoByShareCodeParam.getShareCode();
        Date nowTime = new Date();
        UserShareCodeDto userShareCodeDto = userShareCodeService.loadByShareCode(shareCode);
        InfoByShareCodeVO infoByShareCodeVO = new InfoByShareCodeVO();
        UserBaseInfoVO inviteUserInfoVO = new UserBaseInfoVO();
        if (!ObjectUtils.isNullOrEmpty(userShareCodeDto)) {
            UserDto userDto = userService.loadUserById(userShareCodeDto.getShareUserId());
            inviteUserInfoVO.setMemberType(ConverterUtils.toClienMemberType(userDto.getBuyerLevelCode()));
            String userImageUrl = null;
            String nickName = null;
            if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
                userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
                nickName = userDto.getUserProfileDto().getNickName();
            }
            if (ObjectUtils.isNullOrEmpty(userImageUrl)) {
                userImageUrl = SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH)
                        + USERHEAD_IMAGE_NAME_DEFAULT;
            }
            inviteUserInfoVO.setNickName(nickName);
            inviteUserInfoVO.setUserImageUrl(StringUtils.toFullImageUrl(userImageUrl));
            inviteUserInfoVO.setUserName(userDto.getUserName());
            infoByShareCodeVO.setInviteUserInfo(inviteUserInfoVO);
        }
        ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
        ShareContentVO shareInfo = null;
        if (!ObjectUtils.isNullOrEmpty(shareRuleDto)) {
            shareInfo = new ShareContentVO();
            shareInfo.setContent(shareRuleDto.getShareRuleName());
        }
        infoByShareCodeVO.setShareInfo(shareInfo);
        return super.encapsulateParam(infoByShareCodeVO, AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    /**
     * 3.70分享送好礼新用户领取注册信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/share/acceptinvite")
    @ResponseBody
    public ResultParamModel acceptInvite(HttpServletRequest req, HttpServletResponse resp) {
        AcceptInviteParam acceptInviteParam = super.getEntityParam(req, AcceptInviteParam.class);
        userShareService.updateAcceptInvite(acceptInviteParam.getCode(), acceptInviteParam.getShareCode(),
                acceptInviteParam.getMobile(), null);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "操作成功");
    }

    private String getUserShareChampionAwardSystemConfig() {
        String championAward = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.USERSHARE_CHAMPION_AWARD);
        if (ObjectUtils.isNullOrEmpty(championAward)) {
            championAward = USERSHARE_CHAMPION_AWARD_DEFAULT;
        }
        return championAward;
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
