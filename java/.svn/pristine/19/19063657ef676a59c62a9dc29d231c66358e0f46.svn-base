package com.yilidi.o2o.appparam.buyer.user;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:评论信息参数</p>
 * @author xiasl
 * @date 2017年2月9日
 */
public class EvaluationInfoParam extends AppBaseParam {

    private static final long serialVersionUID = 1L;
    private static final String ANONYMOUS_TYPE_PATTERN = "^(0|1)$";
    @Field("订单号")
    private String saleOrderNo;
    @Field("服务评分")
    private Float serviceScore;
    @Field("配送评分")
    private Float deliverScore;
    @Field("是否为匿名评价标识")
    private Integer isAnonymous;
    @Field("商品评价信息列表")
    private List<SaleProductEvaluationInfoParam> saleProductEvaluations;

    public void validateParams() {
        Param serviceScoreValidate = new Param.Builder(getFieldName("serviceScore"), Param.ParamType.STR_DOUBLE.getType(), serviceScore,
                false).build();
        ParamValidateUtils.validateParams(serviceScoreValidate);
        
        Param deliverScoreValidate = new Param.Builder(getFieldName("deliverScore"), Param.ParamType.STR_DOUBLE.getType(), deliverScore,
                false).build();
        ParamValidateUtils.validateParams(deliverScoreValidate);
        
        Param isAnonymousValidate = new Param.Builder(getFieldName("isAnonymous"), Param.ParamType.STR_INTEGER.getType(), isAnonymous,
                false).build();
        ParamValidateUtils.validateParams(isAnonymousValidate);
        
        Param saleOrderNoValidate = new Param.Builder(getFieldName("saleOrderNo"), Param.ParamType.STR_NORMAL.getType(), saleOrderNo,
                false).build();
        ParamValidateUtils.validateParams(saleOrderNoValidate);
        
        if(!isAnonymous.toString().matches(ANONYMOUS_TYPE_PATTERN)){
        	throw new UserServiceException("<是否为匿名评价标识>参数非法");
        }
        if(ObjectUtils.isNullOrEmpty(saleProductEvaluations)){
        	throw new UserServiceException("商品评价信息列表<saleProductEvaluations> 参数为空");
        }else{
        	for(SaleProductEvaluationInfoParam saleProductEvaluationInfoParam:saleProductEvaluations){
        		saleProductEvaluationInfoParam.validateParams();
        	}
        }
    }

	public Float getServiceScore() {
		return serviceScore;
	}

	public void setServiceScore(Float serviceScore) {
		this.serviceScore = serviceScore;
	}

	public Float getDeliverScore() {
		return deliverScore;
	}

	public void setDeliverScore(Float deliverScore) {
		this.deliverScore = deliverScore;
	}

	public Integer getIsAnonymous() {
		return isAnonymous;
	}

	public void setIsAnonymous(Integer isAnonymous) {
		this.isAnonymous = isAnonymous;
	}

	public List<SaleProductEvaluationInfoParam> getSaleProductEvaluations() {
		return saleProductEvaluations;
	}

	public void setSaleProductEvaluations(List<SaleProductEvaluationInfoParam> saleProductEvaluations) {
		this.saleProductEvaluations = saleProductEvaluations;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

}
