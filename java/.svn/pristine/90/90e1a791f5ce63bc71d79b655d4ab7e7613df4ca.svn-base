/**
 * 文件名称：IProductClassMapStoreTypeService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductClassStoreTypeDto;

/**
 * 功能描述：产品类别与店铺类型映射接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductClassMapStoreTypeService {

	/**
	 * 根据前台传过来的productClass字符串组和StoreType保存产品类别店铺类型映射关系
	 * 
	 * @param mapString
	 *            productClass字符串组和StoreType
	 * @param createUserId
	 *            创建人
	 * @param creatTime
	 *            创建时间
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	Map<String, Object> saveProductClassStoreType(String mapString, Integer createUserId, Date creatTime) throws ProductServiceException;

	/**
	 * 根据前台传过来的产品类别店铺类型映射ID删除产品类别店铺类型映射信息*
	 * 
	 * @param ids
	 *            产品类别店铺类型映射关系id组字符串
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void deleteProductClassStoreType(String ids) throws ProductServiceException;

	/**
	 * 查询产品类别与店铺类型的映射关系列表
	 * 
	 * @param storeDictCode
	 *            店铺类别storeDictCode
	 * @param statusCode
	 *            店铺商品类别一级类别状态
	 * @return List<ProductClassStoreTypeRelatedInfo> 产品类别与店铺类型的映射关系列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	List<ProductClassStoreTypeDto> listBasicClassStoreType(String storeDictCode, String statusCode)
			throws ProductServiceException;
}