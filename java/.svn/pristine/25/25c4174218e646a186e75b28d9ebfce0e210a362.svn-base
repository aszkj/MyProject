package com.yilidi.o2o.appparam.buyer.product;

import org.springframework.util.StringUtils;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取商品分类
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SearchProductsParam extends PageParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("类型编码")
    private String classCode;
    @Field("商品类型")
    private String parentClassCode;
    @Field("关键字")
    private String keywords;
    @Field("小区ID")
    private Integer communityId;
    @Field("店铺ID")
    private Integer storeId;
    @Field("排序类型")
    private Integer orderBy;
    @Field("排序模式")
    private Integer sortBy;

    public void validateParams() {
        if (StringUtils.isEmpty(keywords) && (StringUtils.isEmpty(classCode) && StringUtils.isEmpty(parentClassCode))) {
            throw new ProductServiceException("参数不能为空");
        }
        if (ObjectUtils.isNullOrEmpty(storeId) && ObjectUtils.isNullOrEmpty(communityId)) {
            throw new ProductServiceException("小区ID和店铺ID不能同时为空");
        }
        Param communityIdValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.STR_INTEGER.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        Param orderByValidate = new Param.Builder(getFieldName("orderBy"), Param.ParamType.STR_INTEGER.getType(), orderBy,
                true).build();
        Param sortByValidate = new Param.Builder(getFieldName("sortBy"), Param.ParamType.STR_INTEGER.getType(), sortBy, true)
                .build();
        ParamValidateUtils.validateParams(communityIdValidate, storeIdValidate, orderByValidate, sortByValidate);
        super.validateParams();
    }

    public String getParentClassCode() {
        return parentClassCode;
    }

    public void setParentClassCode(String parentClassCode) {
        this.parentClassCode = parentClassCode;
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
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

}
