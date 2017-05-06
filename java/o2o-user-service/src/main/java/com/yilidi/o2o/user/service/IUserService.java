package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.AdminUserInfoDto;
import com.yilidi.o2o.user.service.dto.RoleBindingUserInfoDto;
import com.yilidi.o2o.user.service.dto.SynUserInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserNameAndTypeInfoDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * 功能描述：user服务层接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IUserService {

    /**
     * 根据用户ID加载用户对象
     * 
     * @param id
     *            用户id
     * @return 用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public UserDto viewUserDetail(Integer id) throws UserServiceException;

    /**
     * 根据用户ID来获取用户对象
     * 
     * @param id
     *            用户ID
     * @return 用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public UserDto loadUserById(Integer id) throws UserServiceException;

    /**
     * 根据用户名与客户类型来获取用户对象
     * 
     * @param userName
     *            用户名
     * @param customerType
     *            客户类型
     * @return 用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public UserDto loadUserByNameAndType(String userName, String customerType) throws UserServiceException;

    /**
     * 检查用户名是否存在
     * 
     * @param userName
     *            用户名
     * @param customerType
     *            客户类型
     * @return Boolean
     * @throws UserServiceException
     *             服务端异常
     */
    public Boolean checkUserNameIsExist(String userName, String customerType) throws UserServiceException;

    /**
     * 添加用户
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void saveUser(UserDto user) throws UserServiceException;

    /**
     * 获取所有的用户
     * 
     * @return 用户列表
     * @throws UserServiceException
     *             服务端异常
     */
    public List<UserDto> listUsers() throws UserServiceException;

    /**
     * 获取用户分页数据
     * 
     * @param userQuery
     *            用户查询Bean
     * @return 分页数据
     * @throws UserServiceException
     *             异常
     */
    public YiLiDiPage<UserDto> findUsers(UserQuery userQuery) throws UserServiceException;

    /**
     * 查询后台管理员用户所有数据
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    public YiLiDiPage<AdminUserInfoDto> findAdminUsers(UserQuery query) throws UserServiceException;

    /**
     * 查询买家用户所有数据
     * 
     * @param query
     *            查询条件对象
     * @return 用户数据列表
     */
    public YiLiDiPage<UserDto> findBuyerUsers(UserQuery query) throws UserServiceException;

    /**
     * 根据用户ID 加载用户对象
     */
    public UserDto loadBuyerUserById(Integer id) throws UserServiceException;

    /**
     * @Description TODO(新增系统管理员)
     * @param userDto
     * @throws UserServiceException
     */
    public void saveAdminUser(UserDto userDto) throws UserServiceException;

    /**
     * 修改用户
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUser(UserDto user) throws UserServiceException;

    /**
     * 审核用户
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUserForAudit(UserDto user) throws UserServiceException;

    /**
     * 启用/禁用用户
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUserForStatus(UserDto user) throws UserServiceException;

    /**
     * 重置密码
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateUserForPassword(UserDto user) throws UserServiceException;

    /**
     * 登录验证
     * 
     * @param userName
     *            用户名
     * @param customerType
     *            客户类型
     * @param loginType
     *            登录类型
     * @param password
     *            密码
     * @return UserDto
     * @throws UserServiceException
     *             服务端异常
     */
    public UserDto loginValidate(String userName, String customerType, String loginType, String password)
            throws UserServiceException;

    /**
     * 添加子账号
     * 
     * @param uDto
     *            用户对象
     * @param customerId
     *            子账号所属的客户ID
     * @throws UserServiceException
     *             服务端异常
     */
    public void saveSubUser(UserDto uDto, Integer customerId) throws UserServiceException;

    /**
     * 修改子账号
     * 
     * @param uDto
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateSubUser(UserDto uDto) throws UserServiceException;

    /**
     * 分页显示子账号列表
     * 
     * @param userQuery
     *            用户查询Bean
     * @return Page<UserDto> 分页数据
     * @throws UserServiceException
     *             服务端异常
     */
    public Page<UserDto> findSubUsers(UserQuery userQuery) throws UserServiceException;

    /**
     * 审核子账号
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateSubUserForAudit(UserDto user) throws UserServiceException;

    /**
     * 启用/禁用子账号
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateSubUserForStatus(UserDto user) throws UserServiceException;

    /**
     * 子账号重置密码
     * 
     * @param user
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateSubUserForPassword(UserDto user) throws UserServiceException;

    /**
     * 
     * @Description TODO(分页获取报表数据)
     * @param userDto
     * @param startLineNum
     * @param pageSize
     * @return List<UserDto>
     * @throws UserServiceException
     */
    public List<UserDto> listDataForExportUser(UserDto userDto, Long startLineNum, Integer pageSize)
            throws UserServiceException;

    /**
     * 
     * @Description TODO(获取报表数据的总记录数)
     * @param userDto
     * @return Long
     * @throws UserServiceException
     */
    public Long getCountsForExportUser(UserDto userDto) throws UserServiceException;

    /**
     * 
     * @Description TODO(批量保存用户)
     * @param userDtoList
     * @throws UserServiceException
     */
    public void saveUserBatch(List<UserDto> userDtoList) throws UserServiceException;

    /**
     * 
     * @Description TODO(获取用户名与客户类型的用户相关信息列表，用于批量导入前的验证)
     * @return Set<UserNameAndTypeInfoDto> 返回的是Set，因为HashSet的contains方法利用的是Hash的查找方式（map.containsKey），可达到O(1)的查询效率，
     *         会比List的contains方法O(n)的查询效率高
     * @throws UserServiceException
     */
    public Set<UserNameAndTypeInfoDto> getUserNameAndTypeInfos() throws UserServiceException;

    /**
     * 
     * @Description TODO(查询买家用户需导出数据的总数，该数据不需要缓存)
     * @param user
     * @return
     */
    public Long getCountsForExportBuyerUser(UserQuery userQuery);

    /**
     * 
     * @Description TODO(分页查询需导出的买家用户数据，导出的数据不需要缓存)
     * @param user
     * @param startLineNum
     * @param pageSize
     * @return List<UserDto>
     */
    public List<UserDto> listDataForExportBuyerUser(@Param("userQuery") UserQuery userQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * @Description TODO(分页获取角色绑定的用户列表信息)
     * @param userIdList
     * @param query
     * @return YiLiDiPage
     * @throws UserServiceException
     */
    public YiLiDiPage<RoleBindingUserInfoDto> findRoleBindingUsers(List<Integer> userIdList, UserQuery query)
            throws UserServiceException;

    /**
     * 获取主用户信息
     * 
     * @param customerId
     * @param masterFlag
     * @return UserServiceException
     * @throws UserServiceException
     */
    public UserDto loadMainUser(Integer customerId, String masterFlag) throws UserServiceException;

    /**
     * 修改用户名
     * 
     * @param uDto
     * @throws UserServiceException
     */
    public void updateUserForUserName(UserDto uDto) throws UserServiceException;

    /**
     * 发送保存同步用户信息
     * 
     * @param synUserInfoDto
     * @throws UserServiceException
     */
    public void sendSaveSynUserInfoMessage(SynUserInfoDto synUserInfoDto) throws UserServiceException;

    /**
     * 发送更新同步用户信息
     * 
     * @param synUserInfoDto
     * @throws UserServiceException
     */
    public void sendUpdateSynUserInfoMessage(SynUserInfoDto synUserInfoDto) throws UserServiceException;

    /**
     * 修改用户头像
     * 
     * @param userId
     *            用户ID
     * @param userAvatar
     *            用户头像地址
     * @return 影响行数
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateUserAvatar(Integer userId, String userAvatar) throws UserServiceException;

    /**
     * 发送修改用户头像地址消息
     * 
     * @param userId
     *            用户ID
     * @param userAvatarUrl
     *            用户头像地址url
     * @throws UserServiceException
     *             系统域服务异常
     */
    public void sendUpdatUserAvatarMessage(Integer userId, String userAvatarUrl) throws UserServiceException;

    /**
     * 修改用户头像
     * 
     * @param userId
     *            用户ID
     * @param userImgUrl
     *            用户头像地址
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateUserImgUrl(Integer userId, String userImgUrl) throws UserServiceException;

    /**
     * 根据用户名查询用户信息
     * 
     * @param userName
     * @return
     */
    public List<UserDto> listBuyerUsersByUserName(String userName) throws UserServiceException;

    /**
     * 修改用户绑定手机号码
     * 
     * @param userId
     *            用户ID
     * @param mobile
     *            手机号码
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateBindMobile(Integer userId, String mobile) throws UserServiceException;

    /**
     * 店鋪子賬號列表
     * 
     * @param storeCode
     * 				店鋪編號
     * @param storeName
     * 				店鋪名稱
     * @param status
     * 				店鋪狀態
     * @return 
     * 		MsgBean
     */
	public YiLiDiPage<UserDto> getChildAccountList(UserQuery userDtoQuery) throws UserServiceException;

	/**
     * 店鋪子賬號密码重置
     * 
     * @param id
     * 		
     * @return 
     * 		MsgBean
     */
	public void updateUserPassword(Integer id);

	/**
     * 修改子賬號状态
     * 
     * @param id
	 * @param freezeTime 
     * 		
     * @return 
     * 		MsgBean
     */
	public void updateUserStatusCode(Integer id, String statusCode, Date freezeTime);

	/**
	 * 获取所有可以接单的用户
	 * @param customerId
	 * @return
	 */
	public List<Integer> getAcceptOrderUserId(Integer customerId);

	/**
	 * 获取推送的用户
	 * @param customerType
	 * @return
	 */
	public List<UserDto> getPushUserByCustomerType(String customerType);
}
