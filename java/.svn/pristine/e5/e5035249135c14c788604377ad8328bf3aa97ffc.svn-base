package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneRelateProductDto;
import com.yilidi.o2o.product.service.dto.query.SecKillSceneQueryDto;

/**
 * 功能描述：场次服务接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISecKillSceneService {

    /**
     * 保存场次基础信息
     * 
     * @param record
     *            场次基础信息对象
     * @return 影响的行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer save(SecKillSceneDto record) throws ProductServiceException;

    /**
     * 复制场次相关信息
     * 
     * @param record
     *            场次基础信息对象
     * @throws ProductServiceException
     *             产品服务异常
     */
    void saveCopyScene(SecKillSceneDto record) throws ProductServiceException;

    /**
     * 根据ID删除场次基础信息
     * 
     * @param secKillSceneId
     *            场次ID
     * @return 影响的行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer deleteById(Integer secKillSceneId) throws ProductServiceException;

    /**
     * 修改场次信息
     * 
     * @param secKillSceneDto
     *            场次信息
     * @return 影响行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer updateSelective(SecKillSceneDto secKillSceneDto) throws ProductServiceException;

    /**
     * 修改场次状态
     * 
     * @param id
     *            场次ID
     * @param statusCode
     *            场次状态
     * @param updateUserId
     *            修改用户ID
     * @param updateTime
     *            修改时间
     * @return 影响行数
     * @throws ProductServiceException
     *             产品服务异常
     */
    Integer updateStatusCodeById(Integer id, String statusCode, Integer updateUserId, Date updateTime)
            throws ProductServiceException;

    /**
     * 根据开始时间更新场次为结束状态
     * 
     * @param startTime
     *            开始时间
     * @param updateUserId
     *            操作用户ID
     * @param updateTime
     *            操作时间
     * @throws ProductServiceException
     *             产品服务异常
     */
    void updateStatusCodeForExpiredByStartTime(Date startTime, Integer updateUserId, Date updateTime)
            throws ProductServiceException;

    /**
     * 根据场次ID获取场次信息
     * 
     * @param secKillSceneId
     *            场次ID
     * @return 场次信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillSceneDto loadById(Integer secKillSceneId) throws ProductServiceException;

    /**
     * 根据活动ID获取场次信息
     * 
     * @param activityId
     *            活动ID
     * @return 场次信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillSceneDto loadByActivityId(Integer activityId) throws ProductServiceException;

    /**
     * 查询场次分页信息列表
     * 
     * @param secKillSceneQueryDto
     *            场次查询条件
     * @return 场次分页信息列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    YiLiDiPage<SecKillSceneDto> findSecKillScenes(SecKillSceneQueryDto secKillSceneQueryDto) throws ProductServiceException;

    /**
     * 查询秒杀商品关联的场次列表
     * 
     * @param secKillSceneQueryDto
     *            场次查询条件
     * @return 场次分页信息列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    YiLiDiPage<SecKillSceneDto> findSecKillProductRelationScenes(SecKillSceneQueryDto secKillSceneQueryDto)
            throws ProductServiceException;

    /**
     * 场次关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数对象
     * @param operatorUserId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品服务域异常
     */
    void updateRelateSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto, Integer operatorUserId)
            throws ProductServiceException;

    /**
     * 场次解除关联秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数对象
     * @param operatorUserId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品服务域异常
     */
    void updateReleaseSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto, Integer operatorUserId)
            throws ProductServiceException;

    /**
     * 失效场次关联的秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数DTO
     * @param operatorUserId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品服务域异常
     */
    void updateInvalidateSceneSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto,
            Integer operatorUserId) throws ProductServiceException;

    /**
     * 有效场次关联的秒杀商品
     * 
     * @param secKillSceneRelateProductDto
     *            参数DTO
     * @param operatorUserId
     *            操作用户ID
     * @throws ProductServiceException
     *             产品服务域异常
     */
    void updateValidSceneSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto, Integer operatorUserId)
            throws ProductServiceException;

    /**
     * 获取正在秒杀的活动信息
     * 
     * @param startTime
     *            当前时间
     * @return 场次信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    SecKillSceneDto loadSecKillSceneForStarting(Date startTime) throws ProductServiceException;

    /**
     * 获取秒杀的活动信息列表
     * 
     * @param startTime
     *            当前时间
     * @param size
     *            显示数量
     * @return 场次信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillSceneDto> listSecKillScene(Date startTime, Integer size) throws ProductServiceException;

    /**
     * 获取开始时间小于等于当前时间的场次信息列表
     * 
     * @param nowTime
     *            当前时间
     * @param size
     *            显示数量
     * @return 场次信息
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillSceneDto> listSecKillSceneBeforOrEqualsStartTime(Date nowTime, Integer size) throws ProductServiceException;

    /**
     * 获取指定时间的重复的场次列表
     * 
     * @param beginStartTime
     *            开始时间
     * @param endStartTime
     *            结束时间
     * @return 场次列表
     * @throws ProductServiceException
     *             产品服务异常
     */
    List<SecKillSceneDto> listSecKillSceneForRepeatByDate(Date beginStartTime, Date endStartTime)
            throws ProductServiceException;

    /**
     * 获取已开始和正在进行的活动列表
     * 
     * @param currentTime
     * @return
     * @throws ProductServiceException
     */
    List<SecKillSceneDto> listStartedAndStaring(Date currentTime) throws ProductServiceException;
}