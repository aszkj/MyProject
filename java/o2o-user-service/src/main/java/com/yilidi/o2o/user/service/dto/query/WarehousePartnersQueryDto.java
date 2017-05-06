package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 微仓关联合伙人信息查询DTO
 * 
 * @author: chenlian
 * @date: 2016年6月29日 下午2:33:25
 */
public class WarehousePartnersQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = -1218645834967289425L;
    /**
     * 微仓ID
     */
    private Integer warehouseId;

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

}
