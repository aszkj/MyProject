package com.yilidi.o2o.controller.mobile.seller.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.yilidi.o2o.appparam.seller.user.InvitationUserParam;
import com.yilidi.o2o.appparam.seller.user.ResetPasswordParam;
import com.yilidi.o2o.appparam.seller.user.UpdatePasswordParam;
import com.yilidi.o2o.appvo.seller.user.InvitationUserVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.sessionmodel.seller.user.SellerSessionModel;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.InvitationUserDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserQueryDto;

/**
 * @Description: TODO(用户信息Controller)
 * @author: chenlian
 * @date: 2016年6月1日 上午11:21:52
 */
@Controller("sellerUserController")
@RequestMapping(value = "/interfaces/seller")
public class UserController extends SellerBaseController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IMessageService messageService;

    @Autowired
    private ICustomerService customerService;

    /**
     * 重置密码
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/resetpassword")
    @ResponseBody
    public ResultParamModel resetPassword(HttpServletRequest req, HttpServletResponse resp) {
        ResetPasswordParam resetPasswordParam = super.getEntityParam(req, ResetPasswordParam.class);
        String mobile = SessionUtils.getSellerCaptchaCheckSession(String
                .valueOf(WebConstants.SELLER_CAPTCHA_TYPE_FORGET_PASSWORD));
        if (StringUtils.isEmpty(mobile)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "验证身份未通过或验证码超时,请重新验证");
        }
        UserDto userDto = userService.loadUserByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
        if (null == userDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该手机号还不是一里递社区会员");
        }
        userDto.setPassword(EncryptUtils.md5Crypt(resetPasswordParam.getPassword()).toLowerCase());
        userService.updateUserForPassword(userDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "重置密码成功");
    }

    /**
     * 修改密码
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/user/updatepassword")
    @ResponseBody
    public ResultParamModel updatePassword(HttpServletRequest req, HttpServletResponse resp) {
        UpdatePasswordParam updatePasswordParam = super.getEntityParam(req, UpdatePasswordParam.class);
        SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
        UserDto userDto = userService.loadUserByNameAndType(sellerSessionModel.getUserName(),
                SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
        if (userDto == null) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该帐户不存在");
        }
        if (!StringUtils.isEquals(EncryptUtils.md5Crypt(updatePasswordParam.getOldPassword()).toLowerCase(),
                userDto.getPassword())) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "原始密码输入错误，请重新输入");
        }
        userDto.setPassword(EncryptUtils.md5Crypt(updatePasswordParam.getPassword()).toLowerCase());
        userService.updateUserForPassword(userDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "修改密码成功");
    }

    /**
     * 获取邀请用户信息列表
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/user/inviteusers")
    @ResponseBody
    public ResultParamModel inviteusers(HttpServletRequest req, HttpServletResponse resp) {
        InvitationUserParam invitationUserParam = super.getEntityParam(req, InvitationUserParam.class);
        InvitedUserQueryDto invitedUserQueryDto = new InvitedUserQueryDto();
        invitedUserQueryDto.setStoreId(super.getStoreId());
        invitedUserQueryDto.setStatusCode(SystemContext.UserDomain.CUSTOMERSTATUS_ON);
        invitedUserQueryDto.setStart(invitationUserParam.getPageNum());
        invitedUserQueryDto.setPageSize(invitationUserParam.getPageSize());
        YiLiDiPage<InvitationUserDto> invitationUserDtoPageInfos = customerService.findInvitedUsers(invitedUserQueryDto);
        List<InvitationUserDto> invitationUserDtoList = invitationUserDtoPageInfos.getResultList();
        List<InvitationUserVO> invitationUserVOList = new ArrayList<InvitationUserVO>();
        if (!ObjectUtils.isNullOrEmpty(invitationUserDtoList)) {
            for (InvitationUserDto invitationUserDto : invitationUserDtoList) {
                InvitationUserVO invitationUserVO = new InvitationUserVO();
                ObjectUtils.fastCopy(invitationUserDto, invitationUserVO);
                invitationUserVOList.add(invitationUserVO);
            }
        }
        return super.encapsulatePageParam(invitationUserDtoPageInfos, invitationUserVOList, AppMsgBean.MsgCode.SUCCESS,
                "获取邀请用户信息列表成功");
    }
}
