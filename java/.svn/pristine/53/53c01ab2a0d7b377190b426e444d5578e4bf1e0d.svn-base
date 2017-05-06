/**
 * 文件名称：ProductTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.product.model.Product;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class ProductTest extends BaseMapperTest {

	@Autowired
	private ProductMapper productMapper;
	
	
	@Test
	public void testLoad() {
		Product pr = productMapper.loadProductBasicInfoById(1);
		printInfo(pr);
	}
	
	@Test
	public void testList() {
		ProductQuery queryProduct = new ProductQuery();
		queryProduct.setProductClassCode(null);
		queryProduct.setBrandCode("APPLE");
		queryProduct.setProductName(null);
		queryProduct.setBarCode(null);
		List<Product> ps = productMapper.findProductsByBasicInfo(queryProduct);
		printInfo(ps);
	}
}
