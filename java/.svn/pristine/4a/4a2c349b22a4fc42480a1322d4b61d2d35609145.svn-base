package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.connect.qq.api.QQUserInfoApi;
import com.yilidi.o2o.core.connect.qq.javabean.QQUserInfo;
import com.yilidi.o2o.core.connect.wechat.api.AccessTokenApi;
import com.yilidi.o2o.core.connect.wechat.api.WechatUserApi;
import com.yilidi.o2o.core.connect.wechat.javabean.AccessToken;
import com.yilidi.o2o.core.connect.wechat.javabean.WechatUserInfo;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.ConnectUserMapper;
import com.yilidi.o2o.user.model.ConnectUser;
import com.yilidi.o2o.user.service.IConnectUserService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IUserProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

/**
 * 功能描述：用户Service服务实现类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("connectUserService")
public class ConnectUserServiceImpl extends BasicDataService implements IConnectUserService {
    private static final String USER_PIC_RELATIVE_PATH_DEFAULT = "/pic/user";

    @Autowired
    private ConnectUserMapper connectUserMapper;
    @Autowired
    private IUserService userService;
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IUserProfileService userProfileService;

    @Override
    public ConnectUserDto loadByOpenId(String openId) throws UserServiceException {
        try {
            ConnectUserDto connectUserDto = null;
            if (ObjectUtils.isNullOrEmpty(openId)) {
                return connectUserDto;
            }
            ConnectUser connectUser = connectUserMapper.loadByOpenId(openId);
            if (!ObjectUtils.isNullOrEmpty(connectUser)) {
                connectUserDto = new ConnectUserDto();
                ObjectUtils.fastCopy(connectUser, connectUserDto);
            }
            return connectUserDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ConnectUserDto loadByUserIdAndConnectType(Integer userId, String connectType) throws UserServiceException {
        try {
            ConnectUserDto connectUserDto = null;
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new UserServiceException("param[userId] can not be null");
            }
            if (ObjectUtils.isNullOrEmpty(connectType)) {
                throw new UserServiceException("param[connectType] can not be null");
            }
            ConnectUser connectUser = connectUserMapper.loadByUserIdAndConnectType(userId, connectType);
            if (!ObjectUtils.isNullOrEmpty(connectUser)) {
                connectUserDto = new ConnectUserDto();
                ObjectUtils.fastCopy(connectUser, connectUserDto);
            }
            return connectUserDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void save(ConnectUserDto connectUserDto) throws UserServiceException {
        try {
            validConnectUser(connectUserDto);
            ConnectUser connectUser = new ConnectUser();
            ObjectUtils.fastCopy(connectUserDto, connectUser);
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(connectUser.getCreateTime())) {
                connectUser.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(connectUser.getModifyTime())) {
                connectUser.setModifyTime(nowTime);
            }
            connectUserMapper.save(connectUser);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void updateBindUserIdByOpenId(String openId, Integer userId) throws UserServiceException {
        try {
            if (StringUtils.isEmpty(openId)) {
                throw new UserServiceException("param[openId] can not be null");
            }
            Date modifyTime = new Date();
            connectUserMapper.updateBindUserIdByOpenId(openId, userId, modifyTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void updateBindUserIdByUnionId(String unionId, Integer userId) throws UserServiceException {
        try {
            if (StringUtils.isEmpty(unionId)) {
                throw new UserServiceException("param[unionId] can not be null");
            }
            Date modifyTime = new Date();
            connectUserMapper.updateBindUserIdByUnionId(unionId, userId, modifyTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    private void validConnectUser(ConnectUserDto connectUserDto) {
        if (ObjectUtils.isNullOrEmpty(connectUserDto)) {
            throw new UserServiceException("参数不能为空");
        }
        if (ObjectUtils.isNullOrEmpty(connectUserDto.getOpenId())) {
            throw new UserServiceException("必填参数不能为空");
        }
    }

    @Override
    public Integer saveBindUserInfo(String openId, String mobile, String password, String channelCode)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(openId)) {
                throw new UserServiceException("openId cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(mobile)) {
                throw new UserServiceException("mobile cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(password)) {
                throw new UserServiceException("password cant not be null");
            }
            ConnectUserDto connectUserDto = loadByOpenId(openId);
            if (ObjectUtils.isNullOrEmpty(connectUserDto)) {
                throw new UserServiceException("无效的openId参数,请重新授权");
            }
            if (!ObjectUtils.isNullOrEmpty(connectUserDto.getUserId())) {
                throw new UserServiceException("已绑定用户");
            }
            UserDto existsUserDto = userService.loadUserByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            // String userImgUrl = connectUserDto.getHeadImgUrl();
            // userImgUrl = userImgUrl.replaceAll("\\\\", CommonConstants.BACKSLASH);
            // FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            // String destFilePathSub = fileUploadUtils.uploadFromUrl(userImgUrl, null, getSystemFileRelativePath());
            // fileUploadUtils.uploadPublishFile(destFilePathSub);

            String passwordEncrypt = EncryptUtils.md5Crypt(password).toLowerCase();
            Integer defaultCreateUserId = getRegistDefaultCreateUserId();
            if (!ObjectUtils.isNullOrEmpty(existsUserDto)) {
                ConnectUser connectUser = connectUserMapper.loadByUserIdAndConnectType(existsUserDto.getId(),
                        connectUserDto.getConnectType());
                if (!ObjectUtils.isNullOrEmpty(connectUser)) {
                    throw new UserServiceException("此手机号已绑定过账号");
                }
                // List<ConnectUser> existsConnectUserList = connectUserMapper.listByUserId(existsUserDto.getId());
                // if (!ObjectUtils.isNullOrEmpty(existsConnectUserList)) {
                // throw new UserServiceException("该用户已绑定");
                // }
                if (!StringUtils.isEmpty(connectUserDto.getUnionId())) {
                    updateBindUserIdByUnionId(connectUserDto.getUnionId(), existsUserDto.getId());
                } else {
                    updateBindUserIdByOpenId(openId, existsUserDto.getId());
                }

                UserDto updateUserDto = new UserDto();
                updateUserDto.setId(existsUserDto.getId());
                updateUserDto.setPassword(passwordEncrypt);
                updateUserDto.setModifyTime(new Date());
                updateUserDto.setModifyUserId(existsUserDto.getId());
                userService.updateUserForPassword(updateUserDto);

                UserProfileDto existsUserProfileDto = existsUserDto.getUserProfileDto();
                if (!ObjectUtils.isNullOrEmpty(existsUserProfileDto)
                        && ObjectUtils.isNullOrEmpty(existsUserProfileDto.getNickName())) {
                    UserProfileDto userProfileDto = new UserProfileDto();
                    userProfileDto.setUserId(existsUserDto.getId());
                    userProfileDto.setNickName(connectUserDto.getNickName());
                    userProfileService.updateByUserIdSelective(userProfileDto);
                }
                if (!ObjectUtils.isNullOrEmpty(existsUserProfileDto)
                        && ObjectUtils.isNullOrEmpty(existsUserProfileDto.getUserImageUrl())) {
                    userService.sendUpdatUserAvatarMessage(existsUserDto.getId(), connectUserDto.getHeadImgUrl());
                }
                return existsUserDto.getId();
            }
            CustomerDto customerDto = new CustomerDto();
            customerDto.setCustomerName(mobile);
            customerDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            customerDto.setPayPassword(passwordEncrypt);
            customerDto.setTelPhone(mobile);
            customerDto.setCreateUserId(defaultCreateUserId);

            UserDto userDto = new UserDto();
            userDto.setUserName(mobile);
            userDto.setPhone(mobile);
            userDto.setRealName(connectUserDto.getNickName());
            userDto.setPassword(passwordEncrypt);
            userDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
            userDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
            userDto.setRegisterPlatform(channelCode);
            userDto.setCreateUserId(defaultCreateUserId);

            UserProfileDto userProfile = new UserProfileDto();
            // userProfile.setUserImageUrl(destFilePathSub);
            userProfile.setNickName(connectUserDto.getNickName());
            userProfile.setGender(toSystemContextGender(connectUserDto.getGender()));
            userDto.setUserProfileDto(userProfile);
            customerDto.setUserDto(userDto);
            customerDto.setMasterUserDto(userDto);
            customerService.saveCustomer(customerDto);
            int addUserId = customerDto.getMasterUserDto().getUserProfileDto().getUserId();
            if (!StringUtils.isEmpty(connectUserDto.getUnionId())) {
                updateBindUserIdByUnionId(connectUserDto.getUnionId(), addUserId);
            } else {
                updateBindUserIdByOpenId(openId, addUserId);
            }
            userService.sendUpdatUserAvatarMessage(addUserId, connectUserDto.getHeadImgUrl());
            return addUserId;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    private String toSystemContextGender(Integer gender) {
        if (ObjectUtils.isNullOrEmpty(gender)) {
            return SystemContext.UserDomain.USERGENDER_FEMALE;
        }
        switch (gender) {
        case CommonConstants.GENDER_MALE:
            return SystemContext.UserDomain.USERGENDER_MALE;
        case CommonConstants.GENDER_FEMALE:
            return SystemContext.UserDomain.USERGENDER_FEMALE;
        default:
            return SystemContext.UserDomain.USERGENDER_FEMALE;
        }
    }

    private Integer getRegistDefaultCreateUserId() {
        String paramValue = super.getSystemParamValue(SystemContext.SystemParams.U_REGIST_DEFAULT_CREATE_USER_ID);
        if (ObjectUtils.isNullOrEmpty(paramValue)) {
            return null;
        }
        return Integer.parseInt(paramValue);
    }

    private String getSystemFileRelativePath() {
        String systemUserPicRelativePath = super.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH);
        if (ObjectUtils.isNullOrEmpty(systemUserPicRelativePath)) {
            return USER_PIC_RELATIVE_PATH_DEFAULT;
        }
        return systemUserPicRelativePath;
    }

    @Override
    public List<ConnectUserDto> listByUnionId(String unionId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(unionId)) {
                return Collections.emptyList();
            }
            List<ConnectUser> connectUserList = connectUserMapper.listByUnionId(unionId);
            List<ConnectUserDto> connectUserDtos = new ArrayList<ConnectUserDto>();
            for (ConnectUser connectUser : connectUserList) {
                ConnectUserDto connectUserDto = new ConnectUserDto();
                ObjectUtils.fastCopy(connectUser, connectUserDto);
                connectUserDtos.add(connectUserDto);
            }
            return connectUserDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ConnectUserDto loadByUnionIdAndConnectType(String unionId, String connectType) throws UserServiceException {
        try {
            return null;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateBindWX(String code, String tradeType, Integer bindUserId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(bindUserId)) {
                throw new UserServiceException("bindUserId parameter cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(code)) {
                throw new UserServiceException("code parameter cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(tradeType)) {
                throw new UserServiceException("tradeType parameter cant not be null");
            }
            List<String> connectTypes = new ArrayList<String>(2);
            connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
            connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
            List<ConnectUser> connectUsers = connectUserMapper.listByUserId(bindUserId, connectTypes);
            if (!ObjectUtils.isNullOrEmpty(connectUsers)) {
                throw new UserServiceException("该用户已经绑定微信账户");
            }
            boolean isJsApi = false;
            String connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP;
            if (WechatConfig.JS_TRADE_TYPE.equals(tradeType)) {
                connectType = SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5;
                isJsApi = true;
            }
            AccessToken accessToken = AccessTokenApi.getAccessToken(code, isJsApi);
            List<ConnectUserDto> connectUserDtos = listByUnionId(accessToken.getUnionid());
            if (!ObjectUtils.isNullOrEmpty(connectUserDtos)) {
                for (ConnectUserDto connectUserDto : connectUserDtos) {
                    if (!ObjectUtils.isNullOrEmpty(connectUserDto.getUserId())) {
                        throw new UserServiceException("该微信已绑定其他账号");
                    }
                }
            }
            ConnectUserDto existsConnectUserDto = loadByOpenId(accessToken.getOpenid());
            if (!ObjectUtils.isNullOrEmpty(existsConnectUserDto)
                    && !ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId())) {
                throw new UserServiceException("该微信已绑定其他账号");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(existsConnectUserDto)) { // 第一次授权
                WechatUserInfo weiXinUserInfo = WechatUserApi.getUserInfo(accessToken.getAccessToken(),
                        accessToken.getOpenid());
                if (!ObjectUtils.isNullOrEmpty(weiXinUserInfo.getErrmsg())) {
                    throw new UserServiceException(weiXinUserInfo.getErrmsg());
                }
                ConnectUserDto connectUserDto = new ConnectUserDto();
                connectUserDto.setOpenId(weiXinUserInfo.getOpenid());
                connectUserDto.setGender(weiXinUserInfo.getSex());
                connectUserDto.setNickName(weiXinUserInfo.getNickname());
                connectUserDto.setUnionId(weiXinUserInfo.getUnionid());
                connectUserDto.setUserId(bindUserId);
                connectUserDto.setHeadImgUrl(weiXinUserInfo.getHeadimgurl());
                connectUserDto.setConnectType(connectType);
                connectUserDto.setCreateTime(nowTime);
                connectUserDto.setModifyTime(nowTime);
                save(connectUserDto);
            }
            updateBindUserIdByUnionId(accessToken.getUnionid(), bindUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void updateUnBindWX(Integer bindUserId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(bindUserId)) {
                throw new UserServiceException("解除绑定用户不能为空");
            }
            List<String> connectTypes = new ArrayList<String>(2);
            connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATAPP);
            connectTypes.add(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
            List<ConnectUser> connectUsers = connectUserMapper.listByUserId(bindUserId, connectTypes);
            if (ObjectUtils.isNullOrEmpty(connectUsers)) {
                throw new UserServiceException("该用户尚未绑定微信账号");
            }
            String unionId = null;
            Integer cancelBindUserId = null;
            for (ConnectUser connectUser : connectUsers) {
                unionId = connectUser.getUnionId();
                break;
            }
            updateBindUserIdByUnionId(unionId, cancelBindUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateBindQQ(String accessToken, String openId, Integer bindUserId, String channel)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(bindUserId)) {
                throw new UserServiceException("bindUserId parameter cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(accessToken)) {
                throw new UserServiceException("accessToken parameter cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(openId)) {
                throw new UserServiceException("openId parameter cant not be null");
            }
            ConnectUserDto connectUserDto = loadByUserIdAndConnectType(bindUserId,
                    SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
            if (!ObjectUtils.isNullOrEmpty(connectUserDto)) {
                throw new UserServiceException("该用户账号尚已经绑定QQ,不能再绑定其他QQ账户");
            }
            ConnectUserDto existsConnectUserDto = loadByOpenId(openId);
            if (!ObjectUtils.isNullOrEmpty(existsConnectUserDto)
                    && !ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId())) {
                throw new UserServiceException("该QQ已绑定其他账号");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(existsConnectUserDto)) { // 第一次授权
                QQUserInfo qqUserInfo = QQUserInfoApi.getUserInfo(accessToken, openId, channel);
                if (!ObjectUtils.isNullOrEmpty(qqUserInfo.getMsg())) {
                    throw new UserServiceException(qqUserInfo.getMsg());
                }
                ConnectUserDto saveConnectUserDto = new ConnectUserDto();
                saveConnectUserDto.setOpenId(openId);
                saveConnectUserDto.setUserId(bindUserId);
                saveConnectUserDto.setGender(getGender(qqUserInfo.getGender()));
                saveConnectUserDto.setNickName(qqUserInfo.getNickname());
                saveConnectUserDto.setHeadImgUrl(qqUserInfo.getHeadimgurl());
                saveConnectUserDto.setConnectType(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
                saveConnectUserDto.setCreateTime(nowTime);
                saveConnectUserDto.setModifyTime(nowTime);
                save(saveConnectUserDto);
                return;
            }
            updateBindUserIdByOpenId(openId, bindUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void updateUnBindQQ(Integer bindUserId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(bindUserId)) {
                throw new UserServiceException("解除绑定用户不能为空");
            }
            ConnectUser connectUser = connectUserMapper.loadByUserIdAndConnectType(bindUserId,
                    SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_QQ);
            if (ObjectUtils.isNullOrEmpty(connectUser)) {
                throw new UserServiceException("该用户尚未绑定微信账号");
            }
            Integer cancelBindUserId = null;
            updateBindUserIdByOpenId(connectUser.getOpenId(), cancelBindUserId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    private int getGender(String gender) {
        if ("男".equals(gender)) {
            return CommonConstants.GENDER_MALE;
        }
        return CommonConstants.GENDER_FEMALE;
    }

    @Override
    public List<ConnectUserDto> listByUserIdAndConnectTypes(Integer userId, List<String> connectTypes)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(connectTypes)) {
                connectTypes = null;
            }
            List<ConnectUser> connectUserList = connectUserMapper.listByUserId(userId, connectTypes);
            List<ConnectUserDto> connectUserDtos = null;
            if (!ObjectUtils.isNullOrEmpty(connectUserList)) {
                connectUserDtos = new ArrayList<ConnectUserDto>(10);
                for (ConnectUser connectUser : connectUserList) {
                    ConnectUserDto connectUserDto = new ConnectUserDto();
                    ObjectUtils.fastCopy(connectUser, connectUserDto);
                    connectUserDtos.add(connectUserDto);
                }
            }
            return connectUserDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
