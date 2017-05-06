package com.yilidi.o2o.controller.mobile.seller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.UserClientTokenParam;
import com.yilidi.o2o.appparam.seller.user.StoreFeedbackParam;
import com.yilidi.o2o.appparam.seller.user.UpdateStoreInfoParam;
import com.yilidi.o2o.appvo.seller.user.StoreDetailVO;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.SellerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IStoreFeedbackService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserClientTokenService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.StoreFeedbackDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserClientTokenDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * @Description: TODO(店铺信息Controller)
 * @author: chenlian
 * @date: 2016年6月1日 下午9:30:53
 */
@Controller("sellerStoreController")
@RequestMapping(value = "/interfaces/seller")
public class StoreController extends SellerBaseController {

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IStoreFeedbackService storeFeedbackService;

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserClientTokenService userClientTokenService;

    /**
     * 获取店铺详细信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/store/detailinfo")
    @ResponseBody
    public ResultParamModel detailInfo(HttpServletRequest req, HttpServletResponse resp) {
        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(super.getStoreId(), null);
        if (null == storeProfileDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该店铺不存在");
        }
        StoreDetailVO storeDetailVO = new StoreDetailVO();
        storeDetailVO.setUserId(super.getUserId());
        storeDetailVO.setUserName(storeProfileDto.getContact());
        storeDetailVO.setUserImageUrl(super.getUserImageUrl());
        storeDetailVO.setStoreId(super.getStoreId());
        storeDetailVO.setStoreName(storeProfileDto.getStoreName());
        storeDetailVO.setBeginBusinessHours(storeProfileDto.getBusinessHoursBegin());
        storeDetailVO.setEndBusinessHours(storeProfileDto.getBusinessHoursEnd());
        storeDetailVO.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
        storeDetailVO.setTransCostAmount(storeProfileDto.getAddSendingPrice());
        storeDetailVO.setHotline(storeProfileDto.getMobile());
        storeDetailVO.setCityCode(storeProfileDto.getCityCode());
        storeDetailVO.setCityName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCityCode()));
        storeDetailVO.setProvinceCode(storeProfileDto.getProvinceCode());
        storeDetailVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getProvinceCode()));
        storeDetailVO.setCountyCode(storeProfileDto.getCountyCode());
        storeDetailVO.setCountyName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCountyCode()));
        storeDetailVO.setAddressDetail(storeProfileDto.getAddressDetail());
        List<Integer> communityIds = storeProfileDto.getCommunityIds();
        if (!ObjectUtils.isNullOrEmpty(communityIds)) {
            storeDetailVO.setCommunityId(communityIds.get(0));
        }
        List<String> communityNames = storeProfileDto.getCommunityNames();
        if (!ObjectUtils.isNullOrEmpty(communityNames)) {
            storeDetailVO.setCommunityName(communityNames.get(0));
        }
        if (SystemContext.UserDomain.STORESTATUS_OPEN.equals(storeProfileDto.getStoreStatus())) {
            storeDetailVO.setStoreStatus(Integer.parseInt(WebConstants.STORE_STATUS_OPEN));
        }
        if (SystemContext.UserDomain.STORESTATUS_CLOSED.equals(storeProfileDto.getStoreStatus())) {
            storeDetailVO.setStoreStatus(Integer.parseInt(WebConstants.STORE_STATUS_CLOSE));
        }
        CustomerDto customerDto = customerService.loadCustomerById(storeProfileDto.getStoreId());
        if (null != customerDto) {
            storeDetailVO.setInvitationCode(customerDto.getInvitationCode());
        }
        return super.encapsulateParam(storeDetailVO, AppMsgBean.MsgCode.SUCCESS, "获取店铺详细信息成功");
    }

    /**
     * 修改店铺详细信息
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/store/updateinfo")
    @ResponseBody
    public ResultParamModel updateInfo(HttpServletRequest req, HttpServletResponse resp) {
        StoreProfileDto spDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == spDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该店铺不存在");
        }
        UpdateStoreInfoParam updateStoreInfoParam = super.getEntityParam(req, UpdateStoreInfoParam.class);
        StoreProfileDto storeProfileDto = new StoreProfileDto();
        storeProfileDto.setStoreId(super.getStoreId());
        storeProfileDto.setStoreName(updateStoreInfoParam.getStoreName());
        storeProfileDto.setBusinessHoursBegin(updateStoreInfoParam.getBeginBusinessHour());
        storeProfileDto.setBusinessHoursEnd(updateStoreInfoParam.getEndBusinessHour());
        storeProfileDto.setStartSendingPrice(updateStoreInfoParam.getDeduceTransCostAmount());
        storeProfileDto.setAddSendingPrice(updateStoreInfoParam.getTransCostAmount());
        storeProfileDto.setMobile(updateStoreInfoParam.getHotline());
        if (null != updateStoreInfoParam.getStoreStatus()
                && Integer.parseInt(WebConstants.STORE_STATUS_OPEN) == updateStoreInfoParam.getStoreStatus().intValue()) {
            storeProfileDto.setStoreStatus(SystemContext.UserDomain.STORESTATUS_OPEN);
        }
        if (null != updateStoreInfoParam.getStoreStatus()
                && Integer.parseInt(WebConstants.STORE_STATUS_CLOSE) == updateStoreInfoParam.getStoreStatus().intValue()) {
            storeProfileDto.setStoreStatus(SystemContext.UserDomain.STORESTATUS_CLOSED);
        }
        storeProfileService.updateStoreDetailsForSeller(storeProfileDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "修改店铺详细信息成功");
    }

    /**
     * 意见反馈
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/setting/feeback")
    @ResponseBody
    public ResultParamModel feeback(HttpServletRequest req, HttpServletResponse resp) {
        StoreProfileDto spDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == spDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "该店铺不存在");
        }
        StoreFeedbackParam storeFeedbackParam = super.getEntityParam(req, StoreFeedbackParam.class);
        StoreFeedbackDto storeFeedbackDto = new StoreFeedbackDto();
        storeFeedbackDto.setStoreId(spDto.getStoreId());
        storeFeedbackDto.setStoreName(spDto.getStoreName());
        storeFeedbackDto.setStoreCode(spDto.getStoreCode());
        storeFeedbackDto.setFeedbackContent(storeFeedbackParam.getFeebackContent());
        storeFeedbackDto.setCreateTime(DateUtils.getCurrentDateTime());
        storeFeedbackDto.setCreateUserId(super.getUserId());
        storeFeedbackService.save(storeFeedbackDto);
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "新增意见反馈成功");
    }

    /**
     * 同步当前手机推送标识符到服务器
     * 
     * @param req
     *            HttpServletRequest 实例对象
     * @param resp
     *            HttpServletResponse 实例对象
     * @return ResultParamModel
     */
    @SellerLoginValidation
    @RequestMapping(value = "/store/saveclientid")
    @ResponseBody
    public ResultParamModel saveClientId(HttpServletRequest req, HttpServletResponse resp) {
        StoreProfileDto spDto = storeProfileService.loadBasicStoreInfo(super.getStoreId(), null);
        if (null == spDto) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "店铺不存在");
        }
        UserClientTokenParam userClientTokenParam = super.getEntityParam(req, UserClientTokenParam.class);
        String clientId = userClientTokenParam.getClientId();
        String deviceToken = userClientTokenParam.getDeviceToken();
        String channelType = ConverterUtils.toServerChannelCode(getIntfCallChannel(req));
        if (StringUtils.isEmpty(channelType)) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "未获取到APP客户端所属平台");
        }
        UserClientTokenDto clientTokenDto = userClientTokenService.loadByClientToken(clientId);
        if (null != clientTokenDto) {
        	userClientTokenService.delete(clientTokenDto.getId());
        }
        UserClientTokenDto deviceTokenDto = userClientTokenService.loadByDeviceToken(deviceToken);
        if (null != deviceTokenDto) {
        	userClientTokenService.delete(deviceTokenDto.getId());
        }
        UserClientTokenDto userClientTokenDto = userClientTokenService.loadByUserId(super.getUserId());
        if (null == userClientTokenDto) {
            UserClientTokenDto uctDto = new UserClientTokenDto();
            UserDto userDto = userService.loadMainUser(super.getStoreId(), SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            if (null != userDto) {
                uctDto.setUserId(userDto.getId());
                uctDto.setClientToken(clientId);
                uctDto.setDeviceToken(deviceToken);
                uctDto.setPlatform(channelType);
                userClientTokenService.save(uctDto);
            }
        } else {
            userClientTokenService.update(userClientTokenDto.getId(), clientId, deviceToken, channelType);
        }
        return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "同步当前手机推送标识符到服务器成功");
    }

}
