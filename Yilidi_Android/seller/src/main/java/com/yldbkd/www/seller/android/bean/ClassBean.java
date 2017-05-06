package com.yldbkd.www.seller.android.bean;

import java.util.List;

/**
 * 商品类型信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class ClassBean extends BaseModel {

    /**
     * 类型ID
     */
    private String classCode;
    /**
     * 类型名称
     */
    private String className;
    /**
     * 类型图片
     */
    private String classImageUrl;
    /**
     * 子类型
     */
    private List<ClassBean> subClassList;

    private boolean isCheck = false;

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public boolean isCheck() {
        return isCheck;
    }

    public void setCheck(boolean check) {
        isCheck = check;
    }

    public String getClassImageUrl() {
        return classImageUrl;
    }

    public void setClassImageUrl(String classImageUrl) {
        this.classImageUrl = classImageUrl;
    }

    public List<ClassBean> getSubClassList() {
        return subClassList;
    }

    public void setSubClassList(List<ClassBean> subClassList) {
        this.subClassList = subClassList;
    }
}
