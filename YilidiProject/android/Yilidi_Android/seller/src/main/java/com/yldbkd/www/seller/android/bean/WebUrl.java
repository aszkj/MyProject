package com.yldbkd.www.seller.android.bean;

/**
 * 返回URL类型数据信息
 * <p/>
 * Created by linghuxj on 16/7/17.
 */
public class WebUrl extends BaseModel {

    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getAndroidValue() {
        return this.value + "?intfCallChannel=android";
    }
}
