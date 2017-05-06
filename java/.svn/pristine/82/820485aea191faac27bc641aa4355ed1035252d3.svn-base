package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:评论晒图参数</p>
 * @author xiasl
 * @date 2017年2月9日
 */
public class SaleProductEvaluationImageParam extends AppBaseParam {

    private static final long serialVersionUID = 1L;

   
    @Field("评价图片URL")
    private String imageUrl;
   

    public void validateParams() {
        Param imageUrlValidate = new Param.Builder(getFieldName("imageUrl"), Param.ParamType.STR_NORMAL.getType(), imageUrl,
                true).build();
        ParamValidateUtils.validateParams(imageUrlValidate);
    }


	public String getImageUrl() {
		return imageUrl;
	}


	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
    
}
