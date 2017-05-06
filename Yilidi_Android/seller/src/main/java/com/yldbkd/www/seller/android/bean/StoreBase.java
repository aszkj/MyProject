package com.yldbkd.www.seller.android.bean;

/**
 * 用户登录信息
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class StoreBase extends BaseModel {

    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 用户图片url
     */
    private String userImageUrl;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 用户手机
     */
    private String userMobile;
    /**
     * 开始营业时间
     */
    private String beginBusinessHours;
    /**
     * 结束营业时间
     */
    private String endBusinessHours;
    /**
     * 店铺邀请码
     */
    private String invitationCode;
    /**
     * 详细地址信息
     */
    private String addressDetail;
    /**
     * 店铺热线
     */
    private String hotline;
    /**
     * 店铺经度
     */
    private Double latitude;
    /**
     * 店铺纬度
     */
    private Double longitude;
    /**
     * 是否是共享库存标识
     * 1：共享
     * 0：非共享
     */
    private Integer shareFlag;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public String getBeginBusinessHours() {
        return beginBusinessHours;
    }

    public void setBeginBusinessHours(String beginBusinessHours) {
        this.beginBusinessHours = beginBusinessHours;
    }

    public String getEndBusinessHours() {
        return endBusinessHours;
    }

    public void setEndBusinessHours(String endBusinessHours) {
        this.endBusinessHours = endBusinessHours;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Integer getShareFlag() {
        return shareFlag;
    }

    public void setShareFlag(Integer shareFlag) {
        this.shareFlag = shareFlag;
    }
}
