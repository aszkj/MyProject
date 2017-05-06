package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.view.View;
import android.webkit.WebSettings;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.viewCustomer.CustomWebView;
import com.yldbkd.www.library.android.common.DisplayUtils;

/**
 * 产品详情页面
 * <p/>
 * Created by linghuxj on 15/11/7.
 */
public class ProductDetailFragment extends BaseFragment {

    private String productDetail;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        productDetail = bundle.getString(Constants.BundleName.PRODUCT_DETAIL);
    }

    @Override
    public int setLayoutId() {
        return R.layout.product_detail_fragment;
    }

    @Override
    public void initView(View view) {
        CustomWebView webView = (CustomWebView) view.findViewById(R.id.product_detail_web_view);
        webView.getSettings().setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
        webView.getSettings().setUseWideViewPort(true);
        webView.getSettings().setLoadWithOverviewMode(true);
        webView.getSettings().setDisplayZoomControls(false);
        webView.getSettings().setJavaScriptEnabled(true);

        webView.setHorizontalScrollBarEnabled(false);
        webView.setVerticalScrollBarEnabled(false);

        DisplayUtils.getPixelDisplayMetricsII(getActivity());
        //对图片进行处理展示
        //productDetail = productDetail.replaceAll("<img", "<img style=\"width:100%;\" ");
        String js = "<script type=\"text/javascript\">\n" +
                "\twindow.onload = function(){\n" +
                "\t\tvar images = document.getElementsByTagName('img');\n" +
                "\t\tvar width = 0;\n" +
                "\t\tfor ( var index in images) {\n" +
                "\t\t\tvar imgw = images[index].width;\n" +
                "\t\t\twidth = width <= imgw ? imgw : width;\n" +
                "\t\t}" +
                "\t\tvar percent = " + (DisplayUtils.screenWidth < 1000 ? 1080 : DisplayUtils.screenWidth) + "/ width \n" +
                "\t\tvar percent = percent * (90-percent);\n" +
                "\t\tdocument.body.style.zoom = percent + '%';\n" +
                "\t}\n" +
                "</script>";
        productDetail = "<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n<head>\n" +
                "</head>\n" +
                "<body>\n" + productDetail +
                "</body>\n" + js +
                "</html>";
        webView.loadDataWithBaseURL(getString(R.string.domain),
                productDetail, Constants.MIME_TYPE_HTML, Constants.ENCODE_UTF8, null);
    }
}
