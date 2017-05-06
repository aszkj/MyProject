package com.yilidi.o2o.appparam.buyer.pay;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 微信支付订单生成参数
 * 
 * @author simpson
 * 
 */
public class WXPayAppOrderParam extends AppBaseParam {

	private static final long serialVersionUID = -570401169287836375L;

	@Field("订单号")
	private String saleOrderNo;

	private String tradeType;

	@Override
	public void validateParams() {
		Param noteValidate = new Param.Builder(getFieldName("saleOrderNo"), Param.ParamType.STR_NORMAL.getType(),
				saleOrderNo, false).build();
		ParamValidateUtils.validateParams(noteValidate);
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}

}
