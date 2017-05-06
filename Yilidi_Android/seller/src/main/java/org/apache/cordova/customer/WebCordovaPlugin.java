package org.apache.cordova.customer;

import org.apache.cordova.CordovaPlugin;

/**
 * 打开外部网页插件
 * <p/>
 * Created by linghuxj on 15/11/28.
 */
public class WebCordovaPlugin extends CordovaPlugin {
    @Override
    public Boolean shouldAllowNavigation(String url) {
        return true;
    }

    @Override
    public Boolean shouldAllowRequest(String url) {
        return true;
    }
}