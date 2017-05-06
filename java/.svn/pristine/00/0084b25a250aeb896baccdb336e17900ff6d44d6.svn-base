package com.yilidi.o2o.system.jms.model.normal;

import java.util.List;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 同步商品冗余库存消息Model
 * 
 * @author: chenbin
 * @date: 2016年5月26日 下午4:24:57
 */
public class SynchroSaleProductRemainCountMessageModel extends JmsMessageModel {

    private static final long serialVersionUID = -4837787857993897573L;

    private Integer userId;

    private List<KeyValuePair<Integer, Integer>> keyValuePairs;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<KeyValuePair<Integer, Integer>> getKeyValuePairs() {
        return keyValuePairs;
    }

    public void setKeyValuePairs(List<KeyValuePair<Integer, Integer>> keyValuePairs) {
        this.keyValuePairs = keyValuePairs;
    }

}
