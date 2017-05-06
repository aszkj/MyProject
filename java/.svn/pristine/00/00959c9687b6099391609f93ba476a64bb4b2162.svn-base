package com.yilidi.o2o.system.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.dao.RoleMapper;
import com.yilidi.o2o.system.model.Role;
import com.yilidi.o2o.system.proxy.IRoleProxyService;
import com.yilidi.o2o.system.proxy.dto.RoleProxyDto;

/**
 * 
 * @Description:TODO(角色Service服务接口实现类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:40:20
 * 
 */
@Service("roleProxyService")
public class RoleServiceProxyImpl extends BasicDataService implements IRoleProxyService {

	@Autowired
	private RoleMapper roleMapper;

	@Override
	public RoleProxyDto loadRoleByNameAndCustomerType(String roleName, String customerType) throws SystemServiceException {
		try {
			Role role = this.roleMapper.loadRoleByNameAndCustomerType(roleName, customerType);
			RoleProxyDto roleDto = null;
			if (null != role) {
				roleDto = new RoleProxyDto();
				ObjectUtils.fastCopy(role, roleDto);
			}
			String customerTypeName = super.getSystemDictName(SystemContext.UserDomain.DictType.CUSTOMERTYPE.getValue(),
					roleDto.getCustomerType());
			roleDto.setCustomerTypeName(customerTypeName);
			return roleDto;
		} catch (Exception e) {
			String msg = "根据角色名称和客户类型获取角色信息";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

}
