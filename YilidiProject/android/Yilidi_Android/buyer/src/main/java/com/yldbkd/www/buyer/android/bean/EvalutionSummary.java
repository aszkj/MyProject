package com.yldbkd.www.buyer.android.bean;

/**
 * 商品评价内容
 * Created by lizhg on 17/02/08.
 */
public class EvalutionSummary extends BaseModel {
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
