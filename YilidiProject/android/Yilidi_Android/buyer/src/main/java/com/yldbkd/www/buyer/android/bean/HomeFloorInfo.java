package com.yldbkd.www.buyer.android.bean;

/**
 * 首页楼层数据结构信息
 * <p/>
 * Created by linghuxj on 16/9/2.
 */
public class HomeFloorInfo extends BaseModel {

    /**
     * 楼层信息
     */
    private FloorInfo floorInfo;
    /**
     * 广告信息
     */
    private Advertisement advertisementInfo;

    public FloorInfo getFloorInfo() {
        return floorInfo;
    }

    public void setFloorInfo(FloorInfo floorInfo) {
        this.floorInfo = floorInfo;
    }

    public Advertisement getAdvertisementInfo() {
        return advertisementInfo;
    }

    public void setAdvertisementInfo(Advertisement advertisementInfo) {
        this.advertisementInfo = advertisementInfo;
    }
}
