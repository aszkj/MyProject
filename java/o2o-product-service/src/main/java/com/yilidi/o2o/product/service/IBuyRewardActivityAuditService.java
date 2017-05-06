package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;
import com.yilidi.o2o.product.service.dto.RewardSaleProductDto;
import com.yilidi.o2o.product.service.dto.RewardTicketDto;
import com.yilidi.o2o.product.service.dto.query.BuyRewardActivityQueryDto;

/**
 * 功能描述：买赠活动Service接口 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年2月27日
 */
public interface IBuyRewardActivityAuditService {

    /**
     * 根据ID获取买赠活动信息
     * 
     * @param id
     * @return BuyRewardActivityAuditDto
     * @throws ProductServiceException
     */
    public BuyRewardActivityAuditDto loadById(Integer id) throws ProductServiceException;

    /**
     * 根据查询条件分页获取买赠活动列表信息
     * 
     * @param buyRewardActivityQueryDto
     * @return YiLiDiPage<BuyRewardActivityAuditDto>
     * @throws ProductServiceException
     */
    public YiLiDiPage<BuyRewardActivityAuditDto> findBuyRewardActivitys(BuyRewardActivityQueryDto buyRewardActivityQueryDto)
            throws ProductServiceException;

    /**
     * 新增买赠活动
     * 
     * @param buyRewardActivityDto
     * @throws ProductServiceException
     */
    public void saveBuyRewardActivity(BuyRewardActivityAuditDto buyRewardActivityDto) throws ProductServiceException;

    /**
     * 根据产品id查询该产品已经参加的买赠活动
     * 
     * @param productId
     * @return
     * @throws ProductServiceException
     */
    public List<BuyRewardActivityAuditDto> getBuyRewardActivityByProductId(Integer productId) throws ProductServiceException;

    /**
     * 更新买赠活动
     * 
     * @param buyRewardActivityDto
     * @throws ProductServiceException
     */
    public void updateBuyRewardActivity(BuyRewardActivityAuditDto buyRewardActivityDto) throws ProductServiceException;

    /**
     * 根据活动名称查询活动
     * 
     * @param activityName
     * @return
     * @throws ProductServiceException
     */
    public List<BuyRewardActivityAuditDto> listBuyRewardActivityByActivityName(String activityName)
            throws ProductServiceException;

    /**
     * 根据活动Ids删除待审核的买赠活动
     * 
     * @param idList
     * @param auditStatusList
     * @throws ProductServiceException
     */
    public void deleteBuyRewardActivityById(List<Integer> idList, List<String> auditStatusList)
            throws ProductServiceException;

    /**
     * 更新批量提交审核的买赠活动审核状态
     * 
     * @param idList
     * @param preAuditStatusList
     * @param submitTime
     * @param auditStatus
     * @param modifyUserId
     * @param modifyTime
     * @throws ProductServiceException
     */
    public void updateAuditStatusByIds(List<Integer> idList, List<String> preAuditStatusList, Date submitTime,
            String auditStatus, Integer modifyUserId, Date modifyTime) throws ProductServiceException;

    /**
     * 审批更新审核状态
     * 
     * @param id
     * @param preAuditStatus
     * @param auditStatus
     * @param finalAuditUserId
     * @param finalAuditTime
     * @param finalAuditRejectReason
     * @param modifyUserId
     * @param modifyTime
     * @throws ProductServiceException
     */
    public void updateAuditStatusByFinalAudit(Integer id, String preAuditStatus, String auditStatus,
            Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId,
            Date modifyTime) throws ProductServiceException;

    /**
     * 审批买赠活动并将买赠活动加人正式库
     * 
     * @param valueOf
     * @param preAuditStatus
     * @param auditStatus
     * @param finalAuditUserId
     * @param finalAuditTime
     * @param finalAuditRejectReason
     * @param modifyUserId
     * @param modifyTime
     */
    public void saveStandardByFinalAuditPass(Integer valueOf, String preAuditStatus, String auditStatus,
            Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId,
            Date modifyTime);

    /**
     * 根据活动id更新活动状态
     * 
     * @param id
     * @param statusCode
     * @throws ProductServiceException
     */
    public void updateActivityStatus(Integer id, String statusCode) throws ProductServiceException;

    /**
     * 获取所有已审批、未结束的买赠活动
     * 
     * @param statusCode(not
     *            like)
     * @param auditStatus
     * @return
     * @throws ProductServiceException
     */
    public List<BuyRewardActivityAuditDto> listBuyRewardActivityByActivityStatusCode(String statusCode, String auditStatus)
            throws ProductServiceException;

    /**
     * 修改买赠活动时间段
     * 
     * @param buyRewardActivityAuditDto
     * @throws ProductServiceException
     */
    public void updateActivityTime(BuyRewardActivityAuditDto buyRewardActivityAuditDto) throws ProductServiceException;

    /**
     * 获取产品参加的买赠活动概要信息
     * 
     * @param productId
     * @return
     * @throws ProductServiceException
     */
    /*
     * public String getActivitySummary(Integer productId) throws
     * ProductServiceException;
     */
    /**
     * 获取产品参加的买赠活动概要信息
     * 
     * @param productId
     * @return
     * @throws ProductServiceException
     */
    public List<BuyRewardActivityAuditDto> getActivityInfoList(Integer productId) throws ProductServiceException;

    /**
     * 根据参加活动的主商品获取赠品信息列表
     * 
     * @param saleProductId
     *            商品ID
     * @param productNumber
     *            商品数量
     * @return
     * @throws ProductServiceException
     */
    public List<RewardSaleProductDto> listRewardSaleProductsBySaleProductId(Integer saleProductId, Integer productNumber)
            throws ProductServiceException;

    /**
     * 根据参加活动的主商品获取赠品奖券信息列表
     * 
     * @param saleProductId
     *            商品ID
     * @param productNumber
     *            商品数量
     * @return
     * @throws ProductServiceException
     */
    public List<RewardTicketDto> listRewardTicketsBySaleProductId(Integer saleProductId, Integer productNumber)
            throws ProductServiceException;

    /**
     * 获取正在进行的买蹭活动
     * 
     * @return
     * @throws ProductServiceException
     */
    public List<BuyRewardActivityAuditDto> listProgressingBuyRewardActivity() throws ProductServiceException;
}