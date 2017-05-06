/**
 * 文件名称：ProductResult.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.model.result;

import com.yilidi.o2o.product.model.Product;

/**
 * 功能描述：产品查询映射结构对象 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductResult extends Product {
	private static final long serialVersionUID = 4643752755857948924L;

	/**
	 * 关联商品数
	 */
	private Integer associationCount;
	/**
	 * 关联在售的商品数
	 */
	private Integer associationOnlineCount;

	public Integer getAssociationCount() {
		return associationCount;
	}

	public void setAssociationCount(Integer associationCount) {
		this.associationCount = associationCount;
	}

	public Integer getAssociationOnlineCount() {
		return associationOnlineCount;
	}

	public void setAssociationOnlineCount(Integer associationOnlineCount) {
		this.associationOnlineCount = associationOnlineCount;
	}

}
