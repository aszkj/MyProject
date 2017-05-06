/**
 * 文件名称：CommissionClearupTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.math.RandomUtils;
import org.apache.commons.lang.time.DateUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.CommissionClearupMapper;
import com.yilidi.o2o.order.model.CommissionClearup;
import com.yilidi.o2o.order.model.result.CommissionReport;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class CommissionClearupTest extends BaseMapperTest {

	
	@Autowired
	private CommissionClearupMapper commissionClearupMapper;
	
	@Test
	public void testSave() {
		CommissionClearup commission = new CommissionClearup();
		
		commission.setClearAmount(2000000L);
		commission.setClearTime(new Date());
		commission.setClearUserId(12);
		commission.setCreateTime(DateUtils.addDays(new Date(), 3));
		commission.setPayTime(DateUtils.addDays(new Date(), 2));
		commission.setStoreId(2);
		commission.setSaleOrderNo(StringUtils.generateSaleOrderNo());
		
		commission.setStatusCode(StringUtils.randomString(12));
		commission.setTotalAmount(RandomUtils.nextLong());
		commission.setClearType("COMMISSIONCLEARTYPE_MONTH");
		commission.setTransferFee(RandomUtils.nextLong());
		
		commissionClearupMapper.save(commission);
	}
	
	@Test
	public void testListBySaleOrderNo() {
		String saleOrderNo = "20150302153025425";
		List<CommissionClearup> clist = commissionClearupMapper.listBySaleOrderNo(saleOrderNo);
		printInfo(clist);
	}
	
	@Test
	public void testListClearupReport() {
		List<CommissionReport> rpts = commissionClearupMapper.listClearupReport(null, null, null, null);
		printInfo(rpts);
	}
	
	@Test
	public void testUpdateClearupMonthly() {
		
		Date startDate = DateUtils.addDays(new Date(), -7);
		Date endDate = new Date();
		Integer rtn = commissionClearupMapper.updateClearupMonthly(4, startDate, endDate, 1, 1);
		
		printInfo(rtn);
	}
}

