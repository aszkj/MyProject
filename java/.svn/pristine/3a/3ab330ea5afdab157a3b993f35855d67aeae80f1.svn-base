package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IAreaDictProxyService;
import com.yilidi.o2o.user.dao.CommunityMapper;
import com.yilidi.o2o.user.dao.DistrictStoreMapper;
import com.yilidi.o2o.user.model.Community;
import com.yilidi.o2o.user.model.DistrictStore;
import com.yilidi.o2o.user.model.combination.CommunityLocationInfo;
import com.yilidi.o2o.user.model.combination.CommunityStoreRelatedInfo;
import com.yilidi.o2o.user.model.combination.SimpleCommunityInfo;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.SimpleCommunityDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.CommunityQuery;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

/**
 * 
 * 小区service实现类
 * 
 * @author: heyong
 * @date: 2015年12月4日 下午5:29:17
 * 
 */
@Service("communityService")
public class CommunityServiceImpl extends BasicDataService implements ICommunityService {

    private static final String BUSINESSTYPE_OPEN = "open";
    private static final String BUSINESSTYPE_SPAM = "spam";

    @Autowired
    private CommunityMapper communityMapper;

    @Autowired
    private DistrictStoreMapper districtStoreMapper;

    @Autowired
    private IAreaDictProxyService areaDictProxyService;
    
    @Autowired
    private IProductProxyService productProxyService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IStoreWarehouseService storeWarehouseService;

    @Override
    public List<CommunityDto> listCommunityByName(String distName) throws UserServiceException {
        List<Community> lists = communityMapper.listCommunityByName(distName);
        List<CommunityDto> tempDtos = new ArrayList<CommunityDto>();
        if (!ObjectUtils.isNullOrEmpty(lists)) {
            for (Community dt : lists) {
                CommunityDto dto = new CommunityDto();
                ObjectUtils.copyProperties(dt, dto);
                tempDtos.add(dto);
            }
        }
        return tempDtos;
    }

    @Override
    public void save(CommunityDto communityDto) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(communityDto)) {
            logger.error("communityService.save--->communityDto为空 ");
            throw new UserServiceException("save传入参数communityDto为空 ");
        }
        Community community = new Community();
        ObjectUtils.fastCopy(communityDto, community);
        communityMapper.save(community);
    }

    @Override
    public void update(CommunityDto communityDto) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(communityDto)) {
            logger.error("communityService.update--->communityDto为空 ");
            throw new UserServiceException("update传入参数communityDto为空 ");
        }
        Community community = communityMapper.loadById(communityDto.getId());
        community.setName(communityDto.getName());
        community.setCityCode(communityDto.getCityCode());
        community.setCountyCode(communityDto.getCountyCode());
        community.setProvinceCode(communityDto.getProvinceCode());
        community.setAddressDetail(communityDto.getAddressDetail());
        community.setDisplay(communityDto.getDisplay());
        community.setLongitude(communityDto.getLongitude());
        community.setLatitude(communityDto.getLatitude());
        community.setModifyTime(communityDto.getModifyTime());
        community.setModifyUserId(communityDto.getModifyUserId());
        communityMapper.update(community);
    }

    @Override
    public CommunityDto loadById(Integer id) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(id)) {
            logger.error("communityService.loadById--->id为空 ");
            throw new UserServiceException("loadById传入参数communityDto为空 ");
        }
        Community community = communityMapper.loadById(id);
        if (!ObjectUtils.isNullOrEmpty(community)) {
            CommunityDto communityDto = new CommunityDto();
            ObjectUtils.fastCopy(community, communityDto);
            // 省
            if (!ObjectUtils.isNullOrEmpty(community.getProvinceCode())) {
                communityDto.setProvinceName(super.getAreaName(community.getProvinceCode()));
            }
            // 市、县
            if (!ObjectUtils.isNullOrEmpty(community.getCityCode())) {
                communityDto.setCityName(super.getAreaName(community.getCityCode()));
            }
            // 区、镇
            if (!ObjectUtils.isNullOrEmpty(community.getCountyCode())) {
                communityDto.setCountyName(super.getAreaName(community.getCountyCode()));
            }
            StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(community.getId(), null);
            communityDto.setStoreProfileDto(storeProfileDto);
            return communityDto;
        }
        return new CommunityDto();
    }

    @Override
    public YiLiDiPage<CommunityDto> findCommunitys(CommunityQuery communityQuery) throws UserServiceException {
        try {
            if (null == communityQuery.getStart() || communityQuery.getStart() <= 0) {
                communityQuery.setStart(1);
            }
            if (null == communityQuery.getPageSize() || communityQuery.getPageSize() <= 0) {
                communityQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(communityQuery.getStart(), communityQuery.getPageSize());
            Page<Community> page = communityMapper.findCommunitys(communityQuery);
            Page<CommunityDto> pageDto = new Page<CommunityDto>(communityQuery.getStart(), communityQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<Community> communities = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communities)) {
                for (Community community : communities) {
                    CommunityDto cDto = new CommunityDto();
                    ObjectUtils.fastCopy(community, cDto);
                    // 根据省市区的code去查找对应的名字 传给前台。
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(community.getCityCode())) {
                        cDto.setCityCode(super.getAreaName(community.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(community.getCountyCode())) {
                        cDto.setCountyCode(super.getAreaName(community.getCountyCode()));
                    }
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCommunitys异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStores(CommunityStoreRelatedQuery query)
            throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (!ObjectUtils.isNullOrEmpty(query.getBusinessType())) {
                if (query.getBusinessType().equals(BUSINESSTYPE_OPEN)) {
                    query.setCurrentOpenDate(new Date());
                } else if (query.getBusinessType().equals(BUSINESSTYPE_SPAM)) {
                    query.setCurrentCloseDate(new Date());
                }
            }

            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<CommunityStoreRelatedInfo> page = communityMapper.findCommunityStores(query);
            Page<CommunityStoreRelatedDto> pageDto = new Page<CommunityStoreRelatedDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<CommunityStoreRelatedInfo> communityStoreRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communityStoreRelatedInfos)) {
                for (CommunityStoreRelatedInfo info : communityStoreRelatedInfos) {
                    CommunityStoreRelatedDto cDto = new CommunityStoreRelatedDto();
                    ObjectUtils.fastCopy(info, cDto);
                    if (!ObjectUtils.isNullOrEmpty(info.getStockShare())) {
                        cDto.setStockShareName(super.getSystemDictName(
                                SystemContext.UserDomain.DictType.STORESTOCKSHARE.getValue(), info.getStockShare()));
                    } else {
                        cDto.setStockShare(SystemContext.UserDomain.STORESTOCKSHARE_NO);
                        cDto.setStockShareName(
                                super.getSystemDictName(SystemContext.UserDomain.DictType.STORESTOCKSHARE.getValue(),
                                        SystemContext.UserDomain.STORESTOCKSHARE_NO));
                    }
                    // 根据省市区的code去查找对应的名字 传给前台。
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityCode(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyCode(super.getAreaName(info.getCountyCode()));
                    }
                    // 添加userid，主要用于角色绑定
                    UserDto userDto = userService.loadMainUser(info.getStoreId(),
                            SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                    	cDto.setUserDto(userDto);
                    }
                    // code转成name返回前台显示
                    cDto.setStoreTypeName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            info.getStoreType()));
                    cDto.setStoreStatusName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORESTATUS.getValue(),
                            info.getStoreStatus()));
                    List<SimpleCommunityInfo> simpleCommunityInfoList = districtStoreMapper
                            .listSimpleCommunityInfoByStoreId(info.getStoreId());
                    if (!ObjectUtils.isNullOrEmpty(simpleCommunityInfoList)) {
                        String strCommunityIds = "";
                        for (int i = 0; i < simpleCommunityInfoList.size(); i++) {
                            if (i == simpleCommunityInfoList.size() - 1) {
                                strCommunityIds += simpleCommunityInfoList.get(i).getCommunityId();
                            } else {
                                strCommunityIds += simpleCommunityInfoList.get(i).getCommunityId() + ",";
                            }
                        }
                        cDto.setStrCommunityIds(strCommunityIds);
                    }
                    Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(info.getStoreId());
                    cDto.setWarehouseId(warehouseId);
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCommunityStores异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }
    
    @Override
    public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStoresByProductId(CommunityStoreRelatedQuery query)
            throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (!ObjectUtils.isNullOrEmpty(query.getBusinessType())) {
                if (query.getBusinessType().equals(BUSINESSTYPE_OPEN)) {
                    query.setCurrentOpenDate(new Date());
                } else if (query.getBusinessType().equals(BUSINESSTYPE_SPAM)) {
                    query.setCurrentCloseDate(new Date());
                }
            }
            
            
			List<Integer> storeIds = productProxyService.listStoreIdsByProductId(
					SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
					SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, query.getProductId());
			query.setStoreIds(storeIds);
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<CommunityStoreRelatedInfo> page = communityMapper.findCommunityStores(query);
            Page<CommunityStoreRelatedDto> pageDto = new Page<CommunityStoreRelatedDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<CommunityStoreRelatedInfo> communityStoreRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communityStoreRelatedInfos)) {
                for (CommunityStoreRelatedInfo info : communityStoreRelatedInfos) {
                    CommunityStoreRelatedDto cDto = new CommunityStoreRelatedDto();
                    ObjectUtils.fastCopy(info, cDto);
                    if (!ObjectUtils.isNullOrEmpty(info.getStockShare())) {
                        cDto.setStockShareName(super.getSystemDictName(
                                SystemContext.UserDomain.DictType.STORESTOCKSHARE.getValue(), info.getStockShare()));
                    } else {
                        cDto.setStockShare(SystemContext.UserDomain.STORESTOCKSHARE_NO);
                        cDto.setStockShareName(
                                super.getSystemDictName(SystemContext.UserDomain.DictType.STORESTOCKSHARE.getValue(),
                                        SystemContext.UserDomain.STORESTOCKSHARE_NO));
                    }
                    // 根据省市区的code去查找对应的名字 传给前台。
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityCode(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyCode(super.getAreaName(info.getCountyCode()));
                    }
                    // 添加userid，主要用于角色绑定
                    UserDto userDto = userService.loadMainUser(info.getStoreId(),
                            SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                        cDto.setUserId(userDto.getId());
                        cDto.setUserName(userDto.getUserName());
                    }
                    // code转成name返回前台显示
                    cDto.setStoreTypeName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            info.getStoreType()));
                    cDto.setStoreStatusName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORESTATUS.getValue(),
                            info.getStoreStatus()));
                    List<SimpleCommunityInfo> simpleCommunityInfoList = districtStoreMapper
                            .listSimpleCommunityInfoByStoreId(info.getStoreId());
                    if (!ObjectUtils.isNullOrEmpty(simpleCommunityInfoList)) {
                        String strCommunityIds = "";
                        for (int i = 0; i < simpleCommunityInfoList.size(); i++) {
                            if (i == simpleCommunityInfoList.size() - 1) {
                                strCommunityIds += simpleCommunityInfoList.get(i).getCommunityId();
                            } else {
                                strCommunityIds += simpleCommunityInfoList.get(i).getCommunityId() + ",";
                            }
                        }
                        cDto.setStrCommunityIds(strCommunityIds);
                    }
                    Integer warehouseId = storeWarehouseService.loadWarehouseIdByStoreId(info.getStoreId());
                    cDto.setWarehouseId(warehouseId);
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCommunityStores异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CommunityStoreRelatedDto> findCommunityStoresByCommunityId(CommunityStoreRelatedQuery query)
            throws UserServiceException {
        try {
            if (null == query.getStart() || query.getStart() <= 0) {
                query.setStart(1);
            }
            if (null == query.getPageSize() || query.getPageSize() <= 0) {
                query.setPageSize(CommonConstants.PAGE_SIZE);
            }
            if (!ObjectUtils.isNullOrEmpty(query.getBusinessType())) {
                if (query.getBusinessType().equals(BUSINESSTYPE_OPEN)) {
                    query.setCurrentOpenDate(new Date());
                } else if (query.getBusinessType().equals(BUSINESSTYPE_SPAM)) {
                    query.setCurrentCloseDate(new Date());
                }
            }

            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<CommunityStoreRelatedInfo> page = communityMapper.findCommunityStoresByCommunityId(query);
            Page<CommunityStoreRelatedDto> pageDto = new Page<CommunityStoreRelatedDto>(query.getStart(),
                    query.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<CommunityStoreRelatedInfo> communityStoreRelatedInfos = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communityStoreRelatedInfos)) {
                for (CommunityStoreRelatedInfo info : communityStoreRelatedInfos) {
                    CommunityStoreRelatedDto cDto = new CommunityStoreRelatedDto();
                    ObjectUtils.fastCopy(info, cDto);
                    // 根据省市区的code去查找对应的名字 传给前台。
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityCode(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyCode(super.getAreaName(info.getCountyCode()));
                    }
                    UserDto userDto = userService.loadMainUser(info.getStoreId(),
                            SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                    if (!ObjectUtils.isNullOrEmpty(userDto)) {
                        cDto.setUserId(userDto.getId());
                        cDto.setUserName(userDto.getUserName());
                    }
                    // code转成name返回前台显示
                    cDto.setStoreTypeName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            info.getStoreType()));
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCommunityStoresByCommunityId异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Boolean cancelRelatedById(Integer storeId, Integer communityId) throws UserServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(storeId) && !ObjectUtils.isNullOrEmpty(communityId)) {
                // 删除关联表
                districtStoreMapper.deleteByIds(storeId, communityId);
                Integer count = districtStoreMapper.getCountByCommunityId(communityId);
                Integer storeCount = count != null ? count : 0;
                // 更新小区表的 门店数量
                communityMapper.updateStoreCountById(communityId, storeCount);
                return true;
            }
            return false;
        } catch (Exception e) {
            logger.error("cancelRelatedById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportStore(CommunityStoreRelatedQuery communityStoreRelatedQuery) throws UserServiceException {
        try {
            Long counts = this.communityMapper.getCountsForExportStore(communityStoreRelatedQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportStore异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<CommunityStoreRelatedDto> listDataForExportStore(CommunityStoreRelatedQuery query, Long startLineNum,
            Integer pageSize) throws UserServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(query.getBusinessType())) {
                if (query.getBusinessType().equals(BUSINESSTYPE_OPEN)) {
                    query.setCurrentOpenDate(new Date());
                } else if (query.getBusinessType().equals(BUSINESSTYPE_SPAM)) {
                    query.setCurrentCloseDate(new Date());
                }
            }
            List<CommunityStoreRelatedInfo> communityStoreRelatedInfos = communityMapper.listDataForExportStore(query,
                    startLineNum, pageSize);
            List<CommunityStoreRelatedDto> communityStoreRelatedDtoList = new ArrayList<>();
            if (!ObjectUtils.isNullOrEmpty(communityStoreRelatedInfos)) {
                for (CommunityStoreRelatedInfo info : communityStoreRelatedInfos) {
                    CommunityStoreRelatedDto cDto = new CommunityStoreRelatedDto();
                    ObjectUtils.fastCopy(info, cDto);
                    // 根据省市区的code去查找对应的名字 传给前台。
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityCode(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyCode(super.getAreaName(info.getCountyCode()));
                    }
                    // code转成name返回前台显示
                    cDto.setStoreTypeName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(),
                            info.getStoreType()));
                    cDto.setStoreStatusName(super.getSystemDictName(SystemContext.UserDomain.DictType.STORESTATUS.getValue(),
                            info.getStoreStatus()));
                    communityStoreRelatedDtoList.add(cDto);
                }
            }
            return communityStoreRelatedDtoList;
        } catch (Exception e) {
            logger.error("listDataForExportStore异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CommunityDto> listCommunitys(CommunityQuery communityQuery) throws UserServiceException {
        try {
            if (null == communityQuery.getStart() || communityQuery.getStart() <= 0) {
                communityQuery.setStart(1);
            }
            if (null == communityQuery.getPageSize() || communityQuery.getPageSize() <= 0) {
                communityQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(communityQuery.getStart(), communityQuery.getPageSize());
            Page<Community> page = communityMapper.findCommunitysPage(communityQuery);
            Page<CommunityDto> pageDto = new Page<CommunityDto>(communityQuery.getStart(), communityQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<Community> communities = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communities)) {
                for (Community community : communities) {
                    CommunityDto cDto = new CommunityDto();
                    ObjectUtils.fastCopy(community, cDto);
                    // 省
                    if (!ObjectUtils.isNullOrEmpty(community.getProvinceCode())) {
                        cDto.setProvinceName(super.getAreaName(community.getProvinceCode()));
                    }
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(community.getCityCode())) {
                        cDto.setCityName(super.getAreaName(community.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(community.getCountyCode())) {
                        cDto.setCountyName(super.getAreaName(community.getCountyCode()));
                    }
                    StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(community.getId(), null);
                    cDto.setStoreProfileDto(storeProfileDto);
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("listCommunitys异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public CommunityDto getLocation(String longitude, String latitude, Integer distance) throws UserServiceException {
        if (ObjectUtils.isNullOrEmpty(longitude)) {
            logger.error("经度为空");
            return null;
        }
        if (ObjectUtils.isNullOrEmpty(latitude)) {
            logger.error("纬度为空");
            return null;
        }
        if (ObjectUtils.isNullOrEmpty(distance)) {
            logger.error("距离为空");
            return null;
        }
        CommunityLocationInfo communityLocationInfo = communityMapper.findNearestCommunity(longitude, latitude, distance);
        if (!ObjectUtils.isNullOrEmpty(communityLocationInfo)) {
            CommunityDto communityDto = new CommunityDto();
            ObjectUtils.fastCopy(communityLocationInfo, communityDto);
            // 省
            if (!ObjectUtils.isNullOrEmpty(communityLocationInfo.getProvinceCode())) {
                communityDto.setProvinceName(super.getAreaName(communityLocationInfo.getProvinceCode()));
            }
            // 市、县
            if (!ObjectUtils.isNullOrEmpty(communityLocationInfo.getCityCode())) {
                communityDto.setCityName(super.getAreaName(communityLocationInfo.getCityCode()));
            }
            // 区、镇
            if (!ObjectUtils.isNullOrEmpty(communityLocationInfo.getCountyCode())) {
                communityDto.setCountyName(super.getAreaName(communityLocationInfo.getCountyCode()));
            }
            StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(communityDto.getId(), null);
            communityDto.setStoreProfileDto(storeProfileDto);
            return communityDto;
        }
        return null;
    }

    @Override
    public YiLiDiPage<CommunityDto> findAroundCommunityList(CommunityQuery communityQuery, String longitude, String latitude)
            throws UserServiceException {
        try {
            if (null == communityQuery.getStart() || communityQuery.getStart() <= 0) {
                communityQuery.setStart(1);
            }
            if (null == communityQuery.getPageSize() || communityQuery.getPageSize() <= 0) {
                communityQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }

            PageHelper.startPage(communityQuery.getStart(), communityQuery.getPageSize());
            Page<CommunityLocationInfo> page = communityMapper.findAroundCommunityList(communityQuery, longitude, latitude);
            Page<CommunityDto> pageDto = new Page<CommunityDto>(communityQuery.getStart(), communityQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<CommunityLocationInfo> communityLocationInfo = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(communityLocationInfo)) {
                for (CommunityLocationInfo info : communityLocationInfo) {
                    CommunityDto cDto = new CommunityDto();
                    ObjectUtils.fastCopy(info, cDto);
                    // 省
                    if (!ObjectUtils.isNullOrEmpty(info.getProvinceCode())) {
                        cDto.setProvinceName(super.getAreaName(info.getProvinceCode()));
                    }
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityName(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyName(super.getAreaName(info.getCountyCode()));
                    }
                    StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(info.getId(),
                            SystemContext.UserDomain.STORESTATUS_OPEN);
                    cDto.setStoreProfileDto(storeProfileDto);
                    pageDto.add(cDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCommunityStoresByCommunityId异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<CommunityDto> listAroundCommunities(Integer distance, String longitude, String latitude)
            throws UserServiceException {
        try {
            List<CommunityLocationInfo> communityLocationInfoList = communityMapper.listAroundCommunities(distance,
                    longitude, latitude);
            List<CommunityDto> communityDtoList = new ArrayList<CommunityDto>();
            if (!ObjectUtils.isNullOrEmpty(communityLocationInfoList)) {
                for (CommunityLocationInfo info : communityLocationInfoList) {
                    CommunityDto cDto = new CommunityDto();
                    ObjectUtils.fastCopy(info, cDto);
                    // 省
                    if (!ObjectUtils.isNullOrEmpty(info.getProvinceCode())) {
                        cDto.setProvinceName(super.getAreaName(info.getProvinceCode()));
                    }
                    // 市、县
                    if (!ObjectUtils.isNullOrEmpty(info.getCityCode())) {
                        cDto.setCityName(super.getAreaName(info.getCityCode()));
                    }
                    // 区、镇
                    if (!ObjectUtils.isNullOrEmpty(info.getCountyCode())) {
                        cDto.setCountyName(super.getAreaName(info.getCountyCode()));
                    }
                    StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(info.getId(),
                            SystemContext.UserDomain.STORESTATUS_OPEN);
                    cDto.setStoreProfileDto(storeProfileDto);
                    communityDtoList.add(cDto);
                }
            }
            return communityDtoList;
        } catch (Exception e) {
            String msg = "根据经度和纬度定位到指定距离范围内小区列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<SimpleCommunityDto> listSimpleCommunityInfoByStoreId(Integer storeId) throws UserServiceException {
        try {
            List<SimpleCommunityInfo> simpleCommunityInfoList = districtStoreMapper
                    .listSimpleCommunityInfoByStoreId(storeId);
            List<SimpleCommunityDto> simpleCommunityDtoList = new ArrayList<SimpleCommunityDto>();
            if (!ObjectUtils.isNullOrEmpty(simpleCommunityInfoList)) {
                for (SimpleCommunityInfo info : simpleCommunityInfoList) {
                    SimpleCommunityDto cDto = new SimpleCommunityDto();
                    ObjectUtils.fastCopy(info, cDto);
                    simpleCommunityDtoList.add(cDto);
                }
            }
            return simpleCommunityDtoList;
        } catch (Exception e) {
            String msg = "根据商家ID获取其关联的小区列表信息出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public void saveStoreCommunityRelations(Integer storeId, String communityIds) throws UserServiceException {
        try {
            if (null == storeId) {
                throw new IllegalArgumentException("参数storeId为空");
            }
            List<SimpleCommunityInfo> simpleCommunityInfoList = districtStoreMapper
                    .listSimpleCommunityInfoByStoreId(storeId);
            if (!ObjectUtils.isNullOrEmpty(simpleCommunityInfoList)) {
                for (SimpleCommunityInfo simpleCommunityInfo : simpleCommunityInfoList) {
                    communityMapper.updateStoreCountById(simpleCommunityInfo.getCommunityId(), 0);
                }
            }
            districtStoreMapper.deleteByStoreId(storeId);
            if (!StringUtils.isEmpty(communityIds)) {
                if (!communityIds.contains(",")) {
                    DistrictStore districtStore = new DistrictStore();
                    districtStore.setStoreId(storeId);
                    districtStore.setCommunityId(Integer.parseInt(communityIds));
                    districtStoreMapper.save(districtStore);
                    communityMapper.updateStoreCountById(Integer.parseInt(communityIds), 1);
                } else {
                    StringTokenizer st = new StringTokenizer(communityIds, ",");
                    while (st.hasMoreTokens()) {
                        Integer communityId = Integer.parseInt(st.nextToken());
                        DistrictStore districtStore = new DistrictStore();
                        districtStore.setStoreId(storeId);
                        districtStore.setCommunityId(communityId);
                        districtStoreMapper.save(districtStore);
                        communityMapper.updateStoreCountById(communityId, 1);
                    }
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "保存商家与小区的关联关系出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<CommunityDto> listCommunitiesByCountyCode(String countyCode) throws UserServiceException {
        try {
            List<Community> lists = communityMapper.listCommunitiesByCountyCode(countyCode);
            List<CommunityDto> tempDtos = new ArrayList<CommunityDto>();
            if (!ObjectUtils.isNullOrEmpty(lists)) {
                for (Community dt : lists) {
                    CommunityDto dto = new CommunityDto();
                    ObjectUtils.copyProperties(dt, dto);
                    tempDtos.add(dto);
                }
            }
            return tempDtos;
        } catch (Exception e) {
            String msg = "根据区县编码获取该区县范围内的小区列表出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
