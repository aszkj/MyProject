/**
 * 文件名称：IProductBasicPropsService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductBasicPropsDto;


/**
 * 功能描述：产品基础属性服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductBasicPropsService {
	/**
	 * 根据前台传过来的saveProductBasicProps保存产品基础属性信息
	 * 
	 * @param saveProductBasicPropsDto
	 *            产品基础属性Dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void saveProductBasicProps(List<ProductBasicPropsDto> saveProductBasicPropsDto) throws ProductServiceException;
	/**
	 * 根据产品类别查询产品基础属性信息
	 * 
	 * @param productClassCode
	 *            产品基础属性Dto
	 * @return  产品类别的基础属性
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	List<ProductBasicPropsDto> listProductBasicProps(String productClassCode) throws ProductServiceException;
	/**
	 * 根据产品类别查询产品基础属性信息
	 * 
	 * @param productClassCode
	 *            产品基础属性Dto
	 * @return  产品类别的基础属性
	 * @throws ProductServiceException
	 *             产品域服务异常
	 *//*
	List<ProductBasicPropsDto> listProductBasicProps(String productClassCode) throws ProductServiceException;*/
	/**
	 * 根据产品类别和产品Id查询某一产品的基础属性信息
	 * 
	 * @param productClassCode
	 *            产品类别编码
	 * @param productId
	 *            产品Id
	 * @return  产品类别的基础属性
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	ProductBasicPropsDto loadProductBasicProps(String productClassCode, Integer productId) throws ProductServiceException;
	/**
	 * 更新产品的基础属性信息
	 * 
	 * @param saveProductBasicPropsDto
	 *            产品基础属性Dto
	 * @throws ProductServiceException
	 *             产品域服务异常
	 */
	void updateProductBasicProps(List<ProductBasicPropsDto> saveProductBasicPropsDto) throws ProductServiceException;
	
}