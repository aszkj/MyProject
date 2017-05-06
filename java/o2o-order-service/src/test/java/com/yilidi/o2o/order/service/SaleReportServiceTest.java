/**
 * 文件名称：SaleReportServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.ISaleReportService;
import com.yilidi.o2o.order.service.dto.SaleReportDto;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleReportServiceTest extends BaseServiceTest {

	@Autowired
	private ISaleReportService saleReportService;

	@Test
	public void testListSaleReportWeekly() {

		try {
			List<SaleReportDto> rptList = saleReportService.listSaleReportWeekly(null);
			printInfo(rptList);
		} catch (OrderServiceException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testListSaleReportTrend() {

		try {
			SaleReportQuery query = new SaleReportQuery();

			List<SaleReportDto> rptList = saleReportService.listSaleReportTrend(query);
			printInfo(rptList);
		} catch (OrderServiceException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testListSaleReportDistribution() {

		try {
			SaleReportQuery query = new SaleReportQuery();

			List<SaleReportDto> rptList = saleReportService
					.listSaleReportDistribution(query, SaleReportDto.ReportBy.BY_AREA);
			printInfo(rptList);
		} catch (OrderServiceException e) {
			e.printStackTrace();
		}
	}
}
