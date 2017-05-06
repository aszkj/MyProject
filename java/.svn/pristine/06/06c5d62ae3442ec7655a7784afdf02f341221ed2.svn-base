package com.yilidi.o2o.controller.mobile.buyer.user;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.appparam.buyer.user.StoreInfoParam;
import com.yilidi.o2o.appparam.buyer.user.StoreLocationListParam;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.query.StoreLocationQueryDto;

/**
 * 店铺
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:38:43
 */
@Controller("buyerStoreController")
@RequestMapping(value = "/interfaces/buyer")
public class StoreController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());
    /** 定位店铺默认距离范围 **/
    private static final Integer STORE_LOCATION_DISTANCE_RANGE_DEFAULT = 3000;
    @Autowired
    private IStoreProfileService storeProfileService;

    /**
     * 加载店铺详细信息接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/store/shopinformation")
    @ResponseBody
    public ResultParamModel communitySearch(HttpServletRequest req, HttpServletResponse resp) {
        StoreInfoParam param = super.getEntityParam(req, StoreInfoParam.class);
        Integer storeId = param.getStoreId();
        StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeId, null);
        StoreInfoVO storeInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
            storeInfoVO = new StoreInfoVO();
            ObjectUtils.fastCopy(storeProfileDto, storeInfoVO);
            storeInfoVO.setStoreStatus(ConverterUtils.toClientStoreStatus(storeProfileDto.getStoreStatus()));
            storeInfoVO.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
            storeInfoVO.setTransCostAmount(storeProfileDto.getAddSendingPrice());
            storeInfoVO.setHotline(StringUtils.defaultIfBlank(storeProfileDto.getMobile(), storeProfileDto.getTelPhone()));
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
        return super.encapsulateParam(storeInfoVO, AppMsgBean.MsgCode.SUCCESS, "加载店铺详细信息接口成功");
    }

    /**
     * 获取附近自提定位列表
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/store/locationlist")
    @ResponseBody
    public ResultParamModel getUserLocationList(HttpServletRequest req, HttpServletResponse resp) {
        StoreLocationListParam storeLocationListParma = super.getEntityParam(req, StoreLocationListParam.class);
        Double longitude = storeLocationListParma.getLongitude(); // 经度
        Double latitude = storeLocationListParma.getLatitude(); // 维度
        StoreLocationQueryDto storeLocationQueryDto = new StoreLocationQueryDto();
        storeLocationQueryDto.setLatitude(latitude);
        storeLocationQueryDto.setLongitude(longitude);
        storeLocationQueryDto.setDistance(ArithUtils.converStringToInt(
                systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.U_STORE_LOCATION_DISTANCE_RANGE),
                STORE_LOCATION_DISTANCE_RANGE_DEFAULT));
        List<StoreInfoVO> userLocationVOList = new ArrayList<StoreInfoVO>();
        List<StoreProfileDto> storeProfileDtos = storeProfileService.listAroundStores(storeLocationQueryDto);
        if (!ObjectUtils.isNullOrEmpty(storeProfileDtos)) {
            for (StoreProfileDto storeProfileDto : storeProfileDtos) {
                StoreInfoVO storeInfoVO = new StoreInfoVO();
                ObjectUtils.fastCopy(storeProfileDto, storeInfoVO);
                storeInfoVO.setDeduceTransCostAmount(storeProfileDto.getStartSendingPrice());
                storeInfoVO.setTransCostAmount(storeProfileDto.getAddSendingPrice());
                storeInfoVO.setStoreStatus(ConverterUtils.toClientStoreStatus(storeProfileDto.getStoreStatus()));
                if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getProvinceCode())) {
                    storeInfoVO.setProvinceName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getProvinceCode()));
                }
                if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCityCode())) {
                    storeInfoVO.setCityName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCityCode()));
                }
                if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCountyCode())) {
                    storeInfoVO.setCountyName(systemBasicDataInfoUtils.getAreaName(storeProfileDto.getCountyCode()));
                }
                userLocationVOList.add(storeInfoVO);
            }
        }
        return super.encapsulateParam(userLocationVOList, AppMsgBean.MsgCode.SUCCESS, "获取定位列表接口成功");
    }
}
