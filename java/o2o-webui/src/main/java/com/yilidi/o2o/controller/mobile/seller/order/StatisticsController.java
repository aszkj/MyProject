package com.yilidi.o2o.controller.mobile.seller.order;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.seller.order.SettleDetailParam;
import com.yilidi.o2o.appparam.seller.order.SummerizeInfoParam;
import com.yilidi.o2o.appparam.seller.order.VipUserDetailParam;
import com.yilidi.o2o.appparam.seller.user.IndexStatParam;
import com.yilidi.o2o.appvo.seller.order.DataStatisticsHomePageVO;
import com.yilidi.o2o.appvo.seller.order.DataStatisticsOrderVO;
import com.yilidi.o2o.appvo.seller.order.DataStatisticsVO;
import com.yilidi.o2o.appvo.seller.order.StoreDataStatisticsVO;
import com.yilidi.o2o.appvo.seller.user.DataStatisticsVipVO;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SettleDetailDto;
import com.yilidi.o2o.order.service.dto.query.SettleDetailQueryDto;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.dto.VipUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.query.VipUserStatisticDetailQueryDto;

/**
 * @Description: TODO(统计Controller)
 * @author: chenlian
 * @date: 2016年6月1日 上午11:42:57
 */
@Controller("sellerStatisticsController")
@RequestMapping(value = "/interfaces/seller")
public class StatisticsController extends SellerBaseController {

    private static final String STR_ONE = "1";

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IOrderService orderService;

    /**
     * 获取合伙人首页统计信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/indexstat")
    @ResponseBody
    public ResultParamModel indexstat(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        IndexStatParam indexStatParam = super.getEntityParam(req, IndexStatParam.class);
        String dataTypeString = indexStatParam.getDataTypeString();
        StoreDataStatisticsVO storeDataStatisticsVO = new StoreDataStatisticsVO();
        if (STR_ONE.equals(String.valueOf(dataTypeString.charAt(0)))) {
            Date startCreateTime = DateUtils.getTodayStartDate();
            Date endCreateTime = DateUtils.getTodayEndDate();
            Long inviteCount = customerService.getInviteCount(super.getStoreId(), startCreateTime, endCreateTime);
            storeDataStatisticsVO.setInviteCount(null == inviteCount ? 0 : inviteCount.intValue());
        }
        if (STR_ONE.equals(String.valueOf(dataTypeString.charAt(1)))) {
            Integer forAcceptOrderCount = orderService.getForAcceptOrderCount(super.getStoreId());
            storeDataStatisticsVO.setForAcceptOrderCount(null == forAcceptOrderCount ? 0 : forAcceptOrderCount.intValue());
        }
        if (STR_ONE.equals(String.valueOf(dataTypeString.charAt(2)))) {
            Date beginDate = DateUtils.getTodayStartDate();
            Date endDate = DateUtils.getTodayEndDate();
            Long finishOrderAmount = orderService.getFinishOrderAmount(super.getStoreId(), beginDate, endDate);
            storeDataStatisticsVO.setFinishOrderAmount(null == finishOrderAmount ? 0L : finishOrderAmount.longValue());
        }
        if (STR_ONE.equals(String.valueOf(dataTypeString.charAt(3)))) {
            Date startCreateTime = DateUtils.getTodayStartDate();
            Date endCreateTime = DateUtils.getTodayEndDate();
            Long vipUserCount = customerService.getVipUserCount(super.getStoreId(), startCreateTime, endCreateTime);
            storeDataStatisticsVO.setVipUserCount(null == vipUserCount ? 0 : vipUserCount.intValue());
        }
        return super.encapsulateParam(storeDataStatisticsVO, AppMsgBean.MsgCode.SUCCESS, "获取合伙人首页统计信息成功");
    }

    /**
     * 获取统计汇总信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     * @throws OrderServiceException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/summerizeinfo")
    @ResponseBody
    public ResultParamModel summerizeInfo(HttpServletRequest req, HttpServletResponse resp) throws OrderServiceException,
            ParseException {
        SummerizeInfoParam summerizeInfoParam = super.getEntityParam(req, SummerizeInfoParam.class);
        Integer finishOrderCount = orderService.getFinishOrderCountByTimes(super.getStoreId(),
                DateUtils.getSpecificStartDate(DateUtils.parseDate(summerizeInfoParam.getBeginTime(),
                        CommonConstants.DATE_FORMAT_DAY)), DateUtils.getSpecificEndDate(DateUtils.parseDate(
                        summerizeInfoParam.getEndTime(), CommonConstants.DATE_FORMAT_DAY)));
        Long orderSettleAmount = orderService.getTotalCommissionAmountByTimes(super.getStoreId(),
                DateUtils.getSpecificStartDate(DateUtils.parseDate(summerizeInfoParam.getBeginTime(),
                        CommonConstants.DATE_FORMAT_DAY)), DateUtils.getSpecificEndDate(DateUtils.parseDate(
                        summerizeInfoParam.getEndTime(), CommonConstants.DATE_FORMAT_DAY)));
        Integer vipUserCount = customerService.getVipUserCountByTimes(super.getStoreId(),
                DateUtils.getSpecificStartDate(DateUtils.parseDate(summerizeInfoParam.getBeginTime(),
                        CommonConstants.DATE_FORMAT_DAY)), DateUtils.getSpecificEndDate(DateUtils.parseDate(
                        summerizeInfoParam.getEndTime(), CommonConstants.DATE_FORMAT_DAY)));
        DataStatisticsVO dataStatisticsVO = new DataStatisticsVO();
        dataStatisticsVO.setVipUserCount(null == vipUserCount ? 0 : vipUserCount);
        dataStatisticsVO.setFinishOrderCount(null == finishOrderCount ? 0 : finishOrderCount);
        dataStatisticsVO.setOrderSettleAmount(null == orderSettleAmount ? 0L : orderSettleAmount);
        return super.encapsulateParam(dataStatisticsVO, AppMsgBean.MsgCode.SUCCESS, "获取统计汇总信息成功");
    }

    /**
     * 获取铂金会员统计详细信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/vipuserdetail")
    @ResponseBody
    public ResultParamModel vipUserDetail(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        VipUserDetailParam vipUserDetailParam = super.getEntityParam(req, VipUserDetailParam.class);
        VipUserStatisticDetailQueryDto vipUserStatisticDetailQueryDto = new VipUserStatisticDetailQueryDto();
        vipUserStatisticDetailQueryDto.setStoreId(super.getStoreId());
        vipUserStatisticDetailQueryDto.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_ON);
        vipUserStatisticDetailQueryDto.setBuyerLevelCode(SystemContext.UserDomain.BUYERLEVEL_B);
        vipUserStatisticDetailQueryDto.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.parseDate(
                vipUserDetailParam.getBeginTime(), CommonConstants.DATE_FORMAT_DAY)));
        vipUserStatisticDetailQueryDto.setEndTime(DateUtils.getSpecificEndDate(DateUtils.parseDate(
                vipUserDetailParam.getEndTime(), CommonConstants.DATE_FORMAT_DAY)));
        vipUserStatisticDetailQueryDto.setStart(vipUserDetailParam.getPageNum());
        vipUserStatisticDetailQueryDto.setPageSize(vipUserDetailParam.getPageSize());
        YiLiDiPage<VipUserStatisticInfoDto> vipUserStatisticDtoPageInfos = customerService
                .findVipUserStatisticInfos(vipUserStatisticDetailQueryDto);
        List<VipUserStatisticInfoDto> vipUserStatisticDtoList = vipUserStatisticDtoPageInfos.getResultList();
        List<DataStatisticsVipVO> dataStatisticsVipVOList = new ArrayList<DataStatisticsVipVO>();
        if (!ObjectUtils.isNullOrEmpty(vipUserStatisticDtoList)) {
            for (VipUserStatisticInfoDto vipUserStatisticInfoDto : vipUserStatisticDtoList) {
                DataStatisticsVipVO dataStatisticsVipVO = new DataStatisticsVipVO();
                ObjectUtils.fastCopy(vipUserStatisticInfoDto, dataStatisticsVipVO);
                dataStatisticsVipVOList.add(dataStatisticsVipVO);
            }
        }
        return super.encapsulatePageParam(vipUserStatisticDtoPageInfos, dataStatisticsVipVOList, AppMsgBean.MsgCode.SUCCESS,
                "获取铂金会员统计详细信息成功");
    }

    /**
     * 获取订单结算统计详细信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/settledetail")
    @ResponseBody
    public ResultParamModel settleDetail(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        SettleDetailParam settleDetailParam = super.getEntityParam(req, SettleDetailParam.class);
        SettleDetailQueryDto settleDetailQueryDto = new SettleDetailQueryDto();
        settleDetailQueryDto.setStoreId(super.getStoreId());
        settleDetailQueryDto.setStatusCode(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
        settleDetailQueryDto.setBeginTime(DateUtils.getSpecificStartDate(DateUtils.parseDate(
                settleDetailParam.getBeginTime(), CommonConstants.DATE_FORMAT_DAY)));
        settleDetailQueryDto.setEndTime(DateUtils.getSpecificEndDate(DateUtils.parseDate(settleDetailParam.getEndTime(),
                CommonConstants.DATE_FORMAT_DAY)));
        settleDetailQueryDto.setStart(settleDetailParam.getPageNum());
        settleDetailQueryDto.setPageSize(settleDetailParam.getPageSize());
        YiLiDiPage<SettleDetailDto> settleDetailDtoPageInfos = orderService.findSettleDetails(settleDetailQueryDto);
        List<SettleDetailDto> settleDetailDtoList = settleDetailDtoPageInfos.getResultList();
        List<DataStatisticsOrderVO> dataStatisticsOrderVOList = new ArrayList<DataStatisticsOrderVO>();
        if (!ObjectUtils.isNullOrEmpty(settleDetailDtoList)) {
            for (SettleDetailDto settleDetailDto : settleDetailDtoList) {
                DataStatisticsOrderVO dataStatisticsOrderVO = new DataStatisticsOrderVO();
                ObjectUtils.fastCopy(settleDetailDto, dataStatisticsOrderVO);
                dataStatisticsOrderVOList.add(dataStatisticsOrderVO);
            }
        }
        return super.encapsulatePageParam(settleDetailDtoPageInfos, dataStatisticsOrderVOList, AppMsgBean.MsgCode.SUCCESS,
                "获取订单结算统计详细信息成功");
    }

    /**
     * 获取合伙人邀请会员数量信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/invitecount")
    @ResponseBody
    public ResultParamModel invitecount(HttpServletRequest req, HttpServletResponse resp) {
        StoreDataStatisticsVO storeDataStatisticsVO = new StoreDataStatisticsVO();
        Long inviteCount = customerService.getInviteCount(super.getStoreId(), null, null);
        storeDataStatisticsVO.setInviteCount(null == inviteCount ? 0 : inviteCount.intValue());
        Long vipUserCount = customerService.getVipUserCount(super.getStoreId(), null, null);
        storeDataStatisticsVO.setVipUserCount(null == vipUserCount ? 0 : vipUserCount.intValue());
        return super.encapsulateParam(storeDataStatisticsVO, AppMsgBean.MsgCode.SUCCESS, "获取合伙人邀请会员数量信息成功");
    }

    /**
     * 合伙人相关数据统计
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     * @throws ParseException
     */
    @SellerLoginValidation
    @RequestMapping(value = "/statistic/summerizetotal")
    @ResponseBody
    public ResultParamModel summerizetotal(HttpServletRequest req, HttpServletResponse resp) throws ParseException {
        DataStatisticsHomePageVO dataStatisticsHomePageVO = new DataStatisticsHomePageVO();
        Date beginDate = DateUtils.getTodayStartDate();
        Date endDate = DateUtils.getTodayEndDate();
        Integer finishOrderCount = orderService.getFinishOrderCountByTimes(super.getStoreId(), beginDate, endDate);
        dataStatisticsHomePageVO.setOrderTotalCountToday(null == finishOrderCount ? 0 : finishOrderCount.intValue());
        Long finishOrderAmount = orderService.getFinishOrderAmount(super.getStoreId(), beginDate, endDate);
        dataStatisticsHomePageVO.setOrderTotalAmtToday(null == finishOrderAmount ? 0L : finishOrderAmount.longValue());
        Integer shouldSettleOrderCount = orderService.getTotalCommissionCountByTimes(super.getStoreId(), null, null);
        dataStatisticsHomePageVO.setShouldSettleOrderCount(null == shouldSettleOrderCount ? 0 : shouldSettleOrderCount
                .intValue());
        Long shouldSettleOrderAmt = orderService.getTotalCommissionAmountByTimes(super.getStoreId(), null, null);
        dataStatisticsHomePageVO.setShouldSettleOrderAmt(null == shouldSettleOrderAmt ? 0L : shouldSettleOrderAmt
                .longValue());
        dataStatisticsHomePageVO.setSettledOrderCount(0);
        dataStatisticsHomePageVO.setSettledOrderAmt(0L);
        dataStatisticsHomePageVO.setInviteVIPCountToday(0);
        dataStatisticsHomePageVO.setInviteVIPAmtToday(0L);
        dataStatisticsHomePageVO.setShouldSettleInviteCount(0);
        dataStatisticsHomePageVO.setShouldSettleInviteAmt(0L);
        dataStatisticsHomePageVO.setSettledInviteCount(0);
        dataStatisticsHomePageVO.setSettledInviteAmt(0L);
        return super.encapsulateParam(dataStatisticsHomePageVO, AppMsgBean.MsgCode.SUCCESS, "获取合伙人相关数据统计信息成功");
    }

}
