package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 店铺与微仓关联实体类，映射数据库表 YiLiDiUserCenter.U_STORE_WAREHOUSE
 * 
 * @author: chenlian
 * @date: 2016年6月23日 下午4:01:48
 */
public class StoreWarehouse extends BaseModel {

    private static final long serialVersionUID = 9122517085982612926L;

    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERTYPE为CUSTOMERTYPE_SELLER的ID，</br>
     * 即，U_STORE_PROFILE表的STORETYPE为STORETYPE_PARTNER或STORETYPE_EXPERIENCE_STORE的STOREID
     */
    private Integer storeId;

    /**
     * 微仓ID, 关联用户域U_CUSTOMER表的CUSTOMERTYPE为CUSTOMERTYPE_SELLER的ID，</br>
     * 即，U_STORE_PROFILE表的STORETYPE为STORETYPE_MICROWAREHOUSE的STOREID
     */
    private Integer warehouseId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

}
