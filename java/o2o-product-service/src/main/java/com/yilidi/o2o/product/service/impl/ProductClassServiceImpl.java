/**
 * 文件名称：ProductClassService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.product.dao.ProductClassMapper;
import com.yilidi.o2o.product.dao.StoreTypeProductClassMapper;
import com.yilidi.o2o.product.model.ProductClass;
import com.yilidi.o2o.product.model.StoreTypeProductClass;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.StoreTypeProductClassDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 功能描述:产品类别服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productClassService")
public class ProductClassServiceImpl extends BasicDataService implements IProductClassService {

	private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";
	@Autowired
	private ProductClassMapper productClassMapper;
	@Autowired
	private StoreTypeProductClassMapper storeTypeProductClassMapper;
	@Autowired
	private IProductService productService;
	@Autowired
	private ISaleProductService saleProductService;
	@Autowired
	private IStoreProfileProxyService storeProfileProxyService;

	@Override
	public void saveProductClass(ProductClassDto saveProductClassDto) throws ProductServiceException {
		// 保存产品类别表开始
		logger.debug("saveProductClassDto -> " + saveProductClassDto);
		try {
			// 检查产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductClassDto)) {
				logger.error("ProductService.saveProductClassDto => 产品参数为空");
				throw new ProductServiceException("ProductService的saveProductClass方法参数为空");
			}
			// 产品类别编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductClassDto.getClassCode())) {
				logger.error("saveProductClassDto.classCode => 产品类别编码参数为空");
				throw new ProductServiceException("产品类别编码参数为空");
			} else {
				// 判断输入的产品编码是否已经存在
				ProductClass productClassLoad = productClassMapper.loadProductClassByClassCode(
						saveProductClassDto.getClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
				if (!ObjectUtils.isNullOrEmpty(productClassLoad)) {
					logger.error("saveProductClassDto.classCode => 产品类别编码" + saveProductClassDto.getClassCode() + "重复");
					throw new ProductServiceException("产品类别编码" + saveProductClassDto.getClassCode() + "重复");
				}
				// 产品类别名称是否为空
				if (ObjectUtils.isNullOrEmpty(saveProductClassDto.getClassName())) {
					logger.error("saveProductClassDto.className => 产品类别名称参数为空");
					throw new ProductServiceException("产品类别名称参数为空");
				}
				// 产品类别图片Url是否为空
				if (ObjectUtils.isNullOrEmpty(saveProductClassDto.getClassImageUrl())) {
					logger.error("saveProductClassDto.classImageUrl => 产品类别图片Url参数为空");
					throw new ProductServiceException("产品类别图片Url参数为空");
				}
				// 产品类别创建者ID是否为空
				if (ObjectUtils.isNullOrEmpty(saveProductClassDto.getCreateUserId())) {
					logger.error("saveProductClassDto.createUserId => 产品类别创建者ID参数为空");
					throw new ProductServiceException("产品类别创建者ID参数为空");
				}
				// 产品类别创建时间是否为空
				if (ObjectUtils.isNullOrEmpty(saveProductClassDto.getCreateTime())) {
					logger.error("saveProductClassDto.createTime => 产品类别创建时间参数为空");
					throw new ProductServiceException("产品类别创建时间参数为空");
				}
				// 判断相同类别名称是否有相同
				if (!ObjectUtils.isNullOrEmpty(this.loadProductClassByClassName(saveProductClassDto.getClassName()))) {
					logger.error("saveProductClassDto.className => 产品类别名称" + saveProductClassDto.getClassName()
					+ "判断类别名称是否有相同,请避免有相同类别名称类别");
					throw new ProductServiceException(
							"产品类别名称为" + saveProductClassDto.getClassName() + "有相同的名称,请避免有相同类别名称类别");
				}

				ProductClass productClass = new ProductClass();
				productClass.setClassCode(saveProductClassDto.getClassCode());
				productClass.setClassName(saveProductClassDto.getClassName());
				String classLevel = "";
				if (saveProductClassDto.getClassLevel().equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_TOP)) {
					classLevel = SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST;
				} else if (saveProductClassDto.getClassLevel()
						.equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_FIRST)) {
					classLevel = SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_SECOND;
				} else if (saveProductClassDto.getClassLevel()
						.equals(SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_SECOND)) {
					classLevel = SystemContext.ProductDomain.PRODUCTCLASSSLEVEL_THIRD;
				}
				productClass.setClassLevel(classLevel);
				productClass.setClassImageUrl(saveProductClassDto.getClassImageUrl());
				productClass.setClassSort(saveProductClassDto.getClassSort());
				productClass.setNote(saveProductClassDto.getNote());
				productClass.setStatusCode(saveProductClassDto.getStatusCode());
				productClass.setDisplay(StringUtils.defaultIfBlank(saveProductClassDto.getDisplay(),
						SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES));
				productClass.setCreateUserId(saveProductClassDto.getCreateUserId());
				productClass.setCreateTime(saveProductClassDto.getCreateTime());
				productClassMapper.saveProductClass(productClass);

				// 产品类别保存成功之后，处理产品类别临时图片
				// 产品类别图片标示不为空并且其为增加，将图片更新到正式的环境
				operateProductClassImage(saveProductClassDto.getImageFlag(), saveProductClassDto.getDelImageUrl(),
						saveProductClassDto.getClassImageUrl());
			}

		} catch (ProductServiceException e) {
			logger.error("保存产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
	}


	// 处理服务器图片
	private void operateProductClassImage(String imageFlag, String delImageUrl, String classImageUrl)
			throws ProductServiceException {
		try {
			// 产品类别保存成功之后，处理产品类别临时图片
			// 产品类别图片标示不为空并且其为增加，将图片更新到正式的环境
			FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
			if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
				fileUploadUtils.uploadPublishFile(classImageUrl);
			}
			// 如果有需要删除的图片，正式环境服务器上的图片删除
			if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
				fileUploadUtils.deletePublishFile(delImageUrl);
			}
		} catch (ProductServiceException e) {
			logger.error("处理产品类别图片出错");
			throw new ProductServiceException("异常：处理产品类别图片出错");
		}
	}

	@Override
	public void updateProductClass(ProductClassDto updateProductClassDto) throws ProductServiceException {
		// 更新产品类别表开始
		logger.debug("updateProductClassDto -> " + updateProductClassDto);
		// 检查产品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto)) {
			logger.error("ProductClassService.updateProductClassDto => 需要更新的产品类别参数为空");
			throw new ProductServiceException("需要更新的产品类别参数为空");
		}
		// 检查产品类别编码是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto.getClassCode())) {
			logger.error("updateProductClass.classCode => 需要更新的产品类别编码为不存在");
			throw new ProductServiceException("需要更新的产品类别编码为不存在");
		}
		// 检查产品类状态是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto.getStatusCode())) {
			logger.error("ProductService.updateProductClassDto.statusCode => 产品分类状态为空");
			throw new ProductServiceException("需要更新的产品类状态为空");
		}
		// 检查产品类是否显示是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto.getDisplay())) {
			logger.error("ProductService.updateProductClassDto.display => 产品分类是否显示为空");
			throw new ProductServiceException("需要更新的产品类是否显示为空");
		}
		// 检查产品类别修改人是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto.getModifyUserId())) {
			logger.error("ProductService.updateProductClassDto.modifyUserId=> 产品类别修改人为空");
			throw new ProductServiceException("需要更新的产品类别修改人id为空");
		}
		// 检查产品类别修改时间是否为空
		if (ObjectUtils.isNullOrEmpty(updateProductClassDto.getModifyTime())) {
			logger.error("ProductService.updateProductClassDto.modifyTime => 产品类别修改时间为空");
			throw new ProductServiceException("需要更新的产品类别修改时间为空");
		}
		// 更新产品类别
		try {
			ProductClass productClass = productClassMapper.loadProductClassByClassCode(updateProductClassDto.getClassCode(),
					null);
			// 更新产品类别
			if (!ObjectUtils.isNullOrEmpty(productClass)) {
				if (ObjectUtils.whetherModified(productClass.getClassName(), updateProductClassDto.getClassName())
						|| ObjectUtils.whetherModified(productClass.getClassImageUrl(),
								updateProductClassDto.getClassImageUrl())
						|| ObjectUtils.whetherModified(productClass.getClassSort(), updateProductClassDto.getClassSort())
						|| ObjectUtils.whetherModified(productClass.getNote(), updateProductClassDto.getNote())
						|| ObjectUtils.whetherModified(productClass.getStatusCode(), updateProductClassDto.getStatusCode())
						|| ObjectUtils.whetherModified(productClass.getDisplay(), updateProductClassDto.getDisplay())) {
					productClass.setClassName(updateProductClassDto.getClassName());
					productClass.setClassImageUrl(updateProductClassDto.getClassImageUrl());
					productClass.setClassSort(updateProductClassDto.getClassSort());
					productClass.setStatusCode(updateProductClassDto.getStatusCode());
					productClass.setDisplay(updateProductClassDto.getDisplay());
					productClass.setNote(updateProductClassDto.getNote());
					productClass.setStatusCode(updateProductClassDto.getStatusCode());
					productClass.setModifyTime(updateProductClassDto.getModifyTime());
					productClass.setModifyUserId(updateProductClassDto.getModifyUserId());
					productClassMapper.updateProductClassByClassCode(productClass);

					// 产品类别保存成功之后，处理产品类别临时图片
					// 产品类别图片标示不为空并且其为增加，将图片更新到正式的环境
					operateProductClassImage(updateProductClassDto.getImageFlag(), updateProductClassDto.getDelImageUrl(),
							updateProductClassDto.getClassImageUrl());
				}
			}

		} catch (ProductServiceException e) {
			logger.error("更新产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}

	}

	@Override
	public List<ProductClassDto> listProductClass(ProductClassQuery queryProductClass) throws ProductServiceException {
		logger.debug("queryProductClass -> " + queryProductClass);
		try {
			if (ObjectUtils.isNullOrEmpty(queryProductClass)) {
				logger.error("产品类别查询参数为空");
				throw new ProductServiceException("异常：产品类别查询参数为空");
			}
			List<ProductClass> productClassList = productClassMapper.listProductClass(queryProductClass);
			List<ProductClassDto> productClassDtoList = null;
			if (!ObjectUtils.isNullOrEmpty(productClassList)) {
				productClassDtoList = new ArrayList<ProductClassDto>();
				for (ProductClass productClass : productClassList) {
					ProductClassDto productClassDto = new ProductClassDto();
					ObjectUtils.fastCopy(productClass, productClassDto);
					productClassDtoList.add(productClassDto);
				}
			}
			return productClassDtoList;
		} catch (ProductServiceException e) {
			logger.error("条件查询产品类别列表出错");
			throw new ProductServiceException(e.getMessage());
		}
	}

	@Override
	public YiLiDiPage<ProductClassDto> findProductClass(ProductClassQuery queryProductClass) throws ProductServiceException {
		logger.debug("queryProductClass -> " + queryProductClass);
		try {
			if (null == queryProductClass.getStart() || queryProductClass.getStart() <= 0) {
				queryProductClass.setStart(1);
			}
			if (null == queryProductClass.getPageSize() || queryProductClass.getPageSize() <= 0) {
				queryProductClass.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(queryProductClass.getStart(), queryProductClass.getPageSize());
			Page<ProductClass> page = productClassMapper.findProductClass(queryProductClass);
			Page<ProductClassDto> pageDto = new Page<ProductClassDto>(queryProductClass.getStart(),
					queryProductClass.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);

			List<ProductClass> productClassList = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(productClassList)) {
				for (ProductClass pc : productClassList) {
					ProductClassDto pDto = null;
					if (!ObjectUtils.isNullOrEmpty(pc)) {
						pDto = new ProductClassDto();
						ObjectUtils.fastCopy(pc, pDto);
						// 将状态转换为状态名称
						pDto.setStatusCodeName(super.getSystemDictName(
								SystemContext.ProductDomain.DictType.PRODUCTCLASSSTATUS.getValue(), pc.getStatusCode()));
						pageDto.add(pDto);
					}
				}
			}

			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (ProductServiceException e) {
			logger.error("依据类别状态查询查询产品类别列表出错");
			throw new ProductServiceException(e.getMessage());
		}
	}

	@Override
	public ProductClassDto loadProductClassByClassCode(String classCode, String statusCode) throws ProductServiceException {
		logger.debug("classCode -> " + classCode);
		ProductClassDto productClassDto = null;
		// 检查产品参数classCode是否为空
		if (ObjectUtils.isNullOrEmpty(classCode)) {
			logger.error("loadProductClassByClassCode.classCode => 产品类别参数classCode为空");
			throw new ProductServiceException("产品参数类别编码为空");
		}
		try {
			ProductClass productClass = productClassMapper.loadProductClassByClassCode(classCode, statusCode);
			if (!ObjectUtils.isNullOrEmpty(productClass)) {
				productClassDto = new ProductClassDto();
				ObjectUtils.fastCopy(productClass, productClassDto);
			}
		} catch (ProductServiceException e) {
			logger.error("查询产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
		return productClassDto;
	}

	/**
	 * 据上一级code获取下一级分类（dao层提供通用接口）
	 * 
	 * @param productClassQuery
	 * @return
	 */
	public List<ProductClass> getAllNextProductClassByUpCodeBasic(ProductClassQuery productClassQuery) throws ProductServiceException{
		return productClassMapper.getAllNextProductClassByUpCode(productClassQuery);
	}

	/**
	 * 根据上一级code获取下一级分类(为controller提供通用接口)
	 * 
	 * <p>
	 * Title: getAllNextProductClassByUpCode
	 * </p>
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param classCode
	 * @return
	 * @throws ProductServiceException
	 * @see com.yilidi.o2o.product.service.IProductClassService#getAllNextProductClassByUpCode(java.lang.String)
	 */
	@Override
	public List<ProductClassDto> getAllNextProductClassByUpCode(ProductClassQuery productClassQuery)
			throws ProductServiceException {
		List<ProductClassDto> productClassDtoList = null;
		ProductClassDto productClassDto = null;
		try {
			List<ProductClass> productClassList = this.getAllNextProductClassByUpCodeBasic(productClassQuery);
			if (!ObjectUtils.isNullOrEmpty(productClassList)) {
				productClassDtoList = new ArrayList<ProductClassDto>();
				ObjectUtils.fastCopy(productClassList, productClassDtoList);
				for (ProductClass productClass : productClassList) {
					productClassDto = new ProductClassDto();
					ObjectUtils.fastCopy(productClass, productClassDto);
					productClassDtoList.add(productClassDto);
				}
			}
			return productClassDtoList;
		} catch (Exception e) {
			logger.info("根据上一级code获取下一级分类异常");
			throw new ProductServiceException(e.getMessage());
		}
	}

	/**
	 * 用于组装tree下一级节点
	 * 
	 * @param productClassQuery
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getAllNextTreeNode(ProductClassQuery productClassQuery) throws ProductServiceException{
		List<Map<String, Object>> mapList = null;
		try {
			List<ProductClass> productClassList = this.getAllNextProductClassByUpCodeBasic(productClassQuery);
			if (!ObjectUtils.isNullOrEmpty(productClassList)) {
				mapList = new ArrayList<Map<String, Object>>();
				for (ProductClass productClass : productClassList) {
					mapList.add(this.getTreeNode(productClass));
				}
			}
			return mapList;
		} catch (Exception e) {
			logger.info("组装treeNode下一级异常");
			throw new ProductServiceException(e.getMessage());
		}
	}

	private Map<String, Object> getTreeNode(ProductClass productClass) {
		Map<String, Object> result = null;
		try {
			if (!ObjectUtils.isNullOrEmpty(productClass)) {
				result = new LinkedHashMap<String, Object>();
				if (!ObjectUtils.isNullOrEmpty(productClass.getClassSort())) {
					result.put("text", productClass.getClassName() + "(" + productClass.getClassSort() + ")");
				} else {
					result.put("text", productClass.getClassName());
				}
				result.put("id", productClass.getId());
				ProductClassQuery query = new ProductClassQuery();
				query.setClassCode(productClass.getClassCode());
				if (ObjectUtils.isNullOrEmpty(this.getAllNextProductClassByUpCodeBasic(query))) {
					result.put("hasChildren", false);
				} else {
					result.put("hasChildren", true);
				}
				result.put("classCode", productClass.getClassCode());
				result.put("statusCode", productClass.getStatusCode());
				result.put("classLevel", productClass.getClassLevel());
				result.put("isLoaded", "0");
				// 查询该产品类别是否存在产品和商品
				if (isCanBeFreeze(productClass.getClassCode())) {
					result.put("isCanDelete", true);
				} else {
					result.put("isCanDelete", false);
				}

			}
		} catch (ProductServiceException e) {
			logger.error("查询产品类别树形结构出错");
			throw new ProductServiceException(e.getMessage());
		}
		return result;
	}

	@Override
	public String deleteProductClassById(Integer id) throws ProductServiceException {
		logger.debug("id -> " + id);
		String errorString = "";
		try {
			// 检查产品参数classCode是否为空
			if (ObjectUtils.isNullOrEmpty(id)) {
				logger.error("deleteProductClassById.id => 产品类别参数id为空");
				throw new ProductServiceException("产品参数产品id为空");
			}
			// 处理图片
			ProductClassDto productClassDto = this.loadProductClassById(id);
			// 判断是否可以删除
			if (isCanBeFreeze(productClassDto.getClassCode())) {
				productClassMapper.deleteProductClassById(id);
				// 如果有需要删除的图片，正式环境服务器上的图片删除
				FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
				if (!ObjectUtils.isNullOrEmpty(productClassDto)
						&& !ObjectUtils.isNullOrEmpty(productClassDto.getClassImageUrl())) {
					fileUploadUtils.deletePublishFile(productClassDto.getClassImageUrl());
				}
			} else {
				errorString = "该产品类别不能被删除，因为其有相关联的产品或者店铺商品存在";
			}
		} catch (ProductServiceException e) {
			logger.error("删除产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
		return errorString;
	}

	@Override
	public String updateStatusCodeById(String statusCode, String classCode, Integer modifyUserId, Date modifyTime)
			throws ProductServiceException {
		logger.debug("statusCode -> " + statusCode + "classCode -> " + classCode + "modifyUserId -> " + modifyUserId
				+ "modifyTime -> " + modifyTime);
		String errorString = "";
		try {
			// 检查产品类别参数类别编码是否为空
			if (ObjectUtils.isNullOrEmpty(classCode)) {
				logger.error("id => 更新产品类别参数classCode为空");
				throw new ProductServiceException("需要更新的产品类别参数classCode为空");
			}
			// 检查产品类别参数id是否为空
			if (ObjectUtils.isNullOrEmpty(statusCode)) {
				logger.error("updateStatusCodeById.statusCode => 更新产品类别参数statusCode为空");
				throw new ProductServiceException("需要更新的产品类别状态编码为空");
			}
			// 检查产品类别修改人id是否为空
			if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
				logger.error("updateStatusCodeById.modifyUserId => 更新产品类别类别参数modifyUserId为空");
				throw new ProductServiceException("需要更新的产品类别修改人为空");
			}
			// 检查产品类别参数id是否为空
			if (ObjectUtils.isNullOrEmpty(modifyTime)) {
				logger.error("updateStatusCodeById.modifyTime => 更新产品类别参数modifyTime为空");
				throw new ProductServiceException("需要更新的产品类别修改时间为空");
			}
			if (statusCode.equals(SystemContext.ProductDomain.PRODUCTCLASSSTATUS_OFF)) {
				if (isCanBeFreeze(classCode)) {
					productClassMapper.updateStatusCodeById(statusCode, classCode, modifyUserId, modifyTime);
				} else {
					errorString = "该产品类别不能被禁用，因为其有相关联的产品或者店铺商品存在";
				}
			} else {
				productClassMapper.updateStatusCodeById(statusCode, classCode, modifyUserId, modifyTime);
			}

		} catch (ProductServiceException e) {
			logger.error("更新产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
		return errorString;
	}

	// 判断该产品类别是否可以被冻结
	private boolean isCanBeFreeze(String classCode) throws ProductServiceException {
		logger.debug("classCode -> " + classCode);
		Boolean isCanBeFreeze = true;
		try {
			// 检查产品类别参数类别编码是否为空
			if (ObjectUtils.isNullOrEmpty(classCode)) {
				logger.error("id => 更新产品类别参数classCode为空");
				throw new ProductServiceException("需要更新的产品类别参数classCode为空");
			}
			// 看店铺商品有没有挂到这个分类下面
			List<SaleProductDto> saleProductDtoList = saleProductService.listSaleProductBasicInfosByClassCode(classCode,
					null);
			// 看基础商品有没有挂到这个分类下面
			List<ProductDto> productDtoList = productService.listProductBasicInfosByClassCode(classCode, null);
			if (!ObjectUtils.isNullOrEmpty(saleProductDtoList) || !ObjectUtils.isNullOrEmpty(productDtoList)) {
				isCanBeFreeze = false;
			}
		} catch (ProductServiceException e) {
			logger.error("更新产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
		return isCanBeFreeze;
	}

	@Override
	public ProductClassDto loadProductClassByClassName(String className) throws ProductServiceException {
		ProductClassDto productClassDto = null;
		try {
			// 检查产品类别名称是否为空
			if (ObjectUtils.isNullOrEmpty(className)) {
				logger.error("id => 产品类别名称为空");
				throw new ProductServiceException("产品类别名称为空");
			}
			ProductClass productClass = productClassMapper.loadProductClassByClassName(className);
			if (!ObjectUtils.isNullOrEmpty(productClass)) {
				productClassDto = new ProductClassDto();
				ObjectUtils.fastCopy(productClass, productClassDto);
			}
		} catch (Exception e) {
			logger.error("依据类别名称和级别查询产品类别出错");
			throw new ProductServiceException("依据类别名称和级别查询产品类别出错");
		}
		return productClassDto;
	}

	@Override
	public ProductClassDto loadProductClassById(Integer id) throws ProductServiceException {
		logger.debug("id -> " + id);
		ProductClassDto productClassDto = null;
		// 检查产品参数id是否为空
		if (ObjectUtils.isNullOrEmpty(id)) {
			logger.error("loadProductClassByClassCode.id => 产品类别参数id为空");
			throw new ProductServiceException("产品参数类别id为空");
		}
		try {
			ProductClass productClass = productClassMapper.loadProductClassById(id);
			if (!ObjectUtils.isNullOrEmpty(productClass)) {
				productClassDto = new ProductClassDto();
				ObjectUtils.fastCopy(productClass, productClassDto);
			}
		} catch (ProductServiceException e) {
			logger.error("查询产品类别出错");
			throw new ProductServiceException(e.getMessage());
		}
		return productClassDto;
	}

	@Override
	public List<Map<String, String>> getBasicProductClassInfoList(ProductClassQuery productClassQuery)
			throws ProductServiceException {
		List<Map<String, String>> productClassDtoMapList = new ArrayList<Map<String, String>>();
		try {

			List<ProductClassDto> productClassDtoList = this.getAllNextProductClassByUpCode(productClassQuery);
			if (!ObjectUtils.isNullOrEmpty(productClassDtoList)) {
				productClassDtoMapList = new ArrayList<Map<String, String>>();
				this.getAllNextClassNameListMap(productClassDtoList,productClassQuery,productClassDtoMapList);
			}
		} catch (ProductServiceException e) {
			logger.error("依据类别状态查询查询产品类别列表出错");
			throw new ProductServiceException(e.getMessage());
		}
		return productClassDtoMapList;
	}


	private void getAllNextClassNameListMap(List<ProductClassDto> productClassDtoList, ProductClassQuery productClassQuery,
			List<Map<String, String>> productClassDtoMapList) {
		Map<String, String> map = null;
		for (ProductClassDto productClassDto : productClassDtoList) {
			List<ProductClassDto> productClassList = this.getAllNextProductClassByUpCode(new ProductClassQuery(productClassDto.getClassCode(),productClassQuery.getStatusCode() , productClassQuery.getDisplay()));
			if(!ObjectUtils.isNullOrEmpty(productClassList)){
				getAllNextClassNameListMap(productClassList,productClassQuery,productClassDtoMapList);
			}else{
				map = new HashMap<String,String>();
				map.put("className", productClassDto.getClassName());
				productClassDtoMapList.add(map);
			}
		}
	}

	@Override
	public List<HashMap<String, String>> listProductClassByStoreType(String storeType, String statusCode)
			throws ProductServiceException {
		List<HashMap<String, String>> productClassMapList = null;
		try {
			List<ProductClass> productClassList = productClassMapper.listProductClassByStoreType(storeType, statusCode,
					null);
			if (!ObjectUtils.isNullOrEmpty(productClassList)) {
				productClassMapList = new ArrayList<HashMap<String, String>>();
				for (ProductClass productClass : productClassList) {
					HashMap<String, String> productClassMap = null;
					if (!ObjectUtils.isNullOrEmpty(productClass)) {
						productClassMap = new HashMap<String, String>();
						// 将类别的编码和名称封装进结果集
						productClassMap.put("className", productClass.getClassName());
						productClassMap.put("classCode", productClass.getClassCode());
					}
					productClassMapList.add(productClassMap);
				}
			}
		} catch (ProductServiceException e) {
			logger.error("依据店铺类别查询查询产品类别列表出错");
			throw new ProductServiceException(e.getMessage());
		}
		return productClassMapList;
	}

	/**
	 * app分类列表
	 * 
	 * 
	 * @param storeId
	 * @param parentClassCode
	 * @param display
	 * @return
	 * @throws ProductServiceException
	 */
	@Override
	public List<ProductClassDto> listProductClassByParentCode(String flag,Integer storeId, String parentClassCode)
			throws ProductServiceException {
		List<ProductClassDto> productClassDtoList = null;
		try {
			if (null == storeId) {
				throw new ProductServiceException("没有选择的店铺");
			}
			// 通过store查询店铺
			StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
			if (null == storeProfileProxyDto) {
				throw new ProductServiceException("店铺不存在");
			}
			String storeType = storeProfileProxyDto.getStoreType();
			if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
					&& SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
				storeType = SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE;
			}
			// 通过店铺类型查出店铺所关联的所有分类（递归）
			Set<String> storeTypeProductClassSet = this.getStoreTypeProductClassList(storeType);
			//组装分类结构
			productClassDtoList = this.listProductClassAll(flag,parentClassCode, storeTypeProductClassSet);
			return productClassDtoList;
		} catch (Exception e) {
			throw new ProductServiceException(e.getMessage());
		}
	}

	private List<ProductClassDto> listProductClassAll(String flag,String parentClassCode, Set<String> storeTypeProductClassSet) {
		ProductClassQuery productClassQuery = new ProductClassQuery();
		productClassQuery.setClassCode(parentClassCode);
		productClassQuery.setStatusCode(SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
		if(!StringUtils.isEmpty(flag)){
			productClassQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
		}
		List<ProductClassDto> productClassDtoList = this
				.getAllNextProductClassByUpCode(productClassQuery);
		if (!ObjectUtils.isNullOrEmpty(productClassDtoList)) {
			if (!parentClassCode.equals(SystemContext.SystemParams.TOP_LEVEL_CLASS)) {
				productClassDtoList = this.getClassCodeListRecursion(flag,productClassDtoList,storeTypeProductClassSet);
			} else {
				productClassDtoList = this.getEndClassCodeList(productClassDtoList, storeTypeProductClassSet);
			}
		}
		return productClassDtoList;
	}

	// 如果传入的classCode不是“TOP_LEVEL_CLASS”递归组装所有的子集
	private List<ProductClassDto> getClassCodeListRecursion(String flag,List<ProductClassDto> productClassDtoList, Set<String> storeTypeProductClassSet) {
		List<ProductClassDto> dtoList = null;
		if(!ObjectUtils.isNullOrEmpty(productClassDtoList)){
			dtoList = this.getEndClassCodeList(productClassDtoList, storeTypeProductClassSet);
			ProductClassQuery productClassQuery = null;
			for (ProductClassDto dto : dtoList) {
				productClassQuery = new ProductClassQuery();
				productClassQuery.setClassCode(dto.getClassCode());
				productClassQuery.setStatusCode(SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON);
				if(!StringUtils.isEmpty(flag)){
					productClassQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
				}
				List<ProductClassDto> productClassDtos = this.getAllNextProductClassByUpCode(productClassQuery);
				if (!ObjectUtils.isNullOrEmpty(productClassDtos)) {
					dto.setSubClassList(getClassCodeListRecursion(flag,productClassDtos, storeTypeProductClassSet));
				}
			}
		}
		return dtoList;
	}

	// 比较获取的list和店铺类型获取的list,取公共的
	private List<ProductClassDto> getEndClassCodeList(List<ProductClassDto> productClassDtoList,
			Set<String> storeTypeProductClassSet) {
		if (ObjectUtils.isNullOrEmpty(storeTypeProductClassSet)) {
			//将图片转成手机端URL
			for (ProductClassDto productClass : productClassDtoList) {
				productClass.setClassImageUrl(StringUtils.toFullImageUrl(productClass.getClassImageUrl()));
			}
			Collections.reverse(productClassDtoList);
			return productClassDtoList;
		} else {
			List<ProductClassDto> productClassList = new ArrayList<ProductClassDto>();
			for (ProductClassDto productClassDto : productClassDtoList) {
				for (String storeTypeProductClass : storeTypeProductClassSet) {
					if (productClassDto.getClassCode().equals(storeTypeProductClass)) {
						productClassDto.setClassImageUrl(StringUtils.toFullImageUrl(productClassDto.getClassImageUrl()));
						productClassList.add(productClassDto);
					}
				}
			}
			Collections.reverse(productClassList);
			return productClassList;
		}
	}

	// 通过店铺类型查出店铺所关联的所有分类
	private Set<String> getStoreTypeProductClassList(String storeType) {
		List<StoreTypeProductClass> storeTypeProductClassList = storeTypeProductClassMapper
				.listStoreProductsByStoreType(storeType);
		Set<String> classCodeSet = null;
		if (!ObjectUtils.isNullOrEmpty(storeTypeProductClassList)) {
			classCodeSet = new HashSet<String>();
			for (StoreTypeProductClass storeTypeProductClass : storeTypeProductClassList) {
				this.getClassCodeByStoreTypeProductClass(storeTypeProductClass.getClassCode(), classCodeSet);
			}
		}
		return classCodeSet;
	}
	// 递归查找所有关联的上级分类
	private void getClassCodeByStoreTypeProductClass(String classCode, Set<String> classCodeSet) {
		classCodeSet.add(classCode);
		ProductClassDto productClassDto = getUpProductClassByClassCode(classCode);
		if (!ObjectUtils.isNullOrEmpty(productClassDto) && !productClassDto.getClassCode().equals(SystemContext.SystemParams.TOP_LEVEL_CLASS)) {
			classCodeSet.add(productClassDto.getClassCode());
			getClassCodeByStoreTypeProductClass(productClassDto.getClassCode(), classCodeSet);
		}
	}

	/**
	 * 根据下级classCode查上级分类
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param classCode
	 * @return
	 * @see com.yilidi.o2o.product.service.IProductClassService#getUpProductClassByClassCode(java.lang.String)
	 */
	@Override
	public ProductClassDto getUpProductClassByClassCode(String classCode) throws ProductServiceException{
		ProductClassDto productClassDto = null;
		ProductClass productClass = productClassMapper.getUpProductClassByClassCode(classCode);
		if (!ObjectUtils.isNullOrEmpty(productClass)) {
			productClassDto = new ProductClassDto();
			ObjectUtils.fastCopy(productClass, productClassDto);
		}
		return productClassDto;
	}

	/**
	 * 根据一个classCode递归获取子集(最下一级的)的classCode
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param classCode
	 * @return
	 * @see com.yilidi.o2o.product.service.IProductClassService#getSunClassCodes(java.lang.String)
	 */
	@Override
	public List<Object> getSubClassCodes(String classCode) throws ProductServiceException{
		List<Object> classCodess = new ArrayList<Object>();
		this.getClassCodes(classCode, classCodess);
		return classCodess;
	}

	private void getClassCodes(String classCode, List<Object> classCodes) {
		List<ProductClassDto> productClassDtolist = getAllNextProductClassByUpCode(
				new ProductClassQuery(classCode,SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON));
		if (!ObjectUtils.isNullOrEmpty(productClassDtolist)) {
			for (ProductClassDto productClassDto : productClassDtolist) {
				getClassCodes(productClassDto.getClassCode(), classCodes);
			}
		} else {
			classCodes.add(classCode);
		}
	}

	@Override
	public List<Map<String, Object>> getUpClassAndNextProductClassByClassCode(String classCode) throws ProductServiceException{
		List<Map<String, Object>> productClassListMap = new ArrayList<Map<String, Object>>();
		int j = 0;
		this.getUpClassCodeAndNextProductClass(classCode, productClassListMap, j);
		// 排序，按一级，二级，三级排
		Collections.reverse(productClassListMap);
		return productClassListMap;
	}

	private void getUpClassCodeAndNextProductClass(String classCode, List<Map<String, Object>> productClassListMap, int j) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("classCode", classCode);
		// 根据classCode查上级class
		List<ProductClassDto> productClassDtolist = null;
		ProductClassDto productClass = this.getUpProductClassByClassCode(classCode);
		if (!ObjectUtils.isNullOrEmpty(productClass)) {
			productClassDtolist = getAllNextProductClassByUpCode(
					new ProductClassQuery(productClass.getClassCode(), SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON));
			map.put("subClassList", productClassDtolist);
			productClassListMap.add(j, map);
			j++;
			getUpClassCodeAndNextProductClass(productClass.getClassCode(), productClassListMap, j);
		} else {
			productClassDtolist = getAllNextProductClassByUpCode(
					new ProductClassQuery(SystemContext.SystemParams.TOP_LEVEL_CLASS, SystemContext.ProductDomain.PRODUCTCLASSSTATUS_ON));
			map.put("subClassList", productClassDtolist);
			productClassListMap.add(j, map);
		}
	}

	/**
	 * 组装产品分类
	 *  
	 * @return
	 */
	@Override
	public List<ProductClassDto> getAllProductClass() throws ProductServiceException{
		List<ProductClassDto> firstProductClassDtoList = this.getAllNextProductClassByUpCode(new ProductClassQuery(SystemContext.SystemParams.TOP_LEVEL_CLASS));
		if(!ObjectUtils.isNullOrEmpty(firstProductClassDtoList)){
			for (ProductClassDto firstProductClassDto : firstProductClassDtoList) {
				List<ProductClassDto> secondProductClassDtoList = this.getAllNextProductClassByUpCode(new ProductClassQuery(firstProductClassDto.getClassCode()));
				if(!ObjectUtils.isNullOrEmpty(secondProductClassDtoList)){
					firstProductClassDto.setSubClassList(secondProductClassDtoList);
					for (ProductClassDto secondProductClassDto : secondProductClassDtoList) {
						List<ProductClassDto> thirdProductClassDtoList = this.getAllNextProductClassByUpCode(new ProductClassQuery(secondProductClassDto.getClassCode()));
						if(!ObjectUtils.isNullOrEmpty(thirdProductClassDtoList)){
							secondProductClassDto.setSubClassList(thirdProductClassDtoList);
						}
					}
				}
			}
		}
		logger.info(firstProductClassDtoList);
		return firstProductClassDtoList;
	}

	@Override
	public List<StoreTypeProductClassDto> getProductClassByStoreType(String storeType) throws ProductServiceException{
		List<StoreTypeProductClassDto> storeTypeProductClassDtoList = null;
		List<StoreTypeProductClass> storeTypeProductClassList = storeTypeProductClassMapper
				.listStoreProductsByStoreType(storeType);
		if(!ObjectUtils.isNullOrEmpty(storeTypeProductClassList)){
			storeTypeProductClassDtoList = new ArrayList<StoreTypeProductClassDto>();
			StoreTypeProductClassDto storeTypeProductClassDto = null;
			for (StoreTypeProductClass storeTypeProductClass : storeTypeProductClassList) {
				storeTypeProductClassDto = new StoreTypeProductClassDto();
				ObjectUtils.fastCopy(storeTypeProductClass, storeTypeProductClassDto);
				storeTypeProductClassDtoList.add(storeTypeProductClassDto);
			}

		}

		return storeTypeProductClassDtoList;
	}

}
