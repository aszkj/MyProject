/**
 * 文件名称：IProductBrandService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ProductBrandDto;
import com.yilidi.o2o.product.service.dto.SaleProductByBrandCodeDto;
import com.yilidi.o2o.product.service.dto.query.ProductBrandQueryDto;

/**
 * 功能描述：产品品牌服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductBrandService {

    /**
     * 根据前台传过来的ProductBrandDto保存产品品牌信息*
     * 
     * @param saveProductBrandDto
     *            产品品牌信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveProductBrand(ProductBrandDto saveProductBrandDto) throws ProductServiceException;

    /**
     * 根据品牌编码更新品牌名称
     * 
     * @param brandCode
     *            品牌编码
     * @param brandName
     *            品牌名称
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     */
    void updateBrandNameByBrandCode(String brandCode, String brandName, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 根据品牌编码更新品牌状态
     * 
     * @param brandCode
     *            品牌编码
     * @param statusCode
     *            状态
     * @param modifyUserId
     *            修改人
     * @param modifyTime
     *            修改时间
     */
    void updateStatusCodeByBrandCode(String brandCode, String statusCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 根据前台传过来的updateProductBrandDto更新产品品牌信息(根据ID更新传过来的所有内容)
     * 
     * @param updateProductBrandDto
     *            产品品牌productDto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateProductBrand(ProductBrandDto updateProductBrandDto) throws ProductServiceException;

    /**
     * 根据品牌id查询品牌信息
     * 
     * @param id
     *            品牌Id
     * @return 品牌信息
     */
    ProductBrandDto loadProductBrandById(Integer id) throws ProductServiceException;

    /**
     * 根据产品品牌编码查询所有的产品品牌（如果状态为null，则获取所有的记录）
     * 
     * @param brandCode
     *            品牌编码
     * @return 品牌列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    ProductBrandDto loadProductBrandByBrandCode(String brandCode) throws ProductServiceException;

    /**
     * 根据条件查询全部品牌
     * 
     * @param queryProductBrand
     *            品牌查询dto
     * @return 品牌相关信息集
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductBrandDto> listProductBrands(ProductBrandQueryDto queryProductBrand) throws ProductServiceException;

    /**
     * 查询全部品牌
     * 
     * @return 品牌相关信息集
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductBrandDto> listProductBrands() throws ProductServiceException;

    /**
     * 根据条件查询品牌相关信息
     * 
     * @param queryProductBrand
     *            品牌查询dto
     * @return 品牌相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductBrandDto> findProductBrandInfos(ProductBrandQueryDto queryProductBrand) throws ProductServiceException;

    /**
     * 根据条件查询全部品牌
     * 
     * @param type
     * @param storeId 
     * @return 品牌相关信息集
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<ProductBrandDto> listProductBrandsByType(String type, Integer storeId,String SaleStatus) throws ProductServiceException;

    /**
     * 根据商铺id和品牌编码查询商品列表
     * 
     * @param storeId
     * @param brandCode
     * @param pageNum
     * @param pageSize
     * @return
     * @throws ProductServiceException
     */
    YiLiDiPage<SaleProductByBrandCodeDto> findSaleProductByBrandCode(Integer storeId, String brandCode, Integer pageNum,
            Integer pageSize) throws ProductServiceException;


    /**
     * 获取所有品牌（通用）
     * 
     * 
     * @return
     */
    List<ProductBrandDto> getAllBrandBasic() throws ProductServiceException;

    /**
     * 根据品牌名称获取产品品牌
     * 
     * @param trim
     * @return
     */
    ProductBrandDto getBrandByName(String brandName) throws ProductServiceException;

    /**
     * 根据品牌code获取产品品牌
     * 
     * @param trim
     * @return
     */
    ProductBrandDto getBrandByCode(String brandCode) throws ProductServiceException;
    /**
     * 根据关键字搜索品牌列表接口
     * @param keywords
     * @param storeId
     * @param pageSize 
     * @param pageNum 
     * @return
     */
	YiLiDiPage<ProductBrandDto> listProductBrandsByKeywords(String keywords, Integer storeId, Integer pageNum, Integer pageSize)throws ProductServiceException ;

}