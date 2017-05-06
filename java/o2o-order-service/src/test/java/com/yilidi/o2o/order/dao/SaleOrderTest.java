/**
 * 文件名称：SaleOrderTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.SaleOrderHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderTest extends BaseMapperTest {

    @Autowired
    private SaleOrderMapper saleOrderMapper;

    @Autowired
    private SaleOrderHistoryMapper saleOrderHistoryMapper;

    private String orderId = "2015030416371177124L";
    private String desc = "这是一段描述语句";

    @Test
    public void testSave() {
        for (int i = 0; i < 30; i++) {
            SaleOrder order = new SaleOrder();
            order.setUserId(1);
            order.setChannelCode("IOS");
            order.setCreateTime(new Date());
            order.setCreateUserId(RandomUtils.nextInt(100));
            order.setOrderCount(RandomUtils.nextInt(50));
            order.setBuyerCustomerId(RandomUtils.nextInt(100));
            // 默认待支付
            order.setStatusCode(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY);
            order.setTotalAmount(RandomUtils.nextInt(5000) * 1000L);
            order.setTransferFee(RandomUtils.nextInt(5000) * 1000L);
            order.setTypeCode(SystemContext.OrderDomain.SALEORDERTYPE_ORDINARY);
            // 自提
            order.setDeliveryMode(SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP);
            order.setBestTime("3小时之内");
            order.setProviceCode("GD");
            order.setCityCode("SZ");
            order.setCountyCode("NS");
            order.setSendStatus("未发货");
            order.setSendCount(1);
            // 在线支付
            order.setPayTypeCode(SystemContext.OrderDomain.SALEORDERPAYTYPE_ONLINE);
            order.setUserId(1);
            order.setUserName("13788999988");
            order.setStoreCode("123445");
            order.setStoreId(1);
            order.setStoreName("黄金店铺");
            saleOrderMapper.save(order);

            this.saveOrderHistory(order);
        }
    }

    @Test
    public void testLoad() {
        SaleOrder order = saleOrderMapper.loadBySaleOrderNo("2015110616185925863u");
        printInfo(order);

        List<SaleOrderHistory> hList = saleOrderHistoryMapper.listBySaleOrderNo(orderId);
        printInfo(hList);
    }

    @Test
    public void testUpdatePay() {
        saleOrderMapper.updatePayBySaleOrderNo(orderId, StringUtils.randomString(12), new Date());

        this.saveOrderHistory(saleOrderMapper.loadBySaleOrderNo(orderId));
    }

    @Test
    public void testUpdatePrice() {
        saleOrderMapper.updatePriceBySaleOrderNo(orderId, RandomUtils.nextInt(5000) * 1000L,
                RandomUtils.nextInt(500) * 1000L);

        this.saveOrderHistory(saleOrderMapper.loadBySaleOrderNo(orderId));
    }

    /**
     * 保存历史记录
     * 
     * @param order
     *            订单信息
     */
    private void saveOrderHistory(SaleOrder order) {
        SaleOrderHistory his = new SaleOrderHistory();

        his.setOperateTime(new Date());
        his.setOperateUserId(1);
        his.setOperationDesc(desc);
        his.setOrderStatus(order.getStatusCode());
        his.setSaleOrderNo(order.getSaleOrderNo());

        saleOrderHistoryMapper.save(his);
    }

    @Test
    public void testLoadBySaleOrderNo() {
        SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo("2015110616185925863u");
        printInfo(saleOrder);
    }
}
