package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:商品评价汇总信息</p>
 * @author xiasl
 * @date 2017年2月14日
 */
public class EvaluationSummaryVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 汇总信息名称
     */
    private String summaryName;
    /**
     * 汇总信息值
     */
    private String summaryValue;
    /**
     * 汇总总数据量
     */
    private Integer summaryCount;
    
    public EvaluationSummaryVO(){
        
    }
    public EvaluationSummaryVO(String summaryName, String summaryValue, Integer summaryCount) {
        super();
        this.summaryName = summaryName;
        this.summaryValue = summaryValue;
        this.summaryCount = summaryCount;
    }
    public String getSummaryName() {
        return summaryName;
    }
    public void setSummaryName(String summaryName) {
        this.summaryName = summaryName;
    }
    public String getSummaryValue() {
        return summaryValue;
    }
    public void setSummaryValue(String summaryValue) {
        this.summaryValue = summaryValue;
    }
    public Integer getSummaryCount() {
        return summaryCount;
    }
    public void setSummaryCount(Integer summaryCount) {
        this.summaryCount = summaryCount;
    }
    
}
