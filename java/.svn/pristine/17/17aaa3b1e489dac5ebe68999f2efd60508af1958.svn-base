/**
 * 文件名称：IProductClassService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ProductClassDto;
import com.yilidi.o2o.product.service.dto.StoreTypeProductClassDto;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;

/**
 * 功能描述：产品类别服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductClassService {

    /**
     * 根据前台传过来的ProductClassDto保存产品类别信息*
     * 
     * @param saveProductClassDto
     *            产品类别信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveProductClass(ProductClassDto saveProductClassDto) throws ProductServiceException;

    /**
     * 根据前台传过来的产品类别ID删除产品类别信息*
     * 
     * @param id
     *            产品类别id
     * @return 是否删除成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    String deleteProductClassById(Integer id) throws ProductServiceException;

    /**
     * 根据前台传过来的updateProductDto更新产品类别信息
     * 
     * @param updateProductClassDto
     *            产品类别productDto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateProductClass(ProductClassDto updateProductClassDto) throws ProductServiceException;

    /**
     * 根据前台传过来的updateProductDto更新产品类别信息
     * 
     * @param statusCode
     *            产品类别statusCode
     * @param classCode
     *            产品编码
     * @param modifyUserId
     *            产品类别modifyUserId
     * @param modifyTime
     *            产品类别modifyTime
     * @return 错误信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    String updateStatusCodeById(String statusCode, String classCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 根据产品类别编码查询产品类别
     * 
     * @param classCode
     *            类别编码
     * @param statusCode
     *            有效状态
     * @return 类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductClassDto loadProductClassByClassCode(String classCode, String statusCode) throws ProductServiceException;

    /**
     * 根据产品类别Id查询产品类别
     * 
     * @param id
     *            类别id
     * @return 类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductClassDto loadProductClassById(Integer id) throws ProductServiceException;

    /**
     * 根据产品类别名称以及父类名称产品类别(导入excel列表时类别信息只有父类名称以及子类名称)
     * 
     * @param className
     *            类别编码
     * @param classLevel
     *            类别级别
     * @param statusCode
     *            类别状态
     * @return 类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductClassDto loadProductClassByClassName(String className)
            throws ProductServiceException;

    /**
     * 根据上一级code所有查出下一级分类
     * 
     * @param productClassQuery
     * @return
     * @throws ProductServiceException
     */
    List<ProductClassDto> getAllNextProductClassByUpCode(ProductClassQuery productClassQuery) throws ProductServiceException;

    /**
     * 用于组装tree下一级节点
     * 
     * @param productClassQuery
     * @return
     */
    public List<Map<String, Object>> getAllNextTreeNode(ProductClassQuery productClassQuery) throws ProductServiceException;

    /**
     * 根据条件查询产品类别列表
     * 
     * @param productClassQuery
     *            产品类别查询条件
     * @return 类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRODUCT_CLASS })
    List<ProductClassDto> listProductClass(ProductClassQuery productClassQuery) throws ProductServiceException;

    /**
     * 根据产品父类找商品分类列表
     * @param flag 
     * 
     * @param storeId
     *            店铺ID
     * @param parentClassCode
     *            产品父类编码
     * @param display
     *            是否显示
     * @return 分类列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductClassDto> listProductClassByParentCode(String flag, Integer storeId, String parentClassCode)
            throws ProductServiceException;

    /**
     * 根据条件查询产品类别列表（分页）
     * 
     * @param productClassQuery
     *            产品类别查询条件
     * @return 类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductClassDto> findProductClass(ProductClassQuery productClassQuery) throws ProductServiceException;

    /**
     * 根据条件查询产品类别
     * 
     * @param productClassQuery
     *            查询实体
     * @return 产品基础类别列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<Map<String, String>> getBasicProductClassInfoList(ProductClassQuery productClassQuery)
            throws ProductServiceException;

    /**
     * 根据店铺类型查询店铺的可以存在的产品基本类别
     * 
     * @param storeType
     *            店铺类型
     * @param statusCode
     *            商品类别状态
     * @return 产品基础类别Map列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<HashMap<String, String>> listProductClassByStoreType(String storeType, String statusCode)
            throws ProductServiceException;

    /**
     * 根据classCode递归获取子集
     * 
     * @param classCode
     * @return
     */
    List<Object> getSubClassCodes(String classCode) throws ProductServiceException;

    /**
     * 根据当前classCode获取上级classCode及list
     * 
     * @param classCode
     * @return
     */
    List<Map<String, Object>> getUpClassAndNextProductClassByClassCode(String classCode) throws ProductServiceException;

    /**
     * 根据下级classCode查上级分类
     * 
     * @param classCode
     * @return
     */
    ProductClassDto getUpProductClassByClassCode(String classCode) throws ProductServiceException;

    /**
     * 组装产品分类
     * 
     * @return
     */
    List<ProductClassDto> getAllProductClass() throws ProductServiceException;

    List<StoreTypeProductClassDto> getProductClassByStoreType(String storeType) throws ProductServiceException;

}