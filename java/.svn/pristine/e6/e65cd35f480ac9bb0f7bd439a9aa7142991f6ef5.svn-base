package com.yilidi.o2o.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appvo.buyer.user.LoginVO;
import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * 
 * @Description:TODO(测试APP调用接口)
 * @author: chenlian
 * @date: 2015年10月27日 下午6:13:16
 * 
 */
@Controller
@RequestMapping(value = "/interfaces/buyer")
public class TestAppController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserService userService;

    /**
     * 
     * @Description TODO(显示用户信息)
     * @param req
     * @param resp
     * @return ResultParamModel
     */
    @BuyerLoginValidation
    @RequestMapping(value = "/showUserForApp")
    @ResponseBody
    public ResultParamModel showUserForApp(HttpServletRequest req, HttpServletResponse resp) {
        AppParamModel param = super.getParameter(req);
        JSONObject entity = param.getEntity();
        // 获取参数值方式一：通过jsonObject的get方式
        Integer id = entity.getInteger("id");
        String userName = entity.getString("userName");
        logger.info("=-=-=-=-=-=-=-=-=-=-=id : " + id);
        logger.info("=-=-=-=-=-=-=-=-=-=-=userName : " + userName);
        Param idParam = new Param.Builder("用户ID", Param.ParamType.INTEGER_TYPE.getType(), id, false).build();
        Param userNameParam = new Param.Builder("用户名", Param.ParamType.STR_NORMAL.getType(), userName, false).build();
        super.validateParams(idParam, userNameParam);
        // 获取参数值方式二：将参数封装成DTO的方式
        //UserDto userDto = super.getEntityObject(req, UserDto.class);
        //logger.info("============+++++userDto : " + JsonUtils.toJsonStringWithDateFormat(userDto));
        //logger.info("============+++++id : " + userDto.getId());
        //logger.info("============+++++userName : " + userDto.getUserName());
        // UserDto uDto = userService.viewUserDetail(id);
        // if (null == uDto) {
        // return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "用户不存在");
        // }
        UserQuery query = new UserQuery();
        YiLiDiPage<UserDto> userDtoPageInfos = userService.findBuyerUsers(query);
        List<UserDto> userDtoList = userDtoPageInfos.getResultList();
        logger.info("============+++++userDtoPageInfos : " + JsonUtils.toJsonStringWithDateFormat(userDtoPageInfos));
        logger.info("============+++++userDtoList : " + JsonUtils.toJsonStringWithDateFormat(userDtoList));
        List<LoginVO> loginVOList = new ArrayList<LoginVO>();
        if (!ObjectUtils.isNullOrEmpty(userDtoList)) {
            for (UserDto uDto : userDtoList) {
                LoginVO loginVO = new LoginVO();
                loginVO.setUserId(uDto.getId());
                loginVO.setUserName(uDto.getUserName());
                loginVOList.add(loginVO);
            }
        }
        return super.encapsulatePageParam(userDtoPageInfos, loginVOList, AppMsgBean.MsgCode.SUCCESS, "查询用户信息成功");
    }

}
