/**
 * 文件名称：productClassMapStoreTypeService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ProductClassMapStoreTypeMapper;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.dao.SaleProductProfileMapper;
import com.yilidi.o2o.product.dao.StoreTypeProductClassMapper;
import com.yilidi.o2o.product.model.ProductClassStoreType;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.StoreTypeProductClass;
import com.yilidi.o2o.product.model.combination.ProductClassStoreTypeRelatedInfo;
import com.yilidi.o2o.product.service.IProductClassMapStoreTypeService;
import com.yilidi.o2o.product.service.IProductClassService;
import com.yilidi.o2o.product.service.dto.ProductClassStoreTypeDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:产品类别与店铺类型映射接口服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productClassMapStoreTypeService")
public class ProductClassMapStoreTypeServiceImpl extends BasicDataService implements IProductClassMapStoreTypeService {

    @Autowired
    private ProductClassMapStoreTypeMapper productClassMapStoreTypeMapper;

    @Autowired
    private SaleProductMapper saleProductMapper;

    @Autowired
    private SaleProductProfileMapper saleProductProfileMapper;
    
    @Autowired
    private IProductClassService productClassService;
    
    @Autowired
    private StoreTypeProductClassMapper storeTypeProductClassMapper;
    
    @Override
    public Map<String, Object> saveProductClassStoreType(String mapString, Integer createUserId, Date creatTime)
            throws ProductServiceException {
        try {
            // 检查产品类别与店铺类型映射关系参数是否为空
            if (ObjectUtils.isNullOrEmpty(mapString)) {
                logger.error("ProductService.saveProductClassStoreType => 保存产品类别与店铺类型映射关系参数为空");
                throw new ProductServiceException("保存产品类别与店铺类型映射关系参数为空");
            }
            // 检查产品类别与店铺类型映射关系createUserId是否为空
            if (ObjectUtils.isNullOrEmpty(createUserId)) {
                logger.error("ProductService.saveProductClassStoreType.createUserId => 商品createUserId为空");
                throw new ProductServiceException("保存产品类别与店铺类型映射关系createUserId参数为空");
            }
            // 检查产品类别与店铺类型映射关系createTime是否为空
            if (ObjectUtils.isNullOrEmpty(creatTime)) {
                logger.error("ProductService.saveProductClassStoreType.createTime => 商品createTime为空");
                throw new ProductServiceException("保存产品类别与店铺类型映射关系createTime参数为空");
            }
            Map<String, Object> modelMsg = this.pakageClassStoreTypeDtos(mapString, createUserId,creatTime);
            List<ProductClassStoreType> productClassStoreTypeList = (List<ProductClassStoreType>)modelMsg.get("obj");
            if (!ObjectUtils.isNullOrEmpty(productClassStoreTypeList)) {
                productClassMapStoreTypeMapper.saveProductClassStoreType(productClassStoreTypeList);
            }
            return modelMsg;
        } catch (ProductServiceException e) {
            logger.error("保存产品类别与店铺类型映射关系出错");
            throw new ProductServiceException("异常：保存产品类别与店铺类型映射关系出错");
        }

    }

    // 将字符串拆分成参数信息封装成dto信息
    private Map<String, Object> pakageClassStoreTypeDtos(String mapString, Integer createUserId, Date createTime)
            throws ProductServiceException {
    	Map<String, Object> modelMsg = new HashMap<String, Object>();
    	//要返回的
        List<ProductClassStoreType> returnProductClassStoreTypeList = new ArrayList<ProductClassStoreType>();
        try {
            // 检查产品类别与店铺类型映射关系参数是否为空
            if (ObjectUtils.isNullOrEmpty(mapString)) {
                logger.error("ProductService.saveProductClassStoreType => 封装产品类别与店铺类型映射关系参数为空");
                throw new ProductServiceException("封装产品类别与店铺类型映射关系参数为空");
            }
            // 保存产品类别与店铺类型映射关系createUserId是否为空
            if (ObjectUtils.isNullOrEmpty(createUserId)) {
                logger.error("ProductService.saveProductClassStoreType.createUserId => 商品createUserId为空");
                throw new ProductServiceException("封装产品类别与店铺类型映射关系createUserId参数为空");
            }
            // 保存产品类别与店铺类型映射关系createTime是否为空
            if (ObjectUtils.isNullOrEmpty(createTime)) {
                logger.error("ProductService.saveProductClassStoreType.createTime => 商品createTime为空");
                throw new ProductServiceException("封装产品类别与店铺类型映射关系createTime参数为空");
            }
            //新
            List<ProductClassStoreType> productClassStoreTypeList = new ArrayList<ProductClassStoreType>();
            String[] mapArrayStrings = mapString.split(",");
            for (int i = 0; i < mapArrayStrings.length - 1; i++) {
                ProductClassStoreType productClassStoreType = null;
                if (!ObjectUtils.isNullOrEmpty(mapArrayStrings[i])) {
                    productClassStoreType = new ProductClassStoreType();
                    productClassStoreType.setStoreType(mapArrayStrings[mapArrayStrings.length - 1]);
                    productClassStoreType.setClassCode(mapArrayStrings[i]);
                    productClassStoreType.setCreateUserId(createUserId);
                    productClassStoreType.setCreateTime(createTime);
                    productClassStoreTypeList.add(productClassStoreType);
                    returnProductClassStoreTypeList.add(productClassStoreType);
                }
            }
            //原
	        List<StoreTypeProductClass> storeTypeProductClassList = storeTypeProductClassMapper
					.listStoreProductsByStoreType(mapArrayStrings[mapArrayStrings.length - 1]);
	        String msg = "";
	        List<Object> classCodes = null;
	        if(!ObjectUtils.isNullOrEmpty(storeTypeProductClassList)){
	        	//比较
	        	for (StoreTypeProductClass storeTypeProductClass : storeTypeProductClassList) {
	        		boolean flag = false;
					for (ProductClassStoreType classStoreType : productClassStoreTypeList) {
						if(storeTypeProductClass.getClassCode().equals(classStoreType.getClassCode())){
							flag = true;
						}
					}
					if(!flag){
						//看有没有产品
						SaleProductQuery saleProductQuery = new SaleProductQuery();
						classCodes = new ArrayList<>();
						classCodes.add(storeTypeProductClass.getClassCode());
						saleProductQuery.setClassCodes(classCodes);
						saleProductQuery.setSaleStatus(SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE);
						if(!ObjectUtils.isNullOrEmpty(saleProductMapper.listSaleProducts(saleProductQuery))){
							msg += "产品分类："+productClassService.loadProductClassByClassCode(storeTypeProductClass.getClassCode(), null).getClassName()+"关联的还有已上架的商品，不能解除关联<br>";
							ProductClassStoreType productClassStoreType = new ProductClassStoreType();
							ObjectUtils.fastCopy(storeTypeProductClass, productClassStoreType);
							returnProductClassStoreTypeList.add(productClassStoreType);
						}
					}
				}
	        }
	        modelMsg.put("msg", msg);
	        modelMsg.put("obj", returnProductClassStoreTypeList);
            this.deleteProductClassStoreType(mapArrayStrings[mapArrayStrings.length - 1]);
            return modelMsg;
        } catch (ProductServiceException e) {
            logger.error("封装产品类别与店铺类型映射关系出错");
            throw new ProductServiceException("异常：封装产品类别与店铺类型映射关系出错");
        }
    }

    @Override
    public void deleteProductClassStoreType(String storeType) throws ProductServiceException {
        try {
            // 检查产品类别与店铺类型映射关系参数是否为空
            if (ObjectUtils.isNullOrEmpty(storeType)) {
                logger.error("ProductService.deleteProductClassStoreType => 删除产品类别与店铺类型映射关系参数storeType为空");
                throw new ProductServiceException("删除产品类别与店铺类型映射关系参数storeType为空");
            }
            productClassMapStoreTypeMapper.deleteAllProductClassStoreType(storeType);
        } catch (ProductServiceException e) {
            logger.error("删除产品类别与店铺类型映射关系出错");
            throw new ProductServiceException("异常：删除产品类别与店铺类型映射关系出错");
        }

    }

    @Override
    public List<ProductClassStoreTypeDto> listBasicClassStoreType(String storeDictCode, String statusCode)
            throws ProductServiceException {
        logger.debug("storeDictCode -> " + storeDictCode);
        try {
            if (ObjectUtils.isNullOrEmpty(storeDictCode)) {
                logger.error("产品类别与店铺类型映射查询参数为空");
                throw new ProductServiceException("异常：产品类别与店铺类型映射查询参数为空");
            }
            List<ProductClassStoreTypeRelatedInfo> productClassStoreTypeRelatedInfoList = productClassMapStoreTypeMapper
                    .listBasicClassStoreType(storeDictCode, statusCode);
            List<ProductClassStoreTypeDto> productClassStoreTypeDtoList = null;
            if (!ObjectUtils.isNullOrEmpty(productClassStoreTypeRelatedInfoList)) {
                productClassStoreTypeDtoList = new ArrayList<ProductClassStoreTypeDto>();
                for (ProductClassStoreTypeRelatedInfo pt : productClassStoreTypeRelatedInfoList) {
                    ProductClassStoreTypeDto productClassStoreTypeDto = null;
                    if (!ObjectUtils.isNullOrEmpty(pt)) {
                        productClassStoreTypeDto = new ProductClassStoreTypeDto();
                        ObjectUtils.fastCopy(pt, productClassStoreTypeDto);
                        String storeTypeNameString = super.getSystemDictName(
                                SystemContext.UserDomain.DictType.STORETYPE.getValue(), pt.getStoreType());
                        productClassStoreTypeDto.setStoreTypeName(storeTypeNameString);
                        List<SaleProduct> saleProductList = saleProductMapper
                                .listSaleProductBasicInfosByClassCodeAndStoreType(
                                        Arrays.asList(productClassStoreTypeDto.getClassCode()),
                                        productClassStoreTypeDto.getStoreType(),
                                        SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON);
                        if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                            List<Integer> saleProductIds = new ArrayList<Integer>();
                            for (SaleProduct saleProduct : saleProductList) {
                                saleProductIds.add(saleProduct.getId());
                            }
                            Long onSaleCounts = saleProductProfileMapper.getOnSaleCountsBySaleProductIds(saleProductIds);
                            if (null != onSaleCounts && 0 != onSaleCounts.longValue()) {
                                productClassStoreTypeDto.setIsExistOnShelfSaleProduct("Y");
                            }
                        }
                        productClassStoreTypeDtoList.add(productClassStoreTypeDto);
                    }
                }
            }
            return productClassStoreTypeDtoList;
        } catch (ProductServiceException e) {
            logger.error("条件查询产品类别列表出错");
            throw new ProductServiceException(e.getMessage());
        }
    }
}
