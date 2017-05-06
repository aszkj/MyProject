package com.yldbkd.www.buyer.android.bean;

/**
 * 省市县区等区域数据信息
 * <p/>
 * Created by linghuxj on 15/10/28.
 */
public class AreaDict extends BaseModel {
    /**
     * 编码
     */
    private String areaDictCode;
    /**
     * 名称
     */
    private String areaDictName;

    public String getAreaDictCode() {
        return areaDictCode;
    }

    public void setAreaDictCode(String areaDictCode) {
        this.areaDictCode = areaDictCode;
    }

    public String getAreaDictName() {
        return areaDictName;
    }

    public void setAreaDictName(String areaDictName) {
        this.areaDictName = areaDictName;
    }
}
