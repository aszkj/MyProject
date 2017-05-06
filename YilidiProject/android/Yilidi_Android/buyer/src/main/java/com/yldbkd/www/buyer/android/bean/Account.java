package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 购物车的商品和数量信息
 * <p/>
 * Created by linghuxj on 15/11/4.
 */
public class Account extends BaseModel {
    private List<AccountInfo> accountInfoList;
    private List<TicketInfo> ticketInfoList;

    public List<AccountInfo> getAccountInfoList() {
        return accountInfoList;
    }

    public void setAccountInfoList(List<AccountInfo> accountInfoList) {
        this.accountInfoList = accountInfoList;
    }

    public List<TicketInfo> getTicketInfoList() {
        return ticketInfoList;
    }

    public void setTicketInfoList(List<TicketInfo> ticketInfoList) {
        this.ticketInfoList = ticketInfoList;
    }
}
