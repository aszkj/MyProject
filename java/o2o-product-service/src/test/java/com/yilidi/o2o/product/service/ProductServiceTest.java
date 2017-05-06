/**
 * 文件名称：ProductServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductServiceTest extends BaseServiceTest {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IProductService productService;

//	 @Test
//	 public void testSaveProduct() throws ProductServiceException {
//	
//	 ProductDto productDto = new ProductDto();
//	 productDto.setBrandCode("奔驰");
//	 productDto.setBarCode("A999999");
//	 productDto.setProductName("奔驰X7");
//	 productDto.setProductClassCode("BCX7");
//	 // productDto.setStatusCode("PRODUCTSTATUS_ON");
//	 productDto.setCreateUserId(1);
//	 productDto.setCreateTime(new Date());
//	
//	 // 附加属性
//	 ProductProfileDto productProfileDto = new ProductProfileDto();
//	 productProfileDto.setContent("卓越的性能");
//	 //productProfileDto.setProductOwner("zxs");
//	 productProfileDto.setSellPoint("舒适");
//	 productProfileDto.setProductSpec("70万/一辆");
//	 productDto.setProductProfileDto(productProfileDto);
//	 // 价格信息
//	 ProductPriceDto productPriceDto = new ProductPriceDto();
//	 productPriceDto.setPromotionalPrice(7000L);
//	 productPriceDto.setRetailPrice(8000L);
//	 productDto.setProductPriceDto(productPriceDto);
//	 // 图片信息
//	 List<ProductImageDto> saveProductImageDtos = new ArrayList<ProductImageDto>();
//	 ProductImageDto productImageDto = new ProductImageDto();
//	 productImageDto.setImageUrl("/home/bc/drink.dmg1");
//	 productImageDto.setMasterFlag("2");
//	 productImageDto.setImageOrder(2);
//	 saveProductImageDtos.add(productImageDto);
//	
//	 ProductImageDto productImageDto1 = new ProductImageDto();
//	 productImageDto1.setImageUrl("/home/bc/drink.dmg2");
//	 productImageDto1.setMasterFlag("1");
//	 productImageDto1.setImageOrder(1);
//	 saveProductImageDtos.add(productImageDto1);
//	 productDto.setProductImageDtos(saveProductImageDtos);
//	 productService.saveProduct(productDto, "IOS");
//	 }

	// @Test
	// public void testUpdateProduct() throws ProductServiceException {
	//
	// ProductDto productDto = productService.loadProductByProductIdAndChannelCode(10,"IOS");
	// productDto.setBrandCode("这酸爽");
	// productDto.setProductName("叫人无法原谅");
	// productDto.setProductClassCode("KDJ");
	// productDto.setStatusCode("PRODUCTSTATUS_ON");
	// productDto.setModifyUserId(1);
	// productDto.setModifyTime(new Date());
	// // 附加属性
	// ProductProfileDto productProfileDto = productDto.getProductProfileDto();
	// productProfileDto.setContent("zxszxszxs123456");
	// productProfileDto.setProductOwner("一里递");
	// productProfileDto.setSellPoint("好吃");
	// productDto.setProductProfileDto(productProfileDto);
	// // 价格信息
	// ProductPriceDto productPriceDto = productDto.getProductPriceDto();
	// productPriceDto.setPromotionalPrice(7L);
	// productPriceDto.setRetailPrice(8L);
	// productDto.setProductPriceDto(productPriceDto);
	// // 图片信息
	// List<ProductImageDto> saveProductImageDtos = productDto.getProductImageDtos();
	// ProductImageDto productImageDto = saveProductImageDtos.get(0);
	// productImageDto.setImageUrl("/home/image/drink.dmg1");
	// productImageDto.setMasterFlag("1");
	// productImageDto.setImageOrder(1);
	// saveProductImageDtos.add(productImageDto);
	//
	// ProductImageDto productImageDto1 = saveProductImageDtos.get(1);
	// productImageDto1.setImageUrl("/home/image/drink.dmg2");
	// productImageDto1.setMasterFlag("2");
	// productImageDto1.setImageOrder(2);
	// saveProductImageDtos.add(productImageDto1);
	// productDto.setProductImageDtos(saveProductImageDtos);
	// productService.updateProduct(productDto, "IOS");
	// }

	// @Test
	// public void testListProductByStatusCode() throws ProductServiceException {
	// ProductQuery queryProduct = new ProductQuery();
	// //queryProduct.setProductName("Q5");
	// //queryProduct.setContent("风");
	// queryProduct.setSellPoint("好");
	// queryProduct.setChannelCode("IOS");
	// List<ProductDto> listProductDto = productService.listProducts(queryProduct);
	// String jsonList = JsonUtils.toJsonStringWithDateFormat(listProductDto);
	// printInfo(jsonList + "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC");
	// logger.info(jsonList + "DDDDDDDDDDDDDDDDDDDDDDDDDDDDD");
	// }

	// @Test
	// public void testLoadProductByProductIdAndChannelCode() {
	// ProductDto productDto = productService.loadProductByProductIdAndChannelCode(10,"IOS");
	//
	// String jsonString = JsonUtils.toJsonStringWithDateFormat(productDto);
	// printInfo(jsonString + "1111111111111111111111111111");
	// logger.info(jsonString + "22222222222222222222222222222222");
	// }

//	@Test
//	public void testListProduct() {
//
//		ProductQuery queryProduct = new ProductQuery();
//		// queryProduct.setProductName("Q5");
//		// queryProduct.setContent("风");
//		//queryProduct.setSellPoint("好");
//		queryProduct.setChannelCode("IOS");
//		queryProduct.setStart(1);
//		queryProduct.setPageSize(10);
//		String jsonString1 = JsonUtils.toJsonStringWithDateFormat(queryProduct);
//		logger.info("queryProduct: ------------> " + jsonString1);
//		YiLiDiPage page = productService.findProductsByBasicInfo(queryProduct);
//
//		String jsonString = JsonUtils.toJsonStringWithDateFormat(page);
//		logger.info("pageSize: ------------> " + myPage.getPageSize());
//	    logger.info("pageNumber: ------------> " + myPage.getCurrentPage());
//	    logger.info("pageEndRow: ------------> " + myPage.getPageCount());
//	    logger.info("pageTotal: ------------> " + myPage.getRecordCount());
//	    logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(myPage.getResultList()));
//		printInfo(jsonString + "333333333333333333333333333333");
//		logger.info(jsonString + "4444444444444444444444444444444");
//	}
	
	@Test
	public void testFindProductRelativeInfos() {

		ProductQuery queryProduct = new ProductQuery();
		queryProduct.setChannelCode("APP");
		//queryProduct.setStart(1);
		//queryProduct.setPageSize(10);
		String jsonString1 = JsonUtils.toJsonStringWithDateFormat(queryProduct);
		logger.info("queryProduct: ------------> " + jsonString1);
		YiLiDiPage<ProductDto> myPage = productService.findProductRelativeInfos(queryProduct);

		String jsonString = JsonUtils.toJsonStringWithDateFormat(myPage);
		logger.info("pageSize: ------------> " + myPage.getPageSize());
		logger.info("currentPage: ------------> " + myPage.getCurrentPage());
		logger.info("pageCount: ------------> " + myPage.getPageCount());
		logger.info("recordCount: ------------> " + myPage.getRecordCount());
		logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(myPage.getResultList()));
		printInfo(jsonString + "333333333333333333333333333333");
		logger.info(jsonString + "4444444444444444444444444444444");
	}
}
