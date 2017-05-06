/**
 * 文件名称：SaleProductImageServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.service.dto.SaleProductImageDto;


/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SaleProductImageServiceTest extends BaseServiceTest {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ISaleProductImageService saleProductImageService;
	
	@Test
	public void testSaveSaleProductImages() throws ProductServiceException {
		List<SaleProductImageDto> saveSaleProductImageDtos = new ArrayList<SaleProductImageDto>();
		SaleProductImageDto saleProductImageDto = new SaleProductImageDto();
		saleProductImageDto.setSaleProductId(3);
		saleProductImageDto.setChannelCode("IOS");
		saleProductImageDto.setImageUrl("/home/zxs/drink.dmg1");
		saleProductImageDto.setMasterFlag("1");
		saleProductImageDto.setImageOrder(1);
		saleProductImageDto.setCreateUserId(1);
		saleProductImageDto.setCreateTime(new Date());
		saveSaleProductImageDtos.add(saleProductImageDto);
		SaleProductImageDto saleProductImageDto1 = new SaleProductImageDto();
		saleProductImageDto1.setSaleProductId(3);
		saleProductImageDto1.setChannelCode("Android");
		saleProductImageDto1.setImageUrl("/home/zxs/drink.dmg2");
		saleProductImageDto1.setMasterFlag("2");
		saleProductImageDto1.setImageOrder(2);
		saleProductImageDto1.setCreateUserId(1);
		saleProductImageDto1.setCreateUserId(1);
		saleProductImageDto1.setCreateTime(new Date());
		saveSaleProductImageDtos.add(saleProductImageDto1);
		saleProductImageService.saveSaleProductImages(saveSaleProductImageDtos);
	}
	
	@Test
	public void testListSaleProductImagesBySaleProductIdAndChannelCode() throws ProductServiceException {
		
		List<SaleProductImageDto> saleProductImageDtoList = saleProductImageService
				.listSaleProductImagesBySaleProductIdAndChannelCode(3, "IOS");
		String jsonString = JsonUtils.toJsonStringWithDateFormat(saleProductImageDtoList);
		printInfo(jsonString + "SSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
		logger.info(jsonString + "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
	}
	
	@Test
	public void testUpdateSaleProductImage() throws ProductServiceException {
		
		SaleProductImageDto saleProductImageDto = new SaleProductImageDto();
		saleProductImageDto.setId(7);
		saleProductImageDto.setImageOrder(2);
		saleProductImageDto.setMasterFlag("PRODUCTIMAGEMASTERFLAG_YES");
		saleProductImageDto.setModifyUserId(1);
		saleProductImageDto.setModifyTime(new Date());
		saleProductImageDto.setImageUrl("/home/zxs/image/drink.dmg");
		//saleProduct.setEnabledFlag("SALEPRODUCTENABLEDFLAG_ON");
		//saleProduct.setSaleStatus("SALEPRODUCTSALESTATUS_INIT");
		
		saleProductImageService.updateSaleProductImage(saleProductImageDto);
	}
}
