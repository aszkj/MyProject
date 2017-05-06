package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.ProductDto;

/**
 * 
 * @Description:TODO(产品相关报表Service接口)
 * @author: zxs
 * @date: 2015年11月19日 下午4:12:00
 * 
 */
public interface IProductRelatedReportService {

	/**
	 * 
	 * @Description TODO(分页获取报表数据)
	 * @param ProductDto
	 * @param startLineNum
	 * @param pageSize
	 * @return List<ProductDto>
	 * @throws ProductServiceException
	 */
	public List<ProductDto> listDataForExportProduct(ProductDto productDto, Long startLineNum, Integer pageSize)
			throws ProductServiceException;

	/**
	 * 
	 * @Description TODO(获取报表数据的总记录数)
	 * @param productDto
	 *        
	 * @return Long
	 * @throws ProductServiceException
	 */
	public Long getCountsForExportProduct(ProductDto productDto) throws ProductServiceException;

}
