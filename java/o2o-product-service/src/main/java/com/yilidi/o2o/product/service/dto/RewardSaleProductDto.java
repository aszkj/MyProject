/**
 * 文件名称：SaleProductDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

/**
 * 功能描述：蹭品商品模型Dto <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class RewardSaleProductDto extends SaleProductAppDto {

    private static final long serialVersionUID = 7331108771868308314L;

    /**
     * 赠送数量
     */
    private Integer number;

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

}
