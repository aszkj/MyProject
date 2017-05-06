package com.yilidi.o2o.appparam;

import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(分页参数)
 * @author: chenlian
 * @date: 2016年6月8日 上午11:42:40
 */
public class PageParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String PAGE_NUM = "pageNum";

    private static final String PAGE_SIZE = "pageSize";

    @Field("当前页数")
    private Integer pageNum;

    @Field("每页大小")
    private Integer pageSize;

    public void validateParams() {
        Param pageNumValidate = new Param.Builder(getFieldName(PAGE_NUM), Param.ParamType.STR_INTEGER.getType(), pageNum,
                false).build();
        Param pageSizeValidate = new Param.Builder(getFieldName(PAGE_SIZE), Param.ParamType.STR_INTEGER.getType(), pageSize,
                false).build();
        ParamValidateUtils.validateParams(pageNumValidate, pageSizeValidate);
    }

    public Integer getPageNum() {
        return pageNum;
    }

    public void setPageNum(Integer pageNum) {
        this.pageNum = pageNum;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

}
