/**
 * 文件名称：SaleProductPriceDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.proxy.dto;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品价格代理实体类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class ProductPriceProxyDto extends BaseDto {

	private static final long serialVersionUID = 5498119891441993589L;
	/**
	 * 商品id
	 */
	private Integer saleProductId;
	/**
	 * 商品价格信息
	 * 
	 * <pre>
	 * 说明：
	 * 1 key:渠道编码, value:map
	 * 2 key:SystemContext.ProductPrice.DIRECTPRICE 或 SystemContext.ProductPrice.RETAILPRICE, 
	 * 	value: 对应的价格
	 * </pre>
	 */
	private Map<String, Map<String, Long>> priceMap = new HashMap<String, Map<String, Long>>();

	
	
	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public Map<String, Map<String, Long>> getPriceMap() {
		return priceMap;
	}

	public void setPriceMap(Map<String, Map<String, Long>> priceMap) {
		this.priceMap = priceMap;
	}
}
