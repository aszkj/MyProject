package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.user.model.StoreSubsidyRecord;
import com.yilidi.o2o.user.model.combination.AllSubsidyInfo;
import com.yilidi.o2o.user.model.combination.StoreSubsidyCountInfo;
import com.yilidi.o2o.user.model.combination.StoreSubsidyRecordInfo;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

/**
 * 
 * @Description:TODO(店铺订单补贴(现金补贴，商品差价补贴，优惠券补贴，物流补贴)金额转可提现记录数据层操作接口类)
 * @author: llp
 * @date: 2015年11月10日 上午10:41:53
 * 
 */
public interface StoreSubsidyRecordMapper {

	/**
	 * 保存订单补贴记录
	 * 
	 * @param record
	 *            订单补贴记录
	 * @return 影响行数
	 */
	Integer save(StoreSubsidyRecord record);

	/**
	 * @Description TODO(根据查询条件，分页查询统计每个店铺的所有补贴金额：现金补贴，商品差价补贴，优惠补贴，物流补贴，以及补贴订单总数)
	 * @param query 查询条件
	 * @return Page<StoreSubsidyCountInfo>
	 */
	Page<StoreSubsidyCountInfo> findStoreSubsidyCountInfos(StoreSubsidyRecordQuery query);

	/**
	 * 根据查询条件分页查询门店账本明细记录（现金补贴，商品补贴，优惠券补贴，物流补贴）
	 * 
	 * @param query
	 *            查询条件对象
	 * @return Page<StoreSubsidyRecord>
	 */
	Page<StoreSubsidyRecordInfo> findStoreSubsidyRecords(StoreSubsidyRecordQuery query);

	/**
	 * 销量汇总统计 订单补贴相关
	 * 
	 * @param saleOrderNos
	 *            订单号列表
	 * @return AllSubsidyInfo
	 */
	AllSubsidyInfo statisticsAllSubsidyInfo(@Param("saleOrderNos") List<String> saleOrderNos);
	
	/**
	 * @Description TODO(分页获取导出门店账本明细记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 *  报表导出不使用缓存
	 */
	List<StoreSubsidyRecordInfo> listDataForExportStoreSubsidyRecord(
			@Param("storeSubsidyRecordQuery") StoreSubsidyRecordQuery query, @Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportStoreSubsidyRecord(StoreSubsidyRecordQuery query);
	
}