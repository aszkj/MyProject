package com.yilidi.o2o.appparam.seller.product;

import org.springframework.util.StringUtils;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(根据类型查询调货商品信息列表参数)
 * @author: chenlian
 * @date: 2016年6月21日 下午3:57:45
 */
public class SearchProductsForTransParam extends PageParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String CLASS_CODE = "classCode";

    private static final String PARENT_CLASS_CODE = "parentClassCode";

    @Field("子类型编码Code")
    private String classCode;

    @Field("父类型编码Code")
    private String parentClassCode;

    public void validateParams() {
        if (StringUtils.isEmpty(classCode) && StringUtils.isEmpty(parentClassCode)) {
            throw new ProductServiceException("子类型编码Code与父类型编码Code不能同时为空");
        }
        if (StringUtils.isEmpty(classCode)) {
            Param parentClassCodeValidate = new Param.Builder(getFieldName(PARENT_CLASS_CODE),
                    Param.ParamType.STR_NORMAL.getType(), parentClassCode, false).build();
            ParamValidateUtils.validateParams(parentClassCodeValidate);
        }
        if (StringUtils.isEmpty(parentClassCode)) {
            Param classCodeValidate = new Param.Builder(getFieldName(CLASS_CODE), Param.ParamType.STR_NORMAL.getType(),
                    classCode, false).build();
            ParamValidateUtils.validateParams(classCodeValidate);
        }
        super.validateParams();
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getParentClassCode() {
        return parentClassCode;
    }

    public void setParentClassCode(String parentClassCode) {
        this.parentClassCode = parentClassCode;
    }

}
