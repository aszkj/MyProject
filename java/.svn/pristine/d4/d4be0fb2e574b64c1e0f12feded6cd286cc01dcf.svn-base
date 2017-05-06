package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：交易评价实体类，映射交易域表YiLiDiOrderCenter.T_TRADE_EVALUATION <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class TradeEvaluation extends BaseModel {
    private static final long serialVersionUID = -7479319028253291515L;
    /**
     * 评价ID，主键自增
     */
    private String id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 商品id
     */
    private Integer saleProductId;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 评价内容
     */
    private String content;
    /**
     * 评价时间
     */
    private Date createTime;
    /**
     * 评价等级, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=TRADEEVALUATIONGRADE)
     */
    private String evaluationGrade;
    /**
     * 描述相符星级，范围0-5
     */
    private Integer coincideStar;
    /**
     * 发货速度星级，范围为0-5
     */
    private Integer sendStar;
    /**
     * 物流速度星级，范围为0-5
     */
    private Integer logisticsStar;
    /**
     * 卖家态度星级, 0-5
     */
    private Integer attitudeStar;
    /**
     * 印象评价。印象标签来自系统字典，根据字典中的DICTCODE字段的下划线后的数字决定，最多支持32个印象,
     * 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=TRADEEVALUATIONIMPRESSION)，用户选中是采用01代码来映射，0代表不中，1
     * 代表选中。如：DICTCODE=TRADEEVALUATIONIMPRESSION_0，则对应字符串的0位。
     */
    private Short impression;
    /**
     * 评价图片1
     */
    private String image1;
    /**
     * 评价图片2
     */
    private String image2;
    /**
     * 评价图片3
     */
    private String image3;

    /**
     * 获取id
     * 
     * @return id
     */
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getEvaluationGrade() {
        return evaluationGrade;
    }

    public void setEvaluationGrade(String evaluationGrade) {
        this.evaluationGrade = evaluationGrade;
    }

    public Integer getCoincideStar() {
        return coincideStar;
    }

    public void setCoincideStar(Integer coincideStar) {
        this.coincideStar = coincideStar;
    }

    public Integer getSendStar() {
        return sendStar;
    }

    public void setSendStar(Integer sendStar) {
        this.sendStar = sendStar;
    }

    public Integer getLogisticsStar() {
        return logisticsStar;
    }

    public void setLogisticsStar(Integer logisticsStar) {
        this.logisticsStar = logisticsStar;
    }

    public Integer getAttitudeStar() {
        return attitudeStar;
    }

    public void setAttitudeStar(Integer attitudeStar) {
        this.attitudeStar = attitudeStar;
    }

    public Short getImpression() {
        return impression;
    }

    public void setImpression(Short impression) {
        this.impression = impression;
    }

    public String getImage1() {
        return image1;
    }

    public void setImage1(String image1) {
        this.image1 = image1;
    }

    public String getImage2() {
        return image2;
    }

    public void setImage2(String image2) {
        this.image2 = image2;
    }

    public String getImage3() {
        return image3;
    }

    public void setImage3(String image3) {
        this.image3 = image3;
    }
}