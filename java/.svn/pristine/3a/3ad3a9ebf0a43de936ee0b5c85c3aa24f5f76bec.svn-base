package com.yilidi.o2o.controller.mobile.buyer.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.product.ActivitySecKillInfoParam;
import com.yilidi.o2o.appparam.buyer.product.SecKillInfoListParam;
import com.yilidi.o2o.appparam.buyer.product.SecKillProdutctsParam;
import com.yilidi.o2o.appvo.buyer.product.ActivitySecKillInfoVO;
import com.yilidi.o2o.appvo.buyer.product.SecKillInfoListVO;
import com.yilidi.o2o.appvo.buyer.product.SecKillProdutctsVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IActivityOrderCustomerRecService;
import com.yilidi.o2o.product.service.ISecKillProductService;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SecKillSaleProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * 秒杀活动接口
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerSecKillActivityController")
@RequestMapping(value = "/interfaces/buyer")
public class SecKillActivityController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    @Autowired
    private ISecKillProductService secKillProductService;
    @Autowired
    private ISecKillSceneService secKillSceneService;
    @Autowired
    private IActivityOrderCustomerRecService activityOrderCustomerRecService;

    /**
     * 根据秒杀活动ID查询活动商品列表接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/seckillproducts")
    @ResponseBody
    public ResultParamModel secKillProducts(HttpServletRequest req, HttpServletResponse resp) {
        SecKillProdutctsParam secKillProdutctsParam = super.getEntityParam(req, SecKillProdutctsParam.class);
        List<SecKillProdutctsVO> secKillProdutctsVOList = new ArrayList<SecKillProdutctsVO>();
        if (ObjectUtils.isNullOrEmpty(secKillProdutctsParam)) {
            return super.encapsulateParam(secKillProdutctsVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        List<SecKillSaleProductDto> secKillSaleProductDtoList = secKillProductService
                .listSecKillSaleProductByActivityIdAndStoreId(secKillProdutctsParam.getStoreId(),
                        secKillProdutctsParam.getActId());
        String deviceId = super.getDeviceId(req);
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        if (!ObjectUtils.isNullOrEmpty(secKillSaleProductDtoList)) {
            SecKillSceneDto secKillSceneDto = secKillSceneService.loadByActivityId(secKillProdutctsParam.getActId());
            Date nowTime = new Date();
            for (SecKillSaleProductDto secKillSaleProductDto : secKillSaleProductDtoList) {
                SecKillProdutctsVO secKillProdutctsVO = new SecKillProdutctsVO();
                secKillProdutctsVO.setSaleProductId(secKillSaleProductDto.getSaleProductId());
                secKillProdutctsVO.setBrandName(secKillSaleProductDto.getBrandName());
                secKillProdutctsVO.setSaleProductSpec(secKillSaleProductDto.getSaleProductSpec());
                secKillProdutctsVO.setSaleProductName(secKillSaleProductDto.getSaleProductName());
                secKillProdutctsVO
                        .setSaleProductImageUrl(StringUtils.toFullImageUrl(secKillSaleProductDto.getSaleProductImageUrl()));
                secKillProdutctsVO.setSeckillPrice(secKillSaleProductDto.getSecKillProductPrice());
                secKillProdutctsVO.setSeckillTotalCount(secKillSaleProductDto.getSecKillCount());
                secKillProdutctsVO.setSeckillShowTotalCount(secKillSaleProductDto.getRemainCount());
                secKillProdutctsVO.setActId(secKillProdutctsParam.getActId());
                secKillProdutctsVO.setProductId(secKillSaleProductDto.getProductId());
                int limitOrderCount = ArithUtils.converIntegerToInt(secKillSaleProductDto.getLimitOrderCount());
                int secKillOrderCount = ArithUtils.converIntegerToInt(secKillSaleProductDto.getSecKillCount());
                if (limitOrderCount > secKillOrderCount || 0 == limitOrderCount) {
                    limitOrderCount = secKillOrderCount;
                }
                int orderCount = ArithUtils.converIntegerToInt(
                        activityOrderCustomerRecService.loadSaleProductOrderCountByActivityIdAndSaleProductId(
                                secKillSceneDto.getActivityId(), secKillSaleProductDto.getSaleProductId()));
                int stockNum = secKillSaleProductDto.getSecKillCount() - orderCount;
                if (stockNum > ArithUtils.converIntegerToInt(secKillSaleProductDto.getSaleProductRemainCount())) {
                    stockNum = ArithUtils.converIntegerToInt(secKillSaleProductDto.getSaleProductRemainCount());
                }
                if (ArithUtils.converIntegerToInt(secKillSaleProductDto.getRemainCount()) <= 0
                        || ArithUtils.converIntegerToInt(secKillSaleProductDto.getSaleProductRemainCount()) <= 0) {
                    stockNum = 0;
                }
                long secKillTime = ArithUtils.converLongTolong(secKillSaleProductDto.getSecKillTime());
                if (secKillTime > 0 && !ObjectUtils.isNullOrEmpty(secKillSceneDto) && nowTime.after(DateUtils
                        .addSeconds(secKillSceneDto.getStartTime(), secKillSaleProductDto.getSecKillTime().intValue()))) {
                    stockNum = 0;
                }
                if (SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF
                        .equals(secKillSceneDto.getStatusCode())) {
                    stockNum = 0;
                }
                if (stockNum < 0) {
                    stockNum = 0;
                }
                if (orderCount >= secKillOrderCount) {
                    limitOrderCount = 0;
                }
                if (!ObjectUtils.isNullOrEmpty(userSessionModel)) {
                    Integer customerOrderCount = activityOrderCustomerRecService
                            .loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(userSessionModel.getCustomerId(),
                                    secKillProdutctsVO.getActId(), secKillSaleProductDto.getSaleProductId(), deviceId, null);
                    limitOrderCount = limitOrderCount - ArithUtils.converIntegerToInt(customerOrderCount);
                }
                if (limitOrderCount > secKillOrderCount - orderCount) {
                    limitOrderCount = secKillOrderCount - orderCount;
                }
                if (limitOrderCount <= 0) {
                    limitOrderCount = 0;
                }
                secKillProdutctsVO.setStockNum(stockNum);
                secKillProdutctsVO.setLimitCount(limitOrderCount);
                secKillProdutctsVOList.add(secKillProdutctsVO);
            }
        }
        return super.encapsulateParam(secKillProdutctsVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 查询首页正在活动的秒杀活动信息接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/activityseckillinfo")
    @ResponseBody
    public ResultParamModel activitySecKillInfo(HttpServletRequest req, HttpServletResponse resp) {
        ActivitySecKillInfoParam activitySecKillInfoParam = super.getEntityParam(req, ActivitySecKillInfoParam.class);
        List<ActivitySecKillInfoVO> activitySecKillInfoVOList = new ArrayList<ActivitySecKillInfoVO>();
        if (ObjectUtils.isNullOrEmpty(activitySecKillInfoParam)) {
            return super.encapsulateParam(activitySecKillInfoVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        ActivitySecKillInfoVO activitySecKillInfoVO = null;
        Date nowTime = new Date();
        SecKillSceneDto secKillSceneDto = secKillSceneService.loadSecKillSceneForStarting(nowTime);
        if (!ObjectUtils.isNullOrEmpty(secKillSceneDto)) {
            activitySecKillInfoVO = new ActivitySecKillInfoVO();
            activitySecKillInfoVO.setActId(secKillSceneDto.getActivityId());
            activitySecKillInfoVO.setActName(getActNameByStartTime(secKillSceneDto.getStartTime()));
            activitySecKillInfoVO.setBeginTime(secKillSceneDto.getStartTime());
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto.getEndTime())) {
                activitySecKillInfoVO
                        .setEndTime(DateUtils.addHours(secKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
            } else {
                activitySecKillInfoVO.setEndTime(secKillSceneDto.getEndTime());
            }
            activitySecKillInfoVO.setStatusName(systemBasicDataInfoUtils.getSystemDictName(
                    SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                    secKillSceneDto.getStatusCode()));
            activitySecKillInfoVO.setSystemTime(nowTime);
        }
        return super.encapsulateParam(activitySecKillInfoVO, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 查询秒杀活动信息列表接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/seckillinfolist")
    @ResponseBody
    public ResultParamModel activitySecKillInfoList(HttpServletRequest req, HttpServletResponse resp) {
        SecKillInfoListParam secKillInfoListParam = super.getEntityParam(req, SecKillInfoListParam.class);
        List<SecKillInfoListVO> secKillInfoListVOList = new ArrayList<SecKillInfoListVO>();
        if (ObjectUtils.isNullOrEmpty(secKillInfoListParam)) {
            return super.encapsulateParam(secKillInfoListVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
        }
        Date nowTime = new Date();
        List<SecKillSceneDto> secKillSceneDtos = secKillSceneService.listSecKillScene(nowTime, 4);
        if (!ObjectUtils.isNullOrEmpty(secKillSceneDtos)) {
            for (SecKillSceneDto secKillSceneDto : secKillSceneDtos) {
                SecKillInfoListVO secKillInfoListVO = new SecKillInfoListVO();
                secKillInfoListVO.setActId(secKillSceneDto.getActivityId());
                secKillInfoListVO.setActName(getActNameByStartTime(secKillSceneDto.getStartTime()));
                secKillInfoListVO.setBeginTime(secKillSceneDto.getStartTime());
                if (ObjectUtils.isNullOrEmpty(secKillSceneDto.getEndTime())) {
                    secKillInfoListVO.setEndTime(
                            DateUtils.addHours(secKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
                } else {
                    secKillInfoListVO.setEndTime(secKillSceneDto.getEndTime());
                }
                secKillInfoListVO.setStatusName(systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                        secKillSceneDto.getStatusCode()));
                secKillInfoListVO.setSystemTime(nowTime);
                secKillInfoListVOList.add(secKillInfoListVO);
            }
        }
        return super.encapsulateParam(secKillInfoListVOList, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 用户活动期内参与抢红包活动信息数据接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/userredenvelopinfo")
    @ResponseBody
    public ResultParamModel activityUserRedEnvelopInfo(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("residueTimes", 2);
        returnMap.put("receivedRedEnvelopCount", 2);
        Map<String, Object> redEnvelopMap = new HashMap<>();
        returnMap.put("redEnvelopActivityInfo", redEnvelopMap);
        redEnvelopMap.put("activityId", 1);
        redEnvelopMap.put("activityRule", "这是活动规则");
        redEnvelopMap.put("maxJoinTimes", 3);
        redEnvelopMap.put("maxTimePerTimes", 30);
        redEnvelopMap.put("interfaceInvokedProbability", 50);
        return super.encapsulateParam(returnMap, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    /**
     * 用户活动期内参与抢红包活动信息数据接口
     * 
     * @param req
     *            HttpServletRequest对象
     * @param resp
     *            HttpServletResponse对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/gradredenvelop")
    @ResponseBody
    public ResultParamModel grabRedEnvelop(HttpServletRequest req, HttpServletResponse resp) {
        Map<String, Object> returnMap = new HashMap<>();
        returnMap.put("couponId", 2);
        returnMap.put("couponCount", 2);
        returnMap.put("couponType", 1);
        returnMap.put("couponTypeName", "优惠券");
        returnMap.put("beginTime", "2016-10-21 09:09:09");
        returnMap.put("endTime", "2016-10-25 09:09:09");
        returnMap.put("couponAmount", 3000);
        returnMap.put("limitedAmount", 50000);
        returnMap.put("userCope", "全场");
        returnMap.put("couponDescription", "满50元使用，APP下单使用，在线支付专享");
        returnMap.put("couponStatus", 1);
        returnMap.put("couponStatusName", "可领取");
        return super.encapsulateParam(returnMap, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private int getSystemParamSecKillSceneEndTime() {
        String endTime = systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.SECKILLSCENE_ENDTIME);
        if (ObjectUtils.isNullOrEmpty(endTime)) {
            return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
        }
        try {
            return Integer.parseInt(endTime.trim());
        } catch (Exception e) {
            logger.warn(e);
        }
        return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
    }

    private String getActNameByStartTime(Date startTime) {
        if (ObjectUtils.isNullOrEmpty(startTime)) {
            return "";
        }
        return DateUtils.formatDate(startTime, CommonConstants.DATE_FORMAT_HOURANDSECOND) + "场";
    }
}
