package com.yilidi.o2o.product.dao;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.StoreProductSubsidySetting;
import com.yilidi.o2o.product.model.combination.StoreProductSubsidySettingInfo;
import com.yilidi.o2o.product.service.dto.query.StoreProductSubsidySettingQuery;

/**
 * 
 * @Description:TODO(店铺商品补贴设置(商品差价补贴)数据层操作接口类) 
 * @author:	llp
 * @date:	2015年11月10日 上午10:41:53 
 *
 */
public interface StoreProductSubsidySettingMapper {

	/**
	 * 保存补贴商品的设置记录
	 * 
	 * @param record 补贴商品记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_PRODUCT_SUBSIDY_SETTING })
	Integer save(StoreProductSubsidySetting record);
	
	/**
	 * 
	 * @Description  TODO(删除补贴商品的设置) 
	 * @param id
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_STORE_PRODUCT_SUBSIDY_SETTING })
	Integer deleteById(Integer id);
	
	/**
	 * @Description  TODO(通过门店ID和产品ID，查找是否存在该补贴商品) 
	 * @param storeId
	 * @param saleProductId
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_PRODUCT_SUBSIDY_SETTING })
	StoreProductSubsidySetting loadStoreProductSubsidy(@Param("storeId") Integer storeId,
			@Param("saleProductId") Integer saleProductId);

	/**
	 * @Description  TODO(根据查询条件分页查询补贴商品设置记录) 
	 * @param query
	 * @return Page<StoreProductSubsidySettingInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_STORE_PRODUCT_SUBSIDY_SETTING,
			DBTablesName.Product.P_SALE_PRODUCT })
	Page<StoreProductSubsidySettingInfo> findStoreProductSubsidySettings(StoreProductSubsidySettingQuery query);
	
	/**
	 * @Description  TODO(根据查询条件分页查询门店商品记录) 
	 * @param query
	 * @return Page<StoreProductSubsidySettingInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_SALE_PRODUCT,
			DBTablesName.Product.P_PRODUCT_CLASS })
	Page<StoreProductSubsidySettingInfo> findStoreProducts(StoreProductSubsidySettingQuery query);
	
}