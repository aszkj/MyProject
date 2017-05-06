package com.yilidi.o2o.appparam.seller.product;

import org.springframework.util.StringUtils;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(根据类型或关键字查询店铺中商品信息列表参数)
 * @author: chenlian
 * @date: 2016年6月21日 下午3:57:45
 */
public class SearchProductsParam extends PageParam {
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String ORDER_BY = "orderBy";

    private static final String SORT_BY = "sortBy";

    private static final String ENABLED_FLAG = "enabledFlag";

    /**
     * 排序类型正则表达式
     */
    private static final String ORDER_BY_PATTERN = "^(0|1|2)$";

    /**
     * 排序模式正则表达式
     */
    private static final String SORT_BY_PATTERN = "^(1|2)$";

    /**
     * 上下架操作类型正则表达式
     */
    private static final String ENABLED_FLAG_PATTERN = "^(0|1|2)$";

    @Field("子类型编码Code")
    private String classCode;

    @Field("父类型编码Code")
    private String parentClassCode;

    @Field("关键字")
    private String keyword;

    @Field("排序类型")
    private Integer orderBy;

    @Field("排序模式")
    private Integer sortBy;

    @Field("上下架标识")
    private Integer enabledFlag;

    public void validateParams() {
        if (StringUtils.isEmpty(keyword) && StringUtils.isEmpty(parentClassCode) && StringUtils.isEmpty(classCode)) {
            throw new ProductServiceException("参数不能为空");
        }
        Param orderByValidate = new Param.Builder(getFieldName(ORDER_BY), Param.ParamType.STR_INTEGER.getType(), orderBy,
                true).regex(ORDER_BY_PATTERN).build();
        Param sortByValidate = new Param.Builder(getFieldName(SORT_BY), Param.ParamType.STR_INTEGER.getType(), sortBy, true)
                .regex(SORT_BY_PATTERN).build();
        Param enabledFlagValidate = new Param.Builder(getFieldName(ENABLED_FLAG), Param.ParamType.STR_INTEGER.getType(),
                enabledFlag, true).regex(ENABLED_FLAG_PATTERN).build();
        ParamValidateUtils.validateParams(orderByValidate, sortByValidate, enabledFlagValidate);
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

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(Integer orderBy) {
        this.orderBy = orderBy;
    }

    public Integer getSortBy() {
        return sortBy;
    }

    public void setSortBy(Integer sortBy) {
        this.sortBy = sortBy;
    }

    public Integer getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(Integer enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

}
