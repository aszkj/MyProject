package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/21 11:51
 * @描述 QQ绑定信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class QQData extends BaseModel {
    /**
     * 用户绑定QQ的昵称
     */
    private String nickName;

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }
}
