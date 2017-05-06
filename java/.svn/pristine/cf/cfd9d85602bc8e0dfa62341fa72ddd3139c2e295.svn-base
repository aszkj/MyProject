/**
 * 文件名称：SaleProductPriceServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.service.dto.SaleProductPriceDto;


/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SaleProductPriceServiceTest extends BaseServiceTest {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ISaleProductPriceService saleProductPriceService;
	
	@Test
	public void testSaveSaleProductPrice() throws ProductServiceException {
		SaleProductPriceDto saleProductPriceDto = new SaleProductPriceDto();
		saleProductPriceDto.setSaleProductId(6);
		saleProductPriceDto.setChannelCode("IOS");
		saleProductPriceDto.setPromotionalPrice(7L);
		saleProductPriceDto.setRetailPrice(8L);
		saleProductPriceDto.setCreateUserId(1);
		saleProductPriceDto.setCreateTime(new Date());
		saleProductPriceService.saveSaleProductPrice(saleProductPriceDto);
	}
	
	@Test
	public void testUpdateSaleProductPrice() throws ProductServiceException {
		SaleProductPriceDto saleProductPriceDto = new SaleProductPriceDto();
		saleProductPriceDto.setSaleProductId(6);
		saleProductPriceDto.setChannelCode("IOS");
		saleProductPriceDto.setPromotionalPrice(10L);
		saleProductPriceDto.setRetailPrice(9L);
		saleProductPriceDto.setModifyUserId(1);
		saleProductPriceDto.setModifyTime(new Date());
		saleProductPriceService.updateSaleProductPrice(saleProductPriceDto);
	}
	@Test
	public void testLoadSaleProductPriceById() throws ProductServiceException {
		
		SaleProductPriceDto saleProductPriceDto = saleProductPriceService.loadSaleProductPriceById(8);
		String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProductPriceDto);
		printInfo(jsonString + "WWWWWWWWWWWWWWWWWWWW");
		logger.info(jsonString + "WWWWWWWWWWWWWWWWWWWWW");
		
	}
}
