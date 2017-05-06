/**
 * 文件名称：IProductBrandService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ProductFavoriteDto;
import com.yilidi.o2o.product.service.dto.query.ProductFavoriteQueryDto;

/**
 * 功能描述：产品品牌服务接口类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductFavoriteService {

    /**
     * 保存用户收藏的产品
     * @param productFavoriteDto
     * @throws ProductServiceException
     */
    void saveProductFavorite(ProductFavoriteDto productFavoriteDto)throws ProductServiceException;

    /**
     * 根据条件查询产品收藏相关信息
     * 
     * @param queryProductFavorite
     *            品牌查询dto
     * @return 产品收藏相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<ProductFavoriteDto> findProductFavoriteInfos(ProductFavoriteQueryDto queryProductFavorite) throws ProductServiceException;
    /**
     * 取消收藏的产品
     * @param productId
     * @param userId
     */
    void deleteProductFavoriteByProductIdAndUserId(String productId, Integer userId)throws ProductServiceException;
    /**
     * 根据用户id和产品id获取收藏的商品
     * @param userId
     * @param productId
     */
    ProductFavoriteDto loadProductFavoriteByUserIdAndProductId(Integer userId, Integer productId);

}