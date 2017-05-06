package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.VoucherPackage;
import com.yilidi.o2o.order.model.query.VoucherPackageQuery;

/**
 * 抵用券包Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:28:27
 */
public interface VoucherPackageMapper {

    /**
     * 新增保存
     * 
     * @param voucherPackage
     *            抵用劵包实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_VOUCHER_PACKAGE })
    Integer save(VoucherPackage voucherPackage);

    /**
     * 更新
     * 
     * @param voucherPackage
     *            抵用劵包实体
     * @return 影响行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_VOUCHER_PACKAGE })
    Integer update(VoucherPackage voucherPackage);

    /**
     * 根据ID查询抵用劵包信息
     * 
     * @param id
     *            抵用劵包ID
     * @return VoucherPackage
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER_PACKAGE })
    VoucherPackage loadById(Integer id);

    /**
     * 
     * 根据ID修改抵用劵包的状态，
     * 
     * @param id
     *            抵用劵包ID
     * @param state
     *            状态
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_VOUCHER_PACKAGE })
    Integer updateStateById(@Param("id") Integer id, @Param("state") String state,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);

    /**
     * 
     * 分頁查询列表
     * 
     * @param voucherPackageQuery
     *            查询条件
     * @return 分頁列表
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER_PACKAGE })
    Page<VoucherPackage> findVoucherPackages(VoucherPackageQuery voucherPackageQuery);

	List<VoucherPackage> listAvailableVoucherPackage();

}
