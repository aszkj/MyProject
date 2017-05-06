package com.yilidi.o2o.user.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IRoleProxyService;
import com.yilidi.o2o.system.proxy.IUserRoleProxyService;
import com.yilidi.o2o.system.proxy.dto.RoleProxyDto;
import com.yilidi.o2o.user.dao.StoreDeliveryMapper;
import com.yilidi.o2o.user.dao.StoreProfileMapper;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.model.StoreDelivery;
import com.yilidi.o2o.user.model.StoreProfile;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.model.combination.StoreDeliveryInfo;
import com.yilidi.o2o.user.service.IStoreDeliveryService;
import com.yilidi.o2o.user.service.dto.StoreDeliveryDto;
import com.yilidi.o2o.user.service.dto.query.StoreDeliveryQuery;

/**
 * 
 * 门店接单员管理service
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午2:27:28
 * 
 */
@Service("storeDeliveryService")
public class StoreDeliveryServiceImpl extends BasicDataService implements IStoreDeliveryService {

	@Autowired
	private StoreDeliveryMapper storeDeliveryMapper;

	@Autowired
	private StoreProfileMapper storeProfileMapper;

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private IUserRoleProxyService userRoleProxyService;

	@Autowired
	private IRoleProxyService roleProxyService;

	private static final String DELIVERY_ROLE_NAME = "店铺接单员";

	@Override
	public void save(StoreDeliveryDto storeDeliveryDto) throws UserServiceException {
		try {
			StoreDelivery storeDelivery = new StoreDelivery();
			ObjectUtils.fastCopy(storeDeliveryDto, storeDelivery);
			this.storeDeliveryMapper.save(storeDelivery);
			// 获取门店信息
			StoreProfile storeProfile = this.storeProfileMapper.loadById(storeDeliveryDto.getStoreId());
			// 新增user
			User user = new User();
			// storeProfile.getStoreId()门店对应的customerID
			user.setCustomerId(storeProfile.getStoreId());
			user.setUserName(storeDeliveryDto.getUserName());
			// 默认密码 888888
			user.setPassword("888888");
			// 子账号
			user.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_SUB);
			user.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			// 默认已启用
			user.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			// 默认已审核通过
			user.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
			// 当前用户ID
			user.setCreateUserId(storeDeliveryDto.getCreateUserId());
			user.setCreateTime(storeDeliveryDto.getCreateDate());
			this.userMapper.save(user);
			Integer userId = user.getId();
			/**
			 * 默认添加门店接单员角色
			 */
			RoleProxyDto roleProxyDto = roleProxyService.loadRoleByNameAndCustomerType(DELIVERY_ROLE_NAME,
					SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			String strRoleIds = null;
			if (!ObjectUtils.isNullOrEmpty(roleProxyDto)) {
				strRoleIds = roleProxyDto.getId().toString();
				userRoleProxyService.saveUserRoles(userId, getRoleIds(strRoleIds), storeDeliveryDto.getCreateUserId(),
						new Date());
			}
		} catch (Exception e) {
			logger.error("save()异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	private Integer[] getRoleIds(String strRoleIds) {
		if (!StringUtils.isEmpty(strRoleIds)) {
			String[] sRoleIds = strRoleIds.split("_");
			Integer[] roleIds = new Integer[sRoleIds.length];
			for (int i = 0; i < sRoleIds.length; i++) {
				roleIds[i] = Integer.parseInt(sRoleIds[i]);
			}
			return roleIds;
		} else {
			return null;
		}
	}

	@Override
	public void update(StoreDeliveryDto storeDeliveryDto) throws UserServiceException {
		try {
			StoreDelivery storeDelivery = this.storeDeliveryMapper.loadById(storeDeliveryDto.getId());
			storeDelivery.setContact(storeDeliveryDto.getContact());
			storeDelivery.setMobile(storeDeliveryDto.getMobile());
			storeDelivery.setRemark(storeDeliveryDto.getRemark());
			this.storeDeliveryMapper.update(storeDelivery);
		} catch (Exception e) {
			logger.error("update()异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public StoreDeliveryDto loadById(Integer id) throws UserServiceException {
		try {
			StoreDeliveryDto dto = null;
			if (!ObjectUtils.isNullOrEmpty(id)) {
				StoreDelivery storeDelivery = this.storeDeliveryMapper.loadById(id);
				if (!ObjectUtils.isNullOrEmpty(storeDelivery)) {
					dto = new StoreDeliveryDto();
					ObjectUtils.fastCopy(storeDelivery, dto);
					StoreProfile storeProfile = this.storeProfileMapper.loadById(storeDelivery.getStoreId());
					dto.setStoreCode(storeProfile.getStoreCode());
					dto.setStoreName(storeProfile.getStoreName());
				}
			}
			return dto;
		} catch (Exception e) {
			logger.error("loadById()异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateStateById(Integer id, String state) throws UserServiceException {
		try {
			if (!ObjectUtils.isNullOrEmpty(id) && !ObjectUtils.isNullOrEmpty(state)) {
				this.storeDeliveryMapper.updateStateById(id, state);
			}
		} catch (Exception e) {
			logger.error("updateStateById()异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<StoreDeliveryDto> findStoreDelivery(StoreDeliveryQuery query) throws UserServiceException {
		try {
			if (null == query.getStart() || query.getStart() <= 0) {
				query.setStart(1);
			}
			if (null == query.getPageSize() || query.getPageSize() <= 0) {
				query.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(query.getStart(), query.getPageSize());
			Page<StoreDeliveryInfo> page = this.storeDeliveryMapper.findStoreDelivery(query);
			Page<StoreDeliveryDto> pageDto = new Page<StoreDeliveryDto>(query.getStart(), query.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<StoreDeliveryInfo> infos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(infos)) {
				for (StoreDeliveryInfo info : infos) {
					StoreDeliveryDto dto = new StoreDeliveryDto();
					ObjectUtils.fastCopy(info, dto);
					pageDto.add(dto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findStoreDelivery异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void resetStoreDeliveryPassword(Integer id) throws UserServiceException {
		try {
			if (!ObjectUtils.isNullOrEmpty(id)) {
				StoreDelivery storeDelivery = this.storeDeliveryMapper.loadById(id);
				if (!ObjectUtils.isNullOrEmpty(storeDelivery) && !ObjectUtils.isNullOrEmpty(storeDelivery.getUserName())) {
					User user = this.userMapper.loadByNameAndType(storeDelivery.getUserName(),
							SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
					if (!ObjectUtils.isNullOrEmpty(user)) {
						user.setPassword("888888");
						this.userMapper.updateByIdSelective(user);
					}
				}
			}
		} catch (Exception e) {
			logger.error("updateStateById()异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}
