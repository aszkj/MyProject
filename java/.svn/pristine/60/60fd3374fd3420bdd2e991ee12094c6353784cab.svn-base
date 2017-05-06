package com.yilidi.o2o.user.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.Customer;
import com.yilidi.o2o.user.model.combination.CustomerRelatedInfo;
import com.yilidi.o2o.user.model.combination.StoreInfo;
import com.yilidi.o2o.user.model.combination.VipUserStatisticInfo;
import com.yilidi.o2o.user.model.query.InvitedUserQuery;
import com.yilidi.o2o.user.model.query.VipUserStatisticDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerQuery;
import com.yilidi.o2o.user.service.dto.query.StoreQuery;

/**
 * 功能描述：客户信息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface CustomerMapper {

    /**
     * 保存客户信息（如果字段值为null，则不保存该字段，即sql语句中不出现该字段）
     * <p>
     * 注： 该接口中推荐使用该方法
     * </p>
     * 
     * @param record
     *            客户信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer saveSelective(Customer record);

    /**
     * 保存客户信息
     * 
     * @param record
     *            客户信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer save(Customer record);

    /**
     * 根据Id更新客户信息（如果字段值为null，则不更新该字段，即sql语句中不出现该字段）
     * <p>
     * 注： 该接口中推荐使用该方法
     * </p>
     * 
     * @param record
     *            客户信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer updateByIdSelective(Customer record);

    /**
     * 修改后台客户
     * 
     * @param record
     *            客户信息对象
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer updateAdminCustomer(Customer record);

    /**
     * 根据ID修改终端用户级别信息
     * 
     * @param id
     *            客户ID
     * @param buyerLevelCode
     *            终端用户级别编码
     * @param vipExpireDate
     *            VIP过期时间
     * @param vipCreateTime
     *            vip开通时间
     * @param modifyUserId
     *            操作用户ID
     * @param modifyTime
     *            操作时间
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer updateBuyerLevelById(@Param("id") Integer id, @Param("buyerLevelCode") String buyerLevelCode,
            @Param("vipExpireDate") Date vipExpireDate, @Param("vipCreateTime") Date vipCreateTime,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 根据客户Id查询客户信息
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @param id
     *            客户Id
     * @return 客户信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Customer loadById(Integer id);

    /**
     * 根据客户名称查询客户信息
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @param customerName
     *            客户名称
     * @return 客户信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Customer loadByCustomerName(String customerName);

    /**
     * 根据门店id,门店编码，门店名称查询门店信息
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @return 门店信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER_PROFILE })
    List<StoreInfo> listStoreInfoByQuery(@Param("storeQuery") StoreQuery storeQuery);

    /**
     * 根据客户Id查询客户相关信息
     * 
     * <pre>
     * 注：该方法 使用缓存
     * </pre>
     * 
     * @param id
     *            客户Id
     * @return 客户信息对象
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER,
            DBTablesName.User.U_USER_PROFILE })
    CustomerRelatedInfo loadCustomerRelatedInfoById(Integer id);

    /**
     * 查询所有数据
     * 
     * <pre>
     * 	注：将使用缓存查询
     * </pre>
     * 
     * @param query
     *            查询条件对象
     * @return 会员数据列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER,
            DBTablesName.User.U_USER_PROFILE })
    Page<CustomerRelatedInfo> findCustomers(CustomerQuery customerQuery);

    /**
     * @Description TODO(获取邀请注册用户数)
     * @param inviteCustomerId
     * @param statusCode
     * @param startCreateTime
     * @param endCreateTime
     * @return Long
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Long getInviteCount(@Param("inviteCustomerId") Integer inviteCustomerId, @Param("statusCode") String statusCode,
            @Param("startCreateTime") Date startCreateTime, @Param("endCreateTime") Date endCreateTime);

    /**
     * @Description TODO(获取卖家所邀请的VIP用户数)
     * @param inviteCustomerId
     * @param statusCode
     * @param buyerLevelCode
     * @param startCreateTime
     * @param endCreateTime
     * @return Long
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Long getVipUserCount(@Param("inviteCustomerId") Integer inviteCustomerId, @Param("statusCode") String statusCode,
            @Param("buyerLevelCode") String buyerLevelCode, @Param("startCreateTime") Date startCreateTime,
            @Param("endCreateTime") Date endCreateTime);

    /**
     * @Description TODO(分页获取邀请注册客户信息列表)
     * @param inviteCustomerId
     * @param statusCode
     * @return Page<Customer>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Page<Customer> findInvitedCustomers(InvitedUserQuery invitedUserQuery);

    /**
     * @Description TODO(获取卖家某一时间段内所邀请的VIP用户数)
     * @param inviteCustomerId
     * @param statusCode
     * @param buyerLevelCode
     * @param beginDate
     * @param endDate
     * @return Integer
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Integer getVipUserCountByTimes(@Param("inviteCustomerId") Integer inviteCustomerId,
            @Param("statusCode") String statusCode, @Param("buyerLevelCode") String buyerLevelCode,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    /**
     * @Description TODO(分页获取铂金会员统计详细信息)
     * @param vipUserStatisticDetailQuery
     * @return Page<VipUserStatisticInfo>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Page<VipUserStatisticInfo> findVipUserStatisticInfos(VipUserStatisticDetailQuery vipUserStatisticDetailQuery);

    /**
     * 根据客户类型和终端用户级别查询客户信息列表
     * 
     * @param customerType
     *            客户类型
     * @param buyerLevelCode
     *            终端用户级别编码
     * @return 客户信息列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    List<Customer> listByCustomerTypeAndBuyerLevelCode(@Param("customerType") String customerType,
            @Param("buyerLevelCode") String buyerLevelCode);

    /**
     * 根据邀请码查找店铺客户
     * 
     * @param invitationCode
     *            邀请码
     * @return Customer
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_CUSTOMER })
    Customer loadByInvitationCode(@Param("invitationCode") String invitationCode);
}