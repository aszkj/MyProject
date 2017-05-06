package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.CommunityMapper;
import com.yilidi.o2o.user.dao.DistrictStoreMapper;
import com.yilidi.o2o.user.dao.StoreProfileMapper;
import com.yilidi.o2o.user.dao.StoreWarehouseMapper;
import com.yilidi.o2o.user.model.Community;
import com.yilidi.o2o.user.model.StoreProfile;
import com.yilidi.o2o.user.model.combination.SimpleCommunityInfo;
import com.yilidi.o2o.user.model.combination.StoreLocationInfo;
import com.yilidi.o2o.user.model.combination.WarehouseLocationInfo;
import com.yilidi.o2o.user.model.query.StoreLocationQuery;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.SynUserInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;
import com.yilidi.o2o.user.service.dto.WarehouseLocationInfoDto;
import com.yilidi.o2o.user.service.dto.query.StoreLocationQueryDto;

/**
 * 
 * 门店管理服务service
 * 
 * @author: heyong
 * @date: 2015年12月4日 下午3:39:14
 * 
 */
@Service("storeProfileService")
public class StoreProfileServiceImpl extends BasicDataService implements IStoreProfileService {

    /**
     * 邀请码分布式锁Key
     */
    private static final String INVITATION_CODE_LOCK_KEY = "INVITATION_CODE_LOCK_KEY";

    /**
     * 邀请码Redis缓存Key
     */
    private static final String INVITATION_CODE_CACHE_KEY = "INVITATION_CODE_CACHE_KEY";

    /**
     * 生成邀请码超时时间，单位秒
     */
    private static int INVITATION_CODE_CREATE_TIMEOUT = 3;

    /** 定位店铺默认距离范围 **/
    private static final Integer STORE_LOCATION_DISTANCE_RANGE_DEFAULT = 3000;

    @Autowired
    private ICustomerService customerService;

    @Autowired
    private IUserService userService;

    @Autowired
    private StoreProfileMapper storeProfileMapper;

    @Autowired
    private DistrictStoreMapper districtStoreMapper;

    @Autowired
    private CommunityMapper communityMapper;
    @Autowired
    private StoreWarehouseMapper storeWarehouseMapper;

    @Override
    public void save(StoreProfileDto storeProfileDto) throws UserServiceException {
        // Jedis jedis = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                logger.error("storeProfileService.save-->storeProfileDto为空");
                throw new UserServiceException("storeProfileDto为空");
            }
            // 新增Customer USER
            CustomerDto customerDto = new CustomerDto();
            // 客户类型 为卖家
            customerDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            customerDto.setSellerLevelCode(SystemContext.UserDomain.SELLERLEVEL_A);
            customerDto.setCustomerName(storeProfileDto.getStoreName());
            // 当前用户ID
            customerDto.setCreateUserId(storeProfileDto.getCreateUserId());
            customerDto.setCreateTime(storeProfileDto.getCreateDate());
            customerDto.setTelPhone(storeProfileDto.getMobile());
            UserDto uDto = new UserDto();
            uDto.setUserName(storeProfileDto.getUserName());
            uDto.setPhone(storeProfileDto.getMobile());
            // 默认密码 888888
            uDto.setPassword(EncryptUtils.md5Crypt("888888").toUpperCase());
            uDto.setRealName(storeProfileDto.getContact());
            // 主账号
            uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
            // 默认已启用
            uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
            // 默认已审核通过
            uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
            // 当前用户ID
            uDto.setCreateUserId(storeProfileDto.getCreateUserId());
            uDto.setCreateTime(storeProfileDto.getCreateDate());
            UserProfileDto userProfileDto = new UserProfileDto();
            uDto.setUserProfileDto(userProfileDto);
            customerDto.setMasterUserDto(uDto);
            String invitationCode = null;
            if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileDto.getStoreType())
                    || SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE.equals(storeProfileDto.getStoreType())
                    || SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                // 生成唯一的邀请码
                CustomerDto cto = customerService.loadByInvitationCode(storeProfileDto.getStoreCode().substring(2));
                if (null != cto) {
                    String msg = "邀请码重复，请仔细检查商家编号后面的数字是否重复！";
                    logger.error(msg);
                    throw new UserServiceException(msg);
                }
                invitationCode = storeProfileDto.getStoreCode().substring(2);
            }
            customerDto.setInvitationCode(invitationCode);
            // 执行插入操作,获得customerId
            Integer cuId = customerService.saveCustomer(customerDto);

            StoreProfile storeProfile = new StoreProfile();
            ObjectUtils.fastCopy(storeProfileDto, storeProfile);
            storeProfile.setStoreId(cuId);
            storeProfileMapper.save(storeProfile);

            String communityIdString = storeProfileDto.getCommunityIdString();
            List<Integer> communityIds = null;
            if (!ObjectUtils.isNullOrEmpty(communityIdString)) {
                communityIds = new ArrayList<Integer>();
                List<String> list = Arrays.asList(communityIdString.split(","));
                for (String a : list) {
                    communityIds.add(Integer.valueOf(a));
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "保存商家信息出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    // private String createInvitationCode(Integer cuId) {
    // Jedis jedis = null;
    // try {
    // DistributedLockUtils.lock(INVITATION_CODE_LOCK_KEY, 3, 5, TimeUnit.SECONDS);
    // jedis = JedisUtils.getJedis();
    // long currentTimeMillis = System.currentTimeMillis();
    // String invitationCode = null;
    // while ((System.currentTimeMillis() - currentTimeMillis) < INVITATION_CODE_CREATE_TIMEOUT * 1000) {
    // String randomString = StringUtils.randomString(6);
    // if (!jedis.exists(INVITATION_CODE_CACHE_KEY)) {
    // CustomerDto cto = customerService.loadByInvitationCode(randomString.toUpperCase());
    // if (null != cto) {
    // continue;
    // }
    // List<StoreProfile> storeProfileList = storeProfileMapper.listStoreProfiles();
    // if (!ObjectUtils.isNullOrEmpty(storeProfileList)) {
    // for (StoreProfile profile : storeProfileList) {
    // if (!StringUtils.isEmpty(profile.getInvitationCode())) {
    // jedis.hset(INVITATION_CODE_CACHE_KEY, profile.getInvitationCode(),
    // Integer.toString(profile.getStoreId()));
    // }
    // }
    // }
    // jedis.hset(INVITATION_CODE_CACHE_KEY, randomString, Integer.toString(cuId));
    // invitationCode = randomString;
    // break;
    // } else {
    // if (jedis.hexists(INVITATION_CODE_CACHE_KEY, randomString)) {
    // continue;
    // }
    // jedis.hset(INVITATION_CODE_CACHE_KEY, randomString, Integer.toString(cuId));
    // invitationCode = randomString;
    // break;
    // }
    // }
    // if (StringUtils.isEmpty(invitationCode)) {
    // String msg = "生成邀请码超时";
    // logger.error(msg);
    // throw new UserServiceException(msg);
    // }
    // return invitationCode;
    // } catch (Exception e) {
    // String msg = "生成邀请码出现系统异常";
    // logger.error(msg, e);
    // throw new UserServiceException(msg);
    // } finally {
    // if (null != jedis) {
    // JedisUtils.returnResource(jedis);
    // }
    // DistributedLockUtils.unlock();
    // }
    // }

    @Override
    public void update(StoreProfileDto storeProfileDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                logger.error("storeProfileService.update-->storeProfileDto为空");
                throw new UserServiceException("查询条件storeProfileDto为空");
            }
            StoreProfile storeProfile = storeProfileMapper.loadById(storeProfileDto.getId());
            if (ObjectUtils.isNullOrEmpty(storeProfile)) {
                throw new UserServiceException("该店铺不存在");
            }
            if (SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE.equals(storeProfileDto.getStoreType())) {
                // 共享库存为空修改微仓不共享库存
                if (ObjectUtils.isNullOrEmpty(storeProfileDto.getStockShare())) {
                    storeProfileDto.setStockShare(SystemContext.UserDomain.STORESTOCKSHARE_NO);
                }
                if (SystemContext.UserDomain.STORESTOCKSHARE_NO.equals(storeProfileDto.getStockShare())) {
                    // 修改关联店铺是否共享状态
                    List<Integer> storeIdList = storeWarehouseMapper.listStoreIdsByWarehouseId(storeProfile.getStoreId());
                    if (!ObjectUtils.isNullOrEmpty(storeIdList)) {
                        for (Integer storeId : storeIdList) {
                            storeProfileMapper.updateStockShareByStoreId(storeId, storeProfileDto.getStockShare());
                        }
                    }
                }
            } else {
                Integer warehouseId = storeWarehouseMapper.loadWarehouseIdByStoreId(storeProfile.getStoreId());
                if (!ObjectUtils.isNullOrEmpty(warehouseId)) {
                    StoreProfile warehouseProfile = storeProfileMapper.loadByStoreId(warehouseId, null);
                    if (!ObjectUtils.isNullOrEmpty(warehouseProfile)
                            && !SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(warehouseProfile.getStockShare())) {
                        if (SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileDto.getStockShare())) {
                            throw new UserServiceException("该店铺关联的微仓是不共享库存,店铺不能设置库存为共享");
                        }
                    }
                }
            }
            storeProfile.setStockShare(storeProfileDto.getStockShare());
            storeProfile.setStoreName(storeProfileDto.getStoreName());
            storeProfile.setProvinceCode(storeProfileDto.getProvinceCode());
            storeProfile.setCityCode(storeProfileDto.getCityCode());
            storeProfile.setCountyCode(storeProfileDto.getCountyCode());
            storeProfile.setAddressDetail(storeProfileDto.getAddressDetail());
            storeProfile.setContact(storeProfileDto.getContact());
            storeProfile.setMobile(storeProfileDto.getMobile());
            storeProfile.setBusinessHoursBegin(storeProfileDto.getBusinessHoursBegin());
            storeProfile.setBusinessHoursEnd(storeProfileDto.getBusinessHoursEnd());
            storeProfile.setAddSendingPrice(storeProfileDto.getAddSendingPrice());
            storeProfile.setStartSendingPrice(storeProfileDto.getStartSendingPrice());
            storeProfile.setLongitude(storeProfileDto.getLongitude());
            storeProfile.setLatitude(storeProfileDto.getLatitude());
            storeProfileMapper.update(storeProfile);
            UserDto userDto = userService.loadMainUser(storeProfile.getStoreId(),
                    SystemContext.UserDomain.USERMASTERFLAG_MAIN);
            CustomerDto customerDto = customerService.loadCustomerById(storeProfile.getStoreId());
            if (null != userDto) {
                if (!userDto.getUserName().equals(storeProfileDto.getUserName())) {
                    UserDto uDto = new UserDto();
                    uDto.setId(userDto.getId());
                    uDto.setUserName(storeProfileDto.getUserName());
                    uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
                    uDto.setModifyUserId(storeProfileDto.getModifyUserId());
                    uDto.setModifyTime(storeProfileDto.getModifyDate());
                    userService.updateUserForUserName(uDto);
                }
                // 同步用户信息
                SynUserInfoDto synUserInfoDto = new SynUserInfoDto();
                synUserInfoDto.setUserName(storeProfileDto.getUserName());
                synUserInfoDto.setCustomerName(storeProfileDto.getStoreName());
                synUserInfoDto.setUserMobile(userDto.getPhone());
                synUserInfoDto.setCustomerMobile(storeProfileDto.getMobile());
                synUserInfoDto.setRealName(userDto.getRealName());
                synUserInfoDto.setInvitationCode(customerDto.getInvitationCode());
                synUserInfoDto.setUserId(userDto.getId());
                userService.sendUpdateSynUserInfoMessage(synUserInfoDto);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public StoreProfileDto loadById(Integer id) throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        if (!ObjectUtils.isNullOrEmpty(id)) {
            StoreProfile storeProfile = storeProfileMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                UserDto userDto = userService.loadMainUser(storeProfile.getStoreId(),
                        SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                if (null != userDto) {
                    storeProfileDto.setUserName(userDto.getUserName());
                }
                // 根据门店ID查出配送的小区名称列表
                Integer storeId = storeProfile.getId();
                List<SimpleCommunityInfo> list = districtStoreMapper.listSimpleCommunityInfoByStoreId(storeId);
                List<Integer> ids = null;
                List<String> names = null;
                if (!ObjectUtils.isNullOrEmpty(list)) {
                    ids = new ArrayList<Integer>();
                    names = new ArrayList<String>();
                    for (SimpleCommunityInfo info : list) {
                        names.add(info.getCommunityName());
                        ids.add(info.getCommunityId());
                    }
                }
                storeProfileDto.setCommunityIds(ids);
                storeProfileDto.setCommunityNames(names);
            }
        }
        return storeProfileDto;
    }

    @Override
    public void updateStatusById(Integer id, String storeStatus) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                logger.error("storeProfileService.updateStatusById-->id为空");
                throw new UserServiceException("查询条件ID为空");
            }
            storeProfileMapper.updateStatusById(id, storeStatus);
        } catch (Exception e) {
            String msg = "修改商家状态出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public void updateStockShareByStoreId(Integer storeId, String stockShare) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("storeProfileService.updateStockShareByStoreId-->id为空");
                throw new UserServiceException("查询条件ID为空");
            }
            storeProfileMapper.updateStockShareByStoreId(storeId, stockShare);
        } catch (Exception e) {
            String msg = "修改商家共享库存状态出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public StoreProfileDto loadByStoreCode(String storeCode) throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        if (!ObjectUtils.isNullOrEmpty(storeCode)) {
            StoreProfile storeProfile = storeProfileMapper.loadByStoreCode(storeCode);
            if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
            }
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadNationalPartner() throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        StoreProfile storeProfile = storeProfileMapper.loadNationalStore(SystemContext.UserDomain.STORETYPE_PARTNER,
                CommonConstants.NATION_AREA_CODE_CHINA);
        if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
            storeProfileDto = new StoreProfileDto();
            ObjectUtils.fastCopy(storeProfile, storeProfileDto);
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadNationalExperienceStore() throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        StoreProfile storeProfile = storeProfileMapper.loadNationalStore(SystemContext.UserDomain.STORETYPE_EXPERIENCE_STORE,
                CommonConstants.NATION_AREA_CODE_CHINA);
        if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
            storeProfileDto = new StoreProfileDto();
            ObjectUtils.fastCopy(storeProfile, storeProfileDto);
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadNationalWarehouse() throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        StoreProfile storeProfile = storeProfileMapper.loadNationalStore(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE,
                CommonConstants.NATION_AREA_CODE_CHINA);
        if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
            storeProfileDto = new StoreProfileDto();
            ObjectUtils.fastCopy(storeProfile, storeProfileDto);
        }
        return storeProfileDto;
    }

    @Override
    public List<StoreProfileDto> listStoreProfile(String storeStatus) throws UserServiceException {
        List<StoreProfile> listStoreProfileDto = storeProfileMapper.getStoreProfile(storeStatus);
        List<StoreProfileDto> dtoLists = null;
        if (!ObjectUtils.isNullOrEmpty(listStoreProfileDto)) {
            dtoLists = new ArrayList<StoreProfileDto>();
            for (StoreProfile storeProfile : listStoreProfileDto) {
                StoreProfileDto storeProfileDto = null;
                if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                    storeProfileDto = new StoreProfileDto();
                    ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                    dtoLists.add(storeProfileDto);
                }
            }
        }
        return dtoLists;
    }

    @Override
    public StoreProfileDto loadByStoreId(Integer storeId, String storeStatus) throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        if (!ObjectUtils.isNullOrEmpty(storeId)) {
            StoreProfile storeProfile = storeProfileMapper.loadByStoreId(storeId, storeStatus);
            if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                // 根据门店ID查出配送的小区名称列表
                List<SimpleCommunityInfo> list = districtStoreMapper.listSimpleCommunityInfoByStoreId(storeId);
                List<Integer> ids = null;
                List<String> names = null;
                if (!ObjectUtils.isNullOrEmpty(list)) {
                    ids = new ArrayList<Integer>();
                    names = new ArrayList<String>();
                    for (SimpleCommunityInfo info : list) {
                        names.add(info.getCommunityName());
                        ids.add(info.getCommunityId());
                    }
                }
                storeProfileDto.setCommunityIds(ids);
                storeProfileDto.setCommunityNames(names);
            }
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadByCommunityId(Integer communityId, String storeStatus) throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        if (null != communityId) {
            StoreProfile storeProfile = storeProfileMapper.loadByCommunityId(communityId, storeStatus);
            if (storeProfile != null) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                // 查询小区
                Community community = communityMapper.loadById(communityId);
                CommunityDto communityDto = new CommunityDto();
                ObjectUtils.fastCopy(community, communityDto);
                storeProfileDto.setCommunityDto(communityDto);
            }
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadNearestStoreProfileByLngAndLat(String longitude, String latitude)
            throws UserServiceException {
        StoreProfile storeProfile = storeProfileMapper.loadNearestStoreProfileByLngAndLat(longitude, latitude);
        StoreProfileDto storeProfileDto = null;
        if (null != storeProfile) {
            storeProfileDto = new StoreProfileDto();
            ObjectUtils.fastCopy(storeProfile, storeProfileDto);
        }
        return storeProfileDto;
    }

    @Override
    public StoreProfileDto loadBasicStoreInfo(Integer storeId, String storeStatus) throws UserServiceException {
        StoreProfileDto storeProfileDto = null;
        if (!ObjectUtils.isNullOrEmpty(storeId)) {
            StoreProfile storeProfile = storeProfileMapper.loadByStoreId(storeId, storeStatus);
            if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
            }
        }
        return storeProfileDto;
    }

    @Override
    public void updateStoreDetailsForSeller(StoreProfileDto storeProfileDto) throws UserServiceException {
        try {
            StoreProfile storeProfile = new StoreProfile();
            ObjectUtils.fastCopy(storeProfileDto, storeProfile);
            storeProfileMapper.updateStoreDetailsForSeller(storeProfile);
        } catch (Exception e) {
            String msg = "修改店铺详细信息出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<WarehouseLocationInfoDto> listAroundWarehouses(Integer distance, String longitude, String latitude,
            String storeType) throws UserServiceException {
        try {
            List<WarehouseLocationInfo> warehouseLocationInfoList = storeProfileMapper.listAroundWarehouses(distance,
                    longitude, latitude, storeType);
            List<WarehouseLocationInfoDto> warehouseLocationInfoDtoList = new ArrayList<WarehouseLocationInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(warehouseLocationInfoList)) {
                for (WarehouseLocationInfo info : warehouseLocationInfoList) {
                    WarehouseLocationInfoDto warehouseLocationInfoDto = new WarehouseLocationInfoDto();
                    ObjectUtils.fastCopy(info, warehouseLocationInfoDto);
                    warehouseLocationInfoDtoList.add(warehouseLocationInfoDto);
                }
            }
            return warehouseLocationInfoDtoList;
        } catch (Exception e) {
            String msg = "根据经度和纬度定位到指定距离范围内微仓列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<StoreProfileDto> listByStoreTypes(List<String> storeTypes) throws UserServiceException {
        try {
            List<StoreProfile> storeProfileList = storeProfileMapper.listByStoreTypes(storeTypes);
            List<StoreProfileDto> storeProfileDtoList = new ArrayList<StoreProfileDto>();
            if (!ObjectUtils.isNullOrEmpty(storeProfileList)) {
                for (StoreProfile info : storeProfileList) {
                    StoreProfileDto storeProfileDto = new StoreProfileDto();
                    ObjectUtils.fastCopy(info, storeProfileDto);
                    storeProfileDtoList.add(storeProfileDto);
                }
            }
            return storeProfileDtoList;
        } catch (Exception e) {
            String msg = "根据若干店铺类型查询店铺列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<StoreProfileDto> listStoreProfileByStoreIds(List<Integer> storeIds) throws UserServiceException {
        try {
            List<StoreProfile> storeProfileList = storeProfileMapper.listStoreProfileByStoreIds(storeIds);
            List<StoreProfileDto> storeProfileDtoList = new ArrayList<StoreProfileDto>();
            if (!ObjectUtils.isNullOrEmpty(storeProfileList)) {
                for (StoreProfile info : storeProfileList) {
                    StoreProfileDto storeProfileDto = new StoreProfileDto();
                    ObjectUtils.fastCopy(info, storeProfileDto);
                    storeProfileDtoList.add(storeProfileDto);
                }
            }
            return storeProfileDtoList;
        } catch (Exception e) {
            String msg = "根据若干店铺ID获取店铺信息列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<StoreProfileDto> listAroundStores(StoreLocationQueryDto storeLocationQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeLocationQueryDto)
                    || ObjectUtils.isNullOrEmpty(storeLocationQueryDto.getLatitude())
                    || ObjectUtils.isNullOrEmpty(storeLocationQueryDto.getLongitude())) {
                logger.info("定位需要的参数为空");
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(storeLocationQueryDto.getDistance())) {
                Integer distance = ArithUtils.converStringToInt(
                        super.getSystemParamValue(SystemContext.SystemParams.U_STORE_LOCATION_DISTANCE_RANGE),
                        STORE_LOCATION_DISTANCE_RANGE_DEFAULT);
                storeLocationQueryDto.setDistance(distance);
            }
            StoreLocationQuery storeLocationQuery = new StoreLocationQuery();
            ObjectUtils.fastCopy(storeLocationQueryDto, storeLocationQuery);
            List<StoreLocationInfo> storeLocationInfos = storeProfileMapper.listAroundStores(storeLocationQuery);
            List<StoreProfileDto> storeProfileDtos = new ArrayList<StoreProfileDto>();
            if (ObjectUtils.isNullOrEmpty(storeLocationInfos)) {
                return storeProfileDtos;
            }
            for (StoreLocationInfo storeLocationInfo : storeLocationInfos) {
                StoreProfileDto storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeLocationInfo, storeProfileDto);
                storeProfileDtos.add(storeProfileDto);
            }
            return storeProfileDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

	@Override
	public List<StoreProfileDto> listStoreByName(String storeName) throws UserServiceException {
		List<StoreProfileDto> storeProfileDtos = new ArrayList<StoreProfileDto>();
        if (!StringUtils.isEmpty(storeName)) {
        	List<StoreProfile> storeProfiles = storeProfileMapper.listByStoreName(storeName);
            if (!ObjectUtils.isNullOrEmpty(storeProfiles)) {
            	for(StoreProfile storeProfile:storeProfiles){
            		StoreProfileDto storeProfileDto = new StoreProfileDto();
                    ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                    storeProfileDtos.add(storeProfileDto);
            	}
            	
            }
        }
        return storeProfileDtos;
	}
	
	@Override
	public List<StoreProfileDto> listStoresByCommunityCode(String communityCode) throws UserServiceException {
        List<Integer> storeIdList = districtStoreMapper.listStoreIdsByCommunityCode(Integer.valueOf(communityCode));
        List<StoreProfileDto> listStores = new ArrayList<StoreProfileDto>();
        if (!ObjectUtils.isNullOrEmpty(storeIdList)) {
        	listStores = listStoreProfileByStoreIds(storeIdList);
        }
		return listStores;
	}

    @Override
    public StoreProfileDto loadByStoreId(Integer storeId) {
        StoreProfileDto storeProfileDto = null;
        if (!ObjectUtils.isNullOrEmpty(storeId)) {
            StoreProfile storeProfile = storeProfileMapper.loadByStoreId(storeId, null);
            if (!ObjectUtils.isNullOrEmpty(storeProfile)) {
                storeProfileDto = new StoreProfileDto();
                ObjectUtils.fastCopy(storeProfile, storeProfileDto);
                UserDto userDto = userService.loadMainUser(storeProfile.getStoreId(),
                        SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                if (null != userDto) {
                    storeProfileDto.setUserName(userDto.getUserName());
                }
            }
        }

        return storeProfileDto;
    }

    @Override
    public void updateStoreScoreByStoreId(Integer storeId,Float storeScore) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                logger.error("storeProfileService.updateStoreScoreByStoreId-->storeId为空");
                throw new UserServiceException("更新条件storeId为空");
            }
            storeProfileMapper.updateStoreScoreByStoreId(storeId, storeScore);
        } catch (Exception e) {
            String msg = "修改商家评价得分出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
