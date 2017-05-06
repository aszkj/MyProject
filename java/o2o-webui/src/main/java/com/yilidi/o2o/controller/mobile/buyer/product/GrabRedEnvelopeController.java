package com.yilidi.o2o.controller.mobile.buyer.product;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.appparam.buyer.product.GrabRedEnvelopeParam;
import com.yilidi.o2o.appvo.buyer.product.GrabRedEnvelopeInfoVO;
import com.yilidi.o2o.appvo.buyer.product.RedEnvelopeActivityInfoVO;
import com.yilidi.o2o.appvo.buyer.product.UserRedEnvelopeInfoVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.model.ProbabilityItemModel;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ProbabilityUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;
import com.yilidi.o2o.order.service.dto.UserVoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherPackageDto;
import com.yilidi.o2o.product.service.IRedEnvelopeService;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeRewardDto;
import com.yilidi.o2o.product.service.dto.UserRedEnvelopeActivityDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * 抢红包活动Controller
 * 
 * @author: chenlian
 * @date: 2016年11月11日 下午3:29:50
 */
@Controller("grabRedEnvelopeController")
@RequestMapping(value = "/interfaces/buyer")
public class GrabRedEnvelopeController extends BuyerBaseController {

    private static final String GRAB_REDENVELOPE_TIMES_DAILY_DEFAULT = "3";

    private static final String GRAB_REDENVELOPE_DURATION_PER_GAME_DEFAULT = "20";

    private static final String GRAB_REDENVELOPE_MAX_COUNT_PER_GAME_DEFAULT = "100";

    private static final String GRAB_REDENVELOPE_ACTIVITY_KEY = "GRAB_REDENVELOPE_ACTIVITY_KEY";

    private static final String USER_GRAB_REDENVELOPE_KEY = "USER_GRAB_REDENVELOPE_KEY";

    private static final Integer GRAB_REDENVELOPE_BEGIN_COUNTDOWN = 5;

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IRedEnvelopeService redEnvelopeService;

    @Autowired
    private ICouponService couponService;

    @Autowired
    private IVoucherService voucherService;

    /**
     * 用户活动期内参与抢红包活动信息数据接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     * @throws ParseException
     * @throws ProductServiceException
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/activity/userredenvelopeinfo")
    @ResponseBody
    public ResultParamModel userRedEnvelopeInfo(HttpServletRequest req, HttpServletResponse resp)
            throws ProductServiceException, ParseException {
        Date currentDateTime = DateUtils.getCurrentDateTime();
        RedEnvelopeActivityDto redEnvelopeActivityDto = redEnvelopeService
                .loadRedEnvelopeActivityByCurrentDateTime(currentDateTime);
        if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "当前时间不存在正在进行的抢红包活动");
        }
        Integer globalActivityId = redEnvelopeActivityDto.getGlobalActivityId();
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        UserRedEnvelopeActivityDto userRedEnvelopeActivityDto = redEnvelopeService.loadUserActivityByAIdAndUIdAndPDate(
                redEnvelopeActivityDto.getId(), userSessionModel.getUserId(), DateUtils.getCurrentDateTime());
        Integer residueTimes = getGrabRedEnvelopeTimesDaily();
        Integer receivedRedEnvelopeCount = 0;
        if (!ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityDto)) {
            residueTimes = getGrabRedEnvelopeTimesDaily().intValue() - userRedEnvelopeActivityDto.getPlayCount().intValue() >= 0 ? getGrabRedEnvelopeTimesDaily()
                    .intValue() - userRedEnvelopeActivityDto.getPlayCount().intValue()
                    : 0;
            receivedRedEnvelopeCount = userRedEnvelopeActivityDto.getRedEnvelopeCount();
        }
        UserRedEnvelopeInfoVO userRedEnvelopeInfo = new UserRedEnvelopeInfoVO();
        userRedEnvelopeInfo.setResidueTimes(residueTimes);
        userRedEnvelopeInfo.setReceivedRedEnvelopeCount(receivedRedEnvelopeCount);
        RedEnvelopeActivityInfoVO redEnvelopeActivityInfo = new RedEnvelopeActivityInfoVO();
        redEnvelopeActivityInfo.setActivityId(globalActivityId);
        redEnvelopeActivityInfo.setActivityRule(redEnvelopeActivityDto.getRule());
        redEnvelopeActivityInfo.setInterfaceInvokedProbability(redEnvelopeActivityDto.getInvokeProbability());
        redEnvelopeActivityInfo.setMaxJoinTimes(getGrabRedEnvelopeTimesDaily());
        redEnvelopeActivityInfo.setMaxTimePerTimes(getGrabRedEnvelopeDurationPerGame());
        redEnvelopeActivityInfo.setMaxCountPerTimes(getGrabRedEnvelopeMaxCountPerGame());
        userRedEnvelopeInfo.setRedEnvelopeActivityInfo(redEnvelopeActivityInfo);
        return super.encapsulateParam(userRedEnvelopeInfo, AppMsgBean.MsgCode.SUCCESS, "获取用户活动期内参与抢红包活动信息数据成功");
    }

    private Integer getGrabRedEnvelopeTimesDaily() {
        String grabRedEnvelopeTimesDailyStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.GRAB_REDENVELOPE_TIMES_DAILY);
        grabRedEnvelopeTimesDailyStr = StringUtils.isEmpty(grabRedEnvelopeTimesDailyStr) ? GRAB_REDENVELOPE_TIMES_DAILY_DEFAULT
                : grabRedEnvelopeTimesDailyStr;
        Integer grabRedEnvelopeTimesDaily = Integer.parseInt(grabRedEnvelopeTimesDailyStr);
        return grabRedEnvelopeTimesDaily;
    }

    private Integer getGrabRedEnvelopeDurationPerGame() {
        String grabRedEnvelopeDurationPerGameStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.GRAB_REDENVELOPE_DURATION_PER_GAME);
        grabRedEnvelopeDurationPerGameStr = StringUtils.isEmpty(grabRedEnvelopeDurationPerGameStr) ? GRAB_REDENVELOPE_DURATION_PER_GAME_DEFAULT
                : grabRedEnvelopeDurationPerGameStr;
        Integer grabRedEnvelopeDurationPerGame = Integer.parseInt(grabRedEnvelopeDurationPerGameStr);
        return grabRedEnvelopeDurationPerGame;
    }

    private Integer getGrabRedEnvelopeMaxCountPerGame() {
        String grabRedEnvelopeMaxCountPerGameStr = systemBasicDataInfoUtils
                .getSystemParamValue(SystemContext.SystemParams.GRAB_REDENVELOPE_MAX_COUNT_PER_GAME);
        grabRedEnvelopeMaxCountPerGameStr = StringUtils.isEmpty(grabRedEnvelopeMaxCountPerGameStr) ? GRAB_REDENVELOPE_MAX_COUNT_PER_GAME_DEFAULT
                : grabRedEnvelopeMaxCountPerGameStr;
        Integer grabRedEnvelopeMaxCountPerGame = Integer.parseInt(grabRedEnvelopeMaxCountPerGameStr);
        return grabRedEnvelopeMaxCountPerGame;
    }

    /**
     * 开始抢红包活动接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     * @throws ParseException
     * @throws ProductServiceException
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/activity/startgrabredenvelope")
    @ResponseBody
    public ResultParamModel startGrabRedEnvelope(HttpServletRequest req, HttpServletResponse resp)
            throws ProductServiceException, ParseException {
        Jedis jedis = null;
        try {
            jedis = JedisUtils.getJedis();
            Date currentDateTime = DateUtils.getCurrentDateTime();
            RedEnvelopeActivityDto redEnvelopeActivityDto = redEnvelopeService
                    .loadRedEnvelopeActivityByCurrentDateTime(currentDateTime);
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "当前时间不存在正在进行的抢红包活动");
            }
            Integer globalActivityId = redEnvelopeActivityDto.getGlobalActivityId();
            UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
            UserRedEnvelopeActivityDto userRedEnvelopeActivityDto = redEnvelopeService.loadUserActivityByAIdAndUIdAndPDate(
                    redEnvelopeActivityDto.getId(), userSessionModel.getUserId(), DateUtils.getCurrentDateTime());
            Integer residueTimes = getGrabRedEnvelopeTimesDaily();
            Integer receivedRedEnvelopeCount = 0;
            if (!ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityDto)) {
                residueTimes = getGrabRedEnvelopeTimesDaily().intValue()
                        - userRedEnvelopeActivityDto.getPlayCount().intValue() >= 0 ? getGrabRedEnvelopeTimesDaily()
                        .intValue() - userRedEnvelopeActivityDto.getPlayCount().intValue() : 0;
                receivedRedEnvelopeCount = userRedEnvelopeActivityDto.getRedEnvelopeCount();
                userRedEnvelopeActivityDto.setLastPlayTime(DateUtils.getCurrentDateTime());
                Integer affectedCount = redEnvelopeService.updateUserActivityByIdWithCountLimit(userRedEnvelopeActivityDto,
                        getGrabRedEnvelopeTimesDaily());
                if (1 != affectedCount.intValue()) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "每日参与抢红包次数已达上限");
                }
            } else {
                UserRedEnvelopeActivityDto ureaDto = new UserRedEnvelopeActivityDto();
                ureaDto.setRedEnvelopeActivityId(redEnvelopeActivityDto.getId());
                ureaDto.setUserId(userSessionModel.getUserId());
                ureaDto.setPlayCount(1);
                ureaDto.setRedEnvelopeCount(0);
                ureaDto.setPlayDate(DateUtils.getCurrentDateTime());
                ureaDto.setLastPlayTime(DateUtils.getCurrentDateTime());
                redEnvelopeService.saveUserActivity(ureaDto);
            }
            UserRedEnvelopeInfoVO userRedEnvelopeInfo = new UserRedEnvelopeInfoVO();
            userRedEnvelopeInfo.setResidueTimes(residueTimes);
            userRedEnvelopeInfo.setReceivedRedEnvelopeCount(receivedRedEnvelopeCount);
            RedEnvelopeActivityInfoVO redEnvelopeActivityInfo = new RedEnvelopeActivityInfoVO();
            redEnvelopeActivityInfo.setActivityId(globalActivityId);
            redEnvelopeActivityInfo.setActivityRule(redEnvelopeActivityDto.getRule());
            redEnvelopeActivityInfo.setInterfaceInvokedProbability(redEnvelopeActivityDto.getInvokeProbability());
            redEnvelopeActivityInfo.setMaxJoinTimes(getGrabRedEnvelopeTimesDaily());
            redEnvelopeActivityInfo.setMaxTimePerTimes(getGrabRedEnvelopeDurationPerGame());
            redEnvelopeActivityInfo.setMaxCountPerTimes(getGrabRedEnvelopeMaxCountPerGame());
            userRedEnvelopeInfo.setRedEnvelopeActivityInfo(redEnvelopeActivityInfo);
            String key = GRAB_REDENVELOPE_ACTIVITY_KEY + CommonConstants.DELIMITER_UNDERLINE + userSessionModel.getUserId();
            jedis.setex(key, getGrabRedEnvelopeDurationPerGame().intValue() + GRAB_REDENVELOPE_BEGIN_COUNTDOWN,
                    Integer.toString(globalActivityId));
            return super.encapsulateParam(userRedEnvelopeInfo, AppMsgBean.MsgCode.SUCCESS, "开始抢红包活动成功");
        } catch (Exception e) {
            String errorMsg = null == e.getMessage() ? "系统出现异常" : e.getMessage();
            logger.error(errorMsg, e);
            throw new IllegalStateException(errorMsg);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    /**
     * 抢红包接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/activity/grabredenvelope")
    @ResponseBody
    public ResultParamModel grabRedEnvelope(HttpServletRequest req, HttpServletResponse resp) {
        Jedis jedis = null;
        try {
            jedis = JedisUtils.getJedis();
            GrabRedEnvelopeParam param = super.getEntityParam(req, GrabRedEnvelopeParam.class);
            Integer activityId = param.getActivityId();
            UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
            Integer userId = userSessionModel.getUserId();
            String key = GRAB_REDENVELOPE_ACTIVITY_KEY + CommonConstants.DELIMITER_UNDERLINE + userId;
            if (!jedis.exists(key)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "请求非法或该次抢红包活动已结束");
            }
            String globalActivityIdStr = jedis.get(key);
            if (activityId.intValue() != Integer.parseInt(globalActivityIdStr)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "请求非法");
            }
            RedEnvelopeActivityDto redEnvelopeActivityDto = redEnvelopeService
                    .loadRedEnvelopeActivityByGlobalActivityId(Integer.parseInt(globalActivityIdStr));
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "抢红包活动不存在");
            }
            UserRedEnvelopeActivityDto userRedEnvelopeActivityDto = redEnvelopeService.loadUserActivityByAIdAndUIdAndPDate(
                    redEnvelopeActivityDto.getId(), userId, DateUtils.getCurrentDateTime());
            if (ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityDto)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户抢红包信息不存在");
            }
            Integer playCount = userRedEnvelopeActivityDto.getPlayCount();
            if (playCount.intValue() > getGrabRedEnvelopeTimesDaily().intValue()) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "每日参与抢红包次数已达上限");
            }
            RedEnvelopeRewardDto winRewardInfo = null;
            List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = redEnvelopeService.listRedEnvelopeRewards(
                    redEnvelopeActivityDto.getId(), SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
            if (ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "抢红包奖励相关信息不存在");
            }
            List<ProbabilityItemModel> items = new ArrayList<ProbabilityItemModel>();
            for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                ProbabilityItemModel item = new ProbabilityItemModel();
                item.setItemId(redEnvelopeRewardDto.getId());
                item.setProbability(new BigDecimal(redEnvelopeRewardDto.getWinProbability()));
                item.setProbabilityRandomNum(redEnvelopeRewardDto.getProbabilityRandomNum());
                items.add(item);
            }
            ProbabilityItemModel probabilityItemModel = ProbabilityUtils.hit(items);
            if (ObjectUtils.isNullOrEmpty(probabilityItemModel)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "未中奖");
            }
            for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                if (redEnvelopeRewardDto.getId().intValue() == probabilityItemModel.getItemId().intValue()) {
                    winRewardInfo = redEnvelopeRewardDto;
                    break;
                }
            }
            String rewardType = winRewardInfo.getRewardType();
            GrabRedEnvelopeInfoVO grabRedEnvelopeInfoVO = null;
            List<GrabRedEnvelopeInfoVO> grabRedEnvelopeInfoVOList = null;
            if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)) {
                CouponDto couponDto = couponService.loadCouponById(winRewardInfo.getPrizeId());
                if (ObjectUtils.isNullOrEmpty(couponDto)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "此优惠券奖品不存在");
                }
                Integer conPackId = couponDto.getConPackId();
                CouponPackageDto couponPackageDto = couponService.loadCouponPackageById(conPackId);
                if (ObjectUtils.isNullOrEmpty(couponPackageDto)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "此优惠券包不存在");
                }
                String prizeName = couponPackageDto.getConName() + "（发放时间："
                        + DateUtils.formatDateLong(couponDto.getGrantTime()) + ",第"+couponDto.getStageNo()+"阶段）";
                String userGrabRedEnvelopeKey = USER_GRAB_REDENVELOPE_KEY + CommonConstants.DELIMITER_UNDERLINE
                        + winRewardInfo.getId();
                DistributedLockUtils.lock(userGrabRedEnvelopeKey);
                Integer releaseCount = winRewardInfo.getReleaseCount();
                List<UserCouponDto> userCouponDtoList = couponService.listUserCouponsByAIdAndCId(
                        Integer.parseInt(globalActivityIdStr), winRewardInfo.getPrizeId());
                if (!ObjectUtils.isNullOrEmpty(userCouponDtoList) && userCouponDtoList.size() >= releaseCount.intValue()) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "中奖优惠券:" + prizeName + "已抢光");
                }
                List<String> statusList = new ArrayList<String>();
                statusList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                statusList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
                List<UserCouponDto> ucDtoList = couponService.listUserCouponsByAIdAndCIdAndUIdAndStatus(null,
                        winRewardInfo.getPrizeId(), userId, statusList);
                if (!ObjectUtils.isNullOrEmpty(ucDtoList)) {
                    return super
                            .encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户之前抢到过此优惠券:" + prizeName + "，且此优惠券既未过期也未被使用");
                }
                Integer winCountLimit = winRewardInfo.getWinCountLimit();
                List<String> sList = new ArrayList<String>();
                sList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_USED);
                sList.add(SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED);
                List<UserCouponDto> dtoList = couponService.listUserCouponsByAIdAndCIdAndUIdAndStatus(
                        Integer.parseInt(globalActivityIdStr), winRewardInfo.getPrizeId(), userId, sList);
                if (0 != winCountLimit.intValue() && !ObjectUtils.isNullOrEmpty(dtoList)
                        && dtoList.size() >= winCountLimit.intValue()) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户在该场次抢红包活动中所抢到的优惠券:" + prizeName
                            + "已超过其限中数量");
                }
                //处理优惠券有效期
                Map<String, Object> timeMap = couponService.getCouponValid(couponDto);
                if(ObjectUtils.isNullOrEmpty(timeMap)){
                	return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "没有获取到奖励的优惠券");
                }
                UserCouponDto userCouponDto = new UserCouponDto();
                userCouponDto.setActivityId(Integer.parseInt(globalActivityIdStr));
                userCouponDto.setConId(couponDto.getId());
                userCouponDto.setUserId(userId);
                userCouponDto.setBatchNo(couponDto.getBatchNo());
                userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                userCouponDto.setBeginTime((Date)timeMap.get("beginTime"));
                userCouponDto.setEndTime((Date)timeMap.get("endTime"));
                userCouponDto.setFindTime(new Date());
                couponService.saveUserCouponForGrabRedEnvelope(userCouponDto, userRedEnvelopeActivityDto.getId());
                grabRedEnvelopeInfoVOList = new ArrayList<GrabRedEnvelopeInfoVO>();
                grabRedEnvelopeInfoVO = new GrabRedEnvelopeInfoVO();
                grabRedEnvelopeInfoVO.setTicketId(winRewardInfo.getPrizeId());
                grabRedEnvelopeInfoVO.setTicketCount(1);
                grabRedEnvelopeInfoVO.setTicketType(ConverterUtils
                        .toClientTicketType(SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON));
                String ticketTypeName = systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.ProductDomain.DictType.REDENVELOPEREWARDTYPE.getValue(),
                        SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON);
                grabRedEnvelopeInfoVO.setTicketTypeName(ticketTypeName);
                grabRedEnvelopeInfoVO.setBeginTime(DateUtils.formatDate((Date)timeMap.get("beginTime"),CommonConstants.DATE_FORMAT_CURRENTTIME));
                grabRedEnvelopeInfoVO.setEndTime(DateUtils.formatDate((Date)timeMap.get("endTime"), CommonConstants.DATE_FORMAT_CURRENTTIME));
                grabRedEnvelopeInfoVO.setTicketAmount(couponPackageDto.getAmount());
                grabRedEnvelopeInfoVO.setLimitedAmount(couponPackageDto.getUseCondition());
                String useScope = systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), couponDto.getUseRangeCode());
                grabRedEnvelopeInfoVO.setUseScope(useScope);
                grabRedEnvelopeInfoVO.setTicketDescription(couponDto.getRule());
                String ticketStatusName = systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                grabRedEnvelopeInfoVO.setTicketStatusName(ticketStatusName);
                grabRedEnvelopeInfoVOList.add(grabRedEnvelopeInfoVO);
            }
            if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                VoucherPackageDto voucherPackageDto = voucherService.loadVoucherPackageById(winRewardInfo.getPrizeId());
                if (ObjectUtils.isNullOrEmpty(voucherPackageDto)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "此抵用券包不存在");
                }
                String vouPackContent = voucherPackageDto.getVouPackContent();
                String[] vouPackContentArray = vouPackContent.split(",");
                Integer totalCount = 0;
                for (int i = 0; i < vouPackContentArray.length; i++) {
                    String[] vouInfos = vouPackContentArray[i].split("_");
                    Integer count = Integer.parseInt(vouInfos[1]);
                    totalCount += count;
                }
                String prizeName = voucherPackageDto.getVouName() + "（发放时间："
                        + DateUtils.formatDateLong(winRewardInfo.getPrizeGrantTime()) + "）";
                List<VoucherDto> voucherDtoList = voucherService.listVouchersByVouPackIdAndGrantTime(
                        winRewardInfo.getPrizeId(), winRewardInfo.getPrizeGrantTime());
                if (ObjectUtils.isNullOrEmpty(voucherDtoList)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "中奖抵用券包:" + prizeName + "里不存在抵用券");
                }
                List<Integer> vouIds = new ArrayList<Integer>();
                for (VoucherDto voucherDto : voucherDtoList) {
                    vouIds.add(voucherDto.getId());
                }
                VoucherDto voucherDto = voucherDtoList.get(0);
                Date validStartTime = voucherDto.getValidStartTime();
                Date validEndTime = voucherDto.getValidEndTime();
                Date currentDateTime = DateUtils.getCurrentDateTime();
                if (currentDateTime.equals(validEndTime) || currentDateTime.after(validEndTime)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "中奖抵用券包:" + prizeName + "已过期");
                }
                Integer releaseCount = winRewardInfo.getReleaseCount();
                List<UserVoucherDto> userVoucherDtoList = voucherService.listUserVouchersByAIdAndVIds(
                        Integer.parseInt(globalActivityIdStr), vouIds);
                if (!ObjectUtils.isNullOrEmpty(userVoucherDtoList)
                        && userVoucherDtoList.size() / totalCount >= releaseCount.intValue()) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "中奖抵用券包:" + prizeName + "已抢光");
                }
                List<String> statusList = new ArrayList<String>();
                statusList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED);
                statusList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE);
                List<UserVoucherDto> uvDtoList = voucherService.listUserVouchersByAIdAndVIdsAndUIdAndStatus(null, vouIds,
                        userId, statusList);
                if (!ObjectUtils.isNullOrEmpty(uvDtoList)) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户之前抢到过此抵用券包:" + prizeName
                            + "，且此券包里含有既未过期也未被使用的抵用券");
                }
                Integer winCountLimit = winRewardInfo.getWinCountLimit();
                List<String> sList = new ArrayList<String>();
                sList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_USED);
                sList.add(SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED);
                List<UserVoucherDto> dtoList = voucherService.listUserVouchersByAIdAndVIdsAndUIdAndStatus(
                        Integer.parseInt(globalActivityIdStr), vouIds, userId, sList);
                if (0 != winCountLimit.intValue() && !ObjectUtils.isNullOrEmpty(dtoList)
                        && dtoList.size() / totalCount >= winCountLimit.intValue()) {
                    return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户在该场次抢红包活动中所抢到的抵用券包:" + prizeName
                            + "已超过其限中数量");
                }
                Map<Integer, Integer> voucherMap = new LinkedHashMap<Integer, Integer>();
                for (int i = 0; i < vouPackContentArray.length; i++) {
                    String[] vouInfos = vouPackContentArray[i].split("_");
                    Long price = Long.parseLong(vouInfos[0]);
                    Integer count = Integer.parseInt(vouInfos[1]);
                    for (VoucherDto vDto : voucherDtoList) {
                        if (price.longValue() == vDto.getVouAmount().longValue()) {
                            voucherMap.put(vDto.getId(), count);
                        }
                    }
                }
                List<UserVoucherDto> list = new ArrayList<UserVoucherDto>();
                for (Entry<Integer, Integer> entry : voucherMap.entrySet()) {
                    Integer voucherId = entry.getKey();
                    Integer count = entry.getValue();
                    for (int i = 0; i < count; i++) {
                        UserVoucherDto userVoucherDto = new UserVoucherDto();
                        userVoucherDto.setVouId(voucherId);
                        userVoucherDto.setUserId(userId);
                        userVoucherDto.setBatchNo(voucherDto.getBatchNo());
                        String status = null;
                        if (currentDateTime.before(voucherDto.getValidStartTime())) {
                            status = SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED;
                        }
                        if (currentDateTime.after(voucherDto.getValidStartTime())
                                && currentDateTime.before(voucherDto.getValidEndTime())) {
                            status = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                        }
                        if (currentDateTime.equals(voucherDto.getValidStartTime())
                                || currentDateTime.equals(voucherDto.getValidEndTime())) {
                            status = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                        }
                        if (currentDateTime.after(voucherDto.getValidEndTime())) {
                            status = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                        }
                        userVoucherDto.setStatus(status);
                        userVoucherDto.setActivityId(Integer.parseInt(globalActivityIdStr));
                        list.add(userVoucherDto);
                    }
                }
                voucherService.saveUserVoucherForGrabRedEnvelope(list, userRedEnvelopeActivityDto.getId());
                grabRedEnvelopeInfoVOList = new ArrayList<GrabRedEnvelopeInfoVO>();
                for (VoucherDto vDto : voucherDtoList) {
                    Integer count = voucherMap.get(vDto.getId());
                    grabRedEnvelopeInfoVO = new GrabRedEnvelopeInfoVO();
                    grabRedEnvelopeInfoVO.setTicketId(vDto.getId());
                    grabRedEnvelopeInfoVO.setTicketCount(count);
                    grabRedEnvelopeInfoVO.setTicketType(ConverterUtils
                            .toClientTicketType(SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER));
                    String ticketTypeName = systemBasicDataInfoUtils.getSystemDictName(
                            SystemContext.ProductDomain.DictType.REDENVELOPEREWARDTYPE.getValue(),
                            SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER);
                    grabRedEnvelopeInfoVO.setTicketTypeName(ticketTypeName);
                    grabRedEnvelopeInfoVO.setBeginTime(DateUtils.formatDate(validStartTime,
                            CommonConstants.DATE_FORMAT_CURRENTTIME));
                    grabRedEnvelopeInfoVO.setEndTime(DateUtils.formatDate(validEndTime,
                            CommonConstants.DATE_FORMAT_CURRENTTIME));
                    grabRedEnvelopeInfoVO.setTicketAmount(vDto.getVouAmount());
                    grabRedEnvelopeInfoVO.setLimitedAmount(vDto.getOrderAmountLimit());
                    grabRedEnvelopeInfoVO.setTicketDescription(vDto.getRule());
                    String status = null;
                    if (currentDateTime.before(voucherDto.getValidStartTime())) {
                        status = SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED;
                    }
                    if (currentDateTime.after(voucherDto.getValidStartTime())
                            && currentDateTime.before(voucherDto.getValidEndTime())) {
                        status = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                    }
                    if (currentDateTime.equals(voucherDto.getValidStartTime())
                            || currentDateTime.equals(voucherDto.getValidEndTime())) {
                        status = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                    }
                    if (currentDateTime.after(voucherDto.getValidEndTime())) {
                        status = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                    }
                    String ticketStatusName = systemBasicDataInfoUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), status);
                    grabRedEnvelopeInfoVO.setTicketStatusName(ticketStatusName);
                    grabRedEnvelopeInfoVOList.add(grabRedEnvelopeInfoVO);
                }
            }
            return super.encapsulateParam(grabRedEnvelopeInfoVOList, AppMsgBean.MsgCode.SUCCESS, "抢红包成功");
        } catch (Exception e) {
            String errorMsg = null == e.getMessage() ? "系统出现异常" : e.getMessage();
            logger.error(errorMsg, e);
            throw new IllegalStateException(errorMsg);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
            DistributedLockUtils.unlock();
        }
    }

}
