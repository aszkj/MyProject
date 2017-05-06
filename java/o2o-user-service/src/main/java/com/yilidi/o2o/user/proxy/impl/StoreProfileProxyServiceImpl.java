package com.yilidi.o2o.user.proxy.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreProfileMapper;
import com.yilidi.o2o.user.model.StoreProfile;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 功能描述：小区Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("storeProfileProxyService")
public class StoreProfileProxyServiceImpl extends BasicDataService implements IStoreProfileProxyService {

    @Autowired
    private IStoreProfileService storeProfileService;
    @Autowired
    private StoreProfileMapper storeProfileMapper;

    @Override
    public StoreProfileProxyDto loadByCommunityId(Integer communityId, String storeStatus) throws UserServiceException {
        try {
            StoreProfileProxyDto storeProfileProxyDto = null;
            StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(communityId, storeStatus);
            if (null != storeProfileDto) {
                storeProfileProxyDto = new StoreProfileProxyDto();
                ObjectUtils.fastCopy(storeProfileDto, storeProfileProxyDto);
                if (!ObjectUtils.isNullOrEmpty(storeProfileDto.getCommunityDto())) {
                    storeProfileProxyDto.setCommunityName(storeProfileDto.getCommunityDto().getName());
                }
            }
            return storeProfileProxyDto;
        } catch (Exception e) {
            logger.error("根据小区查找店铺错误", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public StoreProfileProxyDto loadNearestStoreProfileByLngAndLat(String longitude, String latitude)
            throws UserServiceException {
        try {
            StoreProfileDto storeProfileDto = storeProfileService.loadNearestStoreProfileByLngAndLat(longitude, latitude);
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (null != storeProfileDto) {
                storeProfileProxyDto = new StoreProfileProxyDto();
                ObjectUtils.fastCopy(storeProfileDto, storeProfileProxyDto);
            }
            return storeProfileProxyDto;
        } catch (Exception e) {
            logger.error("根据经纬度查找最近店铺错误", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public StoreProfileProxyDto loadByStoreId(Integer storeId) throws UserServiceException {
        try {
            StoreProfileDto storeProfileDto = storeProfileService.loadByStoreId(storeId, null);
            StoreProfileProxyDto storeProfileProxyDto = null;
            if (!ObjectUtils.isNullOrEmpty(storeProfileDto)) {
                storeProfileProxyDto = new StoreProfileProxyDto();
                ObjectUtils.fastCopy(storeProfileDto, storeProfileProxyDto);
            }
            return storeProfileProxyDto;
        } catch (Exception e) {
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<StoreProfileProxyDto> listByStoreCodeAndStoreName(String storeCode, String storeName)
            throws UserServiceException {
        List<StoreProfile> storeProfileList = storeProfileMapper.listByStoreCodeAndStoreNameAndStoreStatus(storeCode,
                storeName, null);
        if (ObjectUtils.isNullOrEmpty(storeProfileList)) {
            return null;
        }
        List<StoreProfileProxyDto> storeProfileProxyDtoList = new ArrayList<StoreProfileProxyDto>();
        for (StoreProfile storeProfile : storeProfileList) {
            StoreProfileProxyDto storeProfileProxyDto = new StoreProfileProxyDto();
            ObjectUtils.fastCopy(storeProfile, storeProfileProxyDto);
            storeProfileProxyDtoList.add(storeProfileProxyDto);
        }
        return storeProfileProxyDtoList;
    }

}
