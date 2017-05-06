package com.yilidi.o2o.controller.mobile.buyer.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.UserLocationListParam;
import com.yilidi.o2o.appparam.buyer.user.UserLocationParam;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;
import com.yilidi.o2o.appvo.buyer.user.UserLocationVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;

/**
 * 获取定位接口
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:38:43
 */
@Controller("buyerUserLocationController")
@RequestMapping(value = "/interfaces/buyer")
public class UserLocationController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ICommunityService communityService;

    @Autowired
    private IStoreProfileService storeProfileService;

    /** 用户小区定位查找默认范围,单位:米 **/
    private static final Integer COMMUNITY_LOCATION_DISTANCE_RANGE_DEFAULT = 1000;

    /**
     * 获取定位接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/location")
    @ResponseBody
    public ResultParamModel getLocation(HttpServletRequest req, HttpServletResponse resp) {
        UserLocationParam userLocationParma = super.getEntityParam(req, UserLocationParam.class);
        String longitude = userLocationParma.getLongitude(); // 经度
        String latitude = userLocationParma.getLatitude(); // 维度
        logger.info("=-=-=-=-=-=-=-=-=-=-=longitude : " + longitude);
        logger.info("=-=-=-=-=-=-=-=-=-=-=latitude : " + latitude);
        Integer distance = ArithUtils.converStringToInt(
                systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.U_COMMUNITY_LOCATION_DISTANCE_RANGE),
                COMMUNITY_LOCATION_DISTANCE_RANGE_DEFAULT);
        CommunityDto communityDto = communityService.getLocation(longitude, latitude, distance);
        if (null == communityDto || null == communityDto.getStoreProfileDto()) {
            StoreProfileDto storeProfileDto = storeProfileService.loadNationalPartner();
            if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                return super.encapsulateParam(AppMsgBean.MsgCode.SUCCESS, "定位不存在");
            }
            UserLocationVO locationVO = new UserLocationVO();
            locationVO.setCommunityName(storeProfileDto.getStoreName());
            locationVO.setProvinceCode(storeProfileDto.getProvinceCode());
            locationVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getProvinceCode()));
            StoreInfoVO storeInfoVo = null;
            storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(storeProfileDto, storeInfoVo);
            storeInfoVo.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            storeInfoVo.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
            }
            locationVO.setStoreInfo(storeInfoVo);
            return super.encapsulateParam(locationVO, AppMsgBean.MsgCode.SUCCESS, "获取定位接口成功");
        }

        UserLocationVO locationVO = new UserLocationVO();
        ObjectUtils.fastCopy(communityDto, locationVO);
        locationVO.setCommunityId(communityDto.getId()); // 小区ID
        locationVO.setCommunityName(communityDto.getName()); // 小区名称
        StoreInfoVO storeInfoVo = null;
        if (!ObjectUtils.isNullOrEmpty(communityDto.getStoreProfileDto())) {
            storeInfoVo = new StoreInfoVO();
            ObjectUtils.fastCopy(communityDto.getStoreProfileDto(), storeInfoVo);
            storeInfoVo.setDeduceTransCostAmount(communityDto.getStoreProfileDto().getStartSendingPrice());
            storeInfoVo.setTransCostAmount(communityDto.getStoreProfileDto().getAddSendingPrice());
            storeInfoVo.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVo.getStoreStatus()));
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getProvinceCode())) {
                storeInfoVo.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getProvinceCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCityCode())) {
                storeInfoVo.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCityCode()));
            }
            if (!ObjectUtils.isNullOrEmpty(storeInfoVo.getCountyCode())) {
                storeInfoVo.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVo.getCountyCode()));
            }
        }
        locationVO.setStoreInfo(storeInfoVo);
        return super.encapsulateParam(locationVO, AppMsgBean.MsgCode.SUCCESS, "获取定位接口成功");
    }

    /**
     * 获取小区定位列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/locationlist")
    @ResponseBody
    public ResultParamModel getUserLocationList(HttpServletRequest req, HttpServletResponse resp) {
        UserLocationListParam userLocationListParma = super.getEntityParam(req, UserLocationListParam.class);
        String longitude = userLocationListParma.getLongitude(); // 经度
        String latitude = userLocationListParma.getLatitude(); // 维度
        logger.info("=-=-=-=-=-=-=-=-=-=-=longitude : " + longitude);
        logger.info("=-=-=-=-=-=-=-=-=-=-=latitude : " + latitude);
        CommunityQuery communityQuery = new CommunityQuery();
        communityQuery.setStart(userLocationListParma.getPageNum());
        communityQuery.setPageSize(userLocationListParma.getPageSize());
        communityQuery.setDistance(ArithUtils.converStringToInt(
                systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.U_COMMUNITY_LOCATION_DISTANCE_RANGE),
                COMMUNITY_LOCATION_DISTANCE_RANGE_DEFAULT));
        YiLiDiPage<CommunityDto> communityDtoPage = communityService.findAroundCommunityList(communityQuery, longitude,
                latitude);

        List<CommunityDto> communityDtoList = communityDtoPage.getResultList();

        List<UserLocationVO> userLocationVOList = new ArrayList<UserLocationVO>();
        if (!ObjectUtils.isNullOrEmpty(communityDtoList)) {
            for (CommunityDto uDto : communityDtoList) {
                UserLocationVO userLocationVO = new UserLocationVO();
                ObjectUtils.fastCopy(uDto, userLocationVO);
                userLocationVO.setCommunityId(uDto.getId()); // 小区ID
                userLocationVO.setCommunityName(uDto.getName()); // 小区名称
                StoreInfoVO storeInfoVO = null;
                if (!ObjectUtils.isNullOrEmpty(uDto.getStoreProfileDto())) {
                    storeInfoVO = new StoreInfoVO();
                    ObjectUtils.fastCopy(uDto.getStoreProfileDto(), storeInfoVO);
                    storeInfoVO.setStoreStatus(ConverterUtils.toClientStoreStatus(storeInfoVO.getStoreStatus()));
                    if (!ObjectUtils.isNullOrEmpty(storeInfoVO.getProvinceCode())) {
                        storeInfoVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeInfoVO.getProvinceCode()));
                    }
                    if (!ObjectUtils.isNullOrEmpty(storeInfoVO.getCityCode())) {
                        storeInfoVO.setCityName(systemBasicDataInfoUtils.getAreaName(storeInfoVO.getCityCode()));
                    }
                    if (!ObjectUtils.isNullOrEmpty(storeInfoVO.getCountyCode())) {
                        storeInfoVO.setCountyName(systemBasicDataInfoUtils.getAreaName(storeInfoVO.getCountyCode()));
                    }
                }
                userLocationVO.setStoreInfo(storeInfoVO);
                userLocationVOList.add(userLocationVO);
            }
        }
        return super.encapsulatePageParam(communityDtoPage, userLocationVOList, AppMsgBean.MsgCode.SUCCESS, "获取定位列表接口成功");
    }
}
