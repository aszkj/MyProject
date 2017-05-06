package com.yilidi.o2o.appparam.buyer.user;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:商品评论信息参数</p>
 * @author xiasl
 * @date 2017年2月9日
 */
public class SaleProductEvaluationInfoParam extends AppBaseParam {

    private static final long serialVersionUID = 1L;

    @Field("商品ID")
    private Integer saleProductId;
    @Field("商品评分")
    private Float saleProductScore;
    @Field("商品评价内容")
    private String evaluateContent;
    @Field("商品评价图片列表信息")
    private List<SaleProductEvaluationImageParam> evaluateImages;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName("saleProductId"), Param.ParamType.STR_INTEGER.getType(), saleProductId,
                false).build();
        ParamValidateUtils.validateParams(saleProductIdValidate);
        
        Param saleProductScoreValidate = new Param.Builder(getFieldName("saleProductScore"), Param.ParamType.STR_DOUBLE.getType(), saleProductScore,
                false).build();
        ParamValidateUtils.validateParams(saleProductScoreValidate);
        
        Param evaluateContentValidate = new Param.Builder(getFieldName("evaluateContent"), Param.ParamType.STR_NORMAL.getType(), evaluateContent,
                true).build();
        ParamValidateUtils.validateParams(evaluateContentValidate);
        
        if(!ObjectUtils.isNullOrEmpty(evaluateImages)){
        	for(SaleProductEvaluationImageParam saleProductEvaluationImageParam :evaluateImages){
        		saleProductEvaluationImageParam.validateParams();
        	}
        }
    }

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
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

	public List<SaleProductEvaluationImageParam> getEvaluateImages() {
		return evaluateImages;
	}

	public void setEvaluateImages(List<SaleProductEvaluationImageParam> evaluateImages) {
		this.evaluateImages = evaluateImages;
	}
    
}
