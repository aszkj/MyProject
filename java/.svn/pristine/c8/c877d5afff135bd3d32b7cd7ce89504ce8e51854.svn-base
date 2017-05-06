package com.yilidi.o2o.controller.mobile.buyer.order;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.order.UserTicketListParam;
import com.yilidi.o2o.appvo.buyer.order.UserTicketListVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * 用户优惠券请求处理类
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerUserCouponController")
@RequestMapping(value = "/interfaces/buyer")
public class UserTicketController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    /** 优惠券 **/
    private static final int TICKETTYPE_COUPON = 1;
    /** 优惠券名称 **/
    private static final String TICKETTYPENAME_COUPON = "优惠券";
    /** 抵用券 **/
    private static final int TICKETTYPE_VOUCHER = 2;
    /** 抵用券名称 **/
    private static final String TICKETTYPENAME_VOUCHER = "抵用券";
    /** 实物券 **/
    private static final int TICKETTYPE_PHYSICALBOND = 3;
    /** 实物券名称 **/
    private static final String TICKETTYPENAME_PHYSICALBOND = "实物券";
    /** 无效 **/
    private static final int TICKETSTATUS_INVALID = 0;
    /** 有效 **/
    private static final int TICKETSTATUS_VALID = 1;
    /** 抵用券使用范围描述 **/
    private static final String TICKETDUSERCOPE_VOUCHER = "使用限制";

    @Autowired
    private ICouponService couponService;

    @Autowired
    private IVoucherService voucherService;

    /**
     * 重置密码
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/activity/userticketinfo")
    @BuyerLoginValidation
    @ResponseBody
    public ResultParamModel userCouponList(HttpServletRequest req, HttpServletResponse resp) {
        UserTicketListParam userTicketListParam = super.getEntityParam(req, UserTicketListParam.class);
        Integer ticketType = userTicketListParam.getTicketType();
        Integer ticketStatus = userTicketListParam.getTicketStatus();
        Integer pageNum = userTicketListParam.getPageNum();
        Integer pageSize = userTicketListParam.getPageSize();
        if (null == ticketStatus) {
            ticketStatus = TICKETSTATUS_VALID;
        }
        Date nowTime = new Date();
        if (ticketType.intValue() == TICKETTYPE_COUPON) {
            return getUserCouponList(ticketStatus, pageNum, pageSize, nowTime);
        } else if (ticketType.intValue() == TICKETTYPE_VOUCHER) {
            return getUserVoucherList(ticketStatus, pageNum, pageSize, nowTime);
        } else if (ticketType.intValue() == TICKETTYPE_PHYSICALBOND) {
            return getUserPhysicalBondList(ticketStatus, pageNum, pageSize, nowTime);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "获取列表成功");
    }

    private ResultParamModel getUserCouponList(Integer ticketStatus, Integer pageNo, Integer pageSize, Date currentTime) {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        YiLiDiPage<UserCouponInfoDto> page = couponService.findUserCouponsByRealTimeStatus(userSessionModel.getUserId(),
                currentTime, ticketStatus, pageNo, pageSize);
        List<UserCouponInfoDto> userCouponInfoDtoList = page.getResultList();
        List<UserTicketListVO> userTicketListVOs = new ArrayList<UserTicketListVO>();
        if (!ObjectUtils.isNullOrEmpty(userCouponInfoDtoList)) {
            for (UserCouponInfoDto userCouponInfoDto : userCouponInfoDtoList) {
                UserTicketListVO userTicketListVO = new UserTicketListVO();
                userTicketListVO.setTicketId(userCouponInfoDto.getConId());
                userTicketListVO.setTicketType(TICKETTYPE_COUPON);
                userTicketListVO.setTicketTypeName(TICKETTYPENAME_COUPON);
                userTicketListVO.setBeginTime(userCouponInfoDto.getBeginTime());
                userTicketListVO.setEndTime(userCouponInfoDto.getEndTime());
                userTicketListVO.setTicketAmount(userCouponInfoDto.getAmount());
                userTicketListVO.setLimitedAmount(userCouponInfoDto.getUseCondition());
                userTicketListVO.setUseScope(systemBasicDataInfoUtils.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), userCouponInfoDto.getUseRangeCode()));
                userTicketListVO.setTicketDescription(userCouponInfoDto.getRule());
                int status = 0;
                String statusCode = null;
                if (userCouponInfoDto.getBeginTime().after(currentTime)) {
                    status = TICKETSTATUS_VALID;
                    statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED;
                } else if (!userCouponInfoDto.getBeginTime().after(currentTime)
                        && !userCouponInfoDto.getEndTime().before(currentTime)) {
                    if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfoDto.getStatus())) {
                        status = TICKETSTATUS_INVALID;
                        statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USED;
                    } else {
                        status = TICKETSTATUS_VALID;
                        statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE;
                    }
                } else {
                    status = TICKETSTATUS_INVALID;
                    if (SystemContext.OrderDomain.USERCOUPONSSTATUS_USED.equals(userCouponInfoDto.getStatus())) {
                        statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_USED;
                    } else {
                        statusCode = SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED;
                    }
                }
                userTicketListVO.setTicketStatus(status);
                userTicketListVO.setTicketStatusName(systemBasicDataInfoUtils
                        .getSystemDictName(SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), statusCode));
                userTicketListVOs.add(userTicketListVO);
            }
        }
        return super.encapsulatePageParam(page, userTicketListVOs, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private ResultParamModel getUserVoucherList(Integer ticketStatus, Integer pageNo, Integer pageSize, Date nowTime) {
        UserSessionModel userSessionModel = SessionUtils.getBuyerUserSession();
        YiLiDiPage<UserVoucherInfoDto> page = voucherService.findUserVouchersByRealTimeStatus(userSessionModel.getUserId(),
                nowTime, ticketStatus, pageNo, pageSize);
        List<UserVoucherInfoDto> userVoucherInfoDtoList = page.getResultList();
        List<UserTicketListVO> userTicketListVOs = new ArrayList<UserTicketListVO>();
        if (!ObjectUtils.isNullOrEmpty(userVoucherInfoDtoList)) {
            for (UserVoucherInfoDto userVoucherInfoDto : userVoucherInfoDtoList) {
                UserTicketListVO userTicketListVO = new UserTicketListVO();
                userTicketListVO.setTicketId(userVoucherInfoDto.getVouId());
                userTicketListVO.setTicketType(TICKETTYPE_VOUCHER);
                userTicketListVO.setTicketTypeName(TICKETTYPENAME_VOUCHER);
                userTicketListVO.setBeginTime(userVoucherInfoDto.getValidStartTime());
                userTicketListVO.setEndTime(userVoucherInfoDto.getValidEndTime());
                userTicketListVO.setTicketAmount(userVoucherInfoDto.getVouAmount());
                userTicketListVO.setLimitedAmount(userVoucherInfoDto.getOrderAmountLimit());
                userTicketListVO.setUseScope(TICKETDUSERCOPE_VOUCHER);
                userTicketListVO.setTicketDescription(userVoucherInfoDto.getRule());
                int status = 0;
                String statusCode = null;
                if (userVoucherInfoDto.getValidStartTime().after(nowTime)) {
                    status = TICKETSTATUS_VALID;
                    statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED;
                } else if (!userVoucherInfoDto.getValidStartTime().after(nowTime)
                        && !userVoucherInfoDto.getValidEndTime().before(nowTime)) {
                    if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfoDto.getStatus())) {
                        status = TICKETSTATUS_INVALID;
                        statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USED;
                    } else {
                        status = TICKETSTATUS_VALID;
                        statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE;
                    }
                } else {
                    status = TICKETSTATUS_INVALID;
                    if (SystemContext.OrderDomain.USERVOUCHERSTATUS_USED.equals(userVoucherInfoDto.getStatus())) {
                        statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_USED;
                    } else {
                        statusCode = SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED;
                    }
                }
                userTicketListVO.setTicketStatus(status);
                userTicketListVO.setTicketStatusName(systemBasicDataInfoUtils
                        .getSystemDictName(SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), statusCode));
                userTicketListVOs.add(userTicketListVO);
            }
        }
        return super.encapsulatePageParam(page, userTicketListVOs, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }

    private ResultParamModel getUserPhysicalBondList(Integer ticketStatus, Integer pageNo, Integer pageSize,
            Date currentTime) {
        YiLiDiPage page = new YiLiDiPage();
        page.setCurrentPage(pageNo);
        page.setPageCount(1);
        page.setPageSize(pageSize);
        page.setRecordCount(0);
        page.setResultList(new ArrayList());
        return super.encapsulatePageParam(page, null, AppMsgBean.MsgCode.SUCCESS, "执行成功");
    }
}
