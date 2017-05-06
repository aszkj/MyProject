package com.yilidi.o2o.product.service;

import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.SecKillProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSaleProductDto;
import com.yilidi.o2o.product.service.dto.query.SecKillProductQueryDto;

/**
 * 功能描述：场次服务接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillProductService {

    /**
     * 保存秒杀商品
     * 
     * @param record
     *            秒杀商品
     * @return 影响的行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer save(SecKillProductDto record) throws ProductServiceException;

    /**
     * 根据ID删除秒杀商品
     * 
     * @param secKillProductId
     *            秒杀商品ID
     * @return 影响的行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer deleteById(Integer secKillProductId) throws ProductServiceException;

    /**
     * 修改秒杀商品信息
     * 
     * @param secKillProductDto
     *            秒杀商品对象
     * @return 影响行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer update(SecKillProductDto secKillProductDto) throws ProductServiceException;

    /**
     * 根据秒杀商品ID获取秒杀商品信息
     * 
     * @param secKillProductId
     *            秒杀商品ID
     * @return 秒杀商品信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillProductDto loadById(Integer secKillProductId) throws ProductServiceException;

    /**
     * 查询秒杀商品分页信息列表
     * 
     * @param secKillProductQueryDto
     *            秒杀商品查询条件
     * @return 秒杀商品分页信息列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    YiLiDiPage<SecKillProductDto> findSecKillProducts(SecKillProductQueryDto secKillProductQueryDto)
            throws ProductServiceException;

    /**
     * 组合查询秒杀商品分页信息列表
     * 
     * @param secKillProductQueryDto
     *            秒杀商品查询条件
     * @return 秒杀商品分页信息列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    YiLiDiPage<SecKillProductDto> findCommbinationSecKillProducts(SecKillProductQueryDto secKillProductQueryDto)
            throws ProductServiceException;

    /**
     * 查询秒杀商品分页信息列表,不包含场次已关联的秒杀商品
     * 
     * @param secKillProductQueryDto
     *            秒杀商品查询条件
     * @return 秒杀商品分页信息列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    YiLiDiPage<SecKillProductDto> findExcludeSecKillSceneRelationSecKillProducts(
            SecKillProductQueryDto secKillProductQueryDto) throws ProductServiceException;

    /**
     * 根据店铺ID和活动ID查找该店铺秒杀商品列表
     * 
     * @param storeId
     *            店铺ID
     * @param actId
     *            和活动ID
     * @return 店铺秒杀商品列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillSaleProductDto> listSecKillSaleProductByActivityIdAndStoreId(Integer storeId, Integer actId)
            throws ProductServiceException;

    /**
     * 获取指定活动的秒杀商品信息
     * 
     * @param saleProductId
     *            商品ID
     * @param actId
     *            活动ID
     * @return 秒杀商品信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillSaleProductDto loadSecKillSaleProductByActivityIdAndSaleProductId(Integer saleProductId, Integer actId)
            throws ProductServiceException;
}