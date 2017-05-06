/**
 * 文件名称：ProductClassTest.java
 * 
 * 描述：产品类别测试类
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.product.model.ProductClass;
import com.yilidi.o2o.product.service.dto.query.ProductClassQuery;


/**
 * 功能描述：产品类别测试类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class ProductClassTest extends BaseMapperTest {

	protected Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private ProductClassMapper productClassMapper;
	
	
	@Test
	public void testSaveProductClass() {
		ProductClass productClass = new ProductClass();
		productClass.setClassCode("Drink3");
		productClass.setClassName("饮料1234");
		productClass.setClassImageUrl("/home/zxs/Image/drink.dmg1");
		productClass.setClassSort(1);
		//productClass.setParentCode("TOP_LEVEL_CLASS");
		//productClass.setStatusCode("PRODUCTCLASSSTATUS_OFF");
		productClass.setCreateUserId(1);
		productClass.setCreateTime(new Date());
		//productClass.setNote("好喝的饮料1");
		productClassMapper.saveProductClass(productClass);
	}
	
//	@Test
//	public void testUpdateProductClassByClassCode() {
//		ProductClass productClass = productClassMapper.loadProductClassByClassCode("Drink");
//		productClass.setClassName("饮料zxs1");
//		productClass.setClassImageUrl("/home/zxs/Image/drink.dmg");
//		productClass.setClassSort(1);
//		productClass.setNote("好喝的饮料zxs1");
//		productClass.setModifyUserId(1);
//		productClassMapper.updateProductClassByClassCode(productClass);
//	}
//	
//	@Test
//	public void testListProductClassByStatusCode() {
//		List<ProductClass> listProductClasses =  productClassMapper.listProductClassByStatusCode(null);
//
//		String jsonString = JsonUtils.toJsonStringWithDateFormat(listProductClasses);
//		printInfo(jsonString + "AAAAAAAAAAAAAAAAAAAAAAAAA");
//		logger.info(jsonString + "BBBBBBBBBBBBBBBBBBBBBBBBB");
//	}
//	
//	@Test
//	public void testLoadProductClassByStatusCode() {
//		ProductClass productClasse =  productClassMapper.loadProductClassByClassCode("Drink");
//
//		String jsonString = JsonUtils.toJsonStringWithDateFormat(productClasse);
//		printInfo(jsonString + "1111111111111111111111111111");
//		logger.info(jsonString + "22222222222222222222222222222222");
//	}
//	
//	@Test
//	public void testListProductClass() {
//		
//		ProductClassQuery queryProductClass = new ProductClassQuery();
//		queryProductClass.setParentCode("TOP_LEVEL_CLASS");
//		//queryProductClass.setClassCode("Drink");
//		queryProductClass.setOrder("CREATETIME");
//		queryProductClass.setSort("DESC");
//		List<ProductClass> listProductClasses =  productClassMapper.listProductClass(queryProductClass);
//
//		String jsonString = JsonUtils.toJsonStringWithDateFormat(listProductClasses);
//		printInfo(jsonString + "333333333333333333333333333333");
//		logger.info(jsonString + "4444444444444444444444444444444");
//	}
	
}
