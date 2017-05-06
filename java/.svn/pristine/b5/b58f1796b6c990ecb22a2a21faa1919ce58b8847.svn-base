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

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductClassMappingDto;

/**
 * 功能描述：一级产品类别与基础产品类别的映射关系接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductClassMappingService {

	/**
	 * 根据前台传过来的productChildClass字符串组和classCode保存一级产品类别与基础产品类别的映射关系
	 * 
	 * @param mapString
	 *            productChildClass字符串组和classCode
	 * @param createUserId
	 *            创建人
	 * @param creatTime
	 *            创建时间
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveProductClassMapping(String mapString, Integer createUserId, Date creatTime) throws ProductServiceException;

	/**
	 * 根据前台传过来的一级产品类别与基础产品类别的映射删除产品类别信息*
	 * 
	 * @param classCode
	 *            需要删除的一级产品类别的classCode
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void deleteAllProductClassMapping(String classCode) throws ProductServiceException;

	/**
	 * 查询一级产品类别与基础产品类别的映射列表
	 * 
	 * @param classCode
	 *            一级产品类别编码
	 * @param statusCode
	 *            产品基础类别编码状态
	 * @return List<ProductClassMappingDto> 一级产品类别与基础产品类别的映射列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	List<ProductClassMappingDto> listProductClassMapping(String classCode,String statusCode) throws ProductServiceException;

}