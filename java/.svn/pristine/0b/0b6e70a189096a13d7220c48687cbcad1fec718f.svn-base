/**
 * 文件名称：ProductPriceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.product.model.ProductPrice;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class ProductPriceTest extends BaseMapperTest {

	
	@Autowired
	private ProductPriceMapper productPriceMapper;
	
	
	@Test
	public void testUpdate() {
		ProductPrice productPrice = new ProductPrice();
		productPrice.setRetailPrice(1L);
		productPrice.setModifyUserId(1);
		productPriceMapper.updateProductPriceById(productPrice);
	}
	
}
