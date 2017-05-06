package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 终极修改调拨单DTO
 * 
 * @author chenb
 * 
 */
public class FlittingOrderDetailDto extends BaseDto {

    private static final long serialVersionUID = 6865754334114433963L;

    /**
     * 调拨单基础信息DTO
     */
    private FlittingOrderDto flittingOrderDto;
    /**
     * 调拨单数量变化列表
     */
    private List<FlittingOrderRejectDto> flittingOrderRejectDtoList;
    /**
     * 调拨单操作历史列表
     */
    private List<FlittingOrderHistoryDto> flittingOrderHistoryDtoList;

    public FlittingOrderDto getFlittingOrderDto() {
        return flittingOrderDto;
    }

    public void setFlittingOrderDto(FlittingOrderDto flittingOrderDto) {
        this.flittingOrderDto = flittingOrderDto;
    }

    public List<FlittingOrderRejectDto> getFlittingOrderRejectDtoList() {
        return flittingOrderRejectDtoList;
    }

    public void setFlittingOrderRejectDtoList(List<FlittingOrderRejectDto> flittingOrderRejectDtoList) {
        this.flittingOrderRejectDtoList = flittingOrderRejectDtoList;
    }

    public List<FlittingOrderHistoryDto> getFlittingOrderHistoryDtoList() {
        return flittingOrderHistoryDtoList;
    }

    public void setFlittingOrderHistoryDtoList(List<FlittingOrderHistoryDto> flittingOrderHistoryDtoList) {
        this.flittingOrderHistoryDtoList = flittingOrderHistoryDtoList;
    }

}
