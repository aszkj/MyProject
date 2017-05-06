/**
 * 文件名称：ProductImageTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.product.model.ProductImage;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class ProductImageTest extends BaseMapperTest {

	@Autowired
	private ProductImageMapper productImageMapper;

	@Test
	public void testUpdateMasterFlag() {
		productImageMapper.updateMasterFlagById("1", new Date(), 1, 1);
	}

	@Test
	public void testListByProductIdAndChannelCode() {
		List<ProductImage> pis = productImageMapper.listProductImagesByProductIdAndChannelCode(1, "IOS");
		printInfo(pis);
	}
}
