package com.yilidi.o2o.product.service.dto.query;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 专题信息查询DTO
 * 
 * @author: chenlian
 * @date: 2016年8月19日 下午3:07:42
 */
public class ThemeQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = -5205323864799407073L;

    /**
     * 专题名称
     */
    private String themeName;

    /**
     * 专题类型编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEZONETYPE)
     */
    private String typeCode;

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

}