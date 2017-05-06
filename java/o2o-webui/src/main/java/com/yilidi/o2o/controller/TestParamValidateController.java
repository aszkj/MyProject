package com.yilidi.o2o.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yilidi.o2o.controller.common.BaseController;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;
import com.yilidi.o2o.core.paramvalidate.ParamValidator;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 测试参数验证功能Controller
 * 
 * @author chenl
 * 
 */
@Controller
public class TestParamValidateController extends BaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @RequestMapping(value = "/testParamValidate", method = RequestMethod.GET)
    public void testParamValidate(HttpServletRequest req, HttpServletResponse resp) throws UserServiceException {
        try {
            logger.info("----------------- testParamValidate --------------------");
            String errorMsg = "";
            ParamValidateMessageBean mb = null;
            UserDto userDto = new UserDto();
            userDto.setEmail("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
            userDto.setUserName(null);
            userDto.setNote("bbbbbbbbbbbbbbb<script:cccccccccccccc");
            Param userName = new Param.Builder("用户名", Param.ParamType.STR_NORMAL.getType(), userDto.getUserName(), false)
                    .maxLength(128).build();
            Param email = new Param.Builder("用户邮箱", Param.ParamType.STR_EMAIL.getType(), userDto.getEmail(), false)
                    .maxLength(128).build();
            Param auditTime = new Param.Builder("审核时间", Param.ParamType.STR_DATE.getType(), "2015-03-24 12:05:28", true)
                    .maxLength(64).build();
            Param createTime = new Param.Builder("创建时间", Param.ParamType.STR_DATE.getType(), "2015-03-24 12:65:28", true)
                    .maxLength(64).build();
            Param createUserId = new Param.Builder("创建人", Param.ParamType.INTEGER_TYPE.getType(), "ddddddd", false)
                    .maxLength(16).build();
            Param note = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), userDto.getNote(), true).maxLength(
                    256).build();
            mb = ParamValidator.validate(email);
            if (null != mb && mb.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
                errorMsg = mb.getMsg();
                logger.warn("111111111111111 : " + errorMsg);
            }
            List<Param> paramList = new ArrayList<Param>();
            paramList.add(userName);
            paramList.add(email);
            paramList.add(auditTime);
            paramList.add(createTime);
            paramList.add(createUserId);
            paramList.add(note);
            mb = ParamValidator.validateForList(paramList);
            if (null != mb && mb.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
                errorMsg = mb.getMsg();
                logger.warn("222222222222222 : " + errorMsg);
            }
        } catch (Exception e) {
            logger.error("系统出现异常", e);
            throw new UserServiceException(e);
        }
    }

}
