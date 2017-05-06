package com.yilidi.o2o.controller.mobile.buyer.system;

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

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appvo.buyer.system.UserMessageListVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.ISiteMessagePublishedService;
import com.yilidi.o2o.system.service.dto.SiteMessagePublishedDto;
import com.yilidi.o2o.system.service.dto.query.SiteMessagePublishedQuery;

/**
 * 消息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
@Controller("buyerMessagetController")
@RequestMapping(value = "/interfaces/buyer")
public class MessagePublishedController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    // 消息类型正则表达式
    private static final String MESSAGE_TYPE_PATTERN = "^(0|1)$";

    @Autowired
    private ISiteMessagePublishedService siteMessagePublishedService;

    /**
     * 
     * 获取轮播广告
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    // @BuyerLoginValidation
    @RequestMapping(value = "/user/messagelist")
    @ResponseBody
    public ResultParamModel getImageRotate(HttpServletRequest req, HttpServletResponse resp) {
        AppParamModel param = super.getParameter(req);
        JSONObject entity = param.getEntity();
        /**
         * 消息类型 0-系统消息 ,1-用户消息
         */
        String messageType = entity.getString("messageType");
        Integer pageNum = entity.getInteger("pageNum");
        Integer pageSize = entity.getInteger("pageSize");

        Param messageTypeValidate = new Param.Builder("广告类型", Param.ParamType.STR_INTEGER.getType(), messageType, false)
                .regex(MESSAGE_TYPE_PATTERN).build();
        super.validateParams(messageTypeValidate);

        // UserSessionModel userSession = SessionUtils.getBuyerUserSession();
        // Integer receiveId = userSession.getUserId();
        int receiveId = 4;

        SiteMessagePublishedQuery siteMessagePublishedQuery = new SiteMessagePublishedQuery();
        // TODO 参数messageType转系统字典值
        siteMessagePublishedQuery.setMessageType(messageType);
        siteMessagePublishedQuery.setStart(pageNum);
        siteMessagePublishedQuery.setPageSize(pageSize);
        siteMessagePublishedQuery.setReceiveId(receiveId);

        YiLiDiPage<SiteMessagePublishedDto> page = siteMessagePublishedService
                .listSiteMessagePublishedRelationInfo(siteMessagePublishedQuery);
        List<SiteMessagePublishedDto> siteMessageDtoList = page.getResultList();
        List<UserMessageListVO> userMessageVoList = new ArrayList<UserMessageListVO>();
        if (!ObjectUtils.isNullOrEmpty(siteMessageDtoList)) {
            for (int i = 0, size = siteMessageDtoList.size(); i < size; i++) {
                SiteMessagePublishedDto siteMessageDto = siteMessageDtoList.get(i);
                UserMessageListVO userMessageVO = new UserMessageListVO();
                userMessageVO.setSiteMessageId(siteMessageDto.getSiteMessageId());
                userMessageVO.setMessageType(siteMessageDto.getMessageType());
                // TODO 对应messageType
                userMessageVO.setMessageName("用户消息");
                userMessageVO.setStatusCode(1);
                userMessageVO.setSubject(siteMessageDto.getSubject());
                userMessageVO.setContent(siteMessageDto.getContent());
                String createTime = "";
                if (null != siteMessageDto.getCreateTime()) {
                    createTime = DateUtils.formatDate(new Date(), CommonConstants.DATE_FORMAT_CURRENTTIME);
                }
                userMessageVO.setCreateTime(createTime);
                userMessageVoList.add(userMessageVO);
            }
        }
        return super.encapsulatePageParam(page, userMessageVoList, AppMsgBean.MsgCode.SUCCESS, "查询消息列表接口成功");
    }
}
