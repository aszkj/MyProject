package com.yilidi.o2o.product.service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.StoreProductSubsidySettingDto;
import com.yilidi.o2o.product.service.dto.query.StoreProductSubsidySettingQuery;

/**
 * 
 * @Description:TODO(补贴商品设置服务接口类) 
 * @author:	llp
 * @date:	2015年11月10日 下午2:14:23 
 *
 */
public interface IStoreProductSubsidySettingService {

	/**
	 * 保存补贴商品的设置记录
	 * @param recordDto 补贴商品记录
	 */
	void save(StoreProductSubsidySettingDto recordDto) throws ProductServiceException;
	
	/**
	 * @Description  TODO(删除补贴商品的设置) 
	 * @param id
	 */
	void deleteById(Integer id) throws ProductServiceException;

	/**
	 * @Description  TODO(根据查询条件分页查询补贴商品设置记录DTO) 
	 * @param query
	 * @return Page<StoreProductSubsidySettingDto> YiLiDiPage分页数据
	 * @throws ProductServiceException
	 */
	YiLiDiPage<StoreProductSubsidySettingDto> findStoreProductSubsidySettings(StoreProductSubsidySettingQuery query) throws ProductServiceException;
	
	/**
	 * @Description  TODO(根据查询条件分页查询门店商品记录) 
	 * @param query
	 * @return Page<StoreProductSubsidySettingInfo> YiLiDiPage分页数据
	 * @throws ProductServiceException
	 */
	YiLiDiPage<StoreProductSubsidySettingDto> findStoreProducts(StoreProductSubsidySettingQuery query) throws ProductServiceException;
}
