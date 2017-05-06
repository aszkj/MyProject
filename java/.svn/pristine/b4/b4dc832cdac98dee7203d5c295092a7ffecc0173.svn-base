package com.yilidi.o2o.controller.operation.product;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.CouponBasicInfoDto;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.VoucherBasicInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherPackageDto;
import com.yilidi.o2o.product.service.IRedEnvelopeService;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityFormDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeActivityInfoDto;
import com.yilidi.o2o.product.service.dto.RedEnvelopeRewardDto;
import com.yilidi.o2o.product.service.dto.query.RedEnvelopeActivityQueryDto;

/**
 * 红包Controller
 * 
 * @author: chenlian
 * @date: 2016年11月3日 下午2:46:21
 */
@Controller
@RequestMapping(value = "/operation")
public class RedEnvelopeController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IRedEnvelopeService redEnvelopeService;

    @Autowired
    private ICouponService couponService;

    @Autowired
    private IVoucherService voucherService;

    /**
     * 查询抢红包活动信息列表
     * 
     * @param redEnvelopeActivityQueryDto
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/searchRedEnvelopeActivities")
    @ResponseBody
    public MsgBean searchRedEnvelopeActivities(@RequestBody RedEnvelopeActivityQueryDto redEnvelopeActivityQueryDto) {
        try {
            if (!StringUtils.isEmpty(redEnvelopeActivityQueryDto.getStrStartValidTime())) {
                redEnvelopeActivityQueryDto.setStartValidTime(DateUtils.getSpecificStartDate(redEnvelopeActivityQueryDto
                        .getStrStartValidTime()));
            }
            if (!StringUtils.isEmpty(redEnvelopeActivityQueryDto.getStrEndValidTime())) {
                redEnvelopeActivityQueryDto.setEndValidTime(DateUtils.getSpecificEndDate(redEnvelopeActivityQueryDto
                        .getStrEndValidTime()));
            }
            YiLiDiPage<RedEnvelopeActivityInfoDto> yiLiDiPage = redEnvelopeService
                    .findRedEnvelopeActivities(redEnvelopeActivityQueryDto);
            if (!ObjectUtils.isNullOrEmpty(yiLiDiPage) && !ObjectUtils.isNullOrEmpty(yiLiDiPage.getResultList())) {
                List<RedEnvelopeActivityInfoDto> redEnvelopeActivityInfoDtoList = yiLiDiPage.getResultList();
                for (RedEnvelopeActivityInfoDto redEnvelopeActivityInfoDto : redEnvelopeActivityInfoDtoList) {
                    List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = redEnvelopeActivityInfoDto.getRedEnvelopeRewards();
                    if (!ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                        for (RedEnvelopeRewardDto redEnvelopeRewardDto : redEnvelopeRewardDtoList) {
                            String rewardType = redEnvelopeRewardDto.getRewardType();
                            if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_COUPON.equals(rewardType)) {
                                Integer couponId = redEnvelopeRewardDto.getPrizeId();
                                CouponDto couponDto = couponService.loadCouponById(couponId);
                                if (!ObjectUtils.isNullOrEmpty(couponDto)) {
                                    Integer conPackId = couponDto.getConPackId();
                                    CouponPackageDto couponPackageDto = couponService.loadCouponPackageById(conPackId);
                                    if (!ObjectUtils.isNullOrEmpty(couponPackageDto)) {
                                        redEnvelopeRewardDto.setPrizeName(couponPackageDto.getConName());
                                    }
                                }
                            }
                            if (SystemContext.ProductDomain.REDENVELOPEREWARDTYPE_VOUCHER.equals(rewardType)) {
                                Integer vouPackId = redEnvelopeRewardDto.getPrizeId();
                                VoucherPackageDto voucherPackageDto = voucherService.loadVoucherPackageById(vouPackId);
                                if (!ObjectUtils.isNullOrEmpty(voucherPackageDto)) {
                                    redEnvelopeRewardDto.setPrizeName(voucherPackageDto.getVouName());
                                }
                            }
                        }
                    }
                }
            }
            logger.info(JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询抢红包活动信息列表成功");
        } catch (Exception e) {
            logger.error("查询抢红包活动信息列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取抢红包活动所需的优惠券列表
     * 
     * @param activityStartDate
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/{packageId}/listAvailableCoupons")
    @ResponseBody
    public MsgBean listAvailableCoupons(@PathVariable("packageId") Integer packageId) {
        try {
            List<CouponBasicInfoDto> couponBasicInfoDtoList = couponService
                    .listCouponsForRedEnvelopeActivity(packageId);
            return super.encapsulateMsgBean(couponBasicInfoDtoList, MsgBean.MsgCode.SUCCESS, "获取抢红包活动所需的优惠券列表成功");
        } catch (Exception e) {
            logger.error("获取抢红包活动所需的优惠券列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取抢红包活动所需的抵用券列表
     * 
     * @param activityStartDate
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/{strActivityStartDate}/listAvailableVouchers")
    @ResponseBody
    public MsgBean listAvailableVouchers(@PathVariable("strActivityStartDate") String strActivityStartDate) {
        try {
        	Date activityStartDate = null;
        	if(!StringUtils.isEmpty(strActivityStartDate) && !strActivityStartDate.equals("null")){
        		activityStartDate = DateUtils.parseDate(strActivityStartDate);
        	}
            List<VoucherBasicInfoDto> voucherBasicInfoDtoList = voucherService
                    .listVoucherPackagesForRedEnvelopeActivity(activityStartDate);
            return super.encapsulateMsgBean(voucherBasicInfoDtoList, MsgBean.MsgCode.SUCCESS, "获取抢红包活动所需的抵用券列表成功");
        } catch (Exception e) {
            logger.error("获取抢红包活动所需的抵用券列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取抢红包活动有效期区间是否存在时间交集标识
     * 
     * @param activityStartDate
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "{id}_{strActivityStartDate}_{strActivityEndDate}/getValidTimeIntersectionFlag")
    @ResponseBody
    public MsgBean getValidTimeIntersectionFlag(@PathVariable("id") Integer id,
            @PathVariable("strActivityStartDate") String strActivityStartDate,
            @PathVariable("strActivityEndDate") String strActivityEndDate) {
        try {
            String validTimeIntersectionFlag = CommonConstants.STR_NO_FLAG;
            String msg = "";
            if (StringUtils.isEmpty(strActivityStartDate)) {
                msg = "开始有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            if (StringUtils.isEmpty(strActivityEndDate)) {
                msg = "结束有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            Date activityStartDate = DateUtils.parseDate(strActivityStartDate);
            Date activityEndDate = DateUtils.parseDate(strActivityEndDate);
            if (activityEndDate.before(activityStartDate)) {
                msg = "结束有效时间必须大于开始有效时间！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            List<RedEnvelopeActivityDto> redEnvelopeActivityDtoList = redEnvelopeService.listRedEnvelopeActivities();
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDtoList)) {
                msg = "获取抢红包活动有效期区间是否存在时间交集标识成功";
                return super.encapsulateMsgBean(validTimeIntersectionFlag, MsgBean.MsgCode.SUCCESS, msg);
            }
            RedEnvelopeActivityDto reaDto = null;
            if (id.intValue() != 0) {
                reaDto = redEnvelopeService.loadRedEnvelopeActivityById(id);
            }
            for (RedEnvelopeActivityDto redEnvelopeActivityDto : redEnvelopeActivityDtoList) {
                if (!ObjectUtils.isNullOrEmpty(reaDto)
                        && reaDto.getId().intValue() == redEnvelopeActivityDto.getId().intValue()) {
                    continue;
                }
                if ((activityEndDate.after(redEnvelopeActivityDto.getValidStartTime()) && activityStartDate
                        .before(redEnvelopeActivityDto.getValidEndTime()))
                        || (activityStartDate.before(redEnvelopeActivityDto.getValidStartTime()) && activityEndDate
                                .after(redEnvelopeActivityDto.getValidEndTime()))
                        || (activityStartDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                        || (activityStartDate.equals(redEnvelopeActivityDto.getValidEndTime()))
                        || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                        || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))) {
                    validTimeIntersectionFlag = CommonConstants.STR_YES_FLAG;
                    break;
                }
            }
            msg = "获取抢红包活动有效期区间是否存在时间交集标识成功";
            return super.encapsulateMsgBean(validTimeIntersectionFlag, MsgBean.MsgCode.SUCCESS, msg);
        } catch (Exception e) {
            logger.error("获取抢红包活动有效期区间是否存在时间交集标识失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增抢红包游戏
     * 
     * @param redEnvelopeActivityFormDto
     *            抢红包活动Form表单信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createRedEnvelopeActivity")
    @ResponseBody
    public MsgBean createRedEnvelopeActivity(@RequestBody RedEnvelopeActivityFormDto redEnvelopeActivityFormDto) {
        String msg = "";
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityFormDto)) {
                msg = "无法获取需新增的抢红包活动Form表单信息DTO";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            String validTimeIntersectionFlag = CommonConstants.STR_NO_FLAG;
            Date activityStartDate = redEnvelopeActivityFormDto.getValidStartTime();
            Date activityEndDate = redEnvelopeActivityFormDto.getValidEndTime();
            if (ObjectUtils.isNullOrEmpty(activityStartDate)) {
                msg = "开始有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            if (ObjectUtils.isNullOrEmpty(activityEndDate)) {
                msg = "结束有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            if (activityEndDate.before(activityStartDate)) {
                msg = "结束有效时间必须大于开始有效时间！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            List<RedEnvelopeActivityDto> redEnvelopeActivityDtoList = redEnvelopeService.listRedEnvelopeActivities();
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivityDtoList)) {
                for (RedEnvelopeActivityDto redEnvelopeActivityDto : redEnvelopeActivityDtoList) {
                    if ((activityEndDate.after(redEnvelopeActivityDto.getValidStartTime()) && activityStartDate
                            .before(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityStartDate.before(redEnvelopeActivityDto.getValidStartTime()) && activityEndDate
                                    .after(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityStartDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                            || (activityStartDate.equals(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                            || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))) {
                        validTimeIntersectionFlag = CommonConstants.STR_YES_FLAG;
                        break;
                    }
                }
                if (CommonConstants.STR_YES_FLAG.equals(validTimeIntersectionFlag)) {
                    msg = "该有效期区间与之前设置的抢红包游戏有效期存在重叠，请重新选择有效期区间！";
                    logger.error(msg);
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
                }
            }
            redEnvelopeActivityFormDto.setCreateTime(DateUtils.getCurrentDateTime());
            redEnvelopeActivityFormDto.setCreateUserId(super.getUserId());
            redEnvelopeService.saveWholeRedEnvelopeActivity(redEnvelopeActivityFormDto);
            msg = "新增抢红包游戏成功";
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, msg);
        } catch (Exception e) {
            logger.error("新增抢红包游戏失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 查看红包游戏
     * 
     * @param id
     *            抢红包活动ID
     * @return MsgBean
     */
    @RequestMapping(value = "{id}/getRedEnvelopeActivityDetail")
    @ResponseBody
    public MsgBean getRedEnvelopeActivityDetail(@PathVariable("id") Integer id) {
        String msg = "";
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                msg = "无法获取抢红包活动ID";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            RedEnvelopeActivityDto redEnvelopeActivityDto = redEnvelopeService.loadRedEnvelopeActivityById(id);
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityDto)) {
                msg = "需查看的红包游戏不存在";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            List<RedEnvelopeRewardDto> redEnvelopeRewardDtoList = redEnvelopeService.listRedEnvelopeRewards(id,
                    SystemContext.ProductDomain.REDENVELOPEREWARDSTATUS_VALID);
            if (ObjectUtils.isNullOrEmpty(redEnvelopeRewardDtoList)) {
                msg = "需查看的红包游戏奖励不存在";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            RedEnvelopeActivityInfoDto redEnvelopeActivityInfoDto = new RedEnvelopeActivityInfoDto();
            redEnvelopeActivityInfoDto.setActivityName(redEnvelopeActivityDto.getActivityName());
            redEnvelopeActivityInfoDto.setValidStartTime(redEnvelopeActivityDto.getValidStartTime());
            redEnvelopeActivityInfoDto.setValidEndTime(redEnvelopeActivityDto.getValidEndTime());
            redEnvelopeActivityInfoDto.setInvokeProbability(redEnvelopeActivityDto.getInvokeProbability());
            redEnvelopeActivityInfoDto.setRule(redEnvelopeActivityDto.getRule());
            redEnvelopeActivityInfoDto.setRedEnvelopeRewards(redEnvelopeRewardDtoList);
            msg = "查看红包游戏成功";
            return super.encapsulateMsgBean(redEnvelopeActivityInfoDto, MsgBean.MsgCode.SUCCESS, msg);
        } catch (Exception e) {
            logger.error("查看红包游戏失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改抢红包游戏
     * 
     * @param redEnvelopeActivityFormDto
     *            抢红包活动Form表单信息DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateRedEnvelopeActivity")
    @ResponseBody
    public MsgBean updateRedEnvelopeActivity(@RequestBody RedEnvelopeActivityFormDto redEnvelopeActivityFormDto) {
        String msg = "";
        try {
            if (ObjectUtils.isNullOrEmpty(redEnvelopeActivityFormDto)) {
                msg = "无法获取需修改的抢红包活动Form表单信息DTO";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            Integer activityId = redEnvelopeActivityFormDto.getActivityId();
            if (ObjectUtils.isNullOrEmpty(activityId)) {
                msg = "无法获取需修改的抢红包活动ID";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            String validTimeIntersectionFlag = CommonConstants.STR_NO_FLAG;
            Date activityStartDate = redEnvelopeActivityFormDto.getValidStartTime();
            Date activityEndDate = redEnvelopeActivityFormDto.getValidEndTime();
            if (ObjectUtils.isNullOrEmpty(activityStartDate)) {
                msg = "开始有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            if (ObjectUtils.isNullOrEmpty(activityEndDate)) {
                msg = "结束有效时间不能为空！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            if (activityEndDate.before(activityStartDate)) {
                msg = "结束有效时间必须大于开始有效时间！";
                logger.error(msg);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
            }
            List<RedEnvelopeActivityDto> redEnvelopeActivityDtoList = redEnvelopeService.listRedEnvelopeActivities();
            if (!ObjectUtils.isNullOrEmpty(redEnvelopeActivityDtoList)) {
                RedEnvelopeActivityDto reaDto = redEnvelopeService.loadRedEnvelopeActivityById(activityId);
                for (RedEnvelopeActivityDto redEnvelopeActivityDto : redEnvelopeActivityDtoList) {
                    if (!ObjectUtils.isNullOrEmpty(reaDto)
                            && reaDto.getId().intValue() == redEnvelopeActivityDto.getId().intValue()) {
                        continue;
                    }
                    if ((activityEndDate.after(redEnvelopeActivityDto.getValidStartTime()) && activityStartDate
                            .before(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityStartDate.before(redEnvelopeActivityDto.getValidStartTime()) && activityEndDate
                                    .after(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityStartDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                            || (activityStartDate.equals(redEnvelopeActivityDto.getValidEndTime()))
                            || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))
                            || (activityEndDate.equals(redEnvelopeActivityDto.getValidStartTime()))) {
                        validTimeIntersectionFlag = CommonConstants.STR_YES_FLAG;
                        break;
                    }
                }
                if (CommonConstants.STR_YES_FLAG.equals(validTimeIntersectionFlag)) {
                    msg = "该有效期区间与之前设置的抢红包游戏有效期存在重叠，请重新选择有效期区间！";
                    logger.error(msg);
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
                }
            }
            Date currentDate = DateUtils.getCurrentDateTime();
            redEnvelopeActivityFormDto.setCreateTime(currentDate);
            redEnvelopeActivityFormDto.setCreateUserId(super.getUserId());
            redEnvelopeActivityFormDto.setModifyTime(currentDate);
            redEnvelopeActivityFormDto.setModifyUserId(super.getUserId());
            redEnvelopeService.updateWholeRedEnvelopeActivity(redEnvelopeActivityFormDto);
            msg = "修改抢红包游戏成功";
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, msg);
        } catch (Exception e) {
            logger.error("修改抢红包游戏失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
