package com.yilidi.o2o.order.model.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 商品库存查询DTO
 * 
 * @author: chenlian
 * @date: 2016年7月26日 上午10:53:05
 */
public class SaleProductInventoryQuery extends BaseQuery {

    private static final long serialVersionUID = 4857803170161005557L;

    private List<Integer> saleProductIds;

    public List<Integer> getSaleProductIds() {
        return saleProductIds;
    }

    public void setSaleProductIds(List<Integer> saleProductIds) {
        this.saleProductIds = saleProductIds;
    }

}
