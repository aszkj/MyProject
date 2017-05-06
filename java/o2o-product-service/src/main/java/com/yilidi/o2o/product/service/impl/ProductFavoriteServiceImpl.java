/**
 * 文件名称：ProductBrandService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.ProductFavoriteMapper;
import com.yilidi.o2o.product.model.ProductFavorite;
import com.yilidi.o2o.product.model.query.ProductFavoriteQuery;
import com.yilidi.o2o.product.service.IProductFavoriteService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.ProductFavoriteDto;
import com.yilidi.o2o.product.service.dto.query.ProductFavoriteQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述:产品品牌服务类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("productFavoriteService")
public class ProductFavoriteServiceImpl extends BasicDataService implements IProductFavoriteService {

    @Autowired
    private ProductFavoriteMapper productFavoriteMapper;
    @Autowired
    private IProductService productService;
    @Override
    public void saveProductFavorite(ProductFavoriteDto productFavoriteDto) throws ProductServiceException {
        // 保存产品品牌表开始
        logger.debug("productFavoriteDto -> " + productFavoriteDto);
        // 检查产品参数对象是否为空
        if (ObjectUtils.isNullOrEmpty(productFavoriteDto)) {
            logger.error("ProductFavoriteService.saveProductFavorite => 收藏产品的参数为空");
            throw new ProductServiceException("收藏产品的参数为空");
        }
        try {
            // 收藏产品的产品id是否为空
            if (ObjectUtils.isNullOrEmpty(productFavoriteDto.getProductId())) {
                logger.error("productFavoriteDto.getProductId() => 收藏的产品id参数为空");
                throw new ProductServiceException("收藏的产品id参数为空");
            }
            // 产品收藏者ID是否为空
            if (ObjectUtils.isNullOrEmpty(productFavoriteDto.getUserId())) {
                logger.error("productFavoriteDto.getUserId() => 产品收藏者ID参数为空");
                throw new ProductServiceException("产品收藏者ID参数为空");
            }
            ProductFavorite pFavorite = productFavoriteMapper.loadProductFavoriteByUserIdAndProductId(productFavoriteDto.getUserId(),
                    productFavoriteDto.getProductId());
            ProductDto productDto = productService.loadProductByProductIdAndChannelCode(productFavoriteDto.getProductId(), null);
            if(ObjectUtils.isNullOrEmpty(productDto)){
                throw new ProductServiceException("产品信息校验异常");
            }
            if(!ObjectUtils.isNullOrEmpty(pFavorite)){
                throw new ProductServiceException("用户已收藏该商品");
            }
            ProductFavorite productFavorite = new ProductFavorite();
            ObjectUtils.fastCopy(productFavoriteDto, productFavorite);
            productFavoriteMapper.save(productFavorite);
        } catch (ProductServiceException e) {
            logger.error("保存收藏产品出错");
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<ProductFavoriteDto> findProductFavoriteInfos(ProductFavoriteQueryDto queryProductFavoriteDto)
            throws ProductServiceException {
        try {
            if (null == queryProductFavoriteDto.getStart() || queryProductFavoriteDto.getStart() <= 0) {
                queryProductFavoriteDto.setStart(1);
            }
            if (null == queryProductFavoriteDto.getPageSize() || queryProductFavoriteDto.getPageSize() <= 0) {
                queryProductFavoriteDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            ProductFavoriteQuery pfQuery = new ProductFavoriteQuery();
            ObjectUtils.fastCopy(queryProductFavoriteDto, pfQuery);
            PageHelper.startPage(pfQuery.getStart(), pfQuery.getPageSize());
            Page<ProductFavorite> page = productFavoriteMapper.findProductFavorites(pfQuery);
            Page<ProductFavoriteDto> pageDto = new Page<ProductFavoriteDto>(pfQuery.getStart(),
                    pfQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<ProductFavorite> productFavorites = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(productFavorites)) {
                for (ProductFavorite pf : productFavorites) {
                    ProductFavoriteDto pfDto = new ProductFavoriteDto();
                    ObjectUtils.fastCopy(pf, pfDto);
                    pageDto.add(pfDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findProductFavoriteInfos异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteProductFavoriteByProductIdAndUserId(String productIds, Integer userId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(productIds)) {
                throw new ProductServiceException("商品信息参数异常");
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new ProductServiceException("用户信息参数为空");
            }
            
            String[] productIdarr = productIds.split(",");
            for(int i=0;i<productIdarr.length;i++){
                productFavoriteMapper.deleteByByProductIdAndUserId(Integer.valueOf(productIdarr[i]),userId);
            }
        }catch (Exception e) {
            logger.error("deleteProductFavoriteByProductIdAndUserId异常", e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public ProductFavoriteDto loadProductFavoriteByUserIdAndProductId(Integer userId, Integer productId) {
        try {
            if (ObjectUtils.isNullOrEmpty(productId)) {
                throw new ProductServiceException("商品信息参数异常");
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new ProductServiceException("用户信息参数为空");
            }
            ProductFavoriteDto productFavoriteDto = null;
            ProductFavorite productFavorite = productFavoriteMapper.loadProductFavoriteByUserIdAndProductId(userId,
                    productId);
            if (!ObjectUtils.isNullOrEmpty(productFavorite)) {
                productFavoriteDto = new ProductFavoriteDto();
                ObjectUtils.fastCopy(productFavorite, productFavoriteDto);
            }
            return productFavoriteDto;
        } catch (Exception e) {
            logger.error("loadProductFavoriteByUserIdAndProductId异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
