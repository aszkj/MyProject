package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 新增/修改收货地址
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class AddUpdateAddressParam extends AppBaseParam {

    private static final long serialVersionUID = 1L;
    @Field("收货人姓名")
    private String consigneeName;
    @Field("手机号")
    private String phoneNo;
    @Field("小区ID")
    private Integer communityId;
    @Field("市编码")
    private String cityCode;
    @Field("省编码")
    private String provinceCode;
    @Field("区编码")
    private String countyCode;
    @Field("详细地址")
    private String addressDetail;
    @Field("地址ID")
    private Integer addressId;

    public void validateParams() {
        Param consigneeNameValidate = new Param.Builder(getFieldName("consigneeName"), Param.ParamType.STR_NORMAL.getType(),
                consigneeName, false).build();
        Param phoneNoValidate = new Param.Builder(getFieldName("phoneNo"), Param.ParamType.STR_MOBILE.getType(), phoneNo,
                false).build();
        Param communityIdValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.STR_INTEGER.getType(),
                communityId, false).build();
        Param cityCodeValidate = new Param.Builder(getFieldName("cityCode"), Param.ParamType.STR_NORMAL.getType(), cityCode,
                false).build();
        Param provinceCodeValidate = new Param.Builder(getFieldName("provinceCode"), Param.ParamType.STR_NORMAL.getType(),
                provinceCode, false).build();
        Param countyCodeValidate = new Param.Builder(getFieldName("countyCode"), Param.ParamType.STR_NORMAL.getType(),
                countyCode, false).build();
        Param addressDetailValidate = new Param.Builder(getFieldName("addressDetail"), Param.ParamType.STR_NORMAL.getType(),
                addressDetail, false).build();
        Param addressIdValidate = new Param.Builder(getFieldName("addressId"), Param.ParamType.STR_INTEGER.getType(),
                addressId, true).build();
        ParamValidateUtils.validateParams(consigneeNameValidate, phoneNoValidate, communityIdValidate, cityCodeValidate,
                provinceCodeValidate, countyCodeValidate, addressDetailValidate, addressIdValidate);
    }

    public String getConsigneeName() {
        return consigneeName;
    }

    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

}
