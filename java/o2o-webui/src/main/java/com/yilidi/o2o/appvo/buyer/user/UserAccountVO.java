package com.yilidi.o2o.appvo.buyer.user;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 用户账本
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class UserAccountVO extends AppBaseVO {

    private static final long serialVersionUID = -4390208089025068702L;

    private List<CommonAccountVO> accountInfoList;

    private List<TicketAccountVO> ticketInfoList;

    public List<CommonAccountVO> getAccountInfoList() {
        return accountInfoList;
    }

    public void setAccountInfoList(List<CommonAccountVO> accountInfoList) {
        this.accountInfoList = accountInfoList;
    }

    public List<TicketAccountVO> getTicketInfoList() {
        return ticketInfoList;
    }

    public void setTicketInfoList(List<TicketAccountVO> ticketInfoList) {
        this.ticketInfoList = ticketInfoList;
    }

}
