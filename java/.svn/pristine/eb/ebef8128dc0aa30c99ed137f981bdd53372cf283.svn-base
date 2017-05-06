package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.user.model.StoreProductSubsidy;
import com.yilidi.o2o.user.model.combination.StoreProductSubsidyInfo;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;

/**
 * 
 * @Description:TODO(店铺商品差价补贴金额转可提现记录数据层操作接口类) -商品补贴明细
 * @author:	llp
 * @date:	2015年11月10日 上午10:41:53 
 *
 */
public interface StoreProductSubsidyMapper {

	/**
	 * 保存订单商品差价补贴记录
	 * 
	 * @param storeProductSubsidy 订单商品差价补贴记录
	 * @return 影响行数
	 */
	Integer save(StoreProductSubsidy storeProductSubsidy);
	
	/**
	 * @Description  TODO(根据店铺ID，统计该店铺所有的商品差价补贴金额) 
	 * @param storeId
	 * @return
	 */
	Long countPriceSubsidy(Integer storeId);
	
	/**
	 * 根据查询条件分页查询商品差价补贴明细记录（商品差价补贴明细）
	 * @param query 查询条件对象
	 * @return Page<StoreProductSubsidyInfo>
	 */
	Page<StoreProductSubsidyInfo> findStoreProductSubsidies(StoreProductSubsidyQuery query);

	/**
	 * @Description TODO(分页获取导出商品差价补贴记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 *  报表导出不使用缓存
	 */
	List<StoreProductSubsidyInfo> listDataForExportProductSubsidy(
			@Param("storeProductSubsidyQuery") StoreProductSubsidyQuery query, @Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportProductSubsidy(StoreProductSubsidyQuery query);
}