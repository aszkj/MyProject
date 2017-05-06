/**
 * 文件名称：IProductService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.model.combination.ProductTempInfo;
import com.yilidi.o2o.product.service.dto.ProductTempBatchSaveDto;
import com.yilidi.o2o.product.service.dto.ProductTempDto;
import com.yilidi.o2o.product.service.dto.query.ProductTempQuery;

/**
 * 功能描述：临时产品服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductTempService {

	/**
	 * 根据barCode和channelCode查询临时产品信息
	 * 
	 * @param barCode
	 *            产品barCode
	 * @param channelCode
	 *            产品渠道编码
	 * @return 临时产品信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductTempDto loadProductTempByBarCodeAndChannelCode(String barCode, String channelCode) throws ProductServiceException;

	/**
	 * 根据id查询临时产品信息
	 * 
	 * @param tempId
	 *            产品tempId
	 * @return 临时产品信息
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductTempDto loadProductTempById(Integer tempId) throws ProductServiceException;

	/**
	 * 根据前台传过来的ProductTempDto保存临时产品信息
	 * 
	 * @param saveProductTempDto
	 *            临时产品信息
	 * @param channelCode
	 *            渠道编码
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveProductTempDto(ProductTempDto saveProductTempDto, String channelCode) throws ProductServiceException;

	/**
	 * 
	 * 产品批量导入保存至临时表
	 * 
	 * @param productTempDtoList
	 *            临时产品productTempDtoList
	 * @param objs
	 *            其他参数数组
	 * @throws ProductServiceException
	 *             产品域异常
	 */
	void saveProductTempDtoBatch(List<ProductTempDto> productTempDtoList, ProductTempBatchSaveDto objs) throws ProductServiceException;

	/**
	 * 根据条件查询产品相关信息
	 * 
	 * @param productTempQuery
	 *            产品查询dto
	 * @return 临时产品相关信息列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	YiLiDiPage<ProductTempDto> findProductTemps(ProductTempQuery productTempQuery) throws ProductServiceException;

	/**
	 * 
	 * 该条形码产品是否已经存在临时表中
	 * 
	 * @param barCode
	 *            产品barCode
	 * @param channelCode
	 *            产品channelCode
	 * @return boolean
	 * @throws ProductServiceException
	 *             产品域异常
	 */
	boolean checkBarCodeIsExistInProductTemp(String barCode, String channelCode) throws ProductServiceException;

	/**
	 * 
	 * 依据id删除临时表中产品
	 * 
	 * @param tempId
	 *            临时产品tempId
	 * @throws ProductServiceException
	 *             产品域异常
	 */
	void deleteProductTemp(Integer tempId) throws ProductServiceException;
	
	/**
	 * 
	 * 删除所有临时表中产品
	 * 
	 * @throws ProductServiceException
	 *             产品域异常
	 */
	void deleteAllProductTemp() throws ProductServiceException;

	/**
	 * 
	 * 将所有的临时表的产品添加到标准库
	 * @param productTempQuery
	 *            查询实体
	 * @param channelCode
	 *            渠道编码channelCode
	 * @param createUserId
	 *            添加人
	 * @param createTime
	 *            添加时间
	 * @return String
	 * @throws ProductServiceException
	 *             产品域异常
	 */
	List<String> addAllTempProductToStandard(ProductTempQuery productTempQuery, String channelCode, Integer createUserId,
			Date createTime) throws ProductServiceException;

	/**
	 * 根据条件查询临时产品相关信息
	 * 
	 * @param productTempQuery
	 *            产品查询dto
	 * @return 临时产品相关信息列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	List<ProductTempInfo> listProductTemp(ProductTempQuery productTempQuery) throws ProductServiceException;
	
	/**
	 * 获取所有临时产品的条形码
	 * 
	 * @return 临时产品条形码相关信息列表
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	Set<String> getProductTempBarCode() throws ProductServiceException;
}