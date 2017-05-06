package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.BuyerFeedback;
import com.yilidi.o2o.user.model.query.BuyerFeedbackQuery;

/**
 * 反馈dao层接口
 *
 * @author: zhangkun
 * @date: 2016年11月21日 下午6:00:35
 */
public interface BuyerFeedbackMapper {

    /**
     * app提交买家反馈
     * 
     * @param buyerFeedbackDto
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_BUYER_FEEDBACK })
    public int saveBuyerFeedback(BuyerFeedback buyerFeedback);

    /**
     * 买家反馈列表
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_BUYER_FEEDBACK })
    public Page<BuyerFeedback> findAllBuyerFeedback(BuyerFeedbackQuery buyerFeedbackQuery);

    /**
     * 通过id获取买家反馈
     * 
     * @param id
     * @return
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_BUYER_FEEDBACK })
    public BuyerFeedback getBuyerFeedbackById(Integer id);

    /**
     * 处理买家反馈
     * 
     * @param buyerFeedbackDto
     * @return
     */
    @DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_BUYER_FEEDBACK })
    public int updateBuyerFeedback(BuyerFeedback buyerFeedback);

    /**
     * 导出时获取总数
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    public Long getCountsForExportBuyerFeedback(BuyerFeedbackQuery buyerFeedbackQuery);

    /**
     * 导出列表
     * 
     * @param buyerFeedbackQueryDto
     * @return
     */
    public List<BuyerFeedback> getListForExportBuyerFeedback(
            @Param("buyerFeedbackQuery") BuyerFeedbackQuery buyerFeedbackQuery, @Param("startLineNum") Long startLineNum,
            @Param("pageSize") Integer pageSize);

}
