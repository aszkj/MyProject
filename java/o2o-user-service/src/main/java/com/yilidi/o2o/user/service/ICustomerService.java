package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.InvitationUserDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.VipUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.query.CustomerQuery;
import com.yilidi.o2o.user.service.dto.query.InvitedUserQueryDto;
import com.yilidi.o2o.user.service.dto.query.VipUserStatisticDetailQueryDto;

/**
 * 功能描述：customer服务层接口 <br/>
 * 作者： chenlian <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICustomerService {

    /**
     * 查看客户详情
     * 
     * @param id
     *            客户id
     * @return CustomerDto
     * @throws UserServiceException
     *             服务端异常
     */
    public CustomerDto viewCustomerDetail(Integer id) throws UserServiceException;

    /**
     * 根据客户 ID查看企业信息
     * 
     * @param id
     *            客户id
     * @return CustomerDto
     * @throws UserServiceException
     *             服务端异常
     */
    public CustomerDto viewEnterprise(Integer id) throws UserServiceException;

    /**
     * 根据客户ID来获取客户对象
     * 
     * @param id
     *            客户ID
     * @return 客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public CustomerDto loadCustomerById(Integer id) throws UserServiceException;

    /**
     * 根据客户名来获取客户对象
     * 
     * @param customerName
     *            客户名
     * @return 客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public CustomerDto loadCustomerByName(String customerName) throws UserServiceException;

    /**
     * 检查客户名是否存在
     * 
     * @param customerName
     *            客户名
     * @return Boolean
     * @throws UserServiceException
     *             服务端异常
     */
    public Boolean checkCustomerNameIsExist(String customerName) throws UserServiceException;

    /**
     * 添加客户
     * 
     * @param customer
     *            客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public Integer saveCustomer(CustomerDto customer) throws UserServiceException;

    /**
     * 获取客户分页数据
     * 
     * @param customerQuery
     *            客户查询Bean
     * @return 分页数据
     * @throws UserServiceException
     *             异常
     */
    public YiLiDiPage<CustomerDto> findCustomers(CustomerQuery customerQuery) throws UserServiceException;

    /**
     * 修改客户
     * 
     * @param customer
     *            客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateCustomer(CustomerDto customer) throws UserServiceException;

    /**
     * 更新买家用户会员级别信息
     * 
     * @param customerId
     *            客户ID
     * @param buyerLevelCode
     *            用户级别
     * @param vipExpireDate
     *            会员过期时间
     * @param vipCreateTime
     *            会员开通时间
     * @param operationUserId
     *            操作用户ID
     * @param operationDate
     *            操作时间
     * @throws UserServiceException
     *             用户域服务异常
     */
    public void updateBuyerLevelCodeById(Integer customerId, String buyerLevelCode, Date vipExpireDate, Date vipCreateTime,
            Integer operationUserId, Date operationDate) throws UserServiceException;

    /**
     * 修改后台用户
     * 
     * @param UserDto
     *            客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateAdminUser(UserDto userDto) throws UserServiceException;

    /**
     * 审核客户
     * 
     * @param customerDto
     *            客户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateCustomerForAudit(CustomerDto customerDto) throws UserServiceException;

    /**
     * 启用/禁用客户
     * 
     * @param uDto
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateCustomerForStatus(UserDto uDto) throws UserServiceException;

    /**
     * 重置密码
     * 
     * @param uDto
     *            用户对象
     * @throws UserServiceException
     *             服务端异常
     */
    public void updateCustomerForPassword(UserDto uDto) throws UserServiceException;

    /**
     * @Description TODO(获取邀请注册用户数)
     * @param inviteCustomerId
     * @param startCreateTime
     * @param endCreateTime
     * @return Long
     * @throws UserServiceException
     */
    public Long getInviteCount(Integer inviteCustomerId, Date startCreateTime, Date endCreateTime)
            throws UserServiceException;

    /**
     * @Description TODO(获取卖家所邀请的VIP用户数)
     * @param inviteCustomerId
     * @param startCreateTime
     * @param endCreateTime
     * @return Long
     * @throws UserServiceException
     */
    public Long getVipUserCount(Integer inviteCustomerId, Date startCreateTime, Date endCreateTime)
            throws UserServiceException;

    /**
     * @Description TODO(分页获取邀请注册客户信息列表)
     * @param invitedUserQueryDto
     * @return YiLiDiPage<InvitationUserDto>
     * @throws UserServiceException
     */
    public YiLiDiPage<InvitationUserDto> findInvitedUsers(InvitedUserQueryDto invitedUserQueryDto)
            throws UserServiceException;

    /**
     * @Description TODO(获取卖家某一时间段内所邀请的VIP用户数)
     * @param inviteCustomerId
     * @param beginDate
     * @param endDate
     * @return Integer
     * @throws UserServiceException
     */
    public Integer getVipUserCountByTimes(Integer inviteCustomerId, Date beginDate, Date endDate)
            throws UserServiceException;

    /**
     * @Description TODO(分页获取铂金会员统计详细信息)
     * @param vipUserStatisticDetailQueryDto
     * @return YiLiDiPage<VipUserStatisticInfoDto>
     * @throws UserServiceException
     */
    public YiLiDiPage<VipUserStatisticInfoDto> findVipUserStatisticInfos(
            VipUserStatisticDetailQueryDto vipUserStatisticDetailQueryDto) throws UserServiceException;

    /**
     * 根据客户类型和终端用户级别查询客户信息列表
     * 
     * @param customerType
     *            客户类型
     * @param buyerLevelCode
     *            终端用户级别
     * @return 客户信息列表
     */
    public List<CustomerDto> listByCustomerTypeAndBuyerLevelCode(String customerType, String buyerLevelCode)
            throws UserServiceException;

    /**
     * 根据邀请码查找店铺客户
     * 
     * @param invitationCode
     *            邀请码
     * @return CustomerDto
     * @throws UserServiceException
     *             用户域服务异常
     */
    public CustomerDto loadByInvitationCode(String invitationCode) throws UserServiceException;
}
