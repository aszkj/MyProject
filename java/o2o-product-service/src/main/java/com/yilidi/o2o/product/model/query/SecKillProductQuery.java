/**
 * 文件名称：SaleOrderQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.model.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：场次单查询条件封装类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillProductQuery extends BaseQuery {

    private static final long serialVersionUID = 3072124739137145053L;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 场次名称
     */
    private String sceneName;
    /**
     * 秒杀商品状态
     */
    private String secKillProductStatus;
    /**
     * 场次秒杀商品状态
     */
    private String statusCode;
    /**
     * 过滤的产品ID列表
     */
    private List<Integer> excludeSecKillProductIds;

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getSceneName() {
        return sceneName;
    }

    public void setSceneName(String sceneName) {
        this.sceneName = sceneName;
    }

    public String getSecKillProductStatus() {
        return secKillProductStatus;
    }

    public void setSecKillProductStatus(String secKillProductStatus) {
        this.secKillProductStatus = secKillProductStatus;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public List<Integer> getExcludeSecKillProductIds() {
        return excludeSecKillProductIds;
    }

    public void setExcludeSecKillProductIds(List<Integer> excludeSecKillProductIds) {
        this.excludeSecKillProductIds = excludeSecKillProductIds;
    }

}