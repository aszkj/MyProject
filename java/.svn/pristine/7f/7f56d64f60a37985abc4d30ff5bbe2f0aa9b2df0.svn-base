package com.yilidi.o2o.order.proxy;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;

public interface ICouponProxyService {

    public CouponProxyDto loadCouponById(Integer id);

    public Map<String, Object> getCouponValid(CouponProxyDto couponProxyDto);

    public List<CouponProxyDto> listCouponByIds(List<Integer> couponIds);

    public void saveBuyRewardActivity(String orderNo,Integer operationUserId, Date nowTime);
}
