package com.yilidi.o2o.appvo.buyer.user;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:商品评价VO</p>
 * @author xiasl
 * @date 2017年2月10日
 */
public class SaleProductEvaluationVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 用户头像URL
     */
    private String userImageUrl;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 商品评分
     */
    private Float saleProductScore;
    /**
     * 评价内容
     */
    private String evaluateContent;
    /**
     * 商品评价图片列表信息（最多10条）
     */
    private List<EvaluationImageVo> evaluateImages;
	public String getUserImageUrl() {
		return userImageUrl;
	}
	public void setUserImageUrl(String userImageUrl) {
		this.userImageUrl = userImageUrl;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Float getSaleProductScore() {
		return saleProductScore;
	}
	public void setSaleProductScore(Float saleProductScore) {
		this.saleProductScore = saleProductScore;
	}
	public String getEvaluateContent() {
		return evaluateContent;
	}
	public void setEvaluateContent(String evaluateContent) {
		this.evaluateContent = evaluateContent;
	}
	public List<EvaluationImageVo> getEvaluateImages() {
		return evaluateImages;
	}
	public void setEvaluateImages(List<EvaluationImageVo> evaluateImages) {
		this.evaluateImages = evaluateImages;
	}
}
