package com.yldbkd.www.buyer.android.bean;

import java.io.Serializable;
import java.util.Map;

/**
 * @创建者     李贞高
 * @创建时间   2016/11/26 17:10
 * @描述	       封装Map用于页面传递数据
 *
 * @更新者     $Author$
 * @更新时间   $Date$
 * @更新描述   ${TODO}$
 */
public class SerializableMap implements Serializable {
    public Map<Integer, Integer> map;

    public Map<Integer, Integer> getMap() {
        return map;
    }

    public void setMap(Map<Integer, Integer> map) {
        this.map = map;
    }
}
