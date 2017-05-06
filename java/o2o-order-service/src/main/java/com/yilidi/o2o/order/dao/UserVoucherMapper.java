package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.UserVoucher;
import com.yilidi.o2o.order.model.query.UserVoucherQuery;
import com.yilidi.o2o.order.model.result.UserVoucherInfo;

/**
 * 用户抵用劵Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午3:23:50
 */
public interface UserVoucherMapper {

    /**
     * 新增保存
     * 
     * @param userVoucher
     *            实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
    Integer save(UserVoucher userVoucher);

    /**
     * 查询单个UserVoucher
     * 
     * @param id
     *            用户抵用劵ID
     * @return UserVoucher
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
    UserVoucher loadUserVoucherById(Integer id);

    /**
     * 分页获取用户抵用劵使用记录列表
     * 
     * @param userVoucherQuery
     *            查询条件
     * @return 分頁列表
     */
    Page<UserVoucherInfo> findUserVouchers(UserVoucherQuery userVoucherQuery);

    /**
     * 根据活动ID、抵用券ID获取用户抵用券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param vouIds
     *            抵用券ID列表
     * @return UserVoucher
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
    List<UserVoucher> listByActivityIdAndVouIds(@Param("activityId") Integer activityId,
            @Param("vouIds") List<Integer> vouIds);

    /**
     * 根据活动ID、抵用券ID、用户ID、用户抵用劵状态获取用户抵用券列表信息
     * 
     * @param activityId
     *            活动ID
     * @param vouIds
     *            抵用券ID列表
     * @param userId
     *            用户ID
     * @param statusList
     *            用户抵用劵状态列表
     * @return UserVoucher
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
    List<UserVoucher> listByActivityIdAndVouIdsAndUserIdAndStatus(@Param("activityId") Integer activityId,
            @Param("vouIds") List<Integer> vouIds, @Param("userId") Integer userId,
            @Param("statusList") List<String> statusList);

    /**
     * 获取需定时更新状态的抵用券列表
     * 
     * @param statusList
     *            用户抵用劵状态列表
     * @return List<UserVoucher>
     */
    List<UserVoucher> listVouchersForNeedAutoUpdateStatus(@Param("statusList") List<String> statusList);

    /**
     * 
     * 根据ID修改用户抵用劵的状态
     * 
     * @param id
     *            用户抵用劵ID
     * @param status
     *            状态
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
    Integer updateStatusById(@Param("id") Integer id, @Param("status") String status);

    /**
     * 根据状态分页获取用户抵用劵列表(状态有效无效根据时间计算)
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param usedStatus
     *            抵用券使用状态编码
     * @param isValid
     *            是否有效
     * @return 分頁列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER, DBTablesName.Trade.T_VOUCHER,
            DBTablesName.Trade.T_VOUCHER_PACKAGE })
    Page<UserVoucherInfo> findUserVouchersByRealTimeStatus(@Param("userId") Integer userId,
            @Param("currentTime") Date currentTime, @Param("usedStatus") String usedStatus,
            @Param("isValid") Boolean isValid);

    /**
     * 获取用户有效可用的抵用劵列表
     * 
     * @param userId
     *            用户ID
     * @param currentTime
     *            当前时间
     * @param usedStatus
     *            抵用券使用状态编码
     * @return 有效可用的抵用劵列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER, DBTablesName.Trade.T_VOUCHER,
            DBTablesName.Trade.T_VOUCHER_PACKAGE })
    List<UserVoucherInfo> listValidAndUsebleUserVouchers(@Param("userId") Integer userId,
            @Param("currentTime") Date currentTime, @Param("usedStatus") String usedStatus);

    /**
     * 根据用户ID和用户抵用券ID获取抵用券信息
     * 
     * @param userId
     *            用户ID
     * @param userVoucherId
     *            用户抵用券ID
     * @return 抵用劵信息
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_USER_VOUCHER, DBTablesName.Trade.T_VOUCHER,
            DBTablesName.Trade.T_VOUCHER_PACKAGE })
    UserVoucherInfo loadUserVoucherByUserIdAndUserVoucherId(@Param("userId") Integer userId,
            @Param("userVoucherId") Integer userVoucherId);

    /**
     * 获取用户有效抵用券的总数量
     * 
     * @param userId
     *            用户ID
     * @param usedStatus
     *            抵用券使用状态编码
     * @param currentTime
     *            当前时间
     * @return 用户抵用券总数量
     */
    Integer getValidUserVoucherCountByUserId(@Param("userId") Integer userId, @Param("usedStatus") String usedStatus,
            @Param("currentTime") Date currentTime);

	List<UserVoucher> getUserCouponByConPackIdAndBatchNo(@Param("vouPackId")Integer vouPackId, @Param("batchNo")String batchNo);

	/**
	 * 使用优惠券
	 * @param userVoucherId
	 * @param status
	 * @param useTime
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_USER_VOUCHER })
	void updateUseVoucherById(@Param("id") Integer id, @Param("status") String status, @Param("useTime") Date useTime);
}
