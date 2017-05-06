/**
 * 文件名称：IProductProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.proxy;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.proxy.dto.ProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductPriceProxyDto;
import com.yilidi.o2o.product.proxy.dto.SaleProductProxyDto;

/**
 * 功能描述：商品服务代理类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IProductProxyService {

    /**
     * 根据商品id获取商品信息
     * 
     * @param saleProductId
     *            商品id
     * @return 商品信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    public SaleProductProxyDto loadById(Integer saleProductId) throws ProductServiceException;

    /**
     * 根据商品id获取商品详细信息
     * 
     * @param saleProductId
     *            商品id
     * @return 商品信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    public SaleProductProxyDto loadDetailById(Integer saleProductId) throws ProductServiceException;

    /**
     * 根据商品id和下单用户id获取商品的价格
     * 
     * @param saleProductId
     *            商品id
     * @param retailerId
     *            零售商id
     * @return 商品价格信息
     * @throws ProductServiceException
     *             商品服务异常
     */
    public ProductPriceProxyDto loadBySaleProductIdAndUserId(Integer saleProductId, Integer retailerId)
            throws ProductServiceException;

    /**
     * 根据code列表查找商品类别名称列表
     * 
     * @param codesList
     *            类别编码列表
     * @return 类别名称列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<String> listProductClassNamesByCodes(List<String> codesList) throws ProductServiceException;

    /**
     * 根据店铺商品ID列表和渠道查询查找商品详细信息列表
     * 
     * @param saleProductIds
     *            店铺商品ID列表
     * @param enabledFlag
     *            是否可以编码
     * @param saleStatus
     *            上下架状态编码
     * @param channelCode
     *            渠道编码
     * @return 商品信息列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<SaleProductProxyDto> listSaleProductByIdsAndChannelCode(List<Integer> saleProductIds, String enabledFlag,
            String saleStatus, String channelCode) throws ProductServiceException;

    /**
     * 根据店铺商品ID列表和渠道查询查找商品价格信息列表
     * 
     * @param saleProductIds
     *            店铺商品ID列表
     * @param channelCode
     *            渠道编码
     * @return 商品价格列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<SaleProductPriceProxyDto> listSaleProductPriceByIdsAndChannelCode(List<Integer> saleProductIds,
            String channelCode) throws ProductServiceException;

    /**
     * 根据产品ID列表查找相应商户门店id详细信息列表
     * 
     * @param enabledFlag
     *            商品有效状态编码
     * @param saleStatus
     *            商品上下架状态编码
     * @param productId
     *            产品ID
     * @return 商品id列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<Integer> listStoreIdsByProductId(String enabledFlag,
            String saleStatus, Integer productId) throws ProductServiceException;
    
    /**
     * 根据店铺ID查询查找商品详细信息列表
     * 
     * @param productIds
     *            产品ID列表
     * @param enabledFlag
     *            商品有效状态编码
     * @param saleStatus
     *            商品上下架状态编码
     * @param storeId
     *            店铺ID
     * @return 商品信息列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<SaleProductProxyDto> listSaleProductByProductIdsAndStoreId(List<Integer> productIds, String enabledFlag,
            String saleStatus, Integer storeId) throws ProductServiceException;

    /**
     * 根据店铺ID、产品ID列表和渠道编码创建商品详细信息列表
     * 
     * @param storeId
     *            店铺ID
     * @param storeType
     *            店铺类型
     * @param productIds
     *            产品ID列表
     * @param operUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @throws ProductServiceException
     *             商品服务异常
     */
    public void saveSaleProductByProductIdsAndStoreId(Integer storeId, String storeType, List<Integer> productIds,
            Integer operUserId, Date operateTime) throws ProductServiceException;

    /**
     * 根据产品ID列表查询有效的产品详细信息列表
     * 
     * @param productIds
     *            产品ID列表
     * @return 商品信息列表
     * @throws ProductServiceException
     *             商品服务异常
     */
    public List<ProductProxyDto> listProductByProductIds(List<Integer> productIds) throws ProductServiceException;
    /**
     * 根据店铺ID和产品条形码获取商品详情
     * 
     * @param storeId
     *            店铺ID
     * @param barCode
     *            产品条形码
     * @return 商品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    SaleProductProxyDto loadSaleProductInfoByStoreIdAndBarCode(Integer storeId, String storeName,String barCode,String saleProductName)
            throws ProductServiceException;

    /**
     * 批量修改商品库存
     * 
     * @param saleProductIdAndRemainCountDeltaKeys
     *            商品库存变化键值对列表
     * @param userId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateBatchSaleProductRemainCount(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws ProductServiceException;
}
