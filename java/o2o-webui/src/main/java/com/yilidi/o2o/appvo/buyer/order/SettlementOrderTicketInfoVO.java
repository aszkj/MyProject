package com.yilidi.o2o.appvo.buyer.order;

/**
 * 用户券信息列表
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class SettlementOrderTicketInfoVO extends BaseUserTicketVO {

    private static final long serialVersionUID = 3958436906456271098L;

    /**
     * 订单能否使用该奖券：（前端需要根据该字段进行重新排序） <br>
     * 0：不能使用 1：能使用
     */
    private Integer wouldUse;

    public Integer getWouldUse() {
        return wouldUse;
    }

    public void setWouldUse(Integer wouldUse) {
        this.wouldUse = wouldUse;
    }

}
