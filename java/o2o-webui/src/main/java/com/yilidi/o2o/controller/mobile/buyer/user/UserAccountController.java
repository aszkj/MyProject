package com.yilidi.o2o.controller.mobile.buyer.user;

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

import com.yilidi.o2o.appvo.buyer.user.CommonAccountVO;
import com.yilidi.o2o.appvo.buyer.user.TicketAccountVO;
import com.yilidi.o2o.appvo.buyer.user.UserAccountVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * 用户账本
 * 
 * @author: chenb
 * @date: 2016年5月25日 上午11:37:38
 */
@Controller("buyerUserAccountController")
@RequestMapping(value = "/interfaces/buyer")
public class UserAccountController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    /**
     * 账本数值类型:rmb
     */
    private static final Integer ACCOUNTNUMTYPE_RMB = 1;
    /**
     * 账本数值类型:自然数
     */
    private static final Integer ACCOUNTNUMTYPE_NATURAL = 2;

    /** 奖券类型:优惠券 **/
    private static final Integer TICKETTYPE_COUPON = 1;
    /** 奖券类型:抵用券 **/
    private static final Integer TICKETTYPE_VOUCHER = 2;
    /** 奖券类型:实物券 **/
    private static final Integer TICKETTYPE_PHYSICALBOND = 3;

    @Autowired
    private ICouponService couponService;
    @Autowired
    private IVoucherService voucherService;

    /**
     * 3.59用户账本信息总汇接口
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/accountinfo")
    @ResponseBody
    public ResultParamModel resetPassword(HttpServletRequest req, HttpServletResponse resp) {
        UserAccountVO userAccountVO = new UserAccountVO();
        List<CommonAccountVO> commonAccountVOList = getCommonAccountVOList();
        userAccountVO.setAccountInfoList(commonAccountVOList);

        List<TicketAccountVO> voucherVOList = getTicketAccountVOList();
        userAccountVO.setTicketInfoList(voucherVOList);
        return super.encapsulateParam(userAccountVO, AppMsgBean.MsgCode.SUCCESS, "获取用户账本信息成功");
    }

    private List<CommonAccountVO> getCommonAccountVOList() {
        List<CommonAccountVO> commonAccountVOList = new ArrayList<CommonAccountVO>();
        CommonAccountVO balanceVO = new CommonAccountVO();
        balanceVO.setAccountName("账户余额");
        balanceVO.setAccountNum(0L);
        balanceVO.setAccountNumType(ACCOUNTNUMTYPE_RMB);
        commonAccountVOList.add(balanceVO);

        CommonAccountVO centiVO = new CommonAccountVO();
        centiVO.setAccountName("我的厘米");
        centiVO.setAccountNum(0L);
        centiVO.setAccountNumType(ACCOUNTNUMTYPE_NATURAL);
        commonAccountVOList.add(centiVO);

        return commonAccountVOList;
    }

    private List<TicketAccountVO> getTicketAccountVOList() {
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        Date currentTime = new Date();
        Integer couponCount = couponService.getValidUserCouponCountByUserId(userSession.getUserId(), currentTime);
        Integer voucherCount = voucherService.getValidUserVoucherCountByUserId(userSession.getUserId(), currentTime);
        List<TicketAccountVO> ticketAccountVOList = new ArrayList<TicketAccountVO>();
        TicketAccountVO couponVO = new TicketAccountVO();
        couponVO.setTicketTypeName("优惠券");
        couponVO.setTicketType(TICKETTYPE_COUPON);
        couponVO.setTicketCount(couponCount);
        ticketAccountVOList.add(couponVO);

        TicketAccountVO voucherVO = new TicketAccountVO();
        voucherVO.setTicketTypeName("抵用券");
        voucherVO.setTicketType(TICKETTYPE_VOUCHER);
        voucherVO.setTicketCount(voucherCount);
        ticketAccountVOList.add(voucherVO);

        TicketAccountVO physicalBondVO = new TicketAccountVO();
        physicalBondVO.setTicketTypeName("实物券");
        physicalBondVO.setTicketType(TICKETTYPE_PHYSICALBOND);
        physicalBondVO.setTicketCount(0);
        ticketAccountVOList.add(physicalBondVO);

        return ticketAccountVOList;
    }
}
