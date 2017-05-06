package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.BuyerFeedbackDto;
import com.yilidi.o2o.user.service.dto.query.BuyerFeedbackQueryDto;

/**
 * 用户反馈接口
 *
 * @author: zhangkun
 * @date: 2016年11月21日 下午3:05:40
 */
public interface IBuyerFeedbackService {
    /**
     * app提交买家反馈
     * 
     * @param buyerFeedbackDto
     * 
     */
    public void saveBuyerFeedback(BuyerFeedbackDto buyerFeedbackDto) throws UserServiceException;

    /**
     * 买家反馈列表
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    public YiLiDiPage<BuyerFeedbackDto> getAllBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto)
            throws UserServiceException;

    /**
     * 通过id获取买家反馈
     * 
     * @param id
     * @return
     */
    public BuyerFeedbackDto getBuyerFeedbackById(Integer id) throws UserServiceException;

    /**
     * 处理买家反馈
     * 
     * @param buyerFeedbackDto
     * @return
     */
    public boolean updateBuyerFeedback(BuyerFeedbackDto buyerFeedbackDto) throws UserServiceException;

    /**
     * 导出时获取总数
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    public Long getCountsForExportBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto) throws UserServiceException;

    /**
     * 导出列表
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    public List<BuyerFeedbackDto> listDataForExportBuyerFeedback(BuyerFeedbackQueryDto buyerFeedbackQueryDto,
            Long startLineNum, Integer pageSize) throws UserServiceException;
}
