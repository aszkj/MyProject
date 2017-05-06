package com.yilidi.o2o.core.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 概率ItemModel
 * 
 * @author: chenlian
 * @date: 2016年11月8日 上午11:23:24
 */
public class ProbabilityItemModel implements Serializable {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = -2059691300797209041L;

    /**
     * 概率itemId
     */
    private Integer itemId;

    /**
     * 概率
     */
    private BigDecimal probability;

    /**
     * 概率随机数以逗号连接形成字符串
     */
    private String probabilityRandomNum;

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public BigDecimal getProbability() {
        return probability;
    }

    public void setProbability(BigDecimal probability) {
        this.probability = probability;
    }

    public String getProbabilityRandomNum() {
        return probabilityRandomNum;
    }

    public void setProbabilityRandomNum(String probabilityRandomNum) {
        this.probabilityRandomNum = probabilityRandomNum;
    }

}
