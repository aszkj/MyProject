/**
 * 文件名称：SaleProductImageHistory.java
 * 
 * 描述：商品图片
 * 
 *
 */
package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：店铺商品图片信息实体类，映射产品域表YiLiDiProductCenter.P_SALE_PRODUCT_IMAGE_HISTORY <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductImageHistory extends BaseModel {
	private static final long serialVersionUID = 2837661470576738559L;
	/**
     * 历史记录ID， 主键自增
     */
    private Integer id;
    /**
     * 商品图片ID， 关联产品域商品图片信息表P_SALE_PRODUCT_IMAGE的ID',
     */
    private Integer saleProductImageId;
    /**
     * 店铺商品ID， 关联产品域商品基础信息表P_SALE_PRODUCT的ID',
     */
    private Integer saleProductId;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 主图标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTIMAGEMASTERFLAG)
     */
    private String masterFlag;
    /**
     * 图片URL1
     */
    private String imageUrl1;
    /**
     * 图片URL2
     */
    private String imageUrl2;
    /**
     * 图片URL3
     */
    private String imageUrl3;
    /**
     * 图片顺序，图片显示顺序（编号小的先显示，如果编号相同，则id小的先显示）
     */
    private Integer imageOrder;
    /**
     * 操作用户id
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTPRICEOPERTYPE)
     */
    private String operateType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSaleProductImageId() {
		return saleProductImageId;
	}

	public void setSaleProductImageId(Integer saleProductImageId) {
		this.saleProductImageId = saleProductImageId;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
    }

    public String getImageUrl1() {
        return imageUrl1;
    }

    public void setImageUrl1(String imageUrl1) {
        this.imageUrl1 = imageUrl1;
    }

    public String getImageUrl2() {
        return imageUrl2;
    }

    public void setImageUrl2(String imageUrl2) {
        this.imageUrl2 = imageUrl2;
    }

    public String getImageUrl3() {
        return imageUrl3;
    }

    public void setImageUrl3(String imageUrl3) {
        this.imageUrl3 = imageUrl3;
    }

    public Integer getImageOrder() {
        return imageOrder;
    }

    public void setImageOrder(Integer imageOrder) {
        this.imageOrder = imageOrder;
    }

    public Integer getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(Integer operateUserId) {
		this.operateUserId = operateUserId;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}
}