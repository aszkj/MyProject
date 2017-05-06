package com.yilidi.o2o.appvo.seller.system;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(帮助中心地址)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:11:48
 */
public class HelpAddressVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 2500277862081930421L;
    /**
     * 帮助中心地址URL
     */
    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

}
