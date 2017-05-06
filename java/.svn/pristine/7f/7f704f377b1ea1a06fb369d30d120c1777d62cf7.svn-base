/**
 * 文件名称：ISaleProductService.java
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

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.SaleProductBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.SaleProductOtherBatchSaveDto;
import com.yilidi.o2o.product.service.dto.SaleProductSortBatchSaveDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 功能描述：商品服务接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleProductService {

    /**
     * 可通过导入批量保存商品信息
     * 
     * @param listSaleProductDto
     *            商品信息列表
     * @param storeType
     *            需要保存的商品的店铺类型
     * @param channelCode
     *            需要保存的商品的渠道编码
     * @return List<String> 保存错误信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<String> saveSaleProducts(List<SaleProductDto> listSaleProductDto, String storeType, String channelCode)
            throws ProductServiceException;

    /**
     * 根据条件查询商品相关信息
     * 
     * @param querySaleProduct
     *            商品查询dto
     * @return 商品相关信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<SaleProductDto> findSaleProductRelativeInfos(SaleProductQuery querySaleProduct)
            throws ProductServiceException;

    /**
     * 根据saleProductId和渠道编码更新商品的商品类别
     * 
     * @param saleProductId
     *            商品saleProductId
     * @param productClassCode
     *            商品productClassCode
     * @param modifyUserId
     *            商品modifyUserId
     * @param modifyTime
     *            商品modifyTime
     * @return 是否更新成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    boolean updateProductClass(Integer saleProductId, String productClassCode, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 根据saleProductId启用和禁用商品
     * 
     * @param saleProductId
     *            商品saleProductId
     * @param enabledFlag
     *            商品enabledFlag
     * @param modifyUserId
     *            商品modifyUserId
     * @param modifyTime
     *            商品modifyTime
     * @return 是否启用和禁用成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    boolean updateEnabledFlag(Integer saleProductId, String enabledFlag, Integer modifyUserId, Date modifyTime)
            throws ProductServiceException;

    /**
     * 根据id查询商品信息
     * 
     * @param id
     *            商品id
     * @param enabledFlag
     *            商品id
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 商品信息
     */
    SaleProductDto loadSaleProductBasicInfoById(Integer id, String enabledFlag) throws ProductServiceException;

    /**
     * 根据barCode查询商品信息
     * 
     * @param storeId
     *            店铺id
     * @param enableFlag
     *            商品是否有效
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 商品信息
     */
    List<SaleProductDto> listSaleProductBasicInfoByStoreId(Integer storeId, String enableFlag)
            throws ProductServiceException;

    /**
     * 根据商品id和渠道编码查询商品信息
     * 
     * @param saleProductId
     *            商品id
     * @param enabledFlag
     *            是否可以编码
     * @param saleStatus
     *            上下架状态编码
     * @param channelCode
     *            渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 商品信息
     */
    SaleProductDto loadSaleProductByIdAndChannelCode(Integer saleProductId, String enabledFlag, String saleStatus,
            String channelCode) throws ProductServiceException;

    /**
     * 根据id更新商品信息
     * 
     * @param updateSaleProductDto
     *            需要更新的商品dto
     * @param channelCode
     *            需要更新的商品的渠道编码
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateSaleProduct(SaleProductDto updateSaleProductDto, String channelCode) throws ProductServiceException;

    /**
     * 根据id更新商品基础信息
     * 
     * @param updateSaleProductDto
     *            需要更新的商品基础信息dto
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateSaleProductBasicInfo(SaleProductDto updateSaleProductDto) throws ProductServiceException;

    /**
     * 根据前台传过来的条件SaleProductDto查询商品信息
     * 
     * @param querySaleProduct
     *            商品查询实体类
     * 
     * @throws ProductServiceException
     *             产品域服务异常
     * @return 商品信息列表
     */
    Page<SaleProductDto> findSaleProductByBasicInfo(SaleProductQuery querySaleProduct) throws ProductServiceException;

    /**
     * 
     * 分页获取报表数据
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return List<SaleProductDto>
     * 
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<SaleProductDto> listDataForExportSaleProduct(SaleProductQuery saleProductQuery, Long startLineNum,
            Integer pageSize) throws ProductServiceException;

    /**
     * 
     * 获取报表数据的总记录数
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @return Long
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Long getCountsForExportSaleProduct(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 商品添加到标准库
     * 
     * @param saleProductDto
     *            商品saleProductDto
     * @param channelCode
     *            商品channelCode
     * @param createUserId
     *            用户createUserId
     * @param createTime
     *            操作时间createTime
     * @return 是否添加成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    String addToStandard(SaleProductDto saleProductDto, String channelCode, Integer createUserId, Date createTime)
            throws ProductServiceException;

    /**
     * 将标准库产品导入店铺
     * 
     * @param productDtoList
     *            标准库产品列表
     * @param objs
     *            其他参数数组
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveSaleProductBatch(List<ProductDto> productDtoList, SaleProductBatchSaveDto objs) throws ProductServiceException;

    /**
     * 采购/调拨批量保存商品,只能全部成功或失败
     * 
     * @param productDtoList
     *            标准库产品列表
     * @param objs
     *            其他参数数组
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveSaleProductBatchSync(List<ProductDto> productDtoList, SaleProductBatchSaveDto objs)
            throws ProductServiceException;

    /**
     * 将非标准库产品导入店铺
     * 
     * @param saleProductDtoList
     *            其他商品列表
     * @param objs
     *            其他参数数组
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void saveOtherSaleProductBatch(List<SaleProductDto> saleProductDtoList, SaleProductOtherBatchSaveDto objs)
            throws ProductServiceException;

    /**
     * 根据saleProductId和渠道编码更新商品的商品顺序
     * 
     * @param displayOrderList
     *            商品顺序map列表
     * @param objs
     *            其他参数数组
     * @return 是否更新成功
     * @throws ProductServiceException
     *             产品域服务异常
     */
    boolean updateSaleProductDisplayOrderBatch(List<HashMap<String, Object>> displayOrderList,
            SaleProductSortBatchSaveDto objs) throws ProductServiceException;

    /**
     * 根据saleProductId更新商品的商品审核状态
     * 
     * @param saleProductId
     *            商品id
     * @param auditStatusCode
     *            商品auditStatusCode
     * @param auidtNote
     *            商品auidtNote
     * @param auditUserId
     *            商品auditUserId
     * @param auditTime
     *            商品auditTime
     * @throws ProductServiceException
     *             产品域服务异常
     */
    void updateSaleProductAuditStatusCodeById(Integer saleProductId, String auditStatusCode, String auidtNote,
            Integer auditUserId, Date auditTime) throws ProductServiceException;

    /**
     * 
     * 店铺中所有商品条形码信息
     * 
     * @param storeId
     *            店铺id
     * @return List<String> 条形码信息
     * @throws ProductServiceException
     *             产品域异常
     */
    Set<String> getSaleProductBarCode(Integer storeId) throws ProductServiceException;

    /**
     * 
     * 依据商品类别获取商品基本信息列表
     * 
     * @param classCode
     *            商品类别
     * @param enabledFlag
     *            商品状态
     * @return List<SaleProductDto>
     * 
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<SaleProductDto> listSaleProductBasicInfosByClassCode(String classCode, String enabledFlag)
            throws ProductServiceException;

    /**
     * 商品分页搜索
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品分页信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    YiLiDiPage<SaleProductAppDto> findSaleProducts(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 根据销售专区查找商品列表
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品分页信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> findSaleProductsBySaleZoneType(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 根据商品ID和渠道编码查询商品信息
     * 
     * @param saleProductId
     *            商品ID
     * @param enabledFlag
     *            商品有效状态编码
     * @param saleStatus
     *            商品上下架状态编码
     * @param channelCode
     *            渠道编码
     * @return 商品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    SaleProductAppDto loadSaleProductById(Integer saleProductId, String enabledFlag, String saleStatus, String channelCode)
            throws ProductServiceException;

    /**
     * 根据商品ID列表和渠道编码查询商品信息
     * 
     * @param saleProductIds
     *            商品ID列表
     * @param enabledFlag
     *            是否可以编码
     * @param saleStatus
     *            上下架状态编码
     * @param channelCode
     *            渠道编码
     * @return 商品信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> listSaleProductByIdsAndChannelCode(List<Integer> saleProductIds, String enabledFlag,
            String saleStatus, String channelCode) throws ProductServiceException;

    /**
     * 根据产品ID列表和店铺ID和渠道编码查询商品信息
     * 
     * @param productIds
     *            产品ID列表
     * @param enabledFlag
     *            商品有效状态编码
     * @param saleStatus
     *            商品上下架状态编码
     * @param storeId
     *            店铺ID
     * @param channelCode
     *            渠道编码
     * @return 商品信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> listSaleProductByProductIdsAndStoreIdAndChannelCode(List<Integer> productIds, String enabledFlag,
            String saleStatus, Integer storeId, String channelCode) throws ProductServiceException;

    /**
     * 根据商品ID列表和店铺ID和渠道编码查询商品信息
     * 
     * @param saleProductIds
     *            商品ID列表
     * @param enabledFlag
     *            商品有效状态编码
     * @param saleStatus
     *            商品上下架状态编码
     * @param storeId
     *            店铺ID
     * @param channelCode
     *            渠道编码
     * @return 商品信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> listSaleProductByIdsAndStoreIdAndChannelCode(List<Integer> saleProductIds, Integer storeId,
            String enabledFlag, String saleStatus, String channelCode) throws ProductServiceException;

    /**
     * 根据店铺ID和若干条形码获取商品List
     * 
     * @param storeId
     *            店铺ID
     * @param barCodes
     *            条形码列表
     * @return List<SaleProductDto> 商品信息列表
     * @throws ProductServiceException
     *             服务异常
     */
    List<SaleProductDto> listSaleProductsByStoreIdAndBarCodes(Integer storeId, List<String> barCodes)
            throws ProductServiceException;

    /**
     * 根据商品查询条件查询商品库存分页信息
     * 
     * @param saleProductQuery
     *            查询条件
     * @return 商品库存分页信息
     * @throws ProductServiceException
     *             服务异常
     */
    YiLiDiPage<SaleProductAppDto> findSaleProductInventorys(SaleProductQuery saleProductQuery)
            throws ProductServiceException;

    /**
     * 分页获取报表数据
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return SaleProductAppDto>
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> listDataForExportSaleProductInventory(SaleProductQuery saleProductQuery, Long startLineNum,
            Integer pageSize) throws ProductServiceException;

    /**
     * 
     * 获取报表数据的总记录数
     * 
     * @param saleProductQuery
     *            商品查询实体
     * @return Long
     * @throws ProductServiceException
     *             产品域服务异常
     */
    Long getCountsForExportSaleProductInventory(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 获取卖家调拨微仓的商品列表,注:调拨调用,其他谨慎调用
     * 
     * @param saleProductDto
     *            商品DTO
     * @return List<SaleProductAppDto> 商品相关信息列表
     * @throws ProductServiceException
     *             服务异常
     */
    List<SaleProductAppDto> listSaleProductsForSellerFlitting(SaleProductDto saleProductDto) throws ProductServiceException;

    /**
     * 商品搜索
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品信息列表
     * @throws ProductServiceException
     *             产品域服务异常
     */
    List<SaleProductAppDto> listSaleProducts(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 根据小区ID和产品条形码获取商品详情
     * 
     * @param storeId
     *            店铺ID
     * @param barCode
     *            产品条形码
     * @param channelCode
     *            渠道编码
     * @return 商品信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    SaleProductAppDto loadSaleProductByStoreIdAndBarCode(Integer storeId, String barCode, String channelCode)
            throws ProductServiceException;

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
    SaleProductDto loadSaleProductInfoByStoreIdAndBarCode(Integer storeId, String storeName, String barCode,
            String saleProductName) throws ProductServiceException;

    /**
     * 根据楼层ID查找商品列表信息
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品列表信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<SaleProductAppDto> listSaleProductsByFloorId(SaleProductQuery saleProductQuery)
            throws ProductServiceException;

    /**
     * 根据专题类型编码查找商品列表信息
     * 
     * @param saleProductQuery
     *            商品查询条件
     * @return 商品列表信息
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public List<SaleProductAppDto> listSaleProductsByTypeCode(SaleProductQuery saleProductQuery)
            throws ProductServiceException;

    /**
     * 根据店铺ID查询商品品牌codes
     * 
     * @param saleProductQuery
     * @return
     * @throws ProductServiceException
     */
    public List<String> listSaleProductBrandCodesByStoreId(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 根据产品ID查询storeIds
     * 
     * @param saleProductQuery
     * @return
     * @throws ProductServiceException
     */
    public List<Integer> listStoreIdsByProductId(SaleProductQuery saleProductQuery) throws ProductServiceException;

    /**
     * 批量修改商品库存
     * 
     * @param saleProductRemainCountKeys
     *            商品库存键值对列表
     * @param userId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品域异常
     */
    public void updateBatchRemainCountById(List<KeyValuePair<Integer, Integer>> saleProductRemainCountKeys, Integer userId)
            throws ProductServiceException;

    /**
     * 根据产品ID和店铺ID获取商品信息
     * 
     * @param storeId
     * @param productId
     * @return
     * @throws ProductServiceException
     */
    public SaleProductAppDto loadByStoreIdAndProductId(Integer storeId, Integer productId) throws ProductServiceException;
}
