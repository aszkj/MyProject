package com.yilidi.o2o.controller.operation.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

/**
 * 小区管理
 * 
 * @author: heyong
 * @date: 2015年11月19日 下午7:59:40
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class CommunityController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private ICommunityService communityService;

    /**
     * 查询小区列表
     * 
     * @param communityQuery
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listCommunity")
    @ResponseBody
    public MsgBean listCommunity(@RequestBody CommunityQuery communityQuery) {
        try {
            if (null == communityQuery) {
                throw new Exception("无法获取小区communityQuery");
            }
            YiLiDiPage<CommunityDto> yiLiDiPage = communityService.findCommunitys(communityQuery);
            logger.info("listCommunity->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询小区列表成功");
        } catch (Exception e) {
            logger.error("查询小区列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 
     * 查询小区详情
     * 
     * @param id
     *            小区Id
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/getCommunityDetail")
    @ResponseBody
    public MsgBean getCommunityDetail(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取小区ID");
            }
            CommunityDto communityDto = communityService.loadById(id);
            return super.encapsulateMsgBean(communityDto, MsgBean.MsgCode.SUCCESS, "获取小区详情信息成功");
        } catch (Exception e) {
            logger.error("获取小区详情失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改小区
     * 
     * @param communityDto
     *            小区DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateCommunity")
    @ResponseBody
    public MsgBean updateCommunity(@RequestBody CommunityDto communityDto) {
        try {
            Integer communityId = communityDto.getId();
            if (null == communityId) {
                throw new IllegalArgumentException("无法获取需修改的小区ID");
            }
            Param communityName = new Param.Builder("小区名称", Param.ParamType.STR_NORMAL.getType(), communityDto.getName(),
                    false).build();
            Param display = new Param.Builder("是否显示", Param.ParamType.STR_NORMAL.getType(), communityDto.getDisplay(), false)
                    .build();
            Param provinceCode = new Param.Builder("省份code", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getProvinceCode(), false).build();
            Param cityCode = new Param.Builder("城市code", Param.ParamType.STR_NORMAL.getType(), communityDto.getCityCode(),
                    false).build();
            Param countyCode = new Param.Builder("区code", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getCountyCode(), false).build();
            Param addressDetail = new Param.Builder("详细地址", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getAddressDetail(), false).build();
            Param longitude = new Param.Builder("X", Param.ParamType.STR_NORMAL.getType(), communityDto.getLongitude(),
                    false).build();
            Param latitude = new Param.Builder("Y", Param.ParamType.STR_NORMAL.getType(), communityDto.getLatitude(), false)
                    .build();

            super.validateParams(communityName, display, provinceCode, cityCode, countyCode, addressDetail, longitude,
                    latitude);
            communityDto.setModifyTime(new Date());
            communityDto.setModifyUserId(super.getUserId());
            communityService.update(communityDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改小区成功");
        } catch (Exception e) {
            logger.error("修改小区失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增小区
     * 
     * @param communityDto
     *            小区DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createCommunity")
    @ResponseBody
    public MsgBean createCommunity(@RequestBody CommunityDto communityDto) {
        try {
            if (null == communityDto) {
                throw new IllegalArgumentException("无法获取新增的小区communityDto");
            }
            Param communityName = new Param.Builder("小区名称", Param.ParamType.STR_NORMAL.getType(), communityDto.getName(),
                    false).build();
            Param display = new Param.Builder("是否显示", Param.ParamType.STR_NORMAL.getType(), communityDto.getDisplay(), false)
                    .build();
            Param provinceCode = new Param.Builder("省份code", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getProvinceCode(), false).build();
            Param cityCode = new Param.Builder("城市code", Param.ParamType.STR_NORMAL.getType(), communityDto.getCityCode(),
                    false).build();
            Param countyCode = new Param.Builder("区code", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getCountyCode(), false).build();
            Param addressDetail = new Param.Builder("详细地址", Param.ParamType.STR_NORMAL.getType(),
                    communityDto.getAddressDetail(), false).build();
            Param longitude = new Param.Builder("X", Param.ParamType.STR_NORMAL.getType(), communityDto.getLongitude(),
                    false).build();
            Param latitude = new Param.Builder("Y", Param.ParamType.STR_NORMAL.getType(), communityDto.getLatitude(), false)
                    .build();

            super.validateParams(communityName, display, provinceCode, cityCode, countyCode, addressDetail, longitude,
                    latitude);
            communityDto.setCreateTime(new Date());
            communityDto.setCreateUserId(super.getUserId());
            communityDto.setStoreCount(0);
            communityService.save(communityDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增小区成功");
        } catch (Exception e) {
            logger.error("新增小区失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 小区门店列表
     * 
     * @param query
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listCommunityStore")
    @ResponseBody
    public MsgBean listCommunityStore(@RequestBody CommunityStoreRelatedQuery query) {
        try {
            if (ObjectUtils.isNullOrEmpty(query) || ObjectUtils.isNullOrEmpty(query.getCommunityId())) {
                throw new IllegalArgumentException("无法获取query或者communityId为空");
            }
            YiLiDiPage<CommunityStoreRelatedDto> yiLiDiPage = communityService.findCommunityStoresByCommunityId(query);
            logger.info("listCommunityStore->yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询小区门店列表成功");
        } catch (Exception e) {
            logger.error("查询小区门店列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 解除小区门店关系
     * 
     * @param storeId
     *            门店ID
     * @param communityId
     *            小区ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{storeId}-{communityId}/cancelRelated")
    @ResponseBody
    public MsgBean cancelRelated(@PathVariable("storeId") Integer storeId, @PathVariable("communityId") Integer communityId) {
        try {
            if (null == storeId || null == communityId) {
                throw new IllegalArgumentException("无法获取需解除的小区ID");
            }
            if (!ObjectUtils.isNullOrEmpty(storeId) && !ObjectUtils.isNullOrEmpty(communityId)) {
                communityService.cancelRelatedById(storeId, communityId);
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "解除小区门店关系成功");
        } catch (Exception e) {
            logger.error("解除小区门店关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 根据区县编码获取该区县范围内的小区列表
     * 
     * @param countyCode
     * @return MsgBean
     */
    @RequestMapping(value = "/{countyCode}/getCommunityListByCountyCode")
    @ResponseBody
    public MsgBean getCommunityListByCountyCode(@PathVariable("countyCode") String countyCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(countyCode)) {
                List<CommunityDto> communityDtoList = communityService.listCommunitiesByCountyCode(countyCode);
                if (!ObjectUtils.isNullOrEmpty(communityDtoList)) {
                    mapList = new ArrayList<Map<String, String>>();
                    for (CommunityDto communityDto : communityDtoList) {
                        Map<String, String> communityInfoMap = new HashMap<String, String>();
                        communityInfoMap.put(CommonConstants.APPOINTED_KEY_ID, Integer.toString(communityDto.getId()));
                        communityInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, communityDto.getName());
                        mapList.add(communityInfoMap);
                    }
                }
            }
            return super.encapsulateMsgBean(mapList, MsgBean.MsgCode.SUCCESS, "根据区县编码获取该区县范围内的小区列表成功");
        } catch (Exception e) {
            logger.info("根据区县编码获取该区县范围内的小区列表出现异常", e);
            throw new IllegalStateException("根据区县编码获取该区县范围内的小区列表出现异常");
        }
    }

}
