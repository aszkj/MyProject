/**
 * 文件名称：SaleOrderDetailDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：订单详情模型DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderDetailDto extends BaseDto {
    private static final long serialVersionUID = 8319827054551326095L;

    /**
     * 订单信息
     */
    private SaleOrderDto saleOrderDto;

    /**
     * 订单历史信息（记录订单的状态改变历史）
     */
    private List<SaleOrderHistoryDto> hList;

    /**
     * 订单明细信息
     */
    private List<SaleOrderItemDto> items;

    /**
     * 发货信息
     */
    private List<SendOrderDto> sendHistoryList;

    /**
     * 赠品商品信息列表
     */
    private List<OrderGiftInfoDto> saleProductGiftInfoDtos;
    /**
     * 奖券赠品信息列表
     */
    private List<OrderGiftInfoDto> ticketGiftInfoDtos;

    public SaleOrderDto getSaleOrderDto() {
        return saleOrderDto;
    }

    public void setSaleOrderDto(SaleOrderDto saleOrderDto) {
        this.saleOrderDto = saleOrderDto;
    }

    public List<SaleOrderHistoryDto> gethList() {
        return hList;
    }

    public void sethList(List<SaleOrderHistoryDto> hList) {
        this.hList = hList;
    }

    public List<SaleOrderItemDto> getItems() {
        return items;
    }

    public void setItems(List<SaleOrderItemDto> items) {
        this.items = items;
    }

    public List<SendOrderDto> getSendHistoryList() {
        return sendHistoryList;
    }

    public void setSendHistoryList(List<SendOrderDto> sendHistoryList) {
        this.sendHistoryList = sendHistoryList;
    }

    public List<OrderGiftInfoDto> getSaleProductGiftInfoDtos() {
        return saleProductGiftInfoDtos;
    }

    public void setSaleProductGiftInfoDtos(List<OrderGiftInfoDto> saleProductGiftInfoDtos) {
        this.saleProductGiftInfoDtos = saleProductGiftInfoDtos;
    }

    public List<OrderGiftInfoDto> getTicketGiftInfoDtos() {
        return ticketGiftInfoDtos;
    }

    public void setTicketGiftInfoDtos(List<OrderGiftInfoDto> ticketGiftInfoDtos) {
        this.ticketGiftInfoDtos = ticketGiftInfoDtos;
    }

}
