package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.RolePermissionHistory;

/**
 * 功能描述：角色权限关联关系历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public interface RolePermissionHistoryMapper {

	/**
	 * 保持历史记录
	 * @param record 记录实体
	 * @return 影响的行数
	 */
    Integer save(RolePermissionHistory record);
    /**
     * 查询所有的历史记录
     * @return 历史记录列表
     */
    List<RolePermissionHistory> list();
    /**
     * 根据角色ID查询所有的历史记录
     * @param roleId 角色ID
     * @return 历史记录列表
     */
    List<RolePermissionHistory> listByRoleId(Integer roleId);

}