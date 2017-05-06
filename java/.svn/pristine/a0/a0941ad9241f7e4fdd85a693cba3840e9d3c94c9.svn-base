/**
 * 文件名称：IProductService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;

/**
 * 功能描述：产品服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductService {

    /**
     * 根据id查询产品信息
     * 
     * @param id
     *            产品id
     * @param channelCode
     *            产品渠道编码
     * @return 产品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductDto loadProductByProductIdAndChannelCode(Integer id, String channelCode) throws ProductServiceException;

    /**
     * 根据前台传过来的ProductDto保存产品信息
     * 
     * @param saveProductDto
     *            产品信息
     * @param channelCode
     *            渠道编码
     * @return 产品错误信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    String saveProduct(ProductDto saveProductDto, String channelCode) throws ProductServiceException;

    /**
     * 针对导入产品，通过ProductDtos批量保存产品信息
     * 
     * @param saveProductDtos
     *            产品信息
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void batchSaveProduct(List<ProductDto> saveProductDtos, String channelCode) throws ProductServiceException;

    /**
     * 根据前台传过来的updateProductDto更新产品信息
     * 
     * @param updateProductDto
     *            产品productDto
     * @param channelCode
     *            产品渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateProduct(ProductDto updateProductDto, String channelCode) throws ProductServiceException;

    /**
     * 根据产品ID更改产品状态
     * 
     * @param id
     *            产品productId
     * @param statusCode
     *            产品状态
     * @param modifyTime
     *            产品修改时间
     * @param modifyUserId
     *            产品修改人
     * @throws ProductServiceException
     *             产品域服务异常
     * @return boolean
     */
    boolean updateProductStatusById(Integer id, String statusCode, Date modifyTime, Integer modifyUserId)
            throws ProductServiceException;

    /**
     * 根据条件查询产品基础信息之后，得到整个产品信息
     * 
     * @param queryProduct
     *            产品查询dto
     * @return 产品列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductDto> findProductsByBasicInfo(ProductQuery queryProduct) throws ProductServiceException;

    /**
     * 根据条件查询产品基础信息
     * 
     * @return 产品基础信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductDto> getProductBasicInfos() throws ProductServiceException;

    /**
     * 根据条件查询产品基础信息
     * 
     * @param productClassCode
     *            产品类别
     * @param statusCode
     *            产品状态（是否有效）
     * @return 产品基础信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductDto> listProductBasicInfosByClassCode(String productClassCode, String statusCode)
            throws ProductServiceException;

    /**
     * 根据条件查询产品相关信息
     * 
     * @param queryProduct
     *            产品查询dto
     * @return 产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductDto> findProductRelativeInfos(ProductQuery queryProduct) throws ProductServiceException;

    /**
     * 根据条件查询可以导入到指点店铺的产品相关信息，排除自身已有的商品
     * 
     * @param storeId
     *            店铺ID
     * @param storeType
     *            店铺类型
     * @param queryProduct
     *            产品查询dto
     * @return 产品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductDto> findProductRelativeInfosByStoreType(Integer storeId, String storeType, ProductQuery queryProduct)
            throws ProductServiceException;

    /**
     * 根据条形码查询产品信息
     * 
     * @param barCode
     *            产品barCode
     * @param channelCode
     *            产品channelCode
     * @return 产品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductDto loadProductByBarCodeAndChannelCode(String barCode, String channelCode) throws ProductServiceException;

    /**
     * 根据productId和渠道编码更新产品的产品类别
     * 
     * @param id
     *            产品productId
     * @param productClassCode
     *            产品productClassCode
     * @param modifyUserId
     *            产品modifyUserId
     * @param modifyTime
     *            产品modifyTime
     * @return 是否更新成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    boolean updateProductClass(Integer id, String productClassCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 
     * @Description TODO(分页获取报表数据)
     * @param productQuery
     *            产品查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return List<ProductDto>
     * 
     * @throws ProductServiceException
     *             产品域异常
     */
    List<ProductDto> listDataForExportProduct(ProductQuery productQuery, Long startLineNum, Integer pageSize)
            throws ProductServiceException;

    /**
     * 
     * @Description TODO(获取报表数据的总记录数)
     * @param productQuery
     *            产品查询实体
     * @return Long
     * @throws ProductServiceException
     *             产品域异常
     */
    Long getCountsForExportProduct(ProductQuery productQuery) throws ProductServiceException;

    /**
     * 
     * @Description TODO(该条形码产品是否已经存在)
     * @param barCode
     *            产品barCode
     * @return Long
     * @throws ProductServiceException
     *             产品域异常
     */
    boolean checkBarCodeIsExistInStandard(String barCode) throws ProductServiceException;

    /**
     * 
     * @Description TODO(临时表保存至正式产品库)
     * @param productDto
     *            产品productDto
     * @param tempId
     *            临时产品tempId
     * @param channelCode
     *            商品channelCode
     * @param createUserId
     *            用户createUserId
     * @param createTime
     *            操作时间createTime
     * @return String 错误信息
     * @throws ProductServiceException
     *             产品域异常
     */
    List<String> saveProductTempToStandard(ProductDto productDto, Integer tempId, String channelCode, Integer createUserId,
            Date createTime) throws ProductServiceException;

    /**
     * 
     * 产品保存至多个店铺
     * 
     * @param storeInfo
     *            店铺id和店铺编码
     * @param barCodeList
     *            产品barCodeList
     * @param channelCode
     *            商品channelCode
     * @param createUserId
     *            用户createUserId
     * @param createTime
     *            操作时间createTime
     * @return List<String> 错误信息
     * @throws ProductServiceException
     *             产品域异常
     */
    List<String> saveProductToStores(List<HashMap<String, Object>> storeInfo, List<String> barCodeList, String channelCode,
            Integer createUserId, Date createTime) throws ProductServiceException;

    /**
     * 
     * 所有条形码信息
     * 
     * @return List<String> 条形码信息
     * @throws ProductServiceException
     *             产品域异常
     */
    Set<String> getProductBarCode() throws ProductServiceException;

    /**
     * 
     * 所有条形码信息
     * 
     * @param storeType
     *            店铺类型
     * @return List<String> 条形码信息
     * @throws ProductServiceException
     *             产品域异常
     */
    Set<String> getProductBarCodeByStoreType(String storeType) throws ProductServiceException;

    /**
     * 根据条件查询产品基础信息
     * 
     * @param productIds
     *            产品ID列表
     * @param statusCode
     *            产品状态（是否有效）
     * @return 产品信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductDto> listProductByIdsAndStatusCode(List<Integer> productIds, String statusCode)
            throws ProductServiceException;
}