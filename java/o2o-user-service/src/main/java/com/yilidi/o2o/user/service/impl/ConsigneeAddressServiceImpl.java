package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.RegexUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.ConsigneeAddressMapper;
import com.yilidi.o2o.user.model.ConsigneeAddress;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.IConsigneeAddressService;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.dto.CommunityDto;
import com.yilidi.o2o.user.service.dto.ConsigneeAddressDto;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;

/**
 * 功能描述：收货地址Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("consigneeAddressService")
public class ConsigneeAddressServiceImpl extends BasicDataService implements IConsigneeAddressService {

    @Autowired
    private ConsigneeAddressMapper consigneeAddressMapper;

    @Autowired
    private ICommunityService communityService;
    @Autowired
    private IStoreProfileService storeProfileService;

    @Override
    public ConsigneeAddressDto save(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException {
        try {
            // 参数为空的校验
            if (null == consigneeAddressDto || null == consigneeAddressDto.getCreateUserId()
                    || null == consigneeAddressDto.getCustomerId() || null == consigneeAddressDto.getCommunityId()
                    || StringUtils.isEmpty(consigneeAddressDto.getConsigneeName())
                    || StringUtils.isEmpty(consigneeAddressDto.getPhoneNo())
                    || StringUtils.isEmpty(consigneeAddressDto.getAddressDetail())) {
                throw new UserServiceException("参数不能为空");
            }
            // 校验参数不为空时的有效性
            isEffectParam(consigneeAddressDto);

            List<ConsigneeAddress> consigneeAddressList = consigneeAddressMapper
                    .listByCustomerId(consigneeAddressDto.getCustomerId());
            int size = 0;
            if (!ObjectUtils.isNullOrEmpty(consigneeAddressList)) {
                size = consigneeAddressList.size();
            }
            if (size <= 0) { // 新增收货地址时如果不存在其他收货地址设置为默认收货地址
                consigneeAddressDto.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES);
            } else {
                consigneeAddressDto.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_NO);
            }
            if (size >= CommonConstants.CONSIGEE_ADDRESS_MAX_NUMBER) {
                throw new UserServiceException("收货地址数量已达上限");
            }
            ConsigneeAddress consigneeAddress = new ConsigneeAddress();
            ObjectUtils.fastCopy(consigneeAddressDto, consigneeAddress);

            this.consigneeAddressMapper.save(consigneeAddress);
            consigneeAddressDto.setDefaultFlag(consigneeAddress.getDefaultFlag());
            consigneeAddressDto.setAddressId(consigneeAddress.getAddressId());
            return consigneeAddressDto;
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    // 校验参数不为空时的有效性
    private void isEffectParam(ConsigneeAddressDto consigneeAddressDto) {
        if (!StringUtils.isEmpty(consigneeAddressDto.getPhoneNo())
                && !RegexUtils.isMobileNumble(consigneeAddressDto.getPhoneNo())) {
            throw new UserServiceException("手机号码不合法");
        }
        if (null != consigneeAddressDto.getCommunityId()) {
            CommunityDto communityDto = communityService.loadById(consigneeAddressDto.getCommunityId());
            if (null == communityDto) {
                throw new UserServiceException("小区不存在");
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getProvinceCode())) {
                if (!StringUtils.equals(consigneeAddressDto.getProvinceCode(), communityDto.getProvinceCode())) {
                    throw new UserServiceException("不是有效的省");
                }
            } else {
                consigneeAddressDto.setProvinceCode(communityDto.getProvinceCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getCityCode())) {
                if (!StringUtils.equals(consigneeAddressDto.getCityCode(), communityDto.getCityCode())) {
                    throw new UserServiceException("不是有效的市");
                }
            } else {
                consigneeAddressDto.setCityCode(communityDto.getCityCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getTownCode())) {
                if (!StringUtils.equals(consigneeAddressDto.getTownCode(), communityDto.getTownCode())) {
                    throw new UserServiceException("不是有效的地区");
                }
            } else {
                consigneeAddressDto.setTownCode(communityDto.getTownCode());
            }
        }
    }

    @Override
    public void deleteById(Integer id) throws UserServiceException {
        try {
            consigneeAddressMapper.deleteById(id);
        } catch (Exception e) {
            logger.error("deleteById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ConsigneeAddressDto loadById(Integer id, String status) throws UserServiceException {
        try {
            ConsigneeAddress consigneeAddress = consigneeAddressMapper.loadById(id, status);
            ConsigneeAddressDto consigneeAddressDto = null;
            if (null != consigneeAddress) {
                consigneeAddressDto = new ConsigneeAddressDto();
                ObjectUtils.fastCopy(consigneeAddress, consigneeAddressDto);
                CommunityDto communityDto = null;
                String communityName = "";
                if (!ObjectUtils.isNullOrEmpty(consigneeAddress.getCommunityId())) {
                    communityDto = communityService.loadById(consigneeAddress.getCommunityId());// 根据小区ID去查询小区并得到小区名称
                }
                if (!ObjectUtils.isNullOrEmpty(communityDto)) {
                    communityName = communityDto.getName();
                }
                StoreProfileDto storeProfileDto = storeProfileService.loadByCommunityId(consigneeAddress.getCommunityId(),
                        null);
                consigneeAddressDto.setCommunityName(communityName);
                consigneeAddressDto.setStoreProfileDto(storeProfileDto);
            }
            return consigneeAddressDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<ConsigneeAddressDto> listByCustomerId(Integer customerId) throws UserServiceException {
        try {
            List<ConsigneeAddress> consigneeAddressList = consigneeAddressMapper.listByCustomerId(customerId);
            List<ConsigneeAddressDto> consigneeAddressDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(consigneeAddressList)) {
                consigneeAddressDtoList = new ArrayList<ConsigneeAddressDto>();
                for (ConsigneeAddress consigneeAddress : consigneeAddressList) {
                    ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
                    ObjectUtils.fastCopy(consigneeAddress, consigneeAddressDto);
                    CommunityDto communityDto = null;
                    String communityName = "";
                    if (!ObjectUtils.isNullOrEmpty(consigneeAddress.getCommunityId())) {
                        communityDto = communityService.loadById(consigneeAddress.getCommunityId());// 根据小区ID去查询小区并得到小区名称
                    }
                    if (!ObjectUtils.isNullOrEmpty(communityDto)) {
                        communityName = communityDto.getName();
                    }
                    consigneeAddressDto.setCommunityName(communityName);
                    /*
                     * consigneeAddressDto.setFullConsigneeAddress(areaDictProxyService.encapsulateAreaNameByCodes(
                     * consigneeAddress.getProvinceCode(), consigneeAddress.getCityCode(), consigneeAddress.getCountyCode(),
                     * consigneeAddress.getTownCode(), consigneeAddress.getAddressDetail()));
                     */
                    StoreProfileDto storeProfileDto = storeProfileService
                            .loadByCommunityId(consigneeAddress.getCommunityId(), null);
                    consigneeAddressDto.setStoreProfileDto(storeProfileDto);
                    consigneeAddressDtoList.add(consigneeAddressDto);
                }
            }
            return consigneeAddressDtoList;
        } catch (Exception e) {
            logger.error("listByCustomerId异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateByIdSelective(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException {
        try {
            ConsigneeAddress consigneeAddress = this.consigneeAddressMapper.loadById(consigneeAddressDto.getAddressId(),
                    null);
            if (!StringUtils.isEmpty(consigneeAddressDto.getProvinceCode())) {
                consigneeAddress.setProvinceCode(consigneeAddressDto.getProvinceCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getCityCode())) {
                consigneeAddress.setCityCode(consigneeAddressDto.getCityCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getCountyCode())) {
                consigneeAddress.setCountyCode(consigneeAddressDto.getCountyCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getTownCode())) {
                consigneeAddress.setTownCode(consigneeAddressDto.getTownCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getAddressDetail())) {
                consigneeAddress.setAddressDetail(consigneeAddressDto.getAddressDetail());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getDefaultFlag())) {
                consigneeAddress.setDefaultFlag(consigneeAddressDto.getDefaultFlag());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getConsigneeName())) {
                consigneeAddress.setConsigneeName(consigneeAddressDto.getConsigneeName());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getPhoneNo())) {
                consigneeAddress.setPhoneNo(consigneeAddressDto.getPhoneNo());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getStatus())) {
                consigneeAddress.setStatus(consigneeAddressDto.getStatus());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getNote())) {
                consigneeAddress.setNote(consigneeAddressDto.getNote());
            }
            consigneeAddress.setModifyUserId(consigneeAddressDto.getModifyUserId());
            consigneeAddress.setModifyTime(consigneeAddressDto.getModifyTime());
            consigneeAddressMapper.updateByIdSelective(consigneeAddress);
        } catch (Exception e) {
            logger.error("updateByIdSelective异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ConsigneeAddressDto updateById(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException {
        try {
            // 参数不为空的校验
            if (null == consigneeAddressDto.getAddressId() || null == consigneeAddressDto.getModifyUserId()
                    || null == consigneeAddressDto.getModifyTime()) {
                throw new UserServiceException("修改地址参数不能为空");
            }
            // 参数合法性的校验
            isEffectParam(consigneeAddressDto);

            ConsigneeAddress consigneeAddress = this.consigneeAddressMapper.loadById(consigneeAddressDto.getAddressId(),
                    null);
            if (!StringUtils.isEmpty(consigneeAddressDto.getConsigneeName())) {
                consigneeAddress.setConsigneeName(consigneeAddressDto.getConsigneeName());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getPhoneNo())) {
                consigneeAddress.setPhoneNo(consigneeAddressDto.getPhoneNo());
            }
            if (null != consigneeAddressDto.getCommunityId()) {
                consigneeAddress.setCommunityId(consigneeAddressDto.getCommunityId());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getCityCode())) {
                consigneeAddress.setCityCode(consigneeAddressDto.getCityCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getProvinceCode())) {
                consigneeAddress.setProvinceCode(consigneeAddressDto.getProvinceCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getCountyCode())) {
                consigneeAddress.setCountyCode(consigneeAddressDto.getCountyCode());
            }
            if (!StringUtils.isEmpty(consigneeAddressDto.getAddressDetail())) {
                consigneeAddress.setAddressDetail(consigneeAddressDto.getAddressDetail());
            }
            consigneeAddress.setModifyUserId(consigneeAddressDto.getModifyUserId());
            consigneeAddress.setModifyTime(consigneeAddressDto.getModifyTime());
            consigneeAddressMapper.updateById(consigneeAddress);
            return consigneeAddressDto;
        } catch (Exception e) {
            logger.error("updateById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForStatus(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException {
        try {
            ConsigneeAddress consigneeAddress = consigneeAddressMapper.loadById(consigneeAddressDto.getAddressId(), null);
            if (consigneeAddressDto.getCustomerId().intValue() != consigneeAddress.getCustomerId().intValue()) {
                logger.error("非法操作用户[" + consigneeAddress.getCustomerId() + "]");
                throw new OrderServiceException("不支持的操作");
            }
            consigneeAddress.setStatus(consigneeAddressDto.getStatus());
            consigneeAddress.setModifyUserId(consigneeAddressDto.getModifyUserId());
            consigneeAddress.setModifyTime(consigneeAddressDto.getModifyTime());
            consigneeAddressMapper.updateByIdSelective(consigneeAddress);
            if (SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES.equals(consigneeAddress.getDefaultFlag())) {
                List<ConsigneeAddress> consigneeAddressList = consigneeAddressMapper
                        .listByCustomerId(consigneeAddressDto.getCustomerId());
                if (!ObjectUtils.isNullOrEmpty(consigneeAddressList)) {
                    ConsigneeAddress consigneeAddressTemp = consigneeAddressList.get(0);
                    consigneeAddressTemp.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES);
                    consigneeAddressTemp.setModifyUserId(consigneeAddressDto.getModifyUserId());
                    consigneeAddressTemp.setModifyTime(consigneeAddressDto.getModifyTime());
                    consigneeAddressMapper.updateByIdSelective(consigneeAddressTemp);
                }
            }

        } catch (Exception e) {
            logger.error("updateForStatus异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateForDefaultFlag(ConsigneeAddressDto consigneeAddressDto) throws UserServiceException {
        try {
            List<ConsigneeAddress> consigneeAddressList = consigneeAddressMapper
                    .listByCustomerId(consigneeAddressDto.getCustomerId());
            if (!ObjectUtils.isNullOrEmpty(consigneeAddressList)) {
                for (ConsigneeAddress consigneeAddressTemp : consigneeAddressList) {// 设置默认收货地址前先把默认收货地址设置为非默认收货地址
                    if (consigneeAddressTemp.getAddressId().intValue() == consigneeAddressDto.getAddressId().intValue()) {
                        consigneeAddressTemp.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES);
                        consigneeAddressTemp.setModifyUserId(consigneeAddressDto.getModifyUserId());
                        consigneeAddressTemp.setModifyTime(consigneeAddressDto.getModifyTime());
                        consigneeAddressMapper.updateByIdSelective(consigneeAddressTemp);
                    } else if (SystemContext.UserDomain.CONSADDRDEFAULTFLAG_YES
                            .equals(consigneeAddressTemp.getDefaultFlag())) {
                        consigneeAddressTemp.setDefaultFlag(SystemContext.UserDomain.CONSADDRDEFAULTFLAG_NO);
                        consigneeAddressTemp.setModifyUserId(consigneeAddressDto.getModifyUserId());
                        consigneeAddressTemp.setModifyTime(consigneeAddressDto.getModifyTime());
                        consigneeAddressMapper.updateByIdSelective(consigneeAddressTemp);
                    }
                }
            }
        } catch (Exception e) {
            logger.error("updateForDefaultFlag异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ConsigneeAddressDto loadLatelyUpdateByCommunityId(Integer communityId, Integer customerId)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(communityId) || ObjectUtils.isNullOrEmpty(customerId)) {
                return null;
            }
            ConsigneeAddress consigneeAddress = consigneeAddressMapper.loadLatelyUpdateByCommunityId(communityId, customerId,
                    SystemContext.UserDomain.CONSADDRSTATUS_ON);
            if (ObjectUtils.isNullOrEmpty(consigneeAddress)) {
                return null;
            }
            ConsigneeAddressDto consigneeAddressDto = new ConsigneeAddressDto();
            ObjectUtils.fastCopy(consigneeAddress, consigneeAddressDto);
            CommunityDto communityDto = null;
            if (!ObjectUtils.isNullOrEmpty(consigneeAddressDto.getCommunityId())) {
                communityDto = communityService.loadById(consigneeAddress.getCommunityId());// 根据小区ID去查询小区并得到小区名称
            }
            if (!ObjectUtils.isNullOrEmpty(communityDto)) {
                consigneeAddressDto.setCommunityName(communityDto.getName());
            }
            return consigneeAddressDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
