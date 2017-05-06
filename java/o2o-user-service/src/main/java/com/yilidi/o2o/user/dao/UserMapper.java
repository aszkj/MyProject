package com.yilidi.o2o.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.User;
import com.yilidi.o2o.user.model.combination.AdminUserInfo;
import com.yilidi.o2o.user.model.combination.RoleBindingUserInfo;
import com.yilidi.o2o.user.model.combination.UserInfo;
import com.yilidi.o2o.user.model.combination.UserNameAndTypeInfo;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * 功能描述：用户对象操作DAO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface UserMapper {

    /**
     * 保存用户对象
     * 
     * <pre>
     * 	注：将更新user缓存
     * </pre>
     * 
     * @param user
     *            用户对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
    Integer save(User user);

    /**
     * 更新全部字段（如果字段值为null，也更新该字段）
     * 
     * @param user
     *            用户对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
    Integer update(User user);

    /**
     * 根据用户id选择性的更新字段（如果字段值为null，则不更新该字段，推荐使用该方法）
     * 
     * @param user
     *            用户对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
    Integer updateByIdSelective(User user);

    /**
     * 根据用户ID 加载用户对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            用户ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
    User loadById(Integer id);

    /**
     * 根据用户名称加载用户对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param userName
     *            用户名称
     * @param customerType
     *            客户类型
     * @return 用户对象
     */
    User loadByNameAndType(@Param("userName") String userName, @Param("customerType") String customerType);

    /**
     * 查询所有数据
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
    Page<User> findUsers(UserQuery query);

    /**
     * 检查用户名是否存在
     * 
     * @param userName
     *            用户名
     * @return 包含该名称的记录数
     */
    Integer checkUserName(String userName);

    /**
     * 分页查询子账号列表
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
    Page<User> findSubUsers(UserQuery query);

    /**
     * 
     * @Description TODO(查询需导出数据的总数，该数据不需要缓存)
     * @param user
     * @return 总记录数
     */
    Long getCountsForExportUser(User user);

    /**
     * 
     * @Description TODO(分页查询需导出的数据，导出的数据不需要缓存)
     * @param user
     * @param startLineNum
     * @param pageSize
     * @return List<User>
     */
    List<User> listDataForExportUser(@Param("user") User user, @Param("startLineNum") Long startLineNum,
            @Param("pageSize") Integer pageSize);

    /**
     * 
     * 根据客户类型查询userId列表
     * 
     * @param customerType
     * @return userId列表
     */
    List<Integer> listUserIdsByCustomerType(String customerType);

    /**
     * 查询后台管理员用户所有数据
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER, DBTablesName.User.U_LOGIN_LOG })
    Page<AdminUserInfo> findAdminUsers(UserQuery query);

    /**
     * 查询买家用户所有数据
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER, DBTablesName.User.U_CUSTOMER })
    Page<UserInfo> findBuyerUsers(UserQuery query);

    /**
     * 根据用户ID 加载买家用户对象
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param id
     *            用户ID
     * @return 用户对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER, DBTablesName.User.U_CUSTOMER })
    UserInfo loadBuyerUserById(Integer id);

    /**
     * 
     * 根据用户账号列表查询userId列表
     * 
     * @param customerType
     * @return userId列表
     */
    List<Integer> listUserIdsByUserNames(@Param("userNames") List<String> userNames);

    /**
     * 
     * 根据买家用户级别查询userId列表
     * 
     * @param buylevel
     * @return userId列表
     */
    List<Integer> listUserIdsByBuyerLevel(String buyerLevel);

    /**
     * 
     * @Description TODO(批量保存用户)
     * @param list
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
    void batchSave(List<User> list);

    /**
     * 
     * @Description TODO(获取用户名与客户类型的用户相关信息列表，用于批量导入前的验证)
     * @return List<UserNameAndTypeInfo>
     */
    List<UserNameAndTypeInfo> listUserNameAndTypeInfo();

    /**
     * 
     * @Description TODO(查询买家用户需导出数据的总数，该数据不需要缓存)
     * @param user
     * @return 总记录数
     */
    Long getCountsForExportBuyerUser(UserQuery userQuery);

    /**
     * 
     * @Description TODO(分页查询需导出的买家用户数据，导出的数据不需要缓存)
     * @param user
     * @param startLineNum
     * @param pageSize
     * @return List<User>
     */
    List<UserInfo> listDataForExportBuyerUser(@Param("userQuery") UserQuery userQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * @Description TODO(分页获取角色绑定的用户列表信息)
     * @param map
     * @return Page<RoleBindingUserInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
    Page<RoleBindingUserInfo> findRoleBindingUsers(@Param("map") Map<String, Object> map);

    /**
     * 获取主用户信息
     * 
     * @param customerId
     * @param masterFlag
     * @return User
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
    User loadMainUser(@Param("customerId") Integer customerId, @Param("masterFlag") String masterFlag);
    /**
     * 
     * @param userName
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER, DBTablesName.User.U_CUSTOMER })
	List<User> listBuyerUsersByUserName(String userName);
    
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
	Page<User> findChildAccountList(UserQuery userDtoQuery);

    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
	void updateUserPassword(Map<String, Object> map);
    
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_USER })
    void updateUserStatusCode(Map<String, Object> map);

    /**
	 * 获取所有可以接单的用户
	 * @param customerId
	 * @return
	 */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
	List<Integer> getAcceptOrderUserId(@Param("customerId")Integer customerId);
    
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
	List<User> getChildBycustom(@Param("customerId") Integer customerId);

    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_USER })
	List<User> getPushUserByCustomerType(@Param("customerType")String customerType);

}