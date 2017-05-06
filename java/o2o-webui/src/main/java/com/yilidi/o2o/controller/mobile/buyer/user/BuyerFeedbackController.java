package com.yilidi.o2o.controller.mobile.buyer.user;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.BuyerFeedbackParam;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;
import com.yilidi.o2o.user.service.IBuyerFeedbackService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.BuyerFeedbackDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * app买家反馈
 *
 * @author: zhangkun
 * @date: 2016年11月28日 下午5:13:59
 */
@Controller("userFeedbackController")
@RequestMapping(value = "/interfaces/buyer")
public class BuyerFeedbackController extends BuyerBaseController {
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IBuyerFeedbackService buyerFeedbackService;

    @Autowired
    private IUserService userService;

    /**
     * app提交用户反馈方法
     * 
     * @param userId
     * @param userMobile
     * @param content
     * @return
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/user/saveBuyerFeedback")
    @ResponseBody
    public ResultParamModel saveFeedback(HttpServletRequest req, HttpServletResponse res) {
        BuyerFeedbackParam bfp = super.getEntityParam(req, BuyerFeedbackParam.class);
        UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        if (ObjectUtils.isNullOrEmpty(userSession) || userSession.getUserId() == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "session失效");
        }
        UserDto userDto = userService.loadUserById(userSession.getUserId());
        if (ObjectUtils.isNullOrEmpty(userDto)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "未获取到用户信息");
        }
        // 封装参数
        BuyerFeedbackDto feedbackParam = new BuyerFeedbackDto();
        feedbackParam.setUserId(userDto.getId());
        feedbackParam.setUserMobile(userDto.getPhone());
        feedbackParam.setContent(bfp.getContent());
        feedbackParam.setOperateStatus(SystemContext.UserDomain.FEEDBACKSTATIS_NODISPOSE);
        feedbackParam.setSubmitTime(new Date());
        // 请求接口
        buyerFeedbackService.saveBuyerFeedback(feedbackParam);
        logger.info("app提交用户反馈成功");
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "提交成功");
    }

}
