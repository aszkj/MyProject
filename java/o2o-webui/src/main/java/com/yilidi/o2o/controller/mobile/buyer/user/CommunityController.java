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

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.appparam.buyer.user.CommunityInfoParam;
import com.yilidi.o2o.appvo.buyer.user.CommunitySearchVO;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.common.utils.ConverterUtils;
import com.yilidi.o2o.controller.common.BuyerBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;

/**
 * 小区
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:38:43
 */
@Controller("buyerCommunityController")
@RequestMapping(value = "/interfaces/buyer")
public class CommunityController extends BuyerBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ICommunityService communityService;

    /**
     * 小区搜索接口
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/communitysearch")
    @ResponseBody
    public ResultParamModel communitySearch(HttpServletRequest req, HttpServletResponse resp) {
        AppParamModel param = super.getParameter(req);
        JSONObject entity = param.getEntity();
        String keywords = entity.getString("keywords"); // 搜索关键字
        String provinceCode = entity.getString("provinceCode"); // 省编码
        String cityCode = entity.getString("cityCode"); // 市编码
        String countyCode = entity.getString("countyCode"); // 区编码
        Integer pageNum = entity.getInteger("pageNum");
        Integer pageSize = entity.getInteger("pageSize");
        logger.info("====keywords:[{" + keywords + "}],provinceCode:[{" + provinceCode + "}],cityCode:[{" + cityCode
                + "}],countyCode:[{" + countyCode + "}]");
        if (StringUtils.isEmpty(keywords)
                && (StringUtils.isEmpty(provinceCode) || StringUtils.isEmpty(cityCode) || StringUtils.isEmpty(countyCode))) {
            return super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "参数不能为空");
        }

        CommunityQuery communityQuery = new CommunityQuery();
        communityQuery.setKeywords(keywords);
        communityQuery.setProvinceCode(provinceCode);
        communityQuery.setCityCode(cityCode);
        communityQuery.setCountyCode(countyCode);
        communityQuery.setStart(pageNum);
        communityQuery.setPageSize(pageSize);
        communityQuery.setDisplay(SystemContext.UserDomain.COMMUNITYDISPLAY_YES);

        YiLiDiPage<CommunityDto> page = communityService.listCommunitys(communityQuery);
        List<CommunityDto> communityDtoList = page.getResultList();
        List<CommunitySearchVO> communityVOList = new ArrayList<CommunitySearchVO>();
        if (!ObjectUtils.isNullOrEmpty(communityDtoList)) {
            for (int i = 0, size = communityDtoList.size(); i < size; i++) {
                CommunityDto communityDto = communityDtoList.get(i);
                CommunitySearchVO communitySearchVO = new CommunitySearchVO();
                ObjectUtils.fastCopy(communityDto, communitySearchVO);
                communitySearchVO.setCommunityId(communityDto.getId()); // 小区ID
                communitySearchVO.setCommunityName(communityDto.getName()); // 小区名称
                StoreInfoVO storeInfoVO = null;
                if (!ObjectUtils.isNullOrEmpty(communityDto.getStoreProfileDto())) {
                    storeInfoVO = new StoreInfoVO();
                    ObjectUtils.fastCopy(communityDto.getStoreProfileDto(), storeInfoVO);
                    storeInfoVO.setDeduceTransCostAmount(communityDto.getStoreProfileDto().getStartSendingPrice());
                    storeInfoVO.setTransCostAmount(communityDto.getStoreProfileDto().getAddSendingPrice());
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
                communitySearchVO.setStoreInfo(storeInfoVO);
                communityVOList.add(communitySearchVO);
            }
        }
        return super.encapsulatePageParam(page, communityVOList, AppMsgBean.MsgCode.SUCCESS, "小区搜索接口成功");
    }

    /**
     * 获取小区详细信息
     * 
     * @param req
     *            HttpServletRequest
     * @param resp
     *            HttpServletResponse
     * @return ResultParamModel
     */
    @RequestMapping(value = "/user/communityinfo")
    @ResponseBody
    public ResultParamModel communityInfo(HttpServletRequest req, HttpServletResponse resp) {
        CommunityInfoParam communityInfoParam = super.getEntityParam(req, CommunityInfoParam.class);
        CommunityDto communityDto = communityService.loadById(communityInfoParam.getCommunityId());
        if (ObjectUtils.isNullOrEmpty(communityDto)) {
            super.encapsulateParam(AppMsgBean.MsgCode.FAILURE, "小区不存在");
        }
        CommunitySearchVO communitySearchVO = new CommunitySearchVO();
        ObjectUtils.fastCopy(communityDto, communitySearchVO);
        communitySearchVO.setCommunityId(communityDto.getId()); // 小区ID
        communitySearchVO.setCommunityName(communityDto.getName()); // 小区名称
        StoreInfoVO storeInfoVO = null;
        if (!ObjectUtils.isNullOrEmpty(communityDto.getStoreProfileDto())) {
            storeInfoVO = new StoreInfoVO();
            ObjectUtils.fastCopy(communityDto.getStoreProfileDto(), storeInfoVO);
            storeInfoVO.setDeduceTransCostAmount(communityDto.getStoreProfileDto().getStartSendingPrice());
            storeInfoVO.setTransCostAmount(communityDto.getStoreProfileDto().getAddSendingPrice());
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
        communitySearchVO.setStoreInfo(storeInfoVO);
        return super.encapsulateParam(communitySearchVO, AppMsgBean.MsgCode.SUCCESS, "小区搜索接口成功");
    }
}
