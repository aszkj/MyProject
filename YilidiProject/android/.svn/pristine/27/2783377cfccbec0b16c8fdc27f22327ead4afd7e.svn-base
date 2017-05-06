package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.mapapi.map.BaiduMap;
import com.baidu.mapapi.map.BitmapDescriptor;
import com.baidu.mapapi.map.BitmapDescriptorFactory;
import com.baidu.mapapi.map.MapStatus;
import com.baidu.mapapi.map.MapStatusUpdate;
import com.baidu.mapapi.map.MapStatusUpdateFactory;
import com.baidu.mapapi.map.MapView;
import com.baidu.mapapi.map.MarkerOptions;
import com.baidu.mapapi.map.MyLocationConfiguration;
import com.baidu.mapapi.map.MyLocationData;
import com.baidu.mapapi.model.LatLng;
import com.google.gson.Gson;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.bean.ConsigneeAddress;
import com.yldbkd.www.seller.android.bean.StoreBase;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.LocationUtils;
import com.yldbkd.www.seller.android.utils.Logger;

/**
 * 定位地图显示图层Fragment
 * <p/>
 * Created by linghuxj on 16/6/17.
 */
public class LocationMapFragment extends BaseFragment {

    private static final Long LOCATION_INTERVAL = 10 * 1000L;

    private ImageView backView;
    private ImageView locationView;
    private MapView mapView;
    private BaiduMap baiduMap;

    private TextView consigneeView;
    private TextView addressView;

    private LocationUtils location = LocationUtils.getInstance();
    private boolean isFirstLoc = true; // 是否首次定位

    private BitmapDescriptor bd;

    private Double latitudeByUser, longitudeByUser;
    private Double latitudeByStore, longitudeByStore;
    private String consignee, address;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_location_map;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        ConsigneeAddress consigneeAddress = (ConsigneeAddress) bundle.getSerializable(Constants.BundleName.ORDER_DETAIL_CONSIGNEE_INFO);
        StoreBase storeBase = SellerApp.getInstance().getStore();
        latitudeByStore = storeBase.getLatitude();
        longitudeByStore = storeBase.getLongitude();
        if (consigneeAddress == null) {
            return;
        }
        Logger.d(new Gson().toJson(consigneeAddress));
        latitudeByUser = consigneeAddress.getLatitude();
        longitudeByUser = consigneeAddress.getLongitude();
        consignee = consigneeAddress.getConsignee();
        address = consigneeAddress.getConsAddress();
    }

    @Override
    public void initView(View view) {
        backView = (ImageView) view.findViewById(R.id.iv_location_back);
        locationView = (ImageView) view.findViewById(R.id.iv_location_flag);
        mapView = (MapView) view.findViewById(R.id.mv_location);

        consigneeView = (TextView) view.findViewById(R.id.tv_location_consignee);
        addressView = (TextView) view.findViewById(R.id.tv_location_consignee_address);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        locationView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                location.stopLoc();
                location.startLoc();
            }
        });
    }

    @Override
    public void initData() {
        baiduMap = mapView.getMap();
        MapStatusUpdate msu = MapStatusUpdateFactory.zoomTo(14.0f);
        baiduMap.setMapStatus(msu);

        baiduMap.setMyLocationConfigeration(new MyLocationConfiguration(
                MyLocationConfiguration.LocationMode.NORMAL, true, null));
        baiduMap.setMyLocationEnabled(true);
        location.init(getActivity(), LOCATION_INTERVAL.intValue());
        location.registerLocationListener(new LocationListener());

        initMarker();

        consigneeView.setText(consignee);
        addressView.setText(address);
    }

    @Override
    public void onResume() {
        super.onResume();
        location.startLoc();
    }

    @Override
    public void onPause() {
        super.onPause();
        location.stopLoc();
    }

    private void initMarker() {
        if (latitudeByUser != null && longitudeByUser != null) {
            setMarker(latitudeByUser, longitudeByUser);
        }
        if (latitudeByStore != null && longitudeByStore != null) {
            setMarker(latitudeByStore, longitudeByStore);
        }
    }

    private void setMarker(double latitude, double longitude) {
        if (bd == null) {
            bd = BitmapDescriptorFactory.fromResource(R.mipmap.icon_gcoding);
        }
        LatLng latLng = new LatLng(latitude, longitude);
        MarkerOptions markerOptions = new MarkerOptions().position(latLng).icon(bd).zIndex(9).draggable(true);
        // 掉下动画
        markerOptions.animateType(MarkerOptions.MarkerAnimateType.drop);
        baiduMap.addOverlay(markerOptions);
    }

    private class LocationListener implements BDLocationListener {

        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (bdLocation == null || mapView == null) {
                return;
            }
            Logger.d("定位结束：" + bdLocation.getLocType());
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                Logger.d("定位成功：" + bdLocation.getLatitude() + " - " + bdLocation.getLongitude()
                        + " ，精度：" + bdLocation.getRadius());
                MyLocationData locData = new MyLocationData.Builder().accuracy(bdLocation.getRadius())
                        // 此处设置开发者获取到的方向信息，顺时针0-360
                        .direction(100).latitude(bdLocation.getLatitude())
                        .longitude(bdLocation.getLongitude()).build();
                baiduMap.setMyLocationData(locData);
                if (isFirstLoc) {
                    isFirstLoc = false;
                    LatLng ll = new LatLng(bdLocation.getLatitude(), bdLocation.getLongitude());
                    MapStatus.Builder builder = new MapStatus.Builder();
                    builder.target(ll).zoom(19.0f);
                    baiduMap.animateMapStatus(MapStatusUpdateFactory.newMapStatus(builder.build()));
                }
            }
        }
    }
}
