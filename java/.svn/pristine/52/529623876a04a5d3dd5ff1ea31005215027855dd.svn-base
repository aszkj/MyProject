package com.yilidi.o2o.controller.operation.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
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
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.ReportFileModel;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.report.export.user.StoreReportExport;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IRecommendCustomerStoreService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.RecommendCustomerStoreDto;
import com.yilidi.o2o.user.service.dto.SimpleCommunityDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.StoreWarehouseDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.WarehouseAssociatePartnerDto;
import com.yilidi.o2o.user.service.dto.WarehouseLocationInfoDto;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;
import com.yilidi.o2o.user.service.dto.query.WarehousePartnersQueryDto;

/**
 * 商家管理
 * 
 * @author: heyong
 * @date: 2015年11月20日 下午6:21:11
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class StoreController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    private static final Integer COMMUNITY_STORE_DISTANCE_DEFAULT = 2000;

    private static final Integer STORE_WAREHOUSE_DISTANCE_DEFAULT = 2000;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private ICommunityService communityService;

    @Autowired
    private StoreReportExport storeReportExport;

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IStoreWarehouseService storeWarehouseService;

    @Autowired
    private IRecommendCustomerStoreService recommendCustomerStoreService;

    /**
     * 查询商家列表
     * 
     * @param query
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listStore")
    @ResponseBody
    public MsgBean listStore(@RequestBody CommunityStoreRelatedQuery query) {
        try {
            YiLiDiPage<CommunityStoreRelatedDto> yiLiDiPage = communityService.findCommunityStores(query);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询商家列表成功");
        } catch (Exception e) {
            logger.error("查询商家列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 查询商家列表
     * 
     * @param query
     *            查询条件
     * @return MsgBean
     */
    @RequestMapping(value = "/listStoresByProductId")
    @ResponseBody
    public MsgBean listStoresByProductId(@RequestBody CommunityStoreRelatedQuery query) {
        try {
            YiLiDiPage<CommunityStoreRelatedDto> yiLiDiPage = communityService.findCommunityStoresByProductId(query);
            logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
            return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询商家列表成功");
        } catch (Exception e) {
            logger.error("查询商家列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 查询商家详情
     * 
     * @param id
     *            商家ID
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/getStoreDetail")
    @ResponseBody
    public MsgBean getStoreDetail(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取商家ID");
            }
            StoreProfileDto storeProfileDto = storeProfileService.loadById(id);
            return super.encapsulateMsgBean(storeProfileDto, MsgBean.MsgCode.SUCCESS, "获取商家详情信息成功");
        } catch (Exception e) {
            logger.error("获取商家详情失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 修改商家
     * 
     * @param storeProfileDto
     *            商家DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/updateStore")
    @ResponseBody
    public MsgBean updateStore(@RequestBody StoreProfileDto storeProfileDto) {
        try {
            Integer id = storeProfileDto.getId();
            if (null == id) {
                throw new IllegalArgumentException("无法获取需修改的商家ID");
            }
            Param contact = new Param.Builder("联系人姓名", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getContact(),
                    false).build();
            Param userName = null;
            if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                userName = new Param.Builder("登录帐号", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getUserName(),
                        false).build();
            } else {
                userName = new Param.Builder("登录帐号", Param.ParamType.STR_MOBILE.getType(), storeProfileDto.getUserName(),
                        false).build();
            }
            Param stockShare = new Param.Builder("共享库存", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getStockShare(), false).build();
            Param mobile = new Param.Builder("服务热线", Param.ParamType.STR_MOBILE.getType(), storeProfileDto.getMobile(),
                    false).build();
            Param businessHoursBegin = new Param.Builder("开始的配送时间", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getBusinessHoursBegin(), false).build();
            Param businessHoursEnd = new Param.Builder("结束的配送时间", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getBusinessHoursEnd(), false).build();
            Param startSendingPrice = new Param.Builder("免配送费订单金额", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getStartSendingPrice(), false).build();
            Param addSendingPrice = new Param.Builder("增加的配送费", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getAddSendingPrice(), false).build();
            Param provinceCode = new Param.Builder("省份code", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getProvinceCode(), false).build();
            Param cityCode = new Param.Builder("城市code", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getCityCode(),
                    true).build();
            Param countyCode = new Param.Builder("区code", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getCountyCode(), true).build();
            Param addressDetail = new Param.Builder("详细地址", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getAddressDetail(), false).build();
            Param longitude = new Param.Builder("商家所在经度", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getLongitude(), false).build();
            Param latitude = new Param.Builder("商家所在纬度", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getLatitude(),
                    false).build();
            super.validateParams(contact, userName, mobile, stockShare, businessHoursBegin, businessHoursEnd,
                    startSendingPrice, addSendingPrice, provinceCode, cityCode, countyCode, addressDetail, longitude,
                    latitude);
            // 判断storecode唯一性
            StoreProfileDto existDto = storeProfileService.loadByStoreCode(storeProfileDto.getStoreCode());
            if (!ObjectUtils.isNullOrEmpty(existDto) && existDto.getId().intValue() != id.intValue()) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "修改商家失败,商家编号已存在!");
            }
            // 判断username唯一性
            UserDto uDto = userService.loadMainUser(existDto.getStoreId(), SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            if (!uDto.getUserName().equals(storeProfileDto.getUserName())) {
                if (userService.checkUserNameIsExist(storeProfileDto.getUserName(),
                        SystemContext.UserDomain.CUSTOMERTYPE_SELLER)) {
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "修改商家失败,登录帐号已存在!");
                }
            }
            // 判断全国性的商家唯一性
            if (CommonConstants.NATION_AREA_CODE_CHINA.equals(storeProfileDto.getProvinceCode())) {
                if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalPartner();
                    if (!ObjectUtils.isNullOrEmpty(spDto) && spDto.getId().intValue() != id.intValue()) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "修改商家失败,全国性的合伙人已存在!");
                    }
                }
                if (SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalExperienceStore();
                    if (!ObjectUtils.isNullOrEmpty(spDto) && spDto.getId().intValue() != id.intValue()) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "修改商家失败,全国性的体验店已存在!");
                    }
                }
                if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalWarehouse();
                    if (!ObjectUtils.isNullOrEmpty(spDto) && spDto.getId().intValue() != id.intValue()) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "修改商家失败,全国性的微仓已存在!");
                    }
                }
                storeProfileDto.setCityCode("");
                storeProfileDto.setCountyCode("");
            }
            storeProfileDto.setModifyUserId(super.getUserId());
            storeProfileDto.setModifyDate(DateUtils.getCurrentDateTime());
            storeProfileService.update(storeProfileDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改商家成功");
        } catch (Exception e) {
            logger.error("修改商家失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 新增商家
     * 
     * @param storeProfileDto
     *            商家DTO
     * @return MsgBean
     */
    @RequestMapping(value = "/createStore")
    @ResponseBody
    public MsgBean createStore(@RequestBody StoreProfileDto storeProfileDto) {
        try {
            if (null == storeProfileDto) {
                throw new IllegalArgumentException("无法获取新增的商家storeProfileDto");
            }
            Param storeType = new Param.Builder("商家类型", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getStoreType(),
                    false).build();
            Param storeCode = new Param.Builder("商家编号", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getStoreCode(),
                    false).build();
            Param storeName = new Param.Builder("商家名称", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getStoreName(),
                    false).build();
            Param stockShare = new Param.Builder("共享库存", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getStockShare(), false).build();
            Param contact = new Param.Builder("联系人姓名", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getContact(),
                    false).build();
            Param userName = null;
            if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                userName = new Param.Builder("登录帐号", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getUserName(),
                        false).build();
            } else {
                userName = new Param.Builder("登录帐号", Param.ParamType.STR_MOBILE.getType(), storeProfileDto.getUserName(),
                        false).build();
            }
            Param mobile = new Param.Builder("服务热线", Param.ParamType.STR_MOBILE.getType(), storeProfileDto.getMobile(),
                    false).build();
            Param businessHoursBegin = new Param.Builder("开始的配送时间", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getBusinessHoursBegin(), false).build();
            Param businessHoursEnd = new Param.Builder("结束的配送时间", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getBusinessHoursEnd(), false).build();
            Param startSendingPrice = new Param.Builder("免配送费订单金额", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getStartSendingPrice(), false).build();
            Param addSendingPrice = new Param.Builder("增加的配送费", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getAddSendingPrice(), false).build();
            Param provinceCode = new Param.Builder("省份code", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getProvinceCode(), false).build();
            Param cityCode = new Param.Builder("城市code", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getCityCode(),
                    true).build();
            Param countyCode = new Param.Builder("区code", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getCountyCode(), true).build();
            Param addressDetail = new Param.Builder("详细地址", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getAddressDetail(), false).build();
            Param longitude = new Param.Builder("商家所在经度", Param.ParamType.STR_NORMAL.getType(),
                    storeProfileDto.getLongitude(), false).build();
            Param latitude = new Param.Builder("商家所在纬度", Param.ParamType.STR_NORMAL.getType(), storeProfileDto.getLatitude(),
                    false).build();

            super.validateParams(storeType, storeCode, storeName, stockShare, contact, userName, mobile, businessHoursBegin,
                    businessHoursEnd, startSendingPrice, addSendingPrice, provinceCode, cityCode, countyCode, addressDetail,
                    longitude, latitude);
            // 判断storecode唯一性
            StoreProfileDto existDto = storeProfileService.loadByStoreCode(storeProfileDto.getStoreCode());
            if (!ObjectUtils.isNullOrEmpty(existDto)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增商家失败,商家编号已存在!");
            }
            // 判断username唯一性
            if (userService.checkUserNameIsExist(storeProfileDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_SELLER)) {
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增商家失败,登录帐号已存在!");
            }
            // 判断全国性的商家唯一性
            if (CommonConstants.NATION_AREA_CODE_CHINA.equals(storeProfileDto.getProvinceCode())) {
                if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalPartner();
                    if (!ObjectUtils.isNullOrEmpty(spDto)) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增商家失败,全国性的合伙人已存在!");
                    }
                }
                if (SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalExperienceStore();
                    if (!ObjectUtils.isNullOrEmpty(spDto)) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增商家失败,全国性的体验店已存在!");
                    }
                }
                if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                    StoreProfileDto spDto = storeProfileService.loadNationalWarehouse();
                    if (!ObjectUtils.isNullOrEmpty(spDto)) {
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "新增商家失败,全国性的微仓已存在!");
                    }
                }
                storeProfileDto.setCityCode("");
                storeProfileDto.setCountyCode("");
            }
            // 默认开启
            storeProfileDto.setStoreStatus(SystemContext.UserDomain.STORESTATUS_OPEN);
            storeProfileDto.setCreateDate(new Date());
            storeProfileDto.setCreateUserId(super.getUserId());
            storeProfileService.save(storeProfileDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增商家成功");
        } catch (Exception e) {
            logger.error("新增商家失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 开启/关闭 商家
     * 
     * @param id
     *            商家ID
     * @param status
     *            状态
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}-{status}/updateStoreStatus")
    @ResponseBody
    public MsgBean updateStoreStatus(@PathVariable("id") Integer id, @PathVariable("status") Integer status) {
        String showmsg = "";
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取需停用的优惠劵ID");
            }
            // 关闭
            if (!ObjectUtils.isNullOrEmpty(status) && status == 1) {
                storeProfileService.updateStatusById(id, SystemContext.UserDomain.STORESTATUS_CLOSED);
                showmsg += "关闭";
            }
            // 开启
            if (!ObjectUtils.isNullOrEmpty(status) && status == 2) {
                storeProfileService.updateStatusById(id, SystemContext.UserDomain.STORESTATUS_OPEN);
                showmsg += "开启";
            }
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, showmsg + "商家成功");
        } catch (Exception e) {
            logger.error(showmsg + "商家失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取所有可选择关联的小区
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/{id}/listAllOptionalCommunity")
    @ResponseBody
    public MsgBean listAllCommunity(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取商家ID");
            }
            StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(id, null);
            if (null == storeProfileDto || StringUtils.isEmpty(storeProfileDto.getLatitude())
                    || StringUtils.isEmpty(storeProfileDto.getLongitude())) {
                throw new IllegalArgumentException("需关联小区的商家不存在");
            }
            List<CommunityDto> aroundCommunities = communityService.listAroundCommunities(
													            		ArithUtils.converStringToInt(
													            				systemBasicDataInfoUtils.getSystemParamValue(SystemContext.SystemParams.COMMUNITY_STORE_DISTANCE),
													            				COMMUNITY_STORE_DISTANCE_DEFAULT
													            				),
													            		storeProfileDto.getLongitude(), 
													            		storeProfileDto.getLatitude()
													            		);
            List<SimpleCommunityDto> allAssociateCommunityList = communityService.listSimpleCommunityInfoByStoreId(null);
            List<SimpleCommunityDto> storeAssociateCommunityList = communityService.listSimpleCommunityInfoByStoreId(id);
            List<Integer> otherAssociatedCommunityIds = new ArrayList<Integer>();
            if (!ObjectUtils.isNullOrEmpty(allAssociateCommunityList)) {
                if (!ObjectUtils.isNullOrEmpty(storeAssociateCommunityList)) {
                    for (SimpleCommunityDto aDto : allAssociateCommunityList) {
                        boolean isFound = false;
                        for (SimpleCommunityDto sDto : storeAssociateCommunityList) {
                            if (aDto.getCommunityId().intValue() == sDto.getCommunityId().intValue()) {
                                isFound = true;
                                break;
                            }
                        }
                        if (!isFound) {
                            otherAssociatedCommunityIds.add(aDto.getCommunityId());
                        }
                    }
                } else {
                    for (SimpleCommunityDto aDto : allAssociateCommunityList) {
                        otherAssociatedCommunityIds.add(aDto.getCommunityId());
                    }
                }
            }
            List<CommunityDto> allOptionalCommunities = new ArrayList<CommunityDto>();
            if (!ObjectUtils.isNullOrEmpty(aroundCommunities)) {
                if (!ObjectUtils.isNullOrEmpty(otherAssociatedCommunityIds)) {
                    for (CommunityDto communityDto : aroundCommunities) {
                        boolean isFound = false;
                        for (Integer communityId : otherAssociatedCommunityIds) {
                            if (communityDto.getId().intValue() == communityId.intValue()) {
                                isFound = true;
                                break;
                            }
                        }
                        if (!isFound) {
                            allOptionalCommunities.add(communityDto);
                        }
                    }
                } else {
                    allOptionalCommunities = aroundCommunities;
                }
            }
            return super.encapsulateMsgBean(allOptionalCommunities, MsgBean.MsgCode.SUCCESS, "获取所有可选择关联的小区成功");
        } catch (Exception e) {
            logger.error("获取所有可选择关联的小区失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取所有可选择关联的微仓
     * 
     * @param id
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/listAllOptionalWarehouse")
    @ResponseBody
    public MsgBean listAllOptionalWarehouse(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取商家ID");
            }
            StoreProfileDto storeProfileDto = storeProfileService.loadBasicStoreInfo(id, null);
            if (null == storeProfileDto || StringUtils.isEmpty(storeProfileDto.getLatitude())
                    || StringUtils.isEmpty(storeProfileDto.getLongitude())) {
                throw new IllegalArgumentException("需关联微仓的商家不存在");
            }
            List<WarehouseLocationInfoDto> aroundWarehouses = storeProfileService
                    .listAroundWarehouses(
                            ArithUtils.converStringToInt(
                                    systemBasicDataInfoUtils
                                            .getSystemParamValue(SystemContext.SystemParams.STORE_WAREHOUSE_DISTANCE),
                                    STORE_WAREHOUSE_DISTANCE_DEFAULT),
                            storeProfileDto.getLongitude(), storeProfileDto.getLatitude(),
                            SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
            return super.encapsulateMsgBean(aroundWarehouses, MsgBean.MsgCode.SUCCESS, "获取所有可选择关联的微仓成功");
        } catch (Exception e) {
            logger.error("获取所有可选择关联的微仓失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取所有可选择关联的推广门店
     * 
     * @param id
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/listAllOptionalStore")
    @ResponseBody
    public MsgBean listAllOptionalStore(@PathVariable Integer id) {
        try {
            if (null == id) {
                throw new IllegalArgumentException("无法获取商家ID");
            }
            CustomerDto customerDto = customerService.loadCustomerById(id);
            if (null == customerDto) {
                throw new IllegalArgumentException("需关联推广门店的推广人员不存在");
            }
            List<String> storeTypes = new ArrayList<String>();
            storeTypes.add(SystemContext.UserDomain.STORETYPE_PARTNER);
            storeTypes.add(SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE);
            List<StoreProfileDto> storeProfileDtos = storeProfileService.listByStoreTypes(storeTypes);
            return super.encapsulateMsgBean(storeProfileDtos, MsgBean.MsgCode.SUCCESS, "获取所有可选择关联的推广门店成功");
        } catch (Exception e) {
            logger.error("获取所有可选择关联的推广门店失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 保存商家与小区的关联关系
     * 
     * @param storeId
     * @param communityIds
     * @return MsgBean
     */
    @RequestMapping(value = "/{storeId}-{communityIds}/saveStoreCommunityRelations")
    @ResponseBody
    public MsgBean saveStoreCommunityRelations(@PathVariable("storeId") Integer storeId,
            @PathVariable("communityIds") String communityIds) {
        try {
            communityService.saveStoreCommunityRelations(storeId, communityIds);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存商家与小区的关联关系成功");
        } catch (Exception e) {
            logger.error("保存商家与小区的关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 保存合伙人与微仓的关联关系
     * 
     * @param storeId
     * @param communityIds
     * @return MsgBean
     */
    @RequestMapping(value = "/{storeId}-{warehouseId}/saveStoreWarehouseRelations")
    @ResponseBody
    public MsgBean saveStoreWarehouseRelations(@PathVariable("storeId") Integer storeId,
            @PathVariable("warehouseId") Integer warehouseId) {
        try {
            StoreWarehouseDto storeWarehouseDto = new StoreWarehouseDto();
            storeWarehouseDto.setStoreId(storeId);
            storeWarehouseDto.setWarehouseId(warehouseId);
            storeWarehouseDto.setCreateTime(DateUtils.getCurrentDateTime());
            storeWarehouseDto.setCreateUserId(super.getUserId());
            storeWarehouseService.save(storeWarehouseDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存合伙人与微仓的关联关系成功");
        } catch (Exception e) {
            logger.error("保存合伙人与微仓的关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取微仓的基本信息
     * 
     * @param warehouseId
     * @return MsgBean
     */
    @RequestMapping(value = "/{warehouseId}/getWarehouseBasicInfo")
    @ResponseBody
    public MsgBean getWarehouseBasicInfo(@PathVariable("warehouseId") Integer warehouseId) {
        try {
            StoreProfileDto warehouseBasicInfo = storeProfileService.loadBasicStoreInfo(warehouseId, null);
            if (null == warehouseBasicInfo) {
                throw new IllegalArgumentException("该微仓不存在");
            }
            warehouseBasicInfo.setFullAddress(systemBasicDataInfoUtils.getAddressPrefix(warehouseBasicInfo.getProvinceCode(),
                    warehouseBasicInfo.getCityCode(), warehouseBasicInfo.getCountyCode())
                    + warehouseBasicInfo.getAddressDetail());
            return super.encapsulateMsgBean(warehouseBasicInfo, MsgBean.MsgCode.SUCCESS, "获取微仓的基本信息成功");
        } catch (Exception e) {
            logger.error("获取微仓的基本信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 获取微仓所关联门店的信息
     * 
     * @param warehouseId
     * @return MsgBean
     */
    @RequestMapping(value = "/{warehouseId}/listWarehousePartners")
    @ResponseBody
    public MsgBean listWarehousePartners(@PathVariable("warehouseId") Integer warehouseId) {
        try {
            WarehousePartnersQueryDto warehousePartnersQueryDto = new WarehousePartnersQueryDto();
            warehousePartnersQueryDto.setWarehouseId(warehouseId);
            YiLiDiPage<WarehouseAssociatePartnerDto> page = storeWarehouseService
                    .findWarehouseAssociatePartners(warehousePartnersQueryDto);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "获取微仓所关联门店的信息成功");
        } catch (Exception e) {
            logger.error("获取微仓所关联门店的信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 导出商家显示信息列表
     * 
     * @param communityStoreRelatedQuery
     *            查询实体
     * @return MsgBean
     */
    @RequestMapping("/exportSearchStore")
    @ResponseBody
    public MsgBean exportSearchStore(@RequestBody CommunityStoreRelatedQuery communityStoreRelatedQuery) {
        try {
            ReportFileModel reportFileModel = storeReportExport.exportExcel(communityStoreRelatedQuery, "商家报表");
            String jsonString1 = JsonUtils.toJsonStringWithDateFormat(reportFileModel);
            logger.info("--->success :" + jsonString1);
            return super.encapsulateMsgBean(reportFileModel, MsgBean.MsgCode.SUCCESS, "商家报表导出成功");
        } catch (Exception e) {
            logger.error("商家报表导出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(null, MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * 保存推广客户与店铺关联关系
     * 
     * @param recommendCustomerId
     * @param storeId
     * @return MsgBean
     */
    @RequestMapping(value = "/{recommendCustomerId}-{storeId}/saveRecommendCustomerStoreRelations")
    @ResponseBody
    public MsgBean saveRecommendCustomerStoreRelations(@PathVariable("recommendCustomerId") Integer recommendCustomerId,
            @PathVariable("storeId") Integer storeId) {
        try {
            RecommendCustomerStoreDto recommendCustomerStoreDto = new RecommendCustomerStoreDto();
            recommendCustomerStoreDto.setRecommendCustomerId(recommendCustomerId);
            recommendCustomerStoreDto.setStoreId(storeId);
            recommendCustomerStoreDto.setCreateTime(DateUtils.getCurrentDateTime());
            recommendCustomerStoreDto.setCreateUserId(super.getUserId());
            recommendCustomerStoreService.save(recommendCustomerStoreDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "保存推广客户与店铺关联关系成功");
        } catch (Exception e) {
            logger.error("保存推广客户与店铺关联关系失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }
    
    /**
     * 根据小区编码获取该小区关联的店铺列表
     * 
     * @param countyCode
     * @return MsgBean
     */
    @RequestMapping(value = "/{communityCode}/getStoreListByCommunityCode")
    @ResponseBody
    public MsgBean getStoreListByCommunityCode(@PathVariable("communityCode") String communityCode) {
        try {
            List<Map<String, String>> mapList = null;
            if (!StringUtils.isEmpty(communityCode)) {
                List<StoreProfileDto> StoreProfileDtoList = storeProfileService.listStoresByCommunityCode(communityCode);
                if (!ObjectUtils.isNullOrEmpty(StoreProfileDtoList)) {
                    mapList = new ArrayList<Map<String, String>>();
                    for (StoreProfileDto storeProfileDto : StoreProfileDtoList) {
                        Map<String, String> storeInfoMap = new HashMap<String, String>();
                        storeInfoMap.put(CommonConstants.APPOINTED_KEY_ID, Integer.toString(storeProfileDto.getStoreId()));
                        storeInfoMap.put(CommonConstants.APPOINTED_KEY_NAME, storeProfileDto.getStoreName());
                        mapList.add(storeInfoMap);
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
