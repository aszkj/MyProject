/**
 * 文件名称：ProductClassService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.product.dao.ProductClassMappingMapper;
import com.yilidi.o2o.product.model.ProductClassMapping;
import com.yilidi.o2o.product.model.combination.ProductClassMappingRelatedInfo;
import com.yilidi.o2o.product.service.IProductClassMappingService;
import com.yilidi.o2o.product.service.dto.ProductClassMappingDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 功能描述:一级产品类别与基础产品类别的映射关系接口服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productClassMappingService")
public class ProductClassMappingServiceImpl extends BasicDataService implements IProductClassMappingService {

	@Autowired
	private ProductClassMappingMapper productClassMappingMapper;

	@Override
	public void saveProductClassMapping(String mapString, Integer createUserId, Date creatTime)
			throws ProductServiceException {
		try {

			// 检查产品类别与店铺类型映射关系参数是否为空
			if (ObjectUtils.isNullOrEmpty(mapString)) {
				logger.error("ProductService.saveProductClassMapping => 保存一级产品类别与基础类别映射关系参数为空");
				throw new ProductServiceException("保存一级产品类别与基础类别映射关系参数为空");
			}
			// 检查产品类别与店铺类型映射关系createUserId是否为空
			if (ObjectUtils.isNullOrEmpty(createUserId)) {
				logger.error("ProductService.saveProductClassMapping.createUserId => 映射关系createUserId为空");
				throw new ProductServiceException("保存一级产品类别与基础类别映射关系createUserId参数为空");
			}
			// 检查产品类别与店铺类型映射关系createTime是否为空
			if (ObjectUtils.isNullOrEmpty(creatTime)) {
				logger.error("ProductService.saveProductClassMapping.createTime => 映射关系createTime为空");
				throw new ProductServiceException("保存一级产品类别与基础类别映射关系createTime参数为空");
			}
			List<ProductClassMapping> productClassMappingList = this.pakageClassMappings(mapString, createUserId, creatTime);

			if (!ObjectUtils.isNullOrEmpty(productClassMappingList)) {
				productClassMappingMapper.saveProductClassMapping(productClassMappingList);
			}

		} catch (ProductServiceException e) {
			logger.error("保存一级产品类别与基础类别映射关系出错", e);
			throw new ProductServiceException("异常：保存一级产品类别与基础类别映射关系出错");
		}

	}

	// 将字符串拆分成参数信息封装成dto信息
	private List<ProductClassMapping> pakageClassMappings(String mapString, Integer createUserId, Date createTime)
			throws ProductServiceException {
		List<ProductClassMapping> productClassMappingList = null;
		try {
			// 检查一级产品类别与基础类别映射关系参数是否为空
			if (ObjectUtils.isNullOrEmpty(mapString)) {
				logger.error("ProductService.saveProductClassMapping => 封装一级产品类别与基础类别映射关系参数为空");
				throw new ProductServiceException("封装一级产品类别与基础类别映射关系参数为空");
			}
			// 检查一级产品类别与基础类别映射关系createUserId是否为空
			if (ObjectUtils.isNullOrEmpty(createUserId)) {
				logger.error("ProductService.saveProductClassMapping.createUserId => 映射关系createUserId为空");
				throw new ProductServiceException("封装一级产品类别与基础类别映射关系createUserId参数为空");
			}
			// 检查一级产品类别与基础类别映射关系createTime是否为空
			if (ObjectUtils.isNullOrEmpty(createTime)) {
				logger.error("ProductService.saveProductClassMapping.createTime => 映射关系createTime为空");
				throw new ProductServiceException("封装一级产品类别与基础类别映射关系createTime参数为空");
			}
			productClassMappingList = new ArrayList<ProductClassMapping>();
			String[] mapArrayStrings = mapString.split(",");
			Integer lastIndex = mapArrayStrings.length - 1;
			for (int i = 0; i < mapArrayStrings.length - 1; i++) {
				ProductClassMapping productClassMapping = null;
				if (!ObjectUtils.isNullOrEmpty(mapArrayStrings[i])) {
					productClassMapping = new ProductClassMapping();
					productClassMapping.setClassCode(mapArrayStrings[lastIndex]);
					productClassMapping.setChildClassCode(mapArrayStrings[i]);
					productClassMapping.setCreateUserId(createUserId);
					productClassMapping.setCreateTime(createTime);
					productClassMappingList.add(productClassMapping);
				}
			}
			// 删除所有原本的映射关系
//			this.deleteAllProductClassMapping(mapArrayStrings[lastIndex]);

			return productClassMappingList;
		} catch (ProductServiceException e) {
			logger.error("封装一级产品类别与基础类别映射关系出错", e);
			throw new ProductServiceException("异常：封装一级产品类别与基础类别映射关系出错");
		}
	}

	@Override
	public void deleteAllProductClassMapping(String classCode) throws ProductServiceException {
		try {
			// 检查产品类别与店铺类型映射关系参数是否为空
			if (ObjectUtils.isNullOrEmpty(classCode)) {
				logger.error("ProductService.deleteAllProductClassMapping => 删除产品类别与店铺类型映射关系参数classCode为空");
				throw new ProductServiceException("删除产品类别与店铺类型映射关系参数classCode为空");
			}
			// 删除所有的classCode的映射信息
			productClassMappingMapper.deleteAllProductClassMapping(classCode);
		} catch (ProductServiceException e) {
			logger.error("删除产品类别与店铺类型映射关系出错");
			throw new ProductServiceException("异常：删除产品类别与店铺类型映射关系出错");
		}

	}

	@Override
	public List<ProductClassMappingDto> listProductClassMapping(String classCode,String statusCode) throws ProductServiceException {
		logger.debug("classCode -> " + classCode);
		try {
			if (ObjectUtils.isNullOrEmpty(classCode)) {
				logger.error("产品类别与店铺类型映射查询参数为空");
				throw new ProductServiceException("异常：产品类别与店铺类型映射查询参数为空");
			}
			List<ProductClassMappingRelatedInfo> productClassMappingRelatedInfoList = productClassMappingMapper
					.listProductClassMapping(classCode,statusCode);
			List<ProductClassMappingDto> productClassMappingDtoList = null;
			if (!ObjectUtils.isNullOrEmpty(productClassMappingRelatedInfoList)) {
				productClassMappingDtoList = new ArrayList<ProductClassMappingDto>();
				for (ProductClassMappingRelatedInfo pt : productClassMappingRelatedInfoList) {
					ProductClassMappingDto productClassMappingDto = null;
					if (!ObjectUtils.isNullOrEmpty(pt)) {
						productClassMappingDto = new ProductClassMappingDto();
						ObjectUtils.fastCopy(pt, productClassMappingDto);
						productClassMappingDtoList.add(productClassMappingDto);
					}
				}
			}
			return productClassMappingDtoList;
		} catch (ProductServiceException e) {
			logger.error("条件查询产品类别列表出错");
			throw new ProductServiceException(e.getMessage());
		}
	}

}
