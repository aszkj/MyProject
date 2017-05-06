/**
 * 文件名称：SaleOrderItemTest.java
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

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.model.SaleOrderItem;
import com.yilidi.o2o.order.model.SaleOrderPriceHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SaleOrderItemTest extends BaseMapperTest {

	@Autowired
	private SaleOrderItemMapper saleOrderItemsMapper;
	
	@Autowired
	private SaleOrderPriceHistoryMapper saleOrderPriceHistoryMapper;
	
	private String saleOrderNo = "20151112182202795b7l";
	private Integer id = 1;
	
	@Test
	public void testSave() {
		SaleOrderItem item = new SaleOrderItem();
		
		item.setOrderPrice(RandomUtils.nextInt(2000) * 1000L);
		item.setProductClassName(StringUtils.randomString(32));
		item.setStoreId(RandomUtils.nextInt(100));
		item.setQuantity(RandomUtils.nextInt(50));
		item.setSpecifications("300g/盒");
		item.setCommissionPrice(RandomUtils.nextInt(2000) * 1000L);
		item.setSaleOrderNo(saleOrderNo);
		item.setSaleProductId(RandomUtils.nextInt(100));
		item.setSendCount(0);
		item.setTotalPrice(item.getQuantity() * item.getOrderPrice());
		
		saleOrderItemsMapper.save(item);
	}
	
	@Test
	public void testLoad() {
		
		SaleOrderItem item = saleOrderItemsMapper.loadById(id);
		printInfo(item);
	}
	
	@Test
	public void testListByOrderNo() {
		List<SaleOrderItem> items = saleOrderItemsMapper.listBySaleOrderNo(saleOrderNo);
		printInfo(items);
	}
	
	@Test
	public void testUpdateOrderPrice() {
		
		Long orderPrice = RandomUtils.nextInt(2000) * 1000L;
		SaleOrderItem item = saleOrderItemsMapper.loadById(id);
		saleOrderItemsMapper.updateOrderPrice(id, orderPrice, item.getQuantity() * orderPrice);
		
		SaleOrderPriceHistory his = new SaleOrderPriceHistory();
		his.setPreFee(item.getOrderPrice());
		his.setChangedFee(orderPrice);
		his.setMidifyUserId(1);
		his.setModifyTime(new Date());
		his.setSaleOrderItemId(id);
		his.setStoreId(item.getStoreId());
		his.setSaleOrderNo(item.getSaleOrderNo());
		his.setSaleProductId(item.getSaleProductId());
		his.setChangeType("ORDERPRICEHISCHANGETYPE_ITEM");
		saleOrderPriceHistoryMapper.save(his);
		
	}
}
