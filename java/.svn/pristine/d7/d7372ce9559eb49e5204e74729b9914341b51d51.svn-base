package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.StoreProductSubsidyDto;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;

/**
 * 
 * @Description:TODO(店铺商品差价补贴金额转可提现记录数据层操作接口类类) 
 * @author:	llp
 * @date:	2015年11月11日 下午2:14:23 
 *
 */
public interface IStoreProductSubsidyService {

	/**
	 * 保存订单商品差价补贴记录
	 * @param storeProductSubsidy 订单商品差价补贴记录
	 */
	public void save(StoreProductSubsidyDto storeProductSubsidyDto) throws UserServiceException;

	/**
	 * @Description  TODO(根据店铺ID，统计该店铺所有的商品差价补贴金额)
	 * @param storeId
	 * @return
	 */
	public Long countPriceSubsidy(Integer storeId) throws UserServiceException;

	/**
	 * 根据查询条件分页查询商品差价补贴明细记录（商品差价补贴明细）
	 * @param query 查询条件对象
	 * @return Page<StoreProductSubsidyDto> YiLiDiPage 分页数据
	 */
	public YiLiDiPage<StoreProductSubsidyDto> findStoreProductSubsidies(StoreProductSubsidyQuery query) throws UserServiceException;

	/**
	 * @Description TODO(分页获取导出商品差价补贴记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return
	 */
	public List<StoreProductSubsidyDto> listDataForExportProductSubsidy(StoreProductSubsidyQuery query, Long startLineNum,
			Integer pageSize) throws UserServiceException;

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 */
	public Long getCountsForExportProductSubsidy(StoreProductSubsidyQuery query) throws UserServiceException;
}
