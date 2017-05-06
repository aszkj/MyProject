package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.order.model.Voucher;
import com.yilidi.o2o.order.model.query.VoucherQuery;
import com.yilidi.o2o.order.model.result.VoucherInfo;

/**
 * 抵用劵Mapper
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:51:28
 */
public interface VoucherMapper {

    /**
     * 新增保存
     * 
     * @param voucher
     *            实体
     * @return 影响的行数
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Trade.T_VOUCHER })
    Integer save(Voucher voucher);

    /**
     * 查询单张抵用券
     * 
     * @param id
     *            抵用券ID
     * @return Voucher
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
    Voucher loadVoucherById(Integer id);

    /**
     * 获取抢红包活动所需的抵用券列表
     * 
     * @param grantWay
     *            发放方式
     * @param activityStartDate
     *            抢红包活动开始有效时间
     * @param customerType
     *            客户类型编码
     * @param buyerUserType
     *            买家用户类型标示编码
     * @return List<Voucher>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
    List<Voucher> listVouPackIdForRedEnvelopeActivity(@Param("grantWay") String grantWay,
            @Param("activityStartDate") Date activityStartDate, @Param("customerType") String customerType,
            @Param("buyerUserType") String buyerUserType);

    /**
     * 根据抵用券包ID和发放时间获取抵用券列表
     * 
     * @param vouPackId
     *            抵用券包ID
     * @param grantTime
     *            发放时间
     * @return List<Voucher>
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
    List<Voucher> listByVouPackIdAndGrantTime(@Param("vouPackId") Integer vouPackId, @Param("grantTime") Date grantTime);
    
    /**
     * 抵用券发放记录列表
     * @param voucherQuery
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
	Page<VoucherInfo> findVoucherRecord(VoucherQuery voucherQuery);

	VoucherInfo getVoucherGrantRecord(@Param("vouPackId")Integer vouPackId, @Param("batchNo")String batchNo);
	
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
	List<Voucher> getVoucherByGrantWay(@Param("grantWay") String grantWay);

	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Trade.T_VOUCHER })
	List<Voucher> getValidRegistUsevoucherActive(@Param("nowTime") Date nowTime);

}
