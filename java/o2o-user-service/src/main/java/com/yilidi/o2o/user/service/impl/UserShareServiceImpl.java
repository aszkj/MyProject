package com.yilidi.o2o.user.service.impl;

import java.awt.Color;
import java.awt.Font;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.connect.config.WechatConfig;
import com.yilidi.o2o.core.connect.wechat.api.AccessTokenApi;
import com.yilidi.o2o.core.connect.wechat.api.WechatUserApi;
import com.yilidi.o2o.core.connect.wechat.javabean.AccessToken;
import com.yilidi.o2o.core.connect.wechat.javabean.WechatUserInfo;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ImageUtils;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.QRCodeUtil;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.proxy.IOrderProxyService;
import com.yilidi.o2o.order.proxy.IUserCouponProxyService;
import com.yilidi.o2o.order.proxy.dto.SaleOrderItemInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.SaleOrderProxyDto;
import com.yilidi.o2o.order.proxy.dto.UserCouponProxyDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.user.dao.UserShareCodeMapper;
import com.yilidi.o2o.user.model.UserShareCode;
import com.yilidi.o2o.user.proxy.dto.UserShareAwardProxyDto;
import com.yilidi.o2o.user.service.IAccountService;
import com.yilidi.o2o.user.service.IConnectUserService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.IInvitedUserShareRecordService;
import com.yilidi.o2o.user.service.IInviterUserShareAwardService;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.IUserShareService;
import com.yilidi.o2o.user.service.dto.ConnectUserDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.InvitedUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InvitedUserShareRecordDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

import redis.clients.jedis.Jedis;

/**
 * 用户分享Service实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("userShareService")
public class UserShareServiceImpl extends BasicDataService implements IUserShareService {

    private static final String USER_PIC_RELATIVE_PATH_DEFAULT = "/pic/user";
    /**
     * 用户分享码分布式锁Key
     */
    private static final String USERSHARECODE_LOCK_KEY = "USERSHARECODE_LOCK_KEY";

    /**
     * 用户分享码Redis缓存Key
     */
    private static final String USERSHARECODE_CACHE_KEY = "USERSHARECODE_CACHE_KEY";

    /**
     * 生成用户分享码超时时间，单位秒
     */
    private static Integer USERSHARECODE_CREATE_TIMEOUT = 3;

    /** 手机无密码注册默认密码 **/
    private static final String REGISTERUSE_PASSWORD_DEFAULT = "wq436125";

    @Autowired
    private IShareRuleService shareRuleService;
    @Autowired
    private UserShareCodeMapper userShareCodeMapper;
    @Autowired
    private IUserService userService;
    @Autowired
    private IConnectUserService connectUserService;
    @Autowired
    private IInvitedUserShareRecordService invitedUserShareRecordService;
    @Autowired
    private ICustomerService customerService;
    @Autowired
    private IInviterUserShareAwardService inviterUserShareAwardService;
    @Autowired
    private IInvitedUserShareAwardService invitedUserShareAwardService;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IOrderProxyService orderProxyService;
    @Autowired
    private IUserCouponProxyService userCouponProxyService;
    @Autowired
    private IMessageProxyService messageProxyService;
    @Autowired
    private IAccountService accountService;
    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private IStoreWarehouseService storeWarehouseService;

    @Override
    public ShareRuleDto updateShareToWechatFriends(Integer shareUserId, Date currentTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareUserId)) {
                throw new UserServiceException("分享用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(currentTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                throw new UserServiceException("没有进行的分享活动");
            }
            UserShareCode existsUserShareCode = userShareCodeMapper.loadByShareUserId(shareUserId);
            String shareCode = null;
            if (ObjectUtils.isNullOrEmpty(existsUserShareCode)) {
                shareCode = generateShareCode();
                String userShareQRCodePath = generateUserShareQRCode(shareCode, shareUserId, shareRuleDto.getH5DrawUrl());
                UserShareCode userShareCode = new UserShareCode();
                userShareCode.setShareCode(shareCode);
                userShareCode.setShareUserId(shareUserId);
                userShareCode.setQrCodeUrl(userShareQRCodePath);
                userShareCode.setCreateUserId(shareUserId);
                userShareCode.setCreateTime(currentTime);
                userShareCodeMapper.save(userShareCode);
            } else {
                shareCode = existsUserShareCode.getShareCode();
            }
            shareRuleDto.setShareCode(shareCode);
            return shareRuleDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    private String generateUserShareQRCode(String shareCode, Integer userId, String redirectUrl) throws Exception {
        FileUploadUtils fileUpload = FileUploadUtils.getInstance();
        String url = getH5DrawUrl(redirectUrl, shareCode);
        String localBasePath = StringUtils.defaultIfBlank(
                SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH),
                StringUtils.EMPTY);
        String userShareQRCodePath = SystemBasicDataUtils
                .getSystemParamValue(SystemContext.SystemParams.P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH);
        if (StringUtils.isEmpty(userShareQRCodePath)) {
            userShareQRCodePath = CommonConstants.USERSHARE_TO_WECHATFRIENDSCIRCLE_DEFAULT;
        }
        userShareQRCodePath += CommonConstants.BACKSLASH + shareCode + CommonConstants.BACKSLASH + shareCode
                + CommonConstants.DELIMITER_DOT + "png";
        String userShareQRCodeUrl = localBasePath + userShareQRCodePath;
        String companyImagePath = StringUtils.toFullImageUrl(
                CommonConstants.COMPANY_LOGO_IAMGE_DIRECTORY_DEFAULT + CommonConstants.COMPANY_IMAGE_NAME_70_DEFAULT);
        String localCompanyImagePath = localBasePath + fileUpload.uploadFromUrl(companyImagePath,
                fileUpload.getFileNameFromUrl(companyImagePath), CommonConstants.COMPANY_LOGO_IAMGE_DIRECTORY_DEFAULT);
        QRCodeUtil.createQRCodeWithLogo(url, 300, 300, localCompanyImagePath, userShareQRCodeUrl);
        FileUploadUtils.getInstance().uploadPublishFile(userShareQRCodePath);
        return userShareQRCodePath;
    }

    private String getH5DrawUrl(String h5DrawUrl, String shareCode) throws UnsupportedEncodingException {
        if (ObjectUtils.isNullOrEmpty(h5DrawUrl)) {
            return StringUtils.EMPTY;
        }
        StringBuffer resultUrlSb = new StringBuffer();
        resultUrlSb.append(h5DrawUrl);
        if (-1 == h5DrawUrl.indexOf("?")) {
            resultUrlSb.append("?").append("shareCode").append("=").append(shareCode);
        } else {
            resultUrlSb.append("&").append("shareCode").append("=").append(shareCode);
        }
        return AccessTokenApi.getAuthorizeURLThroughPublish(WechatConfig.getAppId(true),
                URLEncoder.encode(StringUtils.toFullMobileUrl(resultUrlSb.toString()), CommonConstants.UTF_8), false);
    }

    private String generateShareCode() throws UserServiceException {
        Jedis jedis = null;
        try {
            DistributedLockUtils.lock(USERSHARECODE_LOCK_KEY, 3, 5, TimeUnit.SECONDS);
            jedis = JedisUtils.getJedis();
            long currentTimeMillis = System.currentTimeMillis();
            while ((System.currentTimeMillis() - currentTimeMillis) < USERSHARECODE_CREATE_TIMEOUT * 1000) {
                String shareCode = StringUtils.randomString(6);
                if (!jedis.exists(getUserShareCodeCacheKey(shareCode))) {
                    List<UserShareCode> userShareCodeList = userShareCodeMapper.listAll();
                    if (!ObjectUtils.isNullOrEmpty(userShareCodeList)) {
                        for (UserShareCode userShareCode : userShareCodeList) {
                            if (!StringUtils.isEmpty(userShareCode.getShareCode())) {
                                jedis.set(getUserShareCodeCacheKey(userShareCode.getShareCode()),
                                        userShareCode.getShareCode());
                            }
                        }
                    }
                    if (jedis.exists(getUserShareCodeCacheKey(shareCode))) {
                        continue;
                    }
                    jedis.set(getUserShareCodeCacheKey(shareCode), shareCode);
                    return shareCode;
                }
            }
            throw new UserServiceException("生成用户分享码超时");
        } catch (Exception e) {
            String msg = "生成用户分享码出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(e.getMessage());
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
            DistributedLockUtils.unlock();
        }
    }

    private String getUserShareCodeCacheKey(String shareCode) {
        return USERSHARECODE_CACHE_KEY + CommonConstants.DELIMITER_DOT + shareCode;
    }

    @Override
    public String updateShareToWechatFriendsCircle(Integer shareUserId, Date currentTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareUserId)) {
                throw new UserServiceException("分享用户不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(currentTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                throw new UserServiceException("没有进行的分享活动");
            }
            UserShareCode existsUserShareCode = userShareCodeMapper.loadByShareUserId(shareUserId);
            String shareCode = null;
            String userShareQRCodePath = null;
            if (ObjectUtils.isNullOrEmpty(existsUserShareCode)) {
                shareCode = generateShareCode();
                userShareQRCodePath = generateUserShareQRCode(shareCode, shareUserId, shareRuleDto.getH5DrawUrl());
                UserShareCode userShareCode = new UserShareCode();
                userShareCode.setShareCode(shareCode);
                userShareCode.setShareUserId(shareUserId);
                userShareCode.setQrCodeUrl(userShareQRCodePath);
                userShareCode.setCreateUserId(shareUserId);
                userShareCode.setCreateTime(currentTime);
                userShareCodeMapper.save(userShareCode);
            } else {
                shareCode = existsUserShareCode.getShareCode();
                userShareQRCodePath = existsUserShareCode.getQrCodeUrl();
            }
            shareRuleDto.setShareCode(shareCode);
            String backgroundImageUrl = shareRuleDto.getBackgroundImageUrl();
            if (ObjectUtils.isNullOrEmpty(backgroundImageUrl)) {
                return StringUtils.EMPTY;
            }
            UserDto userDto = userService.loadUserById(shareUserId);
            if (ObjectUtils.isNullOrEmpty(userDto)) {
                throw new UserServiceException("用户不存在");
            }
            CustomerDto customerDto = customerService.loadCustomerById(userDto.getCustomerId());
            if (ObjectUtils.isNullOrEmpty(customerDto)) {
                throw new UserServiceException("用户不存在");
            }
            FileUploadUtils fileUpload = FileUploadUtils.getInstance();
            String localBasePath = SystemBasicDataUtils
                    .getSystemParamValue(SystemContext.SystemParams.LOCAL_UPLOAD_FILE_BASE_PATH);
            String userImagePath = SystemBasicDataUtils.getSystemParamValue(
                    SystemContext.SystemParams.USER_PIC_RELATIVE_PATH) + CommonConstants.USERHEAD_IMAGE_NAME_DEFAULT;
            String userHeaderShadeImage = StringUtils.toFullImageUrl(
                    SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH)
                            + CommonConstants.USERHEAD_SHADE_IMAGE_NAME_DEFAULT);
            if (SystemContext.UserDomain.BUYERLEVEL_B.equals(customerDto.getBuyerLevelCode())) {
                userHeaderShadeImage = StringUtils.toFullImageUrl(
                        SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH)
                                + CommonConstants.VIPUSERHEAD_SHADE_IMAGE_NAME_DEFAULT);
            }
            if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto())) {
                if (!ObjectUtils.isNullOrEmpty(userDto.getUserProfileDto().getUserImageUrl())) {
                    userImagePath = userDto.getUserProfileDto().getUserImageUrl();
                }
            }
            String userMobile = userDto.getUserName();
            String userShareRelativePath = SystemBasicDataUtils
                    .getSystemParamValue(SystemContext.SystemParams.P_SHARERULEBACKGROUND_PIC_RELATIVE_PATH);
            if (StringUtils.isEmpty(userShareRelativePath)) {
                userShareRelativePath = CommonConstants.USERSHARE_TO_WECHATFRIENDSCIRCLE_DEFAULT;
            }
            userShareRelativePath += CommonConstants.BACKSLASH + shareRuleDto.getShareCode() + CommonConstants.BACKSLASH
                    + shareRuleDto.getShareCode() + CommonConstants.DELIMITER_HR + shareUserId + CommonConstants.DELIMITER_HR
                    + shareRuleDto.getId() + CommonConstants.DELIMITER_DOT + "png";
            String destImageFile = localBasePath + userShareRelativePath;
            String localUserImagePath = localBasePath + fileUpload.uploadFromUrl(StringUtils.toFullImageUrl(userImagePath),
                    fileUpload.getFileNameFromUrl(StringUtils.toFullImageUrl(userImagePath)),
                    SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH));
            ImageUtils.scaleImageByWidthAndHeight(localUserImagePath, localUserImagePath, 200, 200, true);
            String localBackgroundImagePath = localBasePath
                    + fileUpload.uploadFromUrl(StringUtils.toFullImageUrl(backgroundImageUrl),
                            fileUpload.getFileNameFromUrl(StringUtils.toFullImageUrl(backgroundImageUrl)),
                            SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH));
            ImageUtils.pressImage(localUserImagePath, localBackgroundImagePath, destImageFile,
                    shareRuleDto.getAvatarHeight(), 1F);
            String localUserHeaderShadeImage = localBasePath
                    + fileUpload.uploadFromUrl(StringUtils.toFullImageUrl(userHeaderShadeImage),
                            fileUpload.getFileNameFromUrl(StringUtils.toFullImageUrl(userHeaderShadeImage)),
                            SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH));
            ImageUtils.pressImage(localUserHeaderShadeImage, destImageFile, destImageFile, 264, 1F);
            ImageUtils.pressText(userMobile, destImageFile, destImageFile, "宋体", Font.CENTER_BASELINE,
                    new Color(139, 139, 139), 48, shareRuleDto.getMobileHeight(), 1F);
            String localUserShareWRCodeImage = localBasePath
                    + fileUpload.uploadFromUrl(StringUtils.toFullImageUrl(userShareQRCodePath),
                            fileUpload.getFileNameFromUrl(StringUtils.toFullImageUrl(userShareQRCodePath)),
                            SystemBasicDataUtils.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH));
            ImageUtils.pressImage(localUserShareWRCodeImage, destImageFile, destImageFile, shareRuleDto.getQrCodeHeight(),
                    1F);
            fileUpload.uploadPublishFile(userShareRelativePath);
            return userShareRelativePath;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAcceptInvite(String code, String shareCode, String mobile, String channel)
            throws UserServiceException {
        try {
            if (StringUtils.isEmpty(code) || StringUtils.isEmpty(shareCode) || StringUtils.isEmpty(mobile)) {
                throw new UserServiceException("required param can not be null");
            }
            AccessToken accessToken = AccessTokenApi.getAccessToken(code, true);
            if (ObjectUtils.isNullOrEmpty(accessToken) || ObjectUtils.isNullOrEmpty(accessToken.getOpenid())) {
                throw new UserServiceException("获取微信授权信息失败,请刷新重试");
            }
            Date nowTime = new Date();
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                throw new UserServiceException("没有进行的分享活动");
            }
            boolean isBind = false;
            Integer bindUserId = null;
            if (!ObjectUtils.isNullOrEmpty(accessToken.getUnionid())) {
                List<ConnectUserDto> connectUserDtoList = connectUserService.listByUnionId(accessToken.getUnionid());
                if (!ObjectUtils.isNullOrEmpty(connectUserDtoList)) {
                    for (ConnectUserDto connectUserDto : connectUserDtoList) {
                        if (!ObjectUtils.isNullOrEmpty(connectUserDto.getUserId())) {
                            isBind = true;
                            bindUserId = connectUserDto.getUserId();
                            break;
                        }
                    }
                }
            }
            ConnectUserDto existsConnectUserDto = connectUserService.loadByOpenId(accessToken.getOpenid());
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (ObjectUtils.isNullOrEmpty(existsConnectUserDto)) {
                WechatUserInfo weiXinUserInfo = WechatUserApi.getUserInfo(accessToken.getAccessToken(),
                        accessToken.getOpenid());
                if (!ObjectUtils.isNullOrEmpty(weiXinUserInfo.getErrmsg())) {
                    throw new UserServiceException(weiXinUserInfo.getErrmsg());
                }
                existsConnectUserDto = new ConnectUserDto();
                existsConnectUserDto.setOpenId(weiXinUserInfo.getOpenid());
                existsConnectUserDto.setGender(weiXinUserInfo.getSex());
                existsConnectUserDto.setNickName(weiXinUserInfo.getNickname());
                existsConnectUserDto.setUnionId(weiXinUserInfo.getUnionid());
                existsConnectUserDto.setUserId(bindUserId);
                existsConnectUserDto.setHeadImgUrl(weiXinUserInfo.getHeadimgurl());
                existsConnectUserDto.setConnectType(SystemContext.UserDomain.CONNECTUSERCONNECTTYPE_WECHATHTML5);
                existsConnectUserDto.setCreateTime(nowTime);
                existsConnectUserDto.setModifyTime(nowTime);
                connectUserService.save(existsConnectUserDto);
            }
            String destFilePathSub = null;
            if (!ObjectUtils.isNullOrEmpty(existsConnectUserDto.getHeadImgUrl())) {
                String userImgUrl = existsConnectUserDto.getHeadImgUrl().replaceAll("\\\\", CommonConstants.BACKSLASH);
                destFilePathSub = fileUploadUtils.uploadFromUrl(userImgUrl, null, getSystemFileRelativePath());
                fileUploadUtils.uploadPublishFile(destFilePathSub);
            }
            if (!ObjectUtils.isNullOrEmpty(existsConnectUserDto)
                    && !ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUserId())) {
                isBind = true;
            }
            if (isBind) {
                InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                        .loadByInvitedUserIdAndShareRuleId(existsConnectUserDto.getUserId(), shareRuleDto.getId());
                if (!ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                    throw new UserServiceException("您已经参加过活动了");
                }
                throw new UserServiceException("该用户不是新用户,不能参加分享活动");
            }
            UserShareCode userShareCode = userShareCodeMapper.loadByShareCode(shareCode);
            if (ObjectUtils.isNullOrEmpty(userShareCode)) {
                throw new UserServiceException("无效的分享码");
            }
            UserDto existsUserDto = userService.loadUserByNameAndType(mobile, SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            if (!ObjectUtils.isNullOrEmpty(existsUserDto)) {
                InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                        .loadByInvitedUserIdAndShareRuleId(existsUserDto.getId(), shareRuleDto.getId());
                if (!ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                    throw new UserServiceException("您已经参加过活动了");
                }
                throw new UserServiceException("该用户不是新用户,不能参加分享活动");
            }
            String defaultPassword = EncryptUtils.md5Crypt(REGISTERUSE_PASSWORD_DEFAULT).toLowerCase();
            CustomerDto customerDto = new CustomerDto();
            customerDto.setCustomerName(mobile);
            customerDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            customerDto.setPayPassword(defaultPassword);
            customerDto.setTelPhone(mobile);
            customerDto.setCreateUserId(getRegistDefaultCreateUserId());

            UserDto userDto = new UserDto();
            userDto.setUserName(mobile);
            userDto.setPhone(mobile);
            userDto.setPassword(defaultPassword);
            userDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
            userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
            userDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
            if (ObjectUtils.isNullOrEmpty(channel)) {
                channel = SystemContext.UserDomain.CHANNELTYPE_HTML5;
            }
            userDto.setRegisterPlatform(channel);
            userDto.setCreateUserId(getRegistDefaultCreateUserId());

            UserProfileDto userProfile = new UserProfileDto();
            userProfile.setUserImageUrl(destFilePathSub);
            userProfile.setNickName(existsConnectUserDto.getNickName());
            userProfile.setGender(toSystemContextGender(existsConnectUserDto.getGender()));
            userDto.setUserProfileDto(userProfile);
            customerDto.setUserDto(userDto);
            customerDto.setMasterUserDto(userDto);
            customerService.saveCustomer(customerDto);
            int addUserId = customerDto.getMasterUserDto().getUserProfileDto().getUserId();
            if (ObjectUtils.isNullOrEmpty(existsConnectUserDto.getUnionId())) {
                connectUserService.updateBindUserIdByOpenId(existsConnectUserDto.getOpenId(), addUserId);
            } else {
                connectUserService.updateBindUserIdByUnionId(existsConnectUserDto.getUnionId(), addUserId);
            }
            InvitedUserShareRecordDto invitedUserShareRecordDto = new InvitedUserShareRecordDto();
            invitedUserShareRecordDto.setShareCode(userShareCode.getShareCode());
            invitedUserShareRecordDto.setShareUserId(userShareCode.getShareUserId());
            invitedUserShareRecordDto.setShareRuleId(shareRuleDto.getId());
            invitedUserShareRecordDto.setInvitedUserId(addUserId);
            invitedUserShareRecordDto.setCreateUserId(getRegistDefaultCreateUserId());
            invitedUserShareRecordDto.setCreateTime(nowTime);
            invitedUserShareRecordService.save(invitedUserShareRecordDto);
            // 发送用户分享注册奖励消息
            sendUserShareAwardMessage(addUserId, nowTime, null,
                    SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_REGISTER);
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
            return CommonConstants.SYSTEM_USER_ID;
        }
        return Integer.parseInt(paramValue);
    }

    @Override
    public void saveUserShareAwardForLoginContidion(Integer userId, Date nowTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                logger.info("必填参数不能为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                logger.info("没有正在进行的分享的和活动");
                return;
            }
            InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                    .loadByInvitedUserIdAndShareRuleId(userId, shareRuleDto.getId());
            if (ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                logger.info("userId[" + userId + "]没有参加活动");
                return;
            }
            logger.info("进来了");
            boolean isInvitedSave = false;
            boolean isSaveInvitedCoupon = false;
            String[] invitedAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN
                    .equals(shareRuleDto.getInvitedConditionType())) {
                InvitedUserShareAwardDto existsInvitedUserShareAwardDto = invitedUserShareAwardService
                        .loadByInvitedUserIdAndShareRuleId(invitedUserShareRecordDto.getInvitedUserId(),
                                invitedUserShareRecordDto.getShareRuleId());
                if (ObjectUtils.isNullOrEmpty(existsInvitedUserShareAwardDto)) {
                    List<InvitedUserShareAwardDto> invitedUserShareAwardDtoList = new ArrayList<InvitedUserShareAwardDto>();
                    InvitedUserShareAwardDto invitedUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInvitedAward())) {
                            logger.info("被邀请人奖励=" + JsonUtils.toJsonString(shareRuleDto.getInvitedAward()));
                            invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(invitedAwardArrays)) {
                                for (String invitedAward : invitedAwardArrays) {
                                    String[] awardArrays = invitedAward.split(",");
                                    invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                                    invitedUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    invitedUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? null : Long.parseLong(awardArrays[1]));
                                    invitedUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? null : Integer.parseInt(awardArrays[2]));
                                    invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                                }
                                isInvitedSave = true;
                                isSaveInvitedCoupon = true;
                            }
                        }

                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Integer.parseInt(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Long.parseLong(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (isInvitedSave) {
                        invitedUserShareAwardService.save(invitedUserShareAwardDtoList);
                    }
                }
            }
            boolean isInviterSave = false;
            boolean isSaveInviterCoupon = false;
            String[] inviterAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITERCONDITIONTYPE_LOGIN
                    .equals(shareRuleDto.getInviterConditionType())) {
                InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                        .loadByUserIdAndShareRuleIdAndInvitedUserId(invitedUserShareRecordDto.getShareUserId(),
                                invitedUserShareRecordDto.getShareRuleId(), invitedUserShareRecordDto.getInvitedUserId());
                if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                    List<InviterUserShareAwardDto> saveInviterUserShareAwardDtoList = new ArrayList<InviterUserShareAwardDto>();
                    InviterUserShareAwardDto saveInviterUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInviterAward())) {
                            inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(inviterAwardArrays)) {
                                for (String inviterAwardArray : inviterAwardArrays) {
                                    String[] awardArrays = inviterAwardArray.split(",");
                                    saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                                    saveInviterUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    saveInviterUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? null : Long.parseLong(awardArrays[1]));
                                    saveInviterUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? null : Integer.parseInt(awardArrays[2]));
                                    saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                                }
                                isInviterSave = true;
                                isSaveInviterCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInviterAward())
                                ? null : Integer.parseInt(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInviterAward()) ? null
                                : Long.parseLong(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (isInviterSave) {
                        inviterUserShareAwardService.save(saveInviterUserShareAwardDtoList);
                    }
                }
            }
            List<UserCouponProxyDto> userCouponProxyDtos = new ArrayList<UserCouponProxyDto>();
            UserCouponProxyDto userCouponProxyDto = null;
            if (isSaveInvitedCoupon) {
                logger.info("被邀请人=" + JsonUtils.toJsonString(invitedAwardArrays));
                // 被邀请人
                for (String invitedAwardArray : invitedAwardArrays) {
                    String[] awardArrays = invitedAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(userId);
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);

                }
            }
            if (isSaveInviterCoupon) {
                logger.info("邀请人=" + JsonUtils.toJsonString(invitedAwardArrays));
                // 邀请人
                for (String inviterAwardArray : inviterAwardArrays) {
                    String[] awardArrays = inviterAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(invitedUserShareRecordDto.getShareUserId());
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(userCouponProxyDtos)) {
                userCouponProxyService.saveBatchUserCoupon(userCouponProxyDtos);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    private InviterUserShareAwardDto getInviterUserShareAwardDto(InvitedUserShareRecordDto invitedUserShareRecordDto) {
        InviterUserShareAwardDto saveInviterUserShareAwardDto = new InviterUserShareAwardDto();
        saveInviterUserShareAwardDto.setShareCode(invitedUserShareRecordDto.getShareCode());
        saveInviterUserShareAwardDto.setUserId(invitedUserShareRecordDto.getShareUserId());
        saveInviterUserShareAwardDto.setInvitedUserId(invitedUserShareRecordDto.getInvitedUserId());
        saveInviterUserShareAwardDto.setShareRuleId(invitedUserShareRecordDto.getShareRuleId());
        saveInviterUserShareAwardDto.setCreateTime(new Date());
        saveInviterUserShareAwardDto.setCreateUserId(CommonConstants.SYSTEM_USER_ID);
        return saveInviterUserShareAwardDto;
    }

    private InvitedUserShareAwardDto getInvitedUserShareAwardDto(InvitedUserShareRecordDto invitedUserShareRecordDto) {
        InvitedUserShareAwardDto invitedUserShareAwardDto = new InvitedUserShareAwardDto();
        invitedUserShareAwardDto.setShareCode(invitedUserShareRecordDto.getShareCode());
        invitedUserShareAwardDto.setShareRuleId(invitedUserShareRecordDto.getShareRuleId());
        invitedUserShareAwardDto.setShareUserId(invitedUserShareRecordDto.getShareUserId());
        invitedUserShareAwardDto.setInvitedUserId(invitedUserShareRecordDto.getInvitedUserId());
        invitedUserShareAwardDto.setCreateTime(new Date());
        invitedUserShareAwardDto.setCreateUserId(CommonConstants.SYSTEM_USER_ID);
        return invitedUserShareAwardDto;
    }

    @Override
    public void saveUserShareAwardForProductOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                logger.info("必填参数不能为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(orderNo)) {
                logger.info("订单编号为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                logger.info("没有正在进行的分享的和活动");
                return;
            }
            InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                    .loadByInvitedUserIdAndShareRuleId(userId, shareRuleDto.getId());
            if (ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                logger.info("用户userId[" + userId + "]没有参加活动");
                return;
            }
            UserDto userDto = userService.loadUserById(invitedUserShareRecordDto.getShareUserId());
            if (ObjectUtils.isNullOrEmpty(userDto)) {
                throw new UserServiceException("用户[" + invitedUserShareRecordDto.getShareUserId() + "]不存在");
            }
            List<String> statusCodes = new ArrayList<String>(1);
            statusCodes.add(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            List<SaleOrderItemInfoProxyDto> saleOrderItemProxyDtos = orderProxyService
                    .listSaleOrderItemInfoByOrderNo(orderNo, statusCodes);
            if (ObjectUtils.isNullOrEmpty(saleOrderItemProxyDtos)) {
                return;
            }
            String invitedProductStr = shareRuleDto.getInvitedUseProduct();
            String inviterProductStr = shareRuleDto.getInviterUseProduct();
            Set<Integer> productIdSet = new HashSet<Integer>();
            List<Integer> productIdList = new ArrayList<Integer>();
            Map<Integer, Integer> inviterProductIdMap = new HashMap<Integer, Integer>();
            Map<Integer, Integer> invitedProductIdMap = new HashMap<Integer, Integer>();
            if (!StringUtils.isEmpty(invitedProductStr)) {
                String[] invitedProductArr = invitedProductStr.split(CommonConstants.DELIMITER_COMMA);
                for (String productStr : invitedProductArr) {
                    productIdSet.add(Integer.parseInt(productStr));
                    invitedProductIdMap.put(Integer.parseInt(productStr), Integer.parseInt(productStr));
                }
            }
            if (!StringUtils.isEmpty(inviterProductStr)) {
                String[] inviterProductArr = inviterProductStr.split(CommonConstants.DELIMITER_COMMA);
                for (String productStr : inviterProductArr) {
                    productIdSet.add(Integer.parseInt(productStr));
                    inviterProductIdMap.put(Integer.parseInt(productStr), Integer.parseInt(productStr));
                }
            }
            productIdList.addAll(productIdSet);
            List<SaleProductProxyDto> saleProductProxyDtoList = null;
            Integer storeId = saleOrderItemProxyDtos.get(0).getStoreId();
            StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeId);
            if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                logger.info("找不到店铺信息");
                return;
            }
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())
                    && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileDto.getStockShare())) {
                storeId = storeWarehouseService.loadWarehouseIdByStoreId(storeProfileDto.getStoreId());
            }
            if (!ObjectUtils.isNullOrEmpty(productIdList)) {
                saleProductProxyDtoList = productProxyService.listSaleProductByProductIdsAndStoreId(productIdList, null,
                        null, storeId);
            }
            boolean inviterSaleProductIdContain = false;
            boolean invitedSaleProductIdContain = false;
            Map<Integer, Integer> inviterSaleProductIdMap = new HashMap<Integer, Integer>();
            Map<Integer, Integer> invitedSaleProductIdMap = new HashMap<Integer, Integer>();
            if (!ObjectUtils.isNullOrEmpty(saleProductProxyDtoList)) {
                for (SaleProductProxyDto saleProductProxyDto : saleProductProxyDtoList) {
                    if (inviterProductIdMap.containsKey(saleProductProxyDto.getProductId())) {
                        inviterSaleProductIdMap.put(saleProductProxyDto.getId(), saleProductProxyDto.getId());
                    }
                    if (invitedProductIdMap.containsKey(saleProductProxyDto.getProductId())) {
                        invitedSaleProductIdMap.put(saleProductProxyDto.getId(), saleProductProxyDto.getId());
                    }
                }
            }
            for (SaleOrderItemInfoProxyDto saleOrderItemInfoProxyDto : saleOrderItemProxyDtos) {
                if (inviterSaleProductIdMap.containsKey(saleOrderItemInfoProxyDto.getSaleProductId())
                        && saleOrderItemInfoProxyDto.getUserId().intValue() == invitedUserShareRecordDto.getInvitedUserId()
                                .intValue()) {
                    inviterSaleProductIdContain = true;
                }
                if (invitedSaleProductIdMap.containsKey(saleOrderItemInfoProxyDto.getSaleProductId())
                        && saleOrderItemInfoProxyDto.getUserId().intValue() == invitedUserShareRecordDto.getInvitedUserId()
                                .intValue()) {
                    invitedSaleProductIdContain = true;
                }
            }
            boolean isInvitedSave = false;
            boolean isSaveInvitedCoupon = false;
            String[] invitedAwardArrays = null;
            InvitedUserShareAwardDto existsInvitedUserShareAwardDto = invitedUserShareAwardService
                    .loadByInvitedUserIdAndShareRuleId(invitedUserShareRecordDto.getInvitedUserId(),
                            invitedUserShareRecordDto.getShareRuleId());
            if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_PRODUCT
                    .equals(shareRuleDto.getInvitedConditionType())) {
                if (invitedSaleProductIdContain && ObjectUtils.isNullOrEmpty(existsInvitedUserShareAwardDto)) {
                    List<InvitedUserShareAwardDto> invitedUserShareAwardDtoList = new ArrayList<InvitedUserShareAwardDto>();
                    InvitedUserShareAwardDto invitedUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInvitedAward())) {
                            invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(invitedAwardArrays)) {
                                for (String invitedAward : invitedAwardArrays) {
                                    String[] awardArrays = invitedAward.split(",");
                                    invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                                    invitedUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    invitedUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? null : Long.parseLong(awardArrays[1]));
                                    invitedUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? null : Integer.parseInt(awardArrays[2]));
                                    invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                                }
                                isInvitedSave = true;
                                isSaveInvitedCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? 0
                                : Integer.parseInt(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Long.parseLong(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (isInvitedSave) {
                        invitedUserShareAwardService.save(invitedUserShareAwardDtoList);
                    }
                }
            }
            boolean isInviterSave = false;
            boolean isSaveInviterCoupon = false;
            String[] inviterAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITERCONDITIONTYPE_PRODUCT
                    .equals(shareRuleDto.getInviterConditionType())) {
                if (inviterSaleProductIdContain) {
                    InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                            .loadByUserIdAndShareRuleIdAndInvitedUserId(invitedUserShareRecordDto.getShareUserId(),
                                    invitedUserShareRecordDto.getShareRuleId(),
                                    invitedUserShareRecordDto.getInvitedUserId());
                    if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                        List<InviterUserShareAwardDto> saveInviterUserShareAwardDtoList = new ArrayList<InviterUserShareAwardDto>();
                        InviterUserShareAwardDto saveInviterUserShareAwardDto = null;
                        if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
                            if (!StringUtils.isEmpty(shareRuleDto.getInviterAward())) {
                                inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                                if (!ObjectUtils.isNullOrEmpty(inviterAwardArrays)) {
                                    for (String inviterAwardArray : inviterAwardArrays) {
                                        String[] awardArrays = inviterAwardArray.split(",");
                                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(
                                                invitedUserShareRecordDto);
                                        saveInviterUserShareAwardDto.setAwardCouponId(StringUtils.isEmpty(awardArrays[0])
                                                ? null : Integer.parseInt(awardArrays[0]));
                                        saveInviterUserShareAwardDto.setAwardCouponAmount(
                                                StringUtils.isEmpty(awardArrays[1]) ? 0 : Long.parseLong(awardArrays[1]));
                                        saveInviterUserShareAwardDto.setAwardCouponCount(
                                                StringUtils.isEmpty(awardArrays[2]) ? 0 : Integer.parseInt(awardArrays[2]));
                                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                                    }
                                    isInviterSave = true;
                                    isSaveInviterCoupon = true;
                                }
                            }
                        }
                        if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInviterAwardType())) {
                            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                                isInviterSave = true;
                            }
                            saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                            saveInviterUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInviterAward())
                                    ? 0 : Integer.parseInt(shareRuleDto.getInviterAward()));
                            saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                        }
                        if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInviterAwardType())) {
                            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                                isInviterSave = true;
                            }
                            saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                            saveInviterUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInviterAward()) ? 0
                                    : Long.parseLong(shareRuleDto.getInviterAward()));
                            saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                        }
                        if (isInviterSave) {
                            inviterUserShareAwardService.save(saveInviterUserShareAwardDtoList);
                        }
                    } else {
                        logger.info("卖家userId[" + inviterUserShareAwardDto.getUserId() + "]已经奖励过了");
                    }
                }
            }
            List<UserCouponProxyDto> userCouponProxyDtos = new ArrayList<UserCouponProxyDto>();
            UserCouponProxyDto userCouponProxyDto = null;
            if (isSaveInvitedCoupon) {
                // 被邀请人
                for (String invitedAwardArray : invitedAwardArrays) {
                    String[] awardArrays = invitedAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(userId);
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);
                }
            }
            if (isSaveInviterCoupon) {
                // 邀请人
                for (String inviterAwardArray : inviterAwardArrays) {
                    String[] awardArrays = inviterAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(invitedUserShareRecordDto.getShareUserId());
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(userCouponProxyDtos)) {
                userCouponProxyService.saveBatchUserCoupon(userCouponProxyDtos);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserShareAwardForAnyOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                logger.info("必填参数不能为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(orderNo)) {
                logger.info("订单编号为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                logger.info("没有正在进行的分享的和活动");
                return;
            }
            InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                    .loadByInvitedUserIdAndShareRuleId(userId, shareRuleDto.getId());
            if (ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                logger.info("用户userId[" + userId + "]没有参加活动");
                return;
            }
            UserDto userDto = userService.loadUserById(invitedUserShareRecordDto.getShareUserId());
            if (ObjectUtils.isNullOrEmpty(userDto)) {
                throw new UserServiceException("用户[" + invitedUserShareRecordDto.getShareUserId() + "]不存在");
            }
            SaleOrderProxyDto saleOrderProxyDto = orderProxyService.loadSaleOrderBasicInfoByOrderno(orderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrderProxyDto)) {
                return;
            }
            if (!SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED.equals(saleOrderProxyDto.getStatusCode())) {
                logger.info("订单编号:" + orderNo + "没有完成交易,领取奖励失败");
                return;
            }
            if (saleOrderProxyDto.getUserId().intValue() != invitedUserShareRecordDto.getInvitedUserId().intValue()) {
                logger.info("下单用户:" + saleOrderProxyDto.getUserId() + "不是参加活动的用户:"
                        + invitedUserShareRecordDto.getInvitedUserId() + ",领取奖励失败");
                return;
            }
            boolean isInvitedSave = false;
            boolean isSaveInvitedCoupon = false;
            String[] invitedAwardArrays = null;
            InvitedUserShareAwardDto existsInvitedUserShareAwardDto = invitedUserShareAwardService
                    .loadByInvitedUserIdAndShareRuleId(invitedUserShareRecordDto.getInvitedUserId(),
                            invitedUserShareRecordDto.getShareRuleId());
            if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_ANYORDER
                    .equals(shareRuleDto.getInvitedConditionType())) {
                if (ObjectUtils.isNullOrEmpty(existsInvitedUserShareAwardDto)) {
                    List<InvitedUserShareAwardDto> invitedUserShareAwardDtoList = new ArrayList<InvitedUserShareAwardDto>();
                    InvitedUserShareAwardDto invitedUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInvitedAward())) {
                            invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(invitedAwardArrays)) {
                                for (String invitedAward : invitedAwardArrays) {
                                    String[] awardArrays = invitedAward.split(",");
                                    invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                                    invitedUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    invitedUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? 0 : Long.parseLong(awardArrays[1]));
                                    invitedUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? 0 : Integer.parseInt(awardArrays[2]));
                                    invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                                }
                                isInvitedSave = true;
                                isSaveInvitedCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Integer.parseInt(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Long.parseLong(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (isInvitedSave) {
                        invitedUserShareAwardService.save(invitedUserShareAwardDtoList);
                    }
                }
            }
            boolean isInviterSave = false;
            boolean isSaveInviterCoupon = false;
            String[] inviterAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITERCONDITIONTYPE_ANYORDER
                    .equals(shareRuleDto.getInviterConditionType())) {
                InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                        .loadByUserIdAndShareRuleIdAndInvitedUserId(invitedUserShareRecordDto.getShareUserId(),
                                invitedUserShareRecordDto.getShareRuleId(), invitedUserShareRecordDto.getInvitedUserId());
                if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                    List<InviterUserShareAwardDto> saveInviterUserShareAwardDtoList = new ArrayList<InviterUserShareAwardDto>();
                    InviterUserShareAwardDto saveInviterUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInviterAward())) {
                            inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(inviterAwardArrays)) {
                                for (String inviterAwardArray : inviterAwardArrays) {
                                    String[] awardArrays = inviterAwardArray.split(",");
                                    saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                                    saveInviterUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    saveInviterUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? 0 : Long.parseLong(awardArrays[1]));
                                    saveInviterUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? 0 : Integer.parseInt(awardArrays[2]));
                                    saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                                }
                                isInviterSave = true;
                                isSaveInviterCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInviterAward()) ? 0
                                : Integer.parseInt(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInviterAward()) ? null
                                : Long.parseLong(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (isInviterSave) {
                        inviterUserShareAwardService.save(saveInviterUserShareAwardDtoList);
                    }
                } else {
                    logger.info("卖家userId[" + inviterUserShareAwardDto.getUserId() + "]已经奖励过了");
                }
            }
            List<UserCouponProxyDto> userCouponProxyDtos = new ArrayList<UserCouponProxyDto>();
            UserCouponProxyDto userCouponProxyDto = null;
            if (isSaveInvitedCoupon) {
                // 被邀请人
                for (String invitedAwardArray : invitedAwardArrays) {
                    String[] awardArrays = invitedAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(userId);
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);

                }
            }
            if (isSaveInviterCoupon) {
                // 邀请人
                for (String inviterAwardArray : inviterAwardArrays) {
                    String[] awardArrays = inviterAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(invitedUserShareRecordDto.getShareUserId());
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(userCouponProxyDtos)) {
                userCouponProxyService.saveBatchUserCoupon(userCouponProxyDtos);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void saveUserShareAwardForRegisterContidion(Integer userId, Date nowTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                logger.info("必填参数不能为空");
                return;
            }
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            ShareRuleDto shareRuleDto = shareRuleService.loadProgressing(nowTime);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                logger.info("没有正在进行的分享的和活动");
                return;
            }
            InvitedUserShareRecordDto invitedUserShareRecordDto = invitedUserShareRecordService
                    .loadByInvitedUserIdAndShareRuleId(userId, shareRuleDto.getId());
            if (ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)) {
                logger.info("userId[" + userId + "]没有参加活动");
                return;
            }
            boolean isInvitedSave = false;
            boolean isSaveInvitedCoupon = false;
            String[] invitedAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_REGISTER
                    .equals(shareRuleDto.getInvitedConditionType())) {
                InvitedUserShareAwardDto existsInvitedUserShareAwardDto = invitedUserShareAwardService
                        .loadByInvitedUserIdAndShareRuleId(invitedUserShareRecordDto.getInvitedUserId(),
                                invitedUserShareRecordDto.getShareRuleId());
                if (!ObjectUtils.isNullOrEmpty(invitedUserShareRecordDto)
                        && ObjectUtils.isNullOrEmpty(existsInvitedUserShareAwardDto)) {
                    List<InvitedUserShareAwardDto> invitedUserShareAwardDtoList = new ArrayList<InvitedUserShareAwardDto>();
                    InvitedUserShareAwardDto invitedUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInvitedAward())) {
                            invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(invitedAwardArrays)) {
                                for (String invitedAward : invitedAwardArrays) {
                                    String[] awardArrays = invitedAward.split(",");
                                    invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                                    invitedUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    invitedUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? null : Long.parseLong(awardArrays[1]));
                                    invitedUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? null : Integer.parseInt(awardArrays[2]));
                                    invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                                }
                                isInvitedSave = true;
                                isSaveInvitedCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Integer.parseInt(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInvitedAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                            isInvitedSave = true;
                        }
                        invitedUserShareAwardDto = getInvitedUserShareAwardDto(invitedUserShareRecordDto);
                        invitedUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInvitedAward()) ? null
                                : Long.parseLong(shareRuleDto.getInvitedAward()));
                        invitedUserShareAwardDtoList.add(invitedUserShareAwardDto);
                    }
                    if (isInvitedSave) {
                        invitedUserShareAwardService.save(invitedUserShareAwardDtoList);
                    }
                }
            }
            boolean isInviterSave = false;
            boolean isSaveInviterCoupon = false;
            String[] inviterAwardArrays = null;
            if (SystemContext.UserDomain.SHARERULEINVITERCONDITIONTYPE_REGISTER
                    .equals(shareRuleDto.getInviterConditionType())) {
                InviterUserShareAwardDto inviterUserShareAwardDto = inviterUserShareAwardService
                        .loadByUserIdAndShareRuleIdAndInvitedUserId(invitedUserShareRecordDto.getShareUserId(),
                                invitedUserShareRecordDto.getShareRuleId(), invitedUserShareRecordDto.getInvitedUserId());
                if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                    List<InviterUserShareAwardDto> saveInviterUserShareAwardDtoList = new ArrayList<InviterUserShareAwardDto>();
                    InviterUserShareAwardDto saveInviterUserShareAwardDto = null;
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
                        if (!StringUtils.isEmpty(shareRuleDto.getInviterAward())) {
                            inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                            if (!ObjectUtils.isNullOrEmpty(inviterAwardArrays)) {
                                for (String inviterAwardArray : inviterAwardArrays) {
                                    String[] awardArrays = inviterAwardArray.split(",");
                                    saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                                    saveInviterUserShareAwardDto.setAwardCouponId(
                                            StringUtils.isEmpty(awardArrays[0]) ? null : Integer.parseInt(awardArrays[0]));
                                    saveInviterUserShareAwardDto.setAwardCouponAmount(
                                            StringUtils.isEmpty(awardArrays[1]) ? null : Long.parseLong(awardArrays[1]));
                                    saveInviterUserShareAwardDto.setAwardCouponCount(
                                            StringUtils.isEmpty(awardArrays[2]) ? null : Integer.parseInt(awardArrays[2]));
                                    saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                                }
                                isInviterSave = true;
                                isSaveInviterCoupon = true;
                            }
                        }
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardPoints(StringUtils.isEmpty(shareRuleDto.getInviterAward())
                                ? null : Integer.parseInt(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInviterAwardType())) {
                        if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                            isInviterSave = true;
                        }
                        saveInviterUserShareAwardDto = getInviterUserShareAwardDto(invitedUserShareRecordDto);
                        saveInviterUserShareAwardDto.setAwardCash(StringUtils.isEmpty(shareRuleDto.getInviterAward()) ? null
                                : Long.parseLong(shareRuleDto.getInviterAward()));
                        saveInviterUserShareAwardDtoList.add(saveInviterUserShareAwardDto);
                    }
                    if (isInviterSave) {
                        inviterUserShareAwardService.save(saveInviterUserShareAwardDtoList);
                    }
                } else {
                    logger.info("卖家userId[" + inviterUserShareAwardDto.getUserId() + "]已经奖励过了");
                }
            }
            List<UserCouponProxyDto> userCouponProxyDtos = new ArrayList<UserCouponProxyDto>();
            UserCouponProxyDto userCouponProxyDto = null;
            if (isSaveInvitedCoupon) {
                // 被邀请人
                for (String invitedAwardArray : invitedAwardArrays) {
                    String[] awardArrays = invitedAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(userId);
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);

                }
            }
            if (isSaveInviterCoupon) {
                // 邀请人
                for (String inviterAwardArray : inviterAwardArrays) {
                    String[] awardArrays = inviterAwardArray.split(",");
                    userCouponProxyDto = new UserCouponProxyDto();
                    userCouponProxyDto.setConId(Integer.parseInt(awardArrays[0]));
                    userCouponProxyDto.setUserId(invitedUserShareRecordDto.getShareUserId());
                    userCouponProxyDto.setCount(Integer.parseInt(awardArrays[2]));
                    userCouponProxyDtos.add(userCouponProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(userCouponProxyDtos)) {
                userCouponProxyService.saveBatchUserCoupon(userCouponProxyDtos);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void sendUserShareAwardMessage(Integer userId, Date nowTime, String orderNo, String awardConditionType)
            throws UserServiceException {
        try {
            UserShareAwardProxyDto userShareAwardProxyDto = new UserShareAwardProxyDto();
            userShareAwardProxyDto.setAwardConditionType(awardConditionType);
            userShareAwardProxyDto.setNowTime(nowTime);
            userShareAwardProxyDto.setOrderNo(orderNo);
            userShareAwardProxyDto.setUserId(userId);
            messageProxyService.sendUserShareAwardMessage(userShareAwardProxyDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    private String getSystemFileRelativePath() {
        String systemUserPicRelativePath = super.getSystemParamValue(SystemContext.SystemParams.USER_PIC_RELATIVE_PATH);
        if (ObjectUtils.isNullOrEmpty(systemUserPicRelativePath)) {
            return USER_PIC_RELATIVE_PATH_DEFAULT;
        }
        return systemUserPicRelativePath;
    }
}
