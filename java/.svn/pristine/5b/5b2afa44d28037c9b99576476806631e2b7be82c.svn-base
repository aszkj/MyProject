/**
 * 文件名称：SaleDailyTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.order.dao.SaleDailyMapper;
import com.yilidi.o2o.order.model.result.SaleReport;
import com.yilidi.o2o.order.service.dto.SaleReportDto;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleDailyTest extends BaseMapperTest {

	@Autowired
	private SaleDailyMapper saleDailyMapper;

	@Test
	public void testListSaleTrend() {
		SaleReportQuery query = new SaleReportQuery();
		List<SaleReport> rpt = saleDailyMapper.listSaleTrend(query);
		printInfo(rpt);
	}

	@Test
	public void testListSaleDistribution() {
		List<SaleReport> rpt = saleDailyMapper
				.listSaleDistribution("MOBILE", SaleReportDto.ReportBy.BY_AREA, null, null, null);
		printInfo(rpt);
	}
}
