/**
 * 文件名称：ProductBrandService.java
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

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ImageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ISaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SaleProductInventoryProxyDto;
import com.yilidi.o2o.product.dao.ProductBrandMapper;
import com.yilidi.o2o.product.model.ProductBrand;
import com.yilidi.o2o.product.model.SaleProductByBrandCode;
import com.yilidi.o2o.product.model.query.ProductBrandQuery;
import com.yilidi.o2o.product.service.IProductBrandService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.SaleProductByBrandCodeDto;
import com.yilidi.o2o.product.service.dto.query.ProductBrandQueryDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IStoreProfileProxyService;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;
import com.yilidi.o2o.user.proxy.dto.StoreProfileProxyDto;

/**
 * 功能描述:产品品牌服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productBrandService")
public class ProductBrandServiceImpl extends BasicDataService implements IProductBrandService {

	@Autowired
	private ProductBrandMapper productBrandMapper;
	
    @Autowired
    private IStoreProfileProxyService storeProfileProxyService;
    
    @Autowired
    private IStoreWarehouseProxyService storeWarehouseProxyService;

	@Autowired
    private ISaleProductInventoryProxyService saleProductInventoryProxyService;
	
	@Autowired
    private ISaleProductService saleProductService;
	
	@Override
	public void saveProductBrand(ProductBrandDto saveProductBrandDto) throws ProductServiceException {
		// 保存产品品牌表开始
		logger.debug("saveProductBrandDto -> " + saveProductBrandDto);
		// 后天设置自动生成brandcode
		saveProductBrandDto.setBrandCode(generateBrandCode());// ---------------------
		// 检查产品参数对象是否为空
		if (ObjectUtils.isNullOrEmpty(saveProductBrandDto)) {
			logger.error("ProductBrandService.saveProductBrandDto => 产品参数为空");
			throw new ProductServiceException("ProductService的saveProductBrand方法参数为空");
		}
		try {
			// 产品品牌编码是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getBrandCode())) { // 调试
				logger.error("saveProductBrandDto.brandCode => 产品品牌编码参数为空");
				throw new ProductServiceException("产品品牌编码参数为空");
			} else {
				// 判断输入的产品品牌是否已经存在
				ProductBrand productBrand = productBrandMapper
						.loadProductBrandByBrandCode(saveProductBrandDto.getBrandCode());
				if (!ObjectUtils.isNullOrEmpty(productBrand)) {
					logger.error("saveProductBrandDto.ProductBrand => 产品品牌" + saveProductBrandDto.getBrandCode()
							+ "重复，请重新输入产品编码");
					throw new ProductServiceException("产品品牌" + saveProductBrandDto.getBrandCode() + "重复，请重新输入");
				}
			}
			// 产品品牌名称是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getBrandName())) {
				logger.error("saveProductBrandDto.brandName => 产品品牌名称参数为空");
				throw new ProductServiceException("产品品牌名称参数为空");
			}
			// 品牌logo图片路径是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getImageUrl())) {
				logger.error("saveProductBrandDto.getImageUrl => 品牌logo图片参数为空");
				throw new ProductServiceException("品牌logo图片参数为空");
			}
			// 产品品牌创建者ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getCreateUserId())) {
				logger.error("saveProductBrandDto.createUserId => 产品品牌创建者ID参数为空");
				throw new ProductServiceException("产品品牌创建者ID参数为空");
			}
			// 产品品牌创建者ID是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getDisplayOrder())) {
				logger.error("saveProductBrandDto.displayOrder => 产品品牌顺序参数为空");
				throw new ProductServiceException("产品品牌顺序参数为空");
			}
			// 产品品牌创建时间是否为空
			if (ObjectUtils.isNullOrEmpty(saveProductBrandDto.getCreateTime())) {
				logger.error("saveProductBrandDto.createTime => 产品品牌创建时间参数为空");
				throw new ProductServiceException("产品品牌创建时间参数为空");
			}
			ProductBrand productBrand = new ProductBrand();
			productBrand.setDisplayOrder(saveProductBrandDto.getDisplayOrder());
			productBrand.setBrandCode(saveProductBrandDto.getBrandCode());
			productBrand.setBrandName(saveProductBrandDto.getBrandName().trim());
			productBrand.setBrandDesc(saveProductBrandDto.getBrandDesc());
			productBrand.setType(saveProductBrandDto.getType());
			productBrand.setStatusCode(saveProductBrandDto.getStatusCode());
			productBrand.setCreateUserId(saveProductBrandDto.getCreateUserId());
			productBrand.setCreateTime(saveProductBrandDto.getCreateTime());
			productBrand.setImageUrl(saveProductBrandDto.getImageUrl());
			productBrandMapper.saveProductBrand(productBrand);
			ImageUtils.operateImage(saveProductBrandDto.getImageFlag(), saveProductBrandDto.getDelImageUrl(),
					saveProductBrandDto.getImageUrl());
		} catch (ProductServiceException e) {
			logger.error("保存产品品牌出错");
			throw new ProductServiceException("异常：保存产品品牌出错");
		}
	}

	@Override
	public void updateBrandNameByBrandCode(String brandCode, String brandName, Integer modifyUserId, Date modifyTime)
			throws ProductServiceException {
		// 根据品牌编码更新产品品牌表开始
		logger.debug("brandCode -> " + brandCode + "brandName -> " + brandName + "modifyUserId -> " + modifyUserId
				+ "modifyTime -> " + modifyTime);
		// 更新产品品牌
		try {
			// 检查产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(brandCode)) {
				logger.error("ProductBrandService.brandCode => 根据品牌编码更新产品品牌参数brandCode为空");
				throw new ProductServiceException("ProductBrandService的updateBrandNameByBrandCode方法参数brandCode为空");
			}
			// 检查产品品牌名称是否为空
			if (ObjectUtils.isNullOrEmpty(brandName)) {
				logger.error("ProductBrandService.brandName => 需要更新的产品品牌参数品牌名称为空");
				throw new ProductServiceException("需要更新的产品品牌参数品牌名称为空");
			}
			// 检查产品品牌修改人是否为空
			if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
				logger.error("ProductService.updateProductClassDto.modifyUserId=> 根据品牌编码更新产品品牌修改人为空");
				throw new ProductServiceException("ProductService的updateBrandNameByBrandCode方法参数modifyUserId为空");
			}
			// 检查产品品牌修改时间是否为空
			if (ObjectUtils.isNullOrEmpty(modifyTime)) {
				logger.error("ProductService.updateProductClassDto.modifyTime => 根据品牌编码更新产品品牌修改时间为空");
				throw new ProductServiceException("ProductService的updateBrandNameByBrandCode方法参数modifyTime为空");
			}
			ProductBrand productBrand = productBrandMapper.loadProductBrandByBrandCode(brandCode);
			// 更新产品品牌
			if (ObjectUtils.isNullOrEmpty(productBrand)) {
				logger.error("updateProductBrand.productBrand => 根据品牌编码更新产品品牌不存在");
				throw new ProductServiceException("根据品牌编码更新的产品品牌不存在");
			}
			if (ObjectUtils.whetherModified(productBrand.getBrandName(), brandName)) {
				productBrandMapper.updateBrandNameByBrandCode(brandCode, brandName, modifyUserId, modifyTime);
			}

		} catch (ProductServiceException e) {
			logger.error("根据品牌编码更新产品品牌出错");
			throw new ProductServiceException("异常：根据品牌编码更新产品品牌出错");
		}
	}

	@Override
	public void updateStatusCodeByBrandCode(String brandCode, String statusCode, Integer modifyUserId, Date modifyTime)
			throws ProductServiceException {
		// 更新产品品牌状态开始
		logger.debug("brandCode -> " + brandCode + "statusCode -> " + statusCode + "modifyUserId -> " + modifyUserId
				+ "modifyTime -> " + modifyTime);
		// 更新产品品牌
		try {
			// 检查产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(brandCode)) {
				logger.error("ProductBrandService.brandCode => 需要更新产品品牌状态参数brandCode为空");
				throw new ProductServiceException("ProductBrandService的ProductBrandService方法参数brandCode为空");
			}
			// 检查产品品牌状态是否为空
			if (ObjectUtils.isNullOrEmpty(statusCode)) {
				logger.error("ProductBrandService.statusCode => 需要更新的产品品牌参数产品品牌状态为空");
				throw new ProductServiceException("需要更新的产品品牌参数产品品牌状态为空");
			}
			// 检查产品品牌修改人是否为空
			if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
				logger.error("ProductService.updateProductClassDto.modifyUserId=> 更新产品品牌状态修改人为空");
				throw new ProductServiceException(
						"ProductService的updateStatusCodeByBrandCode.modifyUserId方法参数modifyUserId为空");
			}
			// 检查产品品牌修改时间是否为空
			if (ObjectUtils.isNullOrEmpty(modifyTime)) {
				logger.error("ProductService.updateProductClassDto.modifyTime => 更新产品品牌状态修改时间为空");
				throw new ProductServiceException("ProductService的updateStatusCodeByBrandCode方法参数modifyTime为空");
			}
			ProductBrand productBrand = productBrandMapper.loadProductBrandByBrandCode(brandCode);
			// 更新产品状态
			if (ObjectUtils.isNullOrEmpty(productBrand)) {
				logger.error("updateProductBrand.productBrand => 更新产品品牌状态的产品品牌不存在");
				throw new ProductServiceException("更新产品品牌状态的产品品牌不存在");
			}
			if (ObjectUtils.whetherModified(productBrand.getStatusCode(), statusCode)) {
				productBrandMapper.updateStatusCodeByBrandCode(brandCode, statusCode, modifyUserId, modifyTime);
			}

		} catch (ProductServiceException e) {
			logger.error("更新产品品牌状态出错");
			throw new ProductServiceException("异常：更新产品品牌状态出错");
		}
	}

	@Override
	public void updateProductBrand(ProductBrandDto updateProductBrandDto) throws ProductServiceException {
		// 更新产品品牌表开始
		logger.debug("updateProductBrandDto -> " + updateProductBrandDto);
		// 更新产品品牌
		try {
			// 检查产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(updateProductBrandDto)) {
				logger.error("ProductBrandService.updateProductBrandDto => 需要更新的产品品牌参数updateProductBrandDto为空");
				throw new ProductServiceException("ProductBrandService的ProductBrandService方法参数updateProductBrandDto为空");
			}
			// 检查产品品牌参数品牌Id是否为空
			if (ObjectUtils.isNullOrEmpty(updateProductBrandDto.getId())) {
				logger.error("ProductBrandService.id => 需要更新的产品品牌参数id为空");
				throw new ProductServiceException("ProductBrandService的ProductBrandService方法参数id为空");
			}
			// 检查产品品牌修改人是否为空
			if (ObjectUtils.isNullOrEmpty(updateProductBrandDto.getModifyUserId())) {
				logger.error("ProductService.updateProductClassDto.modifyUserId=> 产品品牌修改人为空");
				throw new ProductServiceException("ProductService的updateProductClass.modifyUserId方法参数modifyUserId为空");
			}
			// 检查产品品牌修改时间是否为空
			if (ObjectUtils.isNullOrEmpty(updateProductBrandDto.getModifyTime())) {
				logger.error("ProductService.updateProductClassDto.modifyTime => 产品品牌修改时间为空");
				throw new ProductServiceException("ProductService的updateProductClass方法参数modifyTime为空");
			}
			ProductBrand productBrand = productBrandMapper.loadProductBrandById(updateProductBrandDto.getId());
			// 更新产品品牌
			if (ObjectUtils.isNullOrEmpty(productBrand)) {
				logger.error("updateProductBrand.productBrand => 需要更新的产品品牌不存在");
				throw new ProductServiceException("需要更新的产品品牌不存在");
			}
			ProductBrandDto productBrandDto = getBrandByName(updateProductBrandDto.getBrandName().trim());
			if(null!=updateProductBrandDto.getBrandName() 
					&& ObjectUtils.whetherModified(productBrand.getBrandName(), updateProductBrandDto.getBrandName().trim()) 
					&& !ObjectUtils.isNullOrEmpty(productBrandDto)){
				logger.error("品牌名称已存在");
				throw new ProductServiceException("品牌名称已存在");
			}
			
			if (ObjectUtils.whetherModified(productBrand.getStatusCode(), updateProductBrandDto.getStatusCode())
					|| ObjectUtils.whetherModified(productBrand.getBrandDesc(), updateProductBrandDto.getBrandDesc())
					|| ObjectUtils.whetherModified(productBrand.getBrandName(), updateProductBrandDto.getBrandName().trim())
					|| ObjectUtils.whetherModified(productBrand.getDisplayOrder(),
							updateProductBrandDto.getDisplayOrder())
					|| ObjectUtils.whetherModified(productBrand.getImageUrl(), updateProductBrandDto.getImageUrl())
					|| ObjectUtils.whetherModified(productBrand.getType(), updateProductBrandDto.getType())) {
				productBrand.setStatusCode(updateProductBrandDto.getStatusCode());
				productBrand.setBrandDesc(updateProductBrandDto.getBrandDesc());
				productBrand.setType(updateProductBrandDto.getType());
				productBrand.setBrandName(updateProductBrandDto.getBrandName().trim());
				productBrand.setDisplayOrder(updateProductBrandDto.getDisplayOrder());
				productBrand.setModifyUserId(updateProductBrandDto.getModifyUserId());
				productBrand.setModifyTime(updateProductBrandDto.getModifyTime());
				productBrand.setImageUrl(updateProductBrandDto.getImageUrl());
				productBrandMapper.updateProductBrandById(productBrand);
				ImageUtils.operateImage(updateProductBrandDto.getImageFlag(), updateProductBrandDto.getDelImageUrl(),
						updateProductBrandDto.getImageUrl());
			}

		} catch (ProductServiceException e) {
			logger.error("更新产品品牌出错");
			throw new ProductServiceException("异常：更新产品品牌出错");
		}
	}

	@Override
	public ProductBrandDto loadProductBrandById(Integer id) throws ProductServiceException {
		// 查询产品品牌表开始
		logger.debug("id -> " + id);
		// 更新产品品牌
		try {
			// 查询产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(id)) {
				logger.error("ProductBrandService.loadProductBrandById => 参数id为空");
				throw new ProductServiceException("ProductBrandService的loadProductBrandById方法参数id为空");
			}
			ProductBrand productBrand = productBrandMapper.loadProductBrandById(id);
			// 查询产品
			if (ObjectUtils.isNullOrEmpty(productBrand)) {
				logger.error("updateProductBrand.productBrand => 查询的产品品牌不存在");
				throw new ProductServiceException("查询的产品品牌不存在");
			}
			ProductBrandDto productBrandDto = new ProductBrandDto();
			ObjectUtils.fastCopy(productBrand, productBrandDto);
			productBrandDto.setImageFullUrl(StringUtils.toFullImageUrl(productBrandDto.getImageUrl()));
			return productBrandDto;
		} catch (ProductServiceException e) {
			logger.error("查询产品品牌出错");
			throw new ProductServiceException("异常：查询产品品牌出错，参数id为空");
		}
	}

	@Override
	public ProductBrandDto loadProductBrandByBrandCode(String brandCode) throws ProductServiceException {
		// 查询产品品牌开始
		logger.debug("brandCode -> " + brandCode);
		// 更新产品品牌
		try {
			// 查询产品参数对象是否为空
			if (ObjectUtils.isNullOrEmpty(brandCode)) {
				logger.error("ProductBrandService.loadProductBrandByBrandCode => 查询产品品牌参数brandCode为空");
				throw new ProductServiceException("ProductBrandService的loadProductBrandByBrandCode方法参数brandCode为空");
			}
			ProductBrand productBrand = productBrandMapper.loadProductBrandByBrandCode(brandCode);
			// 查询产品
			if (ObjectUtils.isNullOrEmpty(productBrand)) {
				logger.error("loadProductBrandByBrandCode.productBrand => 按品牌编码查询的产品品牌不存在");
				return null;
			}
			ProductBrandDto productBrandDto = new ProductBrandDto();
			ObjectUtils.fastCopy(productBrand, productBrandDto);

			return productBrandDto;
		} catch (ProductServiceException e) {
			logger.error("按品牌编码查询品牌出错");
			throw new ProductServiceException("异常：按品牌编码查询品牌出错");
		}
	}

	@Override
	public List<ProductBrandDto> listProductBrandsByType(String type,Integer storeId,String saleStatus) throws ProductServiceException {
		SaleProductQuery saleProductQuery = new SaleProductQuery();
        if (null!=storeId) {
        	StoreProfileProxyDto storeProfileProxyDto  = storeProfileProxyService.loadByStoreId(storeId);
        	if(ObjectUtils.isNullOrEmpty(storeProfileProxyDto)){
        		throw new ProductServiceException("异常：按storeId查询店铺信息出错");
        	}
	        if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
	                && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
	            Integer wareHouseId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
	            saleProductQuery.setStoreId(wareHouseId);
	            saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
	        } else {
	            saleProductQuery.setStoreId(storeProfileProxyDto.getStoreId());
	        }
        }
		saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
		if(null != saleStatus){
			saleProductQuery.setSaleStatus(saleStatus);
		}
		saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
		String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
		String sort = CommonConstants.SORT_ORDER_ASC;
		saleProductQuery.setOrder(order);
		saleProductQuery.setSort(sort);
		List<String> brandCodes = saleProductService.listSaleProductBrandCodesByStoreId(saleProductQuery);
		
		ProductBrandQueryDto queryProductBrand = new ProductBrandQueryDto();
		if (type != null && "hot".equals(type.toLowerCase())) {
			queryProductBrand.setType(SystemContext.ProductDomain.HOTSALEFLAG_YES);
		}
		if(!ObjectUtils.isNullOrEmpty(brandCodes)){
			queryProductBrand.setBrandCodesList(brandCodes);
		}
		queryProductBrand.setStatusCode(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON);
		
		List<ProductBrandDto> listProductBrands = listProductBrands(queryProductBrand);
		
		return listProductBrands;
		}

	@Override
	public List<ProductBrandDto> listProductBrands(ProductBrandQueryDto queryProductBrand)
			throws ProductServiceException {
		try {
			if(null == queryProductBrand){
				queryProductBrand = new ProductBrandQueryDto();
			}
			queryProductBrand.setOrder(DBTablesColumnsName.ProductBrand.DISPLAYORDER);
			queryProductBrand.setSort(CommonConstants.SORT_ORDER_ASC+" ,MODIFYTIME DESC");
			ProductBrandQuery productBrandQuery = new ProductBrandQuery();
			ObjectUtils.fastCopy(queryProductBrand, productBrandQuery);

			List<ProductBrand> listProductBrands = productBrandMapper.getProductBrands(productBrandQuery);
			List<ProductBrandDto> listProductBrandDtos = null;
			if (!ObjectUtils.isNullOrEmpty(listProductBrands)) {
				listProductBrandDtos = new ArrayList<ProductBrandDto>();
				for (ProductBrand productBrand : listProductBrands) {
					ProductBrandDto productBrandDto = new ProductBrandDto();
					ObjectUtils.fastCopy(productBrand, productBrandDto);
					listProductBrandDtos.add(productBrandDto);
				}
			}
			return listProductBrandDtos;
		} catch (ProductServiceException e) {
			logger.error("查询产品品牌列表出错");
			throw new ProductServiceException("异常：查询产品列表出错");
		}
	}
	
	@Override
	public List<ProductBrandDto> listProductBrands()throws ProductServiceException {
		try {
			ProductBrandQueryDto queryProductBrand = new ProductBrandQueryDto();
			queryProductBrand.setOrder(DBTablesColumnsName.ProductBrand.DISPLAYORDER);
			queryProductBrand.setSort(CommonConstants.SORT_ORDER_ASC+" ,MODIFYTIME DESC");
			ProductBrandQuery productBrandQuery = new ProductBrandQuery();
			ObjectUtils.fastCopy(queryProductBrand, productBrandQuery);

			List<ProductBrand> listProductBrands = productBrandMapper.getProductBrands(productBrandQuery);
			List<ProductBrandDto> listProductBrandDtos = null;
			if (!ObjectUtils.isNullOrEmpty(listProductBrands)) {
				listProductBrandDtos = new ArrayList<ProductBrandDto>();
				for (ProductBrand productBrand : listProductBrands) {
					ProductBrandDto productBrandDto = new ProductBrandDto();
					ObjectUtils.fastCopy(productBrand, productBrandDto);
					listProductBrandDtos.add(productBrandDto);
				}
			}
			return listProductBrandDtos;
		} catch (ProductServiceException e) {
			logger.error("查询产品品牌列表出错");
			throw new ProductServiceException("异常：查询产品列表出错");
		}
	}


	@Override
	public YiLiDiPage<ProductBrandDto> findProductBrandInfos(ProductBrandQueryDto queryProductBrandDto)
			throws ProductServiceException {
		try {
			if (null == queryProductBrandDto.getStart() || queryProductBrandDto.getStart() <= 0) {
				queryProductBrandDto.setStart(1);
			}
			if (null == queryProductBrandDto.getPageSize() || queryProductBrandDto.getPageSize() <= 0) {
				queryProductBrandDto.setPageSize(CommonConstants.PAGE_SIZE);
			}
			ProductBrandQuery productBrandQuery = new ProductBrandQuery();
			ObjectUtils.fastCopy(queryProductBrandDto, productBrandQuery);
			PageHelper.startPage(productBrandQuery.getStart(), productBrandQuery.getPageSize());
			Page<ProductBrand> page = productBrandMapper.findProductBrandInfos(productBrandQuery);
			Page<ProductBrandDto> pageDto = new Page<ProductBrandDto>(productBrandQuery.getStart(),
					productBrandQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<ProductBrand> productRelatedInfos = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(productRelatedInfos)) {
				for (ProductBrand pri : productRelatedInfos) {
					ProductBrandDto pDto = new ProductBrandDto();
					ObjectUtils.fastCopy(pri, pDto);
					pDto.setImageFullUrl(StringUtils.toFullImageUrl(pDto.getImageUrl()));
					pageDto.add(pDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			logger.error("findProductBrandInfos异常", e);
			throw new ProductServiceException(e.getMessage());
		}
	}

	/**
	 * 生成品牌编码BrandCode(长度为20，yyyyMMddHHmmssSSS+3位随机数)
	 * 
	 * @return 20个字符的单号
	 */
	private String generateBrandCode() {
		StringBuffer sb = new StringBuffer();
		sb.append("PB");
		sb.append(DateUtils.formatDate(new Date(), "yyyyMMddHHmmssSSS"));
		sb.append(StringUtils.randomString(3));
		return sb.toString();
	}

	

	@Override
	public YiLiDiPage<SaleProductByBrandCodeDto> findSaleProductByBrandCode(Integer storeId, String brandCode, Integer pageNum,
			Integer pageSize) throws ProductServiceException {
		 if (null == pageNum) {
			 pageNum = 1;
         }
         if (null == pageSize) {
             pageSize = CommonConstants.PAGE_SIZE;
         }
         
         SaleProductQuery saleProductQuery = new SaleProductQuery();
         saleProductQuery.setStoreId(storeId);
         saleProductQuery.setBrandCode(brandCode);
         saleProductQuery.setStart(pageNum);
         saleProductQuery.setPageSize(pageSize);
         saleProductQuery.setAuditStatusCode(SystemContext.ProductDomain.SALEPRODUCTAUDITSTATUS_PASSED);
         saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
         saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
         saleProductQuery.setOrder("PD."+DBTablesColumnsName.SaleProductProfile.DISPLAYORDER);
         saleProductQuery.setSort(CommonConstants.SORT_ORDER_ASC+" ,P.MODIFYTIME DESC");
         saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
         
         StoreProfileProxyDto storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
         if (ObjectUtils.isNullOrEmpty(storeProfileProxyDto)) {
             throw new ProductServiceException("该店铺不存在");
         }
         //校验店铺是不是共享库存
         if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                 && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
             // 店铺共享库存查询微仓商品信息
             Integer wareHouseId = storeWarehouseProxyService
                     .loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
             saleProductQuery.setStoreId(wareHouseId);
             saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
         }
         
         Page<SaleProductByBrandCodeDto> pageDto = new Page<SaleProductByBrandCodeDto>(pageNum, pageSize);
         PageHelper.startPage(pageNum, pageSize);
         Page<SaleProductByBrandCode> page = productBrandMapper.findSaleProductByBrandCode(saleProductQuery);
         ObjectUtils.fastCopy(page, pageDto);
         List<SaleProductByBrandCode> saleProductInfos = page.getResult();
         if (!ObjectUtils.isNullOrEmpty(saleProductInfos)) {
        	 for (SaleProductByBrandCode saleProductInfo : saleProductInfos) {
            	 SaleProductByBrandCodeDto saleProductInfoDto = new SaleProductByBrandCodeDto();
                 ObjectUtils.fastCopy(saleProductInfo, saleProductInfoDto);
                 
                 if(null!=saleProductInfo.getSaleProductImageUrl())
                	 saleProductInfoDto.setSaleProductImageUrl(saleProductInfo.getSaleProductImageUrl().replace("_1.", "."));
                 //查询库存
                 setSaleProductInventoryInfo(saleProductInfoDto,saleProductInfoDto.getSaleProductId());
                 pageDto.add(saleProductInfoDto);
             }
         }
		return YiLiDiPageUtils.encapsulatePageResult(pageDto);
	}
    // 单个设置商品库存
    private void setSaleProductInventoryInfo(SaleProductByBrandCodeDto saleProductInfoDto, Integer saleProductId)throws ProductServiceException  {
        if (ObjectUtils.isNullOrEmpty(saleProductInfoDto)) {
            return;
        }
        SaleProductInventoryProxyDto saleProductInventoryProxyDto = saleProductInventoryProxyService
                .loadByStoreIdAndSaleProductId(null, saleProductId);
        if (!ObjectUtils.isNullOrEmpty(saleProductInventoryProxyDto)) {
        	saleProductInfoDto.setStockNum(
                    saleProductInventoryProxyDto.getRemainCount() - saleProductInventoryProxyDto.getOrderedCount());
        }else{
        	saleProductInfoDto.setStockNum(0);
        }
    }

	/**
     * 获取所有品牌（通用）
     * 
     * @return
     */
    @Override
    public List<ProductBrandDto> getAllBrandBasic()throws ProductServiceException  {
        List<ProductBrandDto> brandDtoList = null;
        try {
            List<ProductBrand> brandList = productBrandMapper.getAllBrandBasic();
            if (!ObjectUtils.isNullOrEmpty(brandList)) {
                brandDtoList = new ArrayList<ProductBrandDto>();
                ProductBrandDto brandDto = null;
                for (ProductBrand productBrand : brandList) {
                    brandDto = new ProductBrandDto();
                    ObjectUtils.fastCopy(productBrand, brandDto);
                    brandDtoList.add(brandDto);
                }
            }
            return brandDtoList;
        } catch (Exception e) {
            logger.error("getAllBrandBasic异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    /**
     * 根据name获取品牌
     * 
     * <p>
     * Description:
     * </p>
     * 
     * @param brandName
     * @return
     * @see com.yilidi.o2o.product.service.IProductBrandService#getBrandByName(java.lang.String)
     */
    @Override
    public ProductBrandDto getBrandByName(String brandName)throws ProductServiceException  {
    	ProductBrandDto productBrandDto = null;
        ProductBrand productBrand = productBrandMapper.getBrandByName(brandName.trim());
        if (!ObjectUtils.isNullOrEmpty(productBrand)) {
            productBrandDto = new ProductBrandDto();
            ObjectUtils.fastCopy(productBrand, productBrandDto);
        }
        return productBrandDto;
    }

    /**
     * 根据code获取品牌
     * 
     * <p>
     * Description:
     * </p>
     * 
     * @param brandName
     * @return
     * @see com.yilidi.o2o.product.service.IProductBrandService#getBrandByName(java.lang.String)
     */

    @Override
    public ProductBrandDto getBrandByCode(String brandCode)throws ProductServiceException  {
        ProductBrandDto productBrandDto = null;
        ProductBrand productBrand = productBrandMapper.getBrandByCode(brandCode);
        if (!ObjectUtils.isNullOrEmpty(productBrand)) {
            productBrandDto = new ProductBrandDto();
            ObjectUtils.fastCopy(productBrand, productBrandDto);
        }
        return productBrandDto;
    }

	@Override
	public YiLiDiPage<ProductBrandDto> listProductBrandsByKeywords(String keywords, Integer storeId,Integer pageNum, Integer pageSize)throws ProductServiceException  {
		StoreProfileProxyDto storeProfileProxyDto = null;
        if (null!=storeId) {
            storeProfileProxyDto = storeProfileProxyService.loadByStoreId(storeId);
        }else{
        	throw new ProductServiceException("listProductBrandsByKeywords  storeId为空");
        }
        SaleProductQuery saleProductQuery = new SaleProductQuery();
        if (SystemContext.UserDomain.STORETYPE_PARTNER.equals(storeProfileProxyDto.getStoreType())
                && SystemContext.UserDomain.STORESTOCKSHARE_YES.equals(storeProfileProxyDto.getStockShare())) {
            Integer wareHouseId = storeWarehouseProxyService.loadWarehouseIdByStoreId(storeProfileProxyDto.getStoreId());
            saleProductQuery.setStoreId(wareHouseId);
            saleProductQuery.setStoreType(SystemContext.UserDomain.STORETYPE_MICROWAREHOUSE);
        } else {
            saleProductQuery.setStoreId(storeProfileProxyDto.getStoreId());
        }
		//获取店铺的所有在售商品
		saleProductQuery.setEnabledFlag(SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
		saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
		saleProductQuery.setDisplay(SystemContext.ProductDomain.PRODUCTCLASSDISPLAY_YES);
		String order = DBTablesColumnsName.SaleProductProfile.DISPLAYORDER;
		String sort = CommonConstants.SORT_ORDER_ASC;
		saleProductQuery.setOrder(order);
		saleProductQuery.setSort(sort);
		List<String> brandCodes = saleProductService.listSaleProductBrandCodesByStoreId(saleProductQuery);
				
		ProductBrandQueryDto queryProductBrand = new ProductBrandQueryDto();
		queryProductBrand.setBrandName(keywords.trim());
		queryProductBrand.setStatusCode(SystemContext.ProductDomain.PRODUCTBRANDSTATUS_ON);
		queryProductBrand.setPageSize(pageSize);
		queryProductBrand.setStart(pageNum);
		queryProductBrand.setBrandCodesList(brandCodes);
		//获取关键字相关的品牌
		YiLiDiPage<ProductBrandDto> page = this.findProductBrandInfos(queryProductBrand);
		return page;
	}
}
